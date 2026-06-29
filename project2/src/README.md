# Automobile Database Application

- 환경: Windows + MySQL C API (ODBC 미사용)
- 실행 전 `database.h`의 접속 정보 수정 필요

```c
#define DB_HOST "localhost"
#define DB_USER "root"
#define DB_PASS "your_password"
#define DB_NAME "automobile_company_db"
#define DB_PORT 3306
```

- DB는 `database/schema.sql` → `database/sample_data.sql` 순서로 실행


## 실행 메뉴

```
 1. Sales Trends
 2. Defective Part Tracking
 3. Top 2 Brands by Revenue
 4. Top 2 Brands by Unit Sales
 5. Seasonal Sales Patterns
 6. Dealer Inventory Efficiency
 7. Supplier Coverage
 0. Exit
```

번호를 입력해 쿼리를 실행하고, 0으로 종료합니다.
2·5번은 실행 시 추가 입력(부품명·공급사·날짜 / 차체 스타일)을 받습니다.