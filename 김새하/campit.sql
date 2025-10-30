-- 데이터베이스 생성
CREATE DATABASE camfit;
USE camfit;
SHOW TABLES;

-- 테이블 생성
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



-- 셈플데이터 삽입
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

