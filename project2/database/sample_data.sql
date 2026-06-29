-- Sample data for automobile_company_db
USE automobile_company_db;

-- brand
INSERT INTO brand (brand_id, brand_name) VALUES
    (1, 'Hyundai'),
    (2, 'Kia'),
    (3, 'Toyota'),
    (4, 'Honda'),
    (5, 'BMW'),
    (6, 'Tesla'),
    (7, 'Ford'),
    (8, 'Chevrolet'),
    (9, 'Volkswagen'),
    (10, 'Nissan');

-- model
INSERT INTO model (model_id, model_name, year, base_price, body_style, brand_id) VALUES
    (1, 'Avante', 2023, 22000, 'Sedan', 1),
    (2, 'Tucson', 2024, 28000, 'SUV', 1),
    (3, 'K5', 2023, 26000, 'Sedan', 2),
    (4, 'Sportage', 2024, 30000, 'SUV', 2),
    (5, 'Camry', 2023, 27000, 'Sedan', 3),
    (6, 'Supra', 2024, 50000, 'Convertible', 3),
    (7, 'Civic', 2023, 24000, 'Sedan', 4),
    (8, 'CR-V', 2024, 31000, 'SUV', 4),
    (9, 'Z4', 2024, 55000, 'Convertible', 5),
    (10, 'Model 3', 2023, 42000, 'Sedan', 6),
    (11, 'Mustang', 2024, 47000, 'Convertible', 7),
    (12, 'Malibu', 2023, 25000, 'Sedan', 8),
    (13, 'Golf', 2024, 29000, 'Hatchback', 9),
    (14, 'Altima', 2023, 26000, 'Sedan', 10);

-- company_plant
INSERT INTO company_plant (plant_id, plant_name, plant_location) VALUES
    (1, 'Ulsan Assembly', 'Ulsan'),
    (2, 'Asan Assembly', 'Asan'),
    (3, 'Gwangmyeong Plant', 'Gwangmyeong'),
    (4, 'Hwaseong Plant', 'Hwaseong'),
    (5, 'Pyeongtaek Plant', 'Pyeongtaek'),
    (6, 'Gunsan Plant', 'Gunsan'),
    (7, 'Changwon Plant', 'Changwon'),
    (8, 'Gwangju Plant', 'Gwangju'),
    (9, 'Sosan Plant', 'Seosan'),
    (10, 'Jeonju Plant', 'Jeonju');

-- supplier
INSERT INTO supplier (supplier_id, supplier_name, supplier_contact) VALUES
    (1, 'Hyundai Mobis', 'contact1@hyundai.com'),
    (2, 'Bosch', 'contact2@bosch.com'),
    (3, 'Denso', 'contact3@denso.com'),
    (4, 'ZF Friedrichshafen', 'contact4@zf.com'),
    (5, 'Continental', 'contact5@continental.com'),
    (6, 'Aisin', 'contact6@aisin.com'),
    (7, 'Valeo', 'contact7@valeo.com'),
    (8, 'Mando', 'contact8@mando.com'),
    (9, 'Hanon Systems', 'contact9@hanon.com'),
    (10, 'Magna', 'contact10@magna.com');

-- supplier_plant
INSERT INTO supplier_plant (plant_id, plant_name, plant_location, supplier_id) VALUES
    (101, 'SP-Yongin', 'Yongin', 1),
    (102, 'SP-Daejeon', 'Daejeon', 2),
    (103, 'SP-Nagoya', 'Nagoya', 3),
    (104, 'SP-Stuttgart', 'Stuttgart', 4),
    (105, 'SP-Hannover', 'Hannover', 5),
    (106, 'SP-Anjo', 'Anjo', 6),
    (107, 'SP-Paris', 'Paris', 7),
    (108, 'SP-Iksan', 'Iksan', 8),
    (109, 'SP-Daegu', 'Daegu', 9),
    (110, 'SP-Graz', 'Graz', 10),
    (111, 'SP-Pyeongtaek', 'Pyeongtaek', 1),
    (112, 'SP-Cheonan', 'Cheonan', 2);

