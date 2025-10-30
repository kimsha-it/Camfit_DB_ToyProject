-- 데이터베이스 생성
CREATE DATABASE camfit;
USE camfit;
SHOW TABLES;

-- lounge 테이블 생성
CREATE TABLE users (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    password_confirm VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    phone INT NOT NULL
);

CREATE TABLE posts (
	post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
	comment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (post_id) REFERENCES posts(post_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE likes (
	like_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT NOT NULL,
    post_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (post_id) REFERENCES posts(post_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE keeps (
	keep_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT NOT NULL,
    post_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (post_id) REFERENCES posts(post_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE media (
	media_id INT PRIMARY KEY AUTO_INCREMENT,
    related_type VARCHAR(100) NOT NULL,
    relaed_id INT NOT NULL,
    media_type ENUM('IMAGE', 'VIDEO') NOT NULL,
    media_url VARCHAR(255) NOT NULL,
    media_order INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- product 테이블 생성
CREATE TABLE product (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(50) NOT NULL,
product_price INT NOT NULL,
free_shipping INT NOT NULL
);

CREATE TABLE product_brand (
	id INT PRIMARY KEY AUTO_INCREMENT,
    brand_id INT NOT NULL,
    product_id INT NOT NULL
);

CREATE TABLE brand (
	brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50) NOT NULL
);

CREATE TABLE product_category (
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    category_id INT NOT NULL
);

CREATE TABLE category (
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE product_detail (
	product_id INT NOT NULL,
    shipping_info TEXT NOT NULL,
    return_info TEXT NOT NULL,
    product_info TEXT NOT NULL,
    seller_info TEXT NOT NULL
);

CREATE TABLE product_stock (
	product_id INT NOT NULL,
    quantity INT NOT NULL,
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stock_history (
	history_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    quantity_change INT NOT NULL,
    reason VARCHAR(100) NOT NULL,
    field TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE review (
	review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    content VARCHAR(5000) NOT NULL
);

