USE camfit;
-- 1. 기본 CRUD 쿼리
-- 1.1. CREATE (생성)
-- 새 사용자 등록
SELECT *
FROM users;

INSERT INTO users (username, email, password, phone)
VALUES ('김갑수', 'glwer@naver.com', '02131ddc', '01083280001');
-- 새로운 캠핑장 추가
SELECT *
FROM campsite;
INSERT INTO campsite (title, content, phone, certification, open_date, region_id)
VALUES ('남양주한산', '남양주 뷰입니다', '01034233345', 1, current_timestamp, 2);

-- 새 예약 생성 (특정 사용자, 특정 캠핑장 상세)
-- 먼저 campsite_detail_id 와 user_id, payment_id를 확인해야 합니다.
ALTER TABLE payment
    ADD COLUMN user_id INT NOT NULL;

ALTER TABLE payment
    ADD FOREIGN KEY (user_id) REFERENCES users (user_id);

DESCRIBE users;
DESCRIBE payment;

SELECT *
FROM payment;

SELECT *
FROM campsite_detail;

SELECT *
FROM users;

SELECT *
FROM reservation;

DESCRIBE reservation;

INSERT INTO reservation (payment_id, check_in, check_out, user_id)
VALUES (NULL, '2025-11-01 15:00:00', '2025-11-03 11:00:00', 1);

-- 캠핑 로그 작성
SELECT *
FROM camping_log;
DESCRIBE camping_log;

INSERT INTO camping_log (campsite_id, user_id, content)
VALUES (1, 1, '사장님이 친절해요');


-- 1.2. READ (조회)

-- 특정 사용자 정보 조회
SELECT *
FROM users
WHERE user_id = 1;

-- 특정 캠핑장의 상세 정보 조회 (캠핑장 기본 정보, 위치, 편의시설 카테고리 포함)
SELECT *
FROM campsite
WHERE campsite.campsite_id = 1;

-- 특정 예약 상세 내역 조회 (사용자 정보, 결제 정보 포함)
SELECT *
FROM reservation
WHERE reservation.reservation_id = 4;


-- 1.3. UPDATE (수정)
-- 사용자 연락처 정보 수정
SELECT *
FROM users;

UPDATE users
SET users.username = '철수'
WHERE user_id = 1;

-- 캠핑장 설명 수정
SELECT *
FROM campsite;
UPDATE campsite
SET content = '남양주는 안보입니다.'
WHERE campsite_id = 6;

-- 예약 날짜 변경
SELECT *
FROM reservation;

ALTER TABLE reservation
    ADD COLUMN campsite_detail_id INT NOT NULL;

ALTER TABLE reservation
    ADD FOREIGN KEY (campsite_detail_id) REFERENCES campsite_detail (campsite_detail_id);
DESCRIBE  reservation;

UPDATE reservation
SET campsite_detail_id = 1
WHERE campsite_detail_id = "";

-- 1.4. DELETE (삭제)

-- 특정 캠핑 로그 삭제
DELETE FROM camping_log
where camping_log_id = 4;
-- 예약 취소
DELETE FROM reservation
where reservation_id = 5;

-- 2. 핵심 기능 쿼리

-- 2.1. 특정 지역(예: 경기도)의 모든 캠핑장 목록 조회
SELECT title, content
FROM campsite
WHERE region_id = (SELECT region_id FROM region WHERE name = '경기도');

-- 2.2. 특정 캠핑장의 모든 캠핑 로그와 작성자 정보 조회
SELECT
    cl.content,
    u.username
FROM camping_log cl
         JOIN users u ON cl.user_id = u.user_id
WHERE cl.campsite_id = 1;

-- 2.3. 특정 사용자의 모든 예약 내역 조회
SELECT
    r.reservation_id,
    c.title as campsite_title,
    r.check_in,
    r.check_out
FROM reservation r
         JOIN campsite_detail cd ON r.reservation_id = cd.campsite_detail_id -- 이 부분은 스키마에 따라 JOIN 대상이 달라질 수 있습니다.
         JOIN campsite c ON cd.campsite_id = c.campsite_id
WHERE r.user_id = 1;

-- 2.4. 현재 예약 가능한 캠핑 사이트 목록 조회 (재고가 1 이상)
SELECT
    c.title as campsite_title,
    cd.title as detail_title,
    cs.available_stock
FROM campsite_stock cs
         JOIN campsite_detail cd ON cs.campsite_detail_id = cd.campsite_detail_id
         JOIN campsite c ON cd.campsite_id = c.campsite_id
WHERE cs.available_stock > 0;

-- 2.5. 사용자의 검색 기록 조회
SELECT content
FROM search_history
WHERE user_id = 1
ORDER BY search_history_id DESC;


-- 3. 고급 쿼리

-- 3.1. 가장 예약이 많은 캠핑장 Top 5 (인기 캠핑장)
SELECT
    c.title,
    COUNT(r.reservation_id) as reservation_count
FROM reservation r
         JOIN campsite_detail cd ON r.campsite_detail_id = cd.campsite_detail_id
         JOIN campsite c ON cd.campsite_id = c.campsite_id
GROUP BY c.campsite_id
ORDER BY reservation_count DESC
    LIMIT 5;

-- 3.2. 가장 많은 예약을 한 사용자 Top 5 (우수 고객)
SELECT
    u.username,
    COUNT(r.reservation_id) as total_reservations
FROM users u
         JOIN reservation r ON u.user_id = r.user_id
GROUP BY u.username
ORDER BY total_reservations DESC
    LIMIT 5;

-- 3.3. 월별 총 매출액 계산
SELECT
    DATE_FORMAT(r.check_in, '%Y-%m') as month,
    SUM(p.cost) as total_revenue
FROM reservation r
    JOIN payment p ON r.payment_id = p.payment_id
GROUP BY month
ORDER BY month;

-- 3.4. 윈도우 함수(Window Function)를 사용하여 지역별 예약 순위 매기기
SELECT
    c.title,
    r.name as region,
    COUNT(res.reservation_id) as reservation_count,
    RANK() OVER (PARTITION BY r.name ORDER BY COUNT(res.reservation_id) DESC) as ranking_in_region
FROM reservation res
         JOIN campsite_detail cd ON res.reservation_id = cd.campsite_detail_id -- 스키마 확인 필요
         JOIN campsite c ON cd.campsite_id = c.campsite_id
         JOIN region r ON c.region_id = r.region_id
GROUP BY c.title, r.name
ORDER BY r.name, ranking_in_region;
