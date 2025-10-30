-- lounge 셈플데이터 삽입
INSERT INTO users (username, email,  password, phone) VALUES 
('chulsoo', 'chulsoo@example.com', 'chul234', '01012345678'),
('minji', 'minji@example.com', 'minji567', '01023456789'),
('haneul', 'haneul@example.com', 'sky789', '01034567890'),
('jisoo', 'jisoo@example.com', 'jsoo111', '01045678901'),
('taehyun', 'taehyun@example.com', 'tae432', '01056789012'),
('sohee', 'sohee@example.com', 'hee998', '01067890123'),
('junho', 'junho@example.com', 'junho222', '01078901234'),
('yuri', 'yuri@example.com', 'yurixyz', '01089012345'),
('dongmin', 'dongmin@example.com', 'dmin777', '01090123456'),
('suhyun', 'suhyun@example.com', 'suhyun555', '01011223344'),
('arin', 'arin@example.com', 'arin999', '01022334455');

INSERT INTO posts (user_id, content) VALUES
(1, '제주도 여행 중 찍은 사진입니다! 🌴'),
(2, '오늘 점심으로 먹은 파스타가 정말 맛있었어요 🍝'),
(3, '새로 산 노트북 개봉기 💻✨'),
(4, '주말에 친구들과 등산 다녀왔어요 ⛰️'),
(5, '요즘 읽고 있는 책이 너무 감동적이에요 📚'),
(6, '우리집 고양이 너무 귀엽죠? 🐱'),
(7, '회사에서 프로젝트 발표 끝! 이제 한숨 돌립니다 😮‍💨'),
(8, '첫 마라톤 완주! 다리 아프지만 뿌듯해요 🏃‍♂️'),
(9, '새로운 커피숍 발견☕ 분위기가 정말 좋아요.'),
(10, '비 오는 날엔 라디오 들으면서 쉬는 게 최고네요 🌧️');


INSERT INTO comments (user_id, post_id, content) VALUES
(1, 2, '멋진 사진이네요!'),
(2, 1, '제주도 정말 가보고 싶어요 🌴'),
(3, 4, '등산 코스가 어디인가요? 뷰가 멋져요!'),
(4, 6, '고양이 너무 귀엽네요 🐾'),
(5, 3, '노트북 모델이 어떤 건가요?'),
(6, 5, '저도 그 책 읽고 감동받았어요 📚'),
(7, 8, '완주 축하드려요! 대단하세요 💪'),
(8, 9, '저 커피숍 분위기 좋아 보이네요 ☕'),
(9, 10, '비 오는 날엔 확실히 여유롭죠 😊'),
(10, 7, '프로젝트 발표 수고 많으셨어요!');


INSERT INTO likes (user_id, post_id) VALUES
(1, 2),
(2, 2),
(3, 1),
(1, 3),
(4, 1),
(5, 4),
(6, 6),
(7, 8),
(8, 9),
(9, 10),
(10, 5);

INSERT INTO keeps (user_id, post_id) VALUES
(1, 3),
(2, 1),
(3, 2),
(4, 5),
(5, 6),
(6, 4),
(7, 9),
(8, 8),
(9, 10),
(10, 7);

INSERT INTO media (related_type, related_id, media_type, media_url, media_order) VALUES
-- posts
('posts', 1, 'IMAGE', '/uploads/posts/1_jeju_beach.jpg', 1),
('posts', 1, 'IMAGE', '/uploads/posts/1_sunset.jpg', 2),
('posts', 2, 'VIDEO', '/uploads/posts/2_cafe_vlog.mp4', 1),
('posts', 3, 'IMAGE', '/uploads/posts/3_hiking.jpg', 1),
('posts', 4, 'IMAGE', '/uploads/posts/4_food_trip.jpg', 1),

-- product
('product', 1, 'IMAGE', '/uploads/products/1_main.jpg', 1),
('product', 1, 'IMAGE', '/uploads/products/1_detail_1.jpg', 2),
('product', 2, 'IMAGE', '/uploads/products/2_main.jpg', 1),
('product', 3, 'VIDEO', '/uploads/products/3_review.mp4', 1),
('product', 4, 'IMAGE', '/uploads/products/4_thumbnail.jpg', 1),

-- camping_log
('camping_log', 1, 'IMAGE', '/uploads/camping/1_tent_setup.jpg', 1),
('camping_log', 1, 'IMAGE', '/uploads/camping/1_campfire.jpg', 2),
('camping_log', 2, 'VIDEO', '/uploads/camping/2_morning_scenery.mp4', 1),
('camping_log', 3, 'IMAGE', '/uploads/camping/3_mountain_view.jpg', 1),
('camping_log', 4, 'IMAGE', '/uploads/camping/4_river_side.jpg', 1);