-- customer
INSERT INTO customer (customer_id, customer_name, customer_address, customer_phone, gender, annual_income) VALUES
    (1, 'Kim Minsu', '10 Sample-ro, Seoul', '010-1001-2001', 'M', 55000),
    (2, 'Lee Jiwoo', '20 Sample-ro, Seoul', '010-1002-2002', 'F', 82000),
    (3, 'Park Seoyun', '30 Sample-ro, Seoul', '010-1003-2003', 'F', 145000),
    (4, 'Choi Junho', '40 Sample-ro, Seoul', '010-1004-2004', 'M', 38000),
    (5, 'Jung Hana', '50 Sample-ro, Seoul', '010-1005-2005', 'F', 61000),
    (6, 'Kang Doyun', '60 Sample-ro, Seoul', '010-1006-2006', 'M', 190000),
    (7, 'Yoon Sera', '70 Sample-ro, Seoul', '010-1007-2007', 'F', 47000),
    (8, 'Lim Jisung', '80 Sample-ro, Seoul', '010-1008-2008', 'M', 73000),
    (9, 'Han Yuna', '90 Sample-ro, Seoul', '010-1009-2009', 'F', 112000),
    (10, 'Oh Minjae', '100 Sample-ro, Seoul', '010-1010-2010', 'M', 29000),
    (11, 'Seo Arin', '110 Sample-ro, Seoul', '010-1011-2011', 'F', 98000),
    (12, 'Shin Taeyang', '120 Sample-ro, Seoul', '010-1012-2012', 'M', 64000),
    (13, 'Bae Soojin', '130 Sample-ro, Seoul', '010-1013-2013', 'F', 51000),
    (14, 'Moon Hyun', '140 Sample-ro, Seoul', '010-1014-2014', 'M', 135000),
    (15, 'Ko Eunbi', '150 Sample-ro, Seoul', '010-1015-2015', 'F', 42000);

-- dealer
INSERT INTO dealer (dealer_id, dealer_name, dealer_address) VALUES
    (1, 'Gangnam Motors', '5 Main St, Seoul'),
    (2, 'Busan Auto', '10 Main St, Busan'),
    (3, 'Incheon Cars', '15 Main St, Incheon'),
    (4, 'Daegu Wheels', '20 Main St, Daegu'),
    (5, 'Daejeon Drive', '25 Main St, Daejeon'),
    (6, 'Gwangju Garage', '30 Main St, Gwangju'),
    (7, 'Suwon Sales', '35 Main St, Suwon'),
    (8, 'Ulsan Auto', '40 Main St, Ulsan'),
    (9, 'Jeju Motors', '45 Main St, Jeju'),
    (10, 'Sejong Cars', '50 Main St, Sejong');

