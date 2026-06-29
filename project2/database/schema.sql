DROP DATABASE IF EXISTS automobile_company_db;
CREATE DATABASE automobile_company_db
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE automobile_company_db;

CREATE TABLE brand (
    brand_id    INT          NOT NULL,
    brand_name  VARCHAR(50)  NOT NULL,
    PRIMARY KEY (brand_id)
);

CREATE TABLE supplier (
    supplier_id       INT           NOT NULL,
    supplier_name     VARCHAR(100)  NOT NULL,
    supplier_contact  VARCHAR(50),
    PRIMARY KEY (supplier_id)
);

CREATE TABLE company_plant (
    plant_id        INT           NOT NULL,
    plant_name      VARCHAR(100)  NOT NULL,
    plant_location  VARCHAR(100)  NOT NULL,
    PRIMARY KEY (plant_id)
);

CREATE TABLE customer (
    customer_id       INT             NOT NULL,
    customer_name     VARCHAR(100)    NOT NULL,
    customer_address  VARCHAR(255)    NOT NULL,
    customer_phone    VARCHAR(20),
    gender            CHAR(1)         NOT NULL,
    annual_income     DECIMAL(12,2)   NOT NULL,
    PRIMARY KEY (customer_id),
    CONSTRAINT chk_customer_income CHECK (annual_income >= 0)
);

CREATE TABLE dealer (
    dealer_id       INT           NOT NULL,
    dealer_name     VARCHAR(100)  NOT NULL,
    dealer_address  VARCHAR(255)  NOT NULL,
    PRIMARY KEY (dealer_id)
);

CREATE TABLE model (
    model_id    INT           NOT NULL,
    model_name  VARCHAR(100)  NOT NULL,
    year        INT           NOT NULL,
    base_price  DECIMAL(12,2) NOT NULL,
    body_style  VARCHAR(30)   NOT NULL,
    brand_id    INT           NOT NULL,
    PRIMARY KEY (model_id),
    CONSTRAINT fk_model_brand
        FOREIGN KEY (brand_id) REFERENCES brand (brand_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_model_price CHECK (base_price >= 0)
);

CREATE TABLE supplier_plant (
    plant_id        INT           NOT NULL,
    plant_name      VARCHAR(100)  NOT NULL,
    plant_location  VARCHAR(100)  NOT NULL,
    supplier_id     INT           NOT NULL,
    PRIMARY KEY (plant_id),
    CONSTRAINT fk_splant_supplier
        FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE vehicle (
    VIN               CHAR(17)     NOT NULL,
    mfg_date          DATE         NOT NULL,
    status            VARCHAR(20)  NOT NULL,
    color             VARCHAR(30)  NOT NULL,
    model_id          INT          NOT NULL,
    company_plant_id  INT          NOT NULL,
    dealer_id         INT          NULL,
    arrival_date      DATE         NULL,
    PRIMARY KEY (VIN),
    CONSTRAINT fk_vehicle_model
        FOREIGN KEY (model_id) REFERENCES model (model_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_vehicle_cplant
        FOREIGN KEY (company_plant_id) REFERENCES company_plant (plant_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_vehicle_dealer
        FOREIGN KEY (dealer_id) REFERENCES dealer (dealer_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE part (
    part_id            INT           NOT NULL,
    part_name          VARCHAR(100)  NOT NULL,
    part_mfg_date      DATE          NOT NULL,
    VIN                CHAR(17)      NULL,
    supplier_plant_id  INT           NULL,
    company_plant_id   INT           NULL,
    PRIMARY KEY (part_id),
    CONSTRAINT fk_part_vehicle
        FOREIGN KEY (VIN) REFERENCES vehicle (VIN)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_part_splant
        FOREIGN KEY (supplier_plant_id) REFERENCES supplier_plant (plant_id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_part_cplant
        FOREIGN KEY (company_plant_id) REFERENCES company_plant (plant_id)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT chk_part_one_plant CHECK (
        (supplier_plant_id IS NOT NULL AND company_plant_id IS NULL)
        OR
        (supplier_plant_id IS NULL AND company_plant_id IS NOT NULL)
    )
);

CREATE TABLE sale (
    sale_id         INT            NOT NULL,
    sale_date       DATE           NOT NULL,
    sale_price      DECIMAL(12,2)  NOT NULL,
    payment_method  VARCHAR(30)    NOT NULL,
    VIN             CHAR(17)       NOT NULL,
    customer_id     INT            NOT NULL,
    dealer_id       INT            NOT NULL,
    PRIMARY KEY (sale_id),
    CONSTRAINT uq_sale_vin UNIQUE (VIN),
    CONSTRAINT fk_sale_vehicle
        FOREIGN KEY (VIN) REFERENCES vehicle (VIN)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_sale_customer
        FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_sale_dealer
        FOREIGN KEY (dealer_id) REFERENCES dealer (dealer_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_sale_price CHECK (sale_price >= 0)
);

CREATE TABLE contracts (
    supplier_id  INT          NOT NULL,
    model_id     INT          NOT NULL,
    part_type    VARCHAR(50)  NOT NULL,
    PRIMARY KEY (supplier_id, model_id, part_type),
    CONSTRAINT fk_contracts_supplier
        FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_contracts_model
        FOREIGN KEY (model_id) REFERENCES model (model_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX idx_sale_date        ON sale (sale_date);
CREATE INDEX idx_model_bodystyle  ON model (body_style);
CREATE INDEX idx_vehicle_arrival  ON vehicle (arrival_date);
CREATE INDEX idx_part_mfg_date    ON part (part_mfg_date);

DELIMITER $$

CREATE TRIGGER trg_sale_set_status
AFTER INSERT ON sale
FOR EACH ROW
BEGIN
    UPDATE vehicle SET status = 'Sold' WHERE VIN = NEW.VIN;
END$$

DELIMITER ;