-- product 셈플데이터 삽입
INSERT INTO product (product_name, product_price, free_shipping)
VALUES
('캠핑용 텐트 A', 89000, 1),
('캠핑 체어 B', 45000, 0),
('랜턴 C', 32000, 1),
('캠핑 테이블 D', 56000, 0),
('휴대용 버너 E', 41000, 1),
('코펠 세트 F', 38000, 0),
('보온병 G', 22000, 1),
('수납함 H', 27000, 0),
('침낭 I', 65000, 1),
('해먹 J', 49000, 1);

INSERT INTO brand (brand)
VALUES
('캠프라인'),
('코베아'),
('스노우피크'),
('노르디스크'),
('헬리녹스'),
('블랙야크'),
('네이처하이크'),
('캠핑앤피크'),
('미니멀웍스'),
('아이더');

INSERT INTO product_brand (brand_id, product_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO category (category_name)
VALUES
('텐트/타프'),
('의자/테이블'),
('조명'),
('조리도구'),
('취사장비'),
('수납용품'),
('보온용품'),
('침구류'),
('휴식용품'),
('기타');

INSERT INTO product_category (product_id, category_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(5, 4),
(6, 4),
(7, 7),
(8, 6),
(9, 8),
(10, 9);

INSERT INTO product_detail (product_id, shipping_info, return_info, product_info, seller_info)
VALUES
(1, '무료배송 / 2~3일 소요', '7일 이내 교환 가능', '폴리에스터 원단, 방수 처리', '캠프라인 공식몰'),
(2, '3,000원 유료배송', '상품 수령 후 7일 이내 교환 가능', '알루미늄 프레임, 접이식', '코베아 직영'),
(3, '무료배송 / 당일 출고', '불량시 즉시 교환', '충전식 랜턴, 밝기 조절 가능', '스노우피크 코리아'),
(4, '유료배송 / 2일 내 출고', '단순 변심 불가', '내열 내수 테이블', '노르디스크'),
(5, '무료배송 / 제주 추가요금', '교환/반품 가능', '가스식 휴대용 버너', '헬리녹스 온라인샵'),
(6, '3,000원 배송비', '상품 불량시 교환', '스테인리스 5종 세트', '블랙야크 스토어'),
(7, '무료배송', '단순 변심 5일 이내 반품 가능', '보온력 우수한 스테인리스', '네이처하이크'),
(8, '2,500원 배송비', '교환 불가', '폴리프로필렌 수납박스', '캠핑앤피크'),
(9, '무료배송', '7일 이내 교환 가능', '솜 충전, 방한 기능 우수', '미니멀웍스'),
(10, '무료배송 / 1일 출고', '파손시 교환 가능', '통기성 원단 해먹', '아이더 공식몰');

INSERT INTO product_stock (product_id, quantity)
VALUES
(1, 50),
(2, 20),
(3, 80),
(4, 30),
(5, 40),
(6, 25),
(7, 60),
(8, 35),
(9, 15),
(10, 45);

INSERT INTO stock_history (product_id, quantity_change, reason)
VALUES
(1, +50, '초기 입고'),
(2, +20, '초기 입고'),
(3, +80, '초기 입고'),
(4, +30, '초기 입고'),
(5, +40, '초기 입고'),
(6, +25, '초기 입고'),
(7, +60, '초기 입고'),
(8, +35, '초기 입고'),
(9, +15, '초기 입고'),
(10, +45, '초기 입고');

INSERT INTO review (user_id, product_id, content)
VALUES
(1, 1, '텐트 설치도 쉽고 방수도 잘 됩니다.'),
(2, 2, '의자 튼튼하고 접을 때 부드러워요.'),
(3, 3, '랜턴 밝기가 조절되어 너무 좋아요.'),
(4, 4, '테이블 무게감이 있어서 안정적입니다.'),
(5, 5, '버너 화력 좋고 가벼워서 만족해요.'),
(1, 6, '코펠 세트 깔끔하고 가성비 좋아요.'),
(2, 7, '보온병 하루종일 따뜻하게 유지돼요.'),
(3, 8, '수납함 크기 적당하고 실용적이에요.'),
(4, 9, '침낭 따뜻하고 부드러워서 만족합니다.'),
(5, 10, '해먹 편하고 튼튼해서 추천합니다.');