-- vehicle
INSERT INTO vehicle (VIN, mfg_date, status, color, model_id, company_plant_id, dealer_id, arrival_date) VALUES
    ('VIN00000000000001', '2022-12-17', 'InInventory', 'Black', 1, 1, 1, '2023-01-16'),
    ('VIN00000000000002', '2023-02-09', 'InInventory', 'White', 3, 2, 2, '2023-03-11'),
    ('VIN00000000000003', '2023-04-11', 'InInventory', 'Silver', 6, 3, 3, '2023-05-11'),
    ('VIN00000000000004', '2023-05-13', 'InInventory', 'Blue', 5, 4, 4, '2023-06-12'),
    ('VIN00000000000005', '2023-08-14', 'InInventory', 'Red', 7, 5, 5, '2023-09-13'),
    ('VIN00000000000006', '2023-05-14', 'InInventory', 'Gray', 9, 6, 1, '2023-06-13'),
    ('VIN00000000000007', '2022-09-06', 'InInventory', 'Green', 12, 7, 6, '2022-10-06'),
    ('VIN00000000000008', '2023-11-14', 'InInventory', 'Black', 2, 8, 2, '2023-12-14'),
    ('VIN00000000000009', '2024-02-12', 'InInventory', 'White', 4, 9, 3, '2024-03-13'),
    ('VIN00000000000010', '2024-04-10', 'InInventory', 'Silver', 11, 10, 4, '2024-05-10'),
    ('VIN00000000000011', '2024-04-20', 'InInventory', 'Blue', 5, 1, 1, '2024-05-20'),
    ('VIN00000000000012', '2024-07-11', 'InInventory', 'Red', 10, 2, 5, '2024-08-10'),
    ('VIN00000000000013', '2023-08-12', 'InInventory', 'Gray', 1, 3, 6, '2023-09-11'),
    ('VIN00000000000014', '2024-06-13', 'InInventory', 'Green', 6, 4, 2, '2024-07-13'),
    ('VIN00000000000015', '2024-04-24', 'InInventory', 'Black', 13, 5, 7, '2024-05-24'),
    ('VIN00000000000016', '2025-01-16', 'InInventory', 'White', 1, 6, 1, '2025-02-15'),
    ('VIN00000000000017', '2025-04-30', 'InInventory', 'Silver', 2, 7, 2, '2025-05-30'),
    ('VIN00000000000018', '2025-05-11', 'InInventory', 'Blue', 5, 8, 3, '2025-06-10'),
    ('VIN00000000000019', '2025-04-04', 'InInventory', 'Red', 9, 9, 4, '2025-05-04'),
    ('VIN00000000000020', '2025-02-05', 'InInventory', 'Gray', 3, 10, 5, '2025-03-07'),
    ('VIN00000000000021', '2025-02-27', 'InInventory', 'Green', 8, 1, 6, '2025-03-29'),
    ('VIN00000000000022', '2025-09-08', 'InInventory', 'Black', 1, 2, 1, '2025-10-08'),
    ('VIN00000000000023', '2025-08-17', 'InInventory', 'White', 5, 3, 2, '2025-09-16'),
    ('VIN00000000000024', '2025-05-02', 'InInventory', 'Silver', 14, 4, 7, '2025-06-01'),
    ('VIN00000000000025', '2025-11-21', 'InInventory', 'Blue', 1, 5, 1, '2025-12-21'),
    ('VIN00000000000026', '2026-01-03', 'InInventory', 'Red', 2, 6, 2, '2026-02-02'),
    ('VIN00000000000027', '2025-11-12', 'InInventory', 'Gray', 5, 7, 3, '2025-12-12'),
    ('VIN00000000000028', '2025-12-17', 'InInventory', 'Green', 6, 8, 4, '2026-01-16'),
    ('VIN00000000000029', '2026-02-02', 'InInventory', 'Black', 1, 9, 5, '2026-03-04'),
    ('VIN00000000000030', '2026-04-03', 'InInventory', 'White', 5, 10, 1, '2026-05-03'),
    ('VIN00000000000031', '2026-03-02', 'InInventory', 'White', 3, 1, 2, '2026-04-01'),
    ('VIN00000000000032', '2026-02-13', 'InInventory', 'Black', 7, 2, 4, '2026-03-15'),
    ('VIN00000000000033', '2026-04-01', 'InInventory', 'Blue', 10, 3, 5, '2026-05-01'),
    ('VIN00000000000034', '2026-01-21', 'InInventory', 'Silver', 5, 4, 6, '2026-02-20'),
    ('VIN00000000000035', '2026-05-20', 'Manufactured', 'Red', 8, 5, NULL, NULL),
    ('VIN00000000000036', '2026-05-25', 'Manufactured', 'Gray', 11, 6, NULL, NULL);

-- sale
INSERT INTO sale (sale_id, sale_date, sale_price, payment_method, VIN, customer_id, dealer_id) VALUES
    (1, '2023-02-10', 22000, 'Loan', 'VIN00000000000001', 1, 1),
    (2, '2023-04-15', 26000, 'Cash', 'VIN00000000000002', 2, 2),
    (3, '2023-07-20', 52500, 'Lease', 'VIN00000000000003', 3, 3),
    (4, '2023-09-05', 27000, 'Loan', 'VIN00000000000004', 4, 4),
    (5, '2023-11-12', 24000, 'Card', 'VIN00000000000005', 5, 5),
    (6, '2023-07-08', 59400, 'Lease', 'VIN00000000000006', 6, 1),
    (7, '2023-03-25', 25000, 'Loan', 'VIN00000000000007', 7, 6),
    (8, '2024-01-18', 28000, 'Loan', 'VIN00000000000008', 8, 2),
    (9, '2024-05-22', 30000, 'Cash', 'VIN00000000000009', 9, 3),
    (10, '2024-08-03', 49820, 'Lease', 'VIN00000000000010', 10, 4),
    (11, '2024-06-14', 27000, 'Loan', 'VIN00000000000011', 11, 1),
    (12, '2024-10-09', 42000, 'Card', 'VIN00000000000012', 12, 5),
    (13, '2024-02-28', 22000, 'Loan', 'VIN00000000000013', 13, 6),
    (14, '2024-08-17', 53500, 'Lease', 'VIN00000000000014', 14, 2),
    (15, '2024-11-30', 29000, 'Cash', 'VIN00000000000015', 15, 7),
    (16, '2025-03-12', 22000, 'Loan', 'VIN00000000000016', 1, 1),
    (17, '2025-07-04', 28000, 'Cash', 'VIN00000000000017', 2, 2),
    (18, '2025-08-19', 27000, 'Loan', 'VIN00000000000018', 3, 3),
    (19, '2025-07-28', 59400, 'Lease', 'VIN00000000000019', 4, 4),
    (20, '2025-05-06', 26000, 'Card', 'VIN00000000000020', 5, 5),
    (21, '2025-09-15', 31000, 'Loan', 'VIN00000000000021', 6, 6),
    (22, '2025-11-02', 22000, 'Loan', 'VIN00000000000022', 7, 1),
    (23, '2025-10-21', 27000, 'Cash', 'VIN00000000000023', 8, 2),
    (24, '2025-12-08', 26000, 'Loan', 'VIN00000000000024', 9, 7),
    (25, '2026-01-15', 22000, 'Loan', 'VIN00000000000025', 10, 1),
    (26, '2026-03-09', 28000, 'Cash', 'VIN00000000000026', 11, 2),
    (27, '2026-02-20', 27000, 'Loan', 'VIN00000000000027', 12, 3),
    (28, '2026-04-11', 52500, 'Lease', 'VIN00000000000028', 13, 4),
    (29, '2026-05-03', 22000, 'Loan', 'VIN00000000000029', 14, 5),
    (30, '2026-05-28', 27000, 'Cash', 'VIN00000000000030', 15, 1);

