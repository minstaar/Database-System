#ifndef DATABASE_H
#define DATABASE_H

#include <mysql.h>
#include <string>
#include <vector>

#define DB_HOST "localhost"
#define DB_USER "root"
#define DB_PASS "your_password"
#define DB_NAME "automobile_company_db"
#define DB_PORT 3306

MYSQL* dbConnect();
bool runQuery(MYSQL* conn, const std::string& sql, const std::vector<std::string>& params);

#endif
