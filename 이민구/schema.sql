CREATE
DATABASE camfit;
DROP
DATABASE IF EXISTS camfit;

CREATE
DATABASE camfit
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

SHOW
DATABASES;

USE
camfit;

-- campsite
CREATE TABLE campsite
(
    campsite_id INT PRIMARY KEY AUTO_INCREMENT
);

ALTER TABLE campsite

    ADD COLUMN title VARCHAR(100) NOT NULL,
    ADD COLUMN content       TEXT         NOT NULL,
    ADD COLUMN phone_number  INT,
    ADD COLUMN certification BOOLEAN,
    ADD COLUMN open_date     DATETIME,
    ADD COLUMN created_at    DATETIME DEFAULT NOW(),
    ADD COLUMN updated_at    DATETIME DEFAULT NOW() ON
UPDATE NOW();

ALTER TABLE campsite
    ADD FOREIGN KEY (region_id) REFERENCES region (region_id);

SELECT *
FROM campsite;

DESCRIBE campsite;

-- campsite_detail
CREATE TABLE campsite_detail
(
    campsite_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    title              VARCHAR(100) NOT NULL,
    content            TEXT         NOT NULL
);

SHOW
TABLES;

SELECT *
FROM campsite;

DESCRIBE campsite_detail;


ALTER TABLE campsite_detail
    ADD FOREIGN KEY (campsite_id) REFERENCES campsite (campsite_id);

-- campsite_stock
CREATE TABLE campsite_stock
(
    campsite_stock     INT PRIMARY KEY AUTO_INCREMENT,
    campsite_detail_id INT NOT NULL,
    total_stock        INT NOT NULL,
    reserved_stock     INT NOT NULL,
    available_stock    INT NOT NULL,
    date               DATETIME DEFAULT NOW(),
    updated_at         DATETIME DEFAULT NOW() ON UPDATE NOW(),
    FOREIGN KEY (campsite_detail_id) REFERENCES campsite_detail (campsite_detail_id)
);

ALTER TABLE campsite_stock
    CHANGE campsite_stock campsite_stock_id INT;

DESCRIBE campsite_stock;

-- region

CREATE TABLE region
(
    region_id   INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    description VARCHAR(255)
);

DESCRIBE region;

-- location
CREATE TABLE location
(
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    campsite_id INT NOT NULL,
    latitude    INT NOT NULL,
    longitude   INT NOT NULL,
    address     INT NOT NULL,
    FOREIGN KEY (campsite_id) REFERENCES campsite (campsite_id)
);

DESCRIBE location;

-- users
CREATE TABLE users
(
    user_id          INT PRIMARY KEY AUTO_INCREMENT,
    username         VARCHAR(50)                         NOT NULL,
    email            VARCHAR(255)                        NOT NULL,
    password         VARCHAR(255)                        NOT NULL,
    password_confirm VARCHAR(255)                        NOT NULL,
    phone            VARCHAR(100)                        NOT NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE users
    CHANGE created_at created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL;

DESCRIBE users;

-- camping_log
CREATE TABLE camping_log
(
    camping_log_id INT PRIMARY KEY AUTO_INCREMENT,
    campsite_id    INT                                 NOT NULL,
    user_id        INT                                 NOT NULL,
    content        TEXT                                NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (campsite_id) REFERENCES campsite (campsite_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

DESCRIBE camping_log;

-- campsite_category
CREATE TABLE campsite_category
(
    campsite_category_id        INT PRIMARY KEY AUTO_INCREMENT,
    campsite_id                 INT NOT NULL,
    campsite_detail_category_id INT NOT NULL,
    FOREIGN KEY (campsite_id) REFERENCES campsite (campsite_id),
    FOREIGN KEY (campsite_detail_category_id) REFERENCES campsite_detail_category (campsite_detail_category_id)
);

DESCRIBE campsite_category;

-- campsite_detail_category
CREATE TABLE campsite_detail_category
(
    campsite_detail_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name                        VARCHAR(255) NOT NULL
);

DESCRIBE campsite_detail_category;
-- reservation
CREATE TABLE reservation
(
    reservation_id     INT PRIMARY KEY AUTO_INCREMENT,
    user_id            INT                                 NOT NULL,
    payment_id         INT,
    campsite_detail_id INT                                 NOT NULL,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    check_in           TIMESTAMP                           NOT NULL,
    check_out          TIMESTAMP                           NOT NULL,
    state              ENUM ('RESERVED', 'CHECKED_IN', 'CANCELLED') DEFAULT 'RESERVED',
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (payment_id) REFERENCES payment (payment_id),
    FOREIGN KEY (campsite_detail_id) REFERENCES campsite_detail (campsite_detail_id)
);

DESCRIBE reservation;

-- payment
CREATE TABLE payment
(
    payment_id         INT PRIMARY KEY AUTO_INCREMENT,
    user_id            INT                                 NOT NULL,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    payment_method     VARCHAR(255)                        NOT NULL,
    cost               INT                                 NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
);

DESCRIBE payment;

-- search_history
CREATE TABLE search_history
(
    search_history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id           INT                                 NOT NULL,
    content           INT                                 NOT NULL,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

DESCRIBE search_history;

ALTER TABLE search_history
    CHANGE content content VARCHAR (255) NOT NULL;