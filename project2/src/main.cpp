#include "database.h"
#include <iostream>
#include <string>
#include <vector>
#include <cstring>
#include <cstdlib>

MYSQL* dbConnect() {
    MYSQL* conn = mysql_init(nullptr);
    if (!mysql_real_connect(conn, DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT, nullptr, 0)) {
        std::cerr << "Connection failed: " << mysql_error(conn) << "\n";
        mysql_close(conn);
        return nullptr;
    }
    return conn;
}

bool runQuery(MYSQL* conn, const std::string& sql, const std::vector<std::string>& params) {
    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    if (mysql_stmt_prepare(stmt, sql.c_str(), (unsigned long)sql.size())) {
        std::cerr << "Query error: " << mysql_stmt_error(stmt) << "\n";
        mysql_stmt_close(stmt);
        return false;
    }

    size_t np = params.size();
    std::vector<MYSQL_BIND> in(np);
    std::vector<unsigned long> inLen(np);
    if (np > 0) {
        std::memset(in.data(), 0, sizeof(MYSQL_BIND) * np);
        for (size_t i = 0; i < np; ++i) {
            inLen[i] = params[i].size();
            in[i].buffer_type = MYSQL_TYPE_STRING;
            in[i].buffer = (void*)params[i].c_str();
            in[i].buffer_length = inLen[i];
            in[i].length = &inLen[i];
        }
        mysql_stmt_bind_param(stmt, in.data());
    }

    if (mysql_stmt_execute(stmt)) {
        std::cerr << "Query error: " << mysql_stmt_error(stmt) << "\n";
        mysql_stmt_close(stmt);
        return false;
    }

    MYSQL_RES* meta = mysql_stmt_result_metadata(stmt);
    if (!meta) { mysql_stmt_close(stmt); return true; }

    unsigned int nf = mysql_num_fields(meta);
    MYSQL_FIELD* fields = mysql_fetch_fields(meta);

    std::vector<std::vector<char>> buf(nf, std::vector<char>(1024));
    std::vector<unsigned long> len(nf);
    std::vector<char> isNull(nf);
    std::vector<MYSQL_BIND> out(nf);
    std::memset(out.data(), 0, sizeof(MYSQL_BIND) * nf);
    for (unsigned int i = 0; i < nf; ++i) {
        out[i].buffer_type = MYSQL_TYPE_STRING;
        out[i].buffer = buf[i].data();
        out[i].buffer_length = 1024;
        out[i].length = &len[i];
        out[i].is_null = (bool*)&isNull[i];
    }
    mysql_stmt_bind_result(stmt, out.data());

    for (unsigned int i = 0; i < nf; ++i)
        std::cout << (i ? " | " : "") << fields[i].name;
    std::cout << "\n";

    while (mysql_stmt_fetch(stmt) == 0) {
        for (unsigned int i = 0; i < nf; ++i)
            std::cout << (i ? " | " : "") << (isNull[i] ? "NULL" : std::string(buf[i].data(), len[i]));
        std::cout << "\n";
    }

    mysql_free_result(meta);
    mysql_stmt_close(stmt);
    return true;
}

std::string readLine(const std::string& prompt) {
    std::cout << prompt;
    std::string s;
    std::getline(std::cin, s);
    return s;
}

int readInt(const std::string& prompt, int def) {
    std::string s = readLine(prompt);
    return s.empty() ? def : atoi(s.c_str());
}

bool validDate(const std::string& d) {
    return d.size() == 10 && d[4] == '-' && d[7] == '-';
}

// Query 1 - sales trends over the past 3 years, by brand / year / month / week / gender / income range
void querySalesTrends(MYSQL* conn) {
    std::string sql =
        "SELECT b.brand_name, YEAR(s.sale_date) AS yr, MONTH(s.sale_date) AS mon, "
        "  WEEK(s.sale_date) AS wk, c.gender, "
        "  CASE WHEN c.annual_income < 50000 THEN 'Low(<50k)' "
        "       WHEN c.annual_income < 100000 THEN 'Mid(50k-100k)' "
        "       ELSE 'High(>=100k)' END AS income_range, "
        "  COUNT(*) AS units, SUM(s.sale_price) AS revenue "
        "FROM sale s "
        "JOIN customer c ON s.customer_id = c.customer_id "
        "JOIN vehicle v  ON s.VIN = v.VIN "
        "JOIN model m    ON v.model_id = m.model_id "
        "JOIN brand b    ON m.brand_id = b.brand_id "
        "WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) "
        "GROUP BY b.brand_name, yr, mon, wk, c.gender, income_range "
        "ORDER BY b.brand_name, yr, mon, wk, c.gender, income_range";
    runQuery(conn, sql, {});
}