-- part
INSERT INTO part (part_id, part_name, part_mfg_date, VIN, supplier_plant_id, company_plant_id) VALUES
    (1, 'Transmission', '2024-01-15', 'VIN00000000000008', 101, NULL),
    (2, 'Transmission', '2024-02-20', 'VIN00000000000009', 101, NULL),
    (3, 'Transmission', '2024-03-10', 'VIN00000000000010', 101, NULL),
    (4, 'Transmission', '2024-04-05', 'VIN00000000000011', 101, NULL),
    (5, 'Transmission', '2024-06-25', 'VIN00000000000012', 101, NULL),
    (6, 'Transmission', '2023-11-10', 'VIN00000000000013', 111, NULL),
    (7, 'Engine', '2024-05-01', 'VIN00000000000001', 102, NULL),
    (8, 'Engine', '2024-05-02', 'VIN00000000000002', 102, NULL),
    (9, 'Engine', '2025-01-10', NULL, 102, NULL),
    (10, 'Brake Pad', '2024-07-01', 'VIN00000000000003', 103, NULL),
    (11, 'Brake Pad', '2025-02-15', NULL, 103, NULL),
    (12, 'Battery', '2024-08-08', 'VIN00000000000004', 109, NULL),
    (13, 'Battery', '2025-03-03', 'VIN00000000000005', 109, NULL),
    (14, 'Body Panel', '2024-03-20', 'VIN00000000000006', NULL, 1),
    (15, 'Body Panel', '2024-04-22', 'VIN00000000000007', NULL, 2),
    (16, 'Chassis', '2025-05-05', 'VIN00000000000008', NULL, 3),
    (17, 'Chassis', '2025-06-06', NULL, NULL, 4),
    (18, 'Seat Assembly', '2024-09-09', 'VIN00000000000009', NULL, 5),
    (19, 'Dashboard', '2025-07-07', 'VIN00000000000010', NULL, 6),
    (20, 'Transmission', '2025-08-08', NULL, 101, NULL);

-- contracts
INSERT INTO contracts (supplier_id, model_id, part_type) VALUES
    (1, 1, 'Transmission'),
    (1, 2, 'Transmission'),
    (1, 3, 'Transmission'),
    (1, 4, 'Transmission'),
    (1, 5, 'Transmission'),
    (1, 6, 'Transmission'),
    (1, 7, 'Transmission'),
    (1, 8, 'Transmission'),
    (1, 9, 'Transmission'),
    (1, 10, 'Transmission'),
    (2, 1, 'Engine'),
    (2, 2, 'Engine'),
    (2, 3, 'Engine'),
    (3, 5, 'Brake Pad'),
    (3, 6, 'Brake Pad'),
    (9, 1, 'Battery'),
    (9, 4, 'Battery'),
    (5, 5, 'Tire'),
    (6, 6, 'Transmission');
