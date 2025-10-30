USE camfit;

-- 1. 기본 CRUD 쿼리

-- 1.1. CREATE (생성)

-- 새 사용자 등록
INSERT INTO users (username, email, password, phone) VALUES
('maengku', 'maeng@example.com', 'kuku567!', 01088889696);
SELECT * FROM users;

-- 새로운 캠핑장 추가
INSERT INTO campsite (title, content, region_id) VALUES
('양평 약수동산 캠핑장', '양평에 위치한 캠핑장입니다.', 2);
SELECT * FROM campsite;

-- 새 예약 생성 (특정 사용자, 특정 캠핑장 상세)
-- 먼저 campsite_detail_id 와 user_id, payment_id를 확인해야 합니다.
INSERT INTO reservation (user_id, payment_id, check_in, check_out) VALUES
(13, 1, '2025-12-10 15:00', '2025-12-12 11:00');
SELECT * FROM reservation;

-- 캠핑 로그 작성
INSERT INTO camping_log (campsite_id, user_id, content) VALUES
(3, 13, '떡잎방범대 친구들과 재밌게 놀았어요.');
SELECT * FROM camping_log;

-- 1.2. READ (조회)

-- 특정 사용자 정보 조회
SELECT * FROM users
WHERE user_id = 13;

-- 특정 캠핑장의 상세 정보 조회 (캠핑장 기본 정보, 위치, 편의시설 카테고리 포함)
SELECT * FROM campsite
WHERE campsite_id = 3;

-- 특정 예약 상세 내역 조회 (사용자 정보, 결제 정보 포함)
SELECT * FROM reservation
WHERE reservation_id = 3;

-- 1.3. UPDATE (수정)

-- 사용자 연락처 정보 수정
UPDATE users
SET
	phone = '01088889696'
WHERE user_id = 13;
SELECT * FROM users;

-- 캠핑장 설명 수정
UPDATE campsite
SET
	content = '양평에 위치한 리버뷰 캠핑장입니다.'
WHERE campsite_id = 3;
SELECT * FROM campsite;

-- 예약 날짜 변경
UPDATE reservation
SET 
	check_in = '2025-12-09 15:00'
WHERE reservation_id =3;
SELECT * FROM reservation;

-- 1.4. DELETE (삭제)

-- 특정 캠핑 로그 삭제
DELETE FROM camping_log
WHERE camping_log_id = 3;
SELECT * FROM camping_log;

-- 예약 취소
DELETE FROM reservation
WHERE reservation_id = 3;
SELECT * FROM reservation;

-- 2. 핵심 기능 쿼리

-- 2.1. 특정 지역(예: 경기도)의 모든 캠핑장 목록 조회
SELECT *
FROM campsite
JOIN region ON campsite.region_id = region.region_id
WHERE region.name = '경기도';

-- 2.2. 특정 캠핑장의 모든 캠핑 로그와 작성자 정보 조회
SELECT cl.content, cl.user_id
FROM campsite c
JOIN camping_log cl ON c.campsite_id = cl.campsite_id
WHERE c.campsite_id = 3;

-- 2.3. 특정 사용자의 모든 예약 내역 조회
SELECT *
FROM reservation r
JOIN users u ON r.user_id = u.user_id
WHERE u.user_id = 13;

-- 2.4. 현재 예약 가능한 캠핑 사이트 목록 조회 (재고가 1 이상)
SELECT *
FROM campsite c
JOIN campsite_detail cd ON c.campsite_id = cd.campsite_id
JOIN campsite_stock cs ON cd.campsite_detail_id = cs.campsite_detail_id
WHERE cs.available_stock >= 1;

-- 2.5. 사용자의 검색 기록 조회
SELECT * 
FROM search_history sh
JOIN users u ON sh.user_id = u.user_id
WHERE u.user_id = 1;

-- 3. 고급 쿼리

-- 3.1. 가장 예약이 많은 캠핑장 Top 5 (인기 캠핑장)
SELECT 
	c.title,
	COUNT(r.campsite_detail_id) AS reserv_count
FROM campsite c
JOIN campsite_detail cd ON c.campsite_id = cd.campsite_id
JOIN reservation r ON cd.campsite_detail_id = r.campsite_detail_id
GROUP BY c.campsite_id
ORDER BY reserv_count DESC;

-- 3.2. 가장 많은 예약을 한 사용자 Top 5 (우수 고객)
SELECT 
	u.username,
    COUNT(r.campsite_detail_id) AS reserv_count
FROM users u
JOIN reservation r ON u.user_id = r.user_id
GROUP BY u.user_id
ORDER BY reserv_count DESC;


-- 3.3. 월별 총 매출액 계산
SELECT
    DATE_FORMAT(p.created_at, '%Y-%m') AS month,
    SUM(p.cost) AS total_revenue,
    COUNT(r.reservation_id) AS reservation_count
FROM payment p
LEFT JOIN reservation r ON p.payment_id = r.payment_id
GROUP BY month
ORDER BY month;