// Query 2 - defective part tracking (supplier + part type + date range)
void queryDefectivePart(MYSQL* conn) {
    std::string partName = readLine("  Part name (e.g., Transmission / Engine / Battery): ");
    int supplierId = readInt("  Supplier id: ", 1);
    std::string start = readLine("  Start date YYYY-MM-DD (e.g., 2024-01-01): ");
    std::string end   = readLine("  End date YYYY-MM-DD (e.g., 2024-06-30): ");
    if (!validDate(start) || !validDate(end)) {
        std::cout << "  Invalid date format.\n";
        return;
    }
    std::string sql =
        "SELECT p.part_id, p.part_name, p.VIN, m.model_name, c.customer_name, s.sale_date "
        "FROM part p "
        "JOIN supplier_plant sp ON p.supplier_plant_id = sp.plant_id "
        "JOIN vehicle v  ON p.VIN = v.VIN "
        "JOIN model m    ON v.model_id = m.model_id "
        "JOIN sale s     ON v.VIN = s.VIN "
        "JOIN customer c ON s.customer_id = c.customer_id "
        "WHERE sp.supplier_id = ? AND p.part_name = ? "
        "  AND p.part_mfg_date BETWEEN ? AND ? "
        "ORDER BY p.part_id";
    runQuery(conn, sql, { std::to_string(supplierId), partName, start, end });
}

// Query 3 - top 2 brands by revenue in the past year
void queryTopRevenue(MYSQL* conn) {
    std::string sql =
        "SELECT b.brand_name, SUM(s.sale_price) AS revenue "
        "FROM sale s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m   ON v.model_id = m.model_id "
        "JOIN brand b   ON m.brand_id = b.brand_id "
        "WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) "
        "GROUP BY b.brand_name ORDER BY revenue DESC LIMIT 2";
    runQuery(conn, sql, {});
}

// Query 4 - top 2 brands by unit sales in the past year
void queryTopUnits(MYSQL* conn) {
    std::string sql =
        "SELECT b.brand_name, COUNT(*) AS units "
        "FROM sale s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m   ON v.model_id = m.model_id "
        "JOIN brand b   ON m.brand_id = b.brand_id "
        "WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) "
        "GROUP BY b.brand_name ORDER BY units DESC LIMIT 2";
    runQuery(conn, sql, {});
}

// Query 5 - best month(s) for a body style
void querySeasonal(MYSQL* conn) {
    std::string bodyStyle = readLine("  Body style (e.g., Sedan / SUV / Convertible): ");
    if (bodyStyle.empty()) bodyStyle = "Convertible";
    std::string sql =
        "SELECT MONTH(s.sale_date) AS month, COUNT(*) AS units "
        "FROM sale s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN model m   ON v.model_id = m.model_id "
        "WHERE m.body_style = ? "
        "GROUP BY MONTH(s.sale_date) ORDER BY units DESC, month";
    runQuery(conn, sql, { bodyStyle });
}

// Query 6 - dealers with the longest average inventory time
void queryDealerInventory(MYSQL* conn) {
    std::string sql =
        "SELECT d.dealer_id, d.dealer_name, "
        "       ROUND(AVG(DATEDIFF(s.sale_date, v.arrival_date)), 1) AS avg_days "
        "FROM sale s "
        "JOIN vehicle v ON s.VIN = v.VIN "
        "JOIN dealer d  ON s.dealer_id = d.dealer_id "
        "WHERE v.arrival_date IS NOT NULL "
        "GROUP BY d.dealer_id, d.dealer_name ORDER BY avg_days DESC";
    runQuery(conn, sql, {});
}

// Query 7 - supplier covering the most distinct models
void querySupplierCoverage(MYSQL* conn) {
    std::string sql =
        "SELECT su.supplier_id, su.supplier_name, COUNT(DISTINCT ct.model_id) AS model_count "
        "FROM contracts ct "
        "JOIN supplier su ON ct.supplier_id = su.supplier_id "
        "GROUP BY su.supplier_id, su.supplier_name ORDER BY model_count DESC";
    runQuery(conn, sql, {});
}

void displayMenu() {
    std::cout << "\n==== Automobile Company DB ====\n"
              << " 1. Sales Trends\n"
              << " 2. Defective Part Tracking\n"
              << " 3. Top 2 Brands by Revenue\n"
              << " 4. Top 2 Brands by Unit Sales\n"
              << " 5. Seasonal Sales Patterns\n"
              << " 6. Dealer Inventory Efficiency\n"
              << " 7. Supplier Coverage\n"
              << " 0. Exit\n";
}

int main() {
    MYSQL* conn = dbConnect();
    if (!conn) return 1;
    std::cout << "Connected to " << DB_NAME << ".\n";

    while (true) {
        displayMenu();
        int choice = readInt("Select [0-7]: ", -1);
        if (choice == 0) break;
        switch (choice) {
            case 1: querySalesTrends(conn);      break;
            case 2: queryDefectivePart(conn);    break;
            case 3: queryTopRevenue(conn);       break;
            case 4: queryTopUnits(conn);         break;
            case 5: querySeasonal(conn);         break;
            case 6: queryDealerInventory(conn);  break;
            case 7: querySupplierCoverage(conn); break;
            default: std::cout << "Invalid choice.\n"; break;
        }
    }

    mysql_close(conn);
    return 0;
}
