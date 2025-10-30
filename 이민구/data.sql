USE
camfit;

-- 1️⃣ region
INSERT INTO region (region_id, name, description)
VALUES (1, '서울', '서울특별시'),
       (2, '경기도', '경기도');

SELECT *
FROM region;


-- 2️⃣ users
INSERT INTO users (user_id, username, email, password, password_confirm, phone)
VALUES (1, 'testuser', 'test@example.com', 'password', 'password', '010-1234-5678'),
       (2, 'testuser2', 'test2@example.com', 'password', 'password', '010-8765-4321');

SELECT *
FROM users;


-- 3️⃣ campsite_detail_category
INSERT INTO campsite_detail_category (campsite_detail_category_id, name)
VALUES (1, '편의시설'),
       (2, '자연환경');

SELECT *
FROM campsite_detail_category;


-- 4️⃣ payment
INSERT INTO payment (payment_id, cost, payment_method)
VALUES (1, 50000, 'credit_card'),
       (2, 75000, 'bank_transfer');

SELECT *
FROM payment;


-- 5️⃣ campsite
INSERT INTO campsite (campsite_id, title, content, region_id)
VALUES (1, '서울대공원 캠핑장', '서울대공원에 위치한 캠핑장입니다.', 2),
       (2, '가평 자라섬 캠핑장', '자라섬에 위치한 캠핑장입니다.', 2);

SELECT *
FROM campsite;


-- 6️⃣ campsite_category
INSERT INTO campsite_category (campsite_category_id, campsite_id, campsite_detail_category_id)
VALUES (1, 1, 1),
       (2, 2, 2);

SELECT *
FROM campsite_category;


-- 7️⃣ campsite_detail
INSERT INTO campsite_detail (campsite_detail_id, title, content, campsite_id)
VALUES (1, 'A-1', '데크', 1),
       (2, 'B-2', '파쇄석', 2);

SELECT *
FROM campsite_detail;


-- 8️⃣ campsite_stock
INSERT INTO campsite_stock (campsite_stock_id, campsite_detail_id, total_stock, reserved_stock, available_stock)
VALUES (1, 1, 10, 2, 8),
       (2, 2, 20, 5, 15);

SELECT *
FROM campsite_stock;


-- 9️⃣ location
INSERT INTO location (location_id, campsite_id, latitude, longitude, address)
VALUES (1, 1, 37.426, 127.01, '경기도 과천시 대공원광장로 102'),
       (2, 2, 37.81, 127.52, '경기도 가평군 가평읍 자라섬로 60');

SELECT *
FROM location;


-- 🔟 camping_log
INSERT INTO camping_log (camping_log_id, campsite_id, user_id, content)
VALUES (1, 1, 1, '가족과 함께 즐거운 시간이었습니다.'),
       (2, 2, 2, '조용하고 좋았어요.');

SELECT *
FROM camping_log;


-- 11️⃣ reservation
INSERT INTO reservation (reservation_id, user_id, payment_id, check_in, check_out)
VALUES (1, 1, 1, '2025-11-01 14:00:00', '2025-11-02 11:00:00'),
       (2, 2, 2, '2025-11-08 14:00:00', '2025-11-09 11:00:00');

SELECT *
FROM reservation;


-- 12️⃣ search_history
INSERT INTO search_history (search_history_id, user_id, content)
VALUES (1, 1, '서울 캠핑장'),
       (2, 2, '가평 캠핑장');

SELECT *
FROM search_history;
