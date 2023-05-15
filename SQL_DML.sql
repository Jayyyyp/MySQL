/* 좌측의 SCHEMAS의 DATABASE는 더블클릭이나 우클릭으로도 호출할 수 있지만
use DB명; 을 수행해 호출할 수도 있다.*/

-- Workbench(윈도우)에서 수행 가능한 구문은 거의 모든 CLI 환경에서 수행 가능
-- DATABASE 변경 구문
use sys; -- use bitcamp06

/*DATABASE 정보 조회*/
show DATABASES;

-- 테이블 생성
CREATE TABLE user_tbl(
	user_num INT(5) PRIMARY KEY AUTO_INCREMENT, -- INSERT시, 숫자 자동 배정
    user_name VARCHAR(10) NOT NULL,
    user_birth_year INT NOT NULL,
    user_address CHAR(5) NOT NULL,
    user_height INT, -- 자리 수 제한 없음
    entry_date DATE -- 회원가입일PRIMARY
);

/*특정 테이블은 원래 조회할 때 
SELECT * FROM 데이터베이스명.테이블명;
형식으로 조회해야 한다.
그러나, use 구문을 이용해 데이터베이스를 지정한 경우는 데이터베이스 생략 가능*/
SELECT * FROM bitcamp06.user_tbl;
SELECT * FROM user_tbl;

USE bitcamp06;

-- PK가 걸린 컬럼은 NULL을 주면 알아서 숫자 배정
INSERT INTO user_tbl VALUES(NULL, '김자바', 1987, '서울', 180, '2002-05-03');
INSERT INTO user_tbl VALUES(NULL, '이연희', 1992, '경기', 164, '2020-05-12');
INSERT INTO user_tbl VALUES(NULL, '박종현', 1990, '부산', 177, '2022-06-01');
INSERT INTO user_tbl (user_name, user_birth_year, user_address, user_height, entry_date)
VALUES('신영웅', 1995, '광주', 172, '2020-07-15');

-- WHERE 조건절을 이용해 조회
-- 90년대 이후 출생자만 조회하기 user_birth_year가 1989보다 큰 유저만
SELECT * FROM user_tbl WHERE user_birth_year > 1989;

-- 키 175 미만만 조회하는 SELECT 문
SELECT * FROM user_tbl WHERE user_height < 175;

-- AND 혹은 OR을 이용해 조건을 두 개이상 걸 수 있다.
SELECT * FROM user_tbl WHERE user_num > 2 OR user_height < 178;

-- UPDATE 테이블명 SET 컬럼명 1 = 대입값 1, 컬럼명 2 = 대입값 2 ...
-- 주의할 점 : WHERE을 걸지 않으면 해당 컬럼의 모든 값을 통일해버린다.
UPDATE user_tbl SET user_address = '서울';

-- WHERE절 없는 UPDATE 구문 실행 방지 : 0 대입 시 해제, 1 대입시 실행
SET sql_safe_updates = 1;
SELECT * FROM user_tbl;

-- 테이블이 존재하지 않다면 삭제구문을 실행하지 않아 에러 발생하지 않음
DROP TABLE IF EXISTS user_tbl;
DROP TABLE user_tbl;

-- 김자바가 이사를 강원으로 갔습니다. 지역을 서울에서 강원으로 바꾸기
UPDATE user_tbl SET user_address = '강원' WHERE user_num = 1;

-- 삭제는 특정 컬럼만 떼서 삭제할 일이 없으므로, SELECT와 달리 * 등을 쓰지 않는다.
DELETE FROM user_tbl WHERE user_name = '박종현';

-- WHERE없이 삭제 시, TRUNCATE와 비슷하게 작동한다.
DELETE FROM user_tbl;

-- 다중 INSERT 구문 사용
/*INSERT INTO 테이블명 (컬럼1, 컬럼2, 컬럼3, ...)
	VALUES (값1, 값2, 값3, ...),
			(값 4, 값 5, 값 6);*/
INSERT INTO user_tbl
	VALUES(NULL, '강개발', 1994, '경남', 178, '2020-08-02'),
			(NULL, '최지선', 1998, '전북', 170, '2020-08-03'),
            (NULL, '류가연', 2000, '전남', 158, '2020-08-20');
SELECT * FROM user_tbl;

-- INSERT SELECT 를 이용한 데이터 삽입을 위해 user_tbl과 동일한 테이블 하나 더 만들기
CREATE TABLE user_tbl2(
	user_num INT(5) PRIMARY KEY AUTO_INCREMENT, -- INSERT시, 숫자 자동 배정
    user_name VARCHAR(10) NOT NULL,
    user_birth_year INT NOT NULL,
    user_address CHAR(5) NOT NULL,
    user_height INT, -- 자리 수 제한 없음
    entry_date DATE -- 회원가입일PRIMARY
);

-- user_tbl2에 user_tbl1의 자료 중 생년 1995년 이후인 사람의 자료만 복사해 삽입하기
INSERT INTO user_tbl2
	SELECT * FROM user_tbl
    WHERE user_birth_year > 1995;
SELECT * FROM user_tbl2;

-- 두번째 테이블인 구매내역을 나타내는 buy_tbl 생성하기
-- 어떤 유저가 무엇을 샀는지 저장하는 테이블이다.
-- 어떤 유저는 반드시 user_tbl에 존재하는 유저만 추가할 수 있다.
CREATE TABLE buy_tbl(
	buy_num INT AUTO_INCREMENT PRIMARY KEY,
    user_num INT(5) NOT NULL,
    prod_name VARCHAR(10) NOT NULL,
    prod_cate VARCHAR(10) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL 
);

-- 외래키 설정 없이 추가하기
INSERT INTO buy_tbl VALUES(NULL, 4, '아이패드', '전자기기', 100, 1);
INSERT INTO buy_tbl VALUES(NULL, 4, '애플펜슬', '전자기기', 15, 1);
INSERT INTO buy_tbl VALUES
	(NULL, 6, '트레이닝복', '의류', 10, 2),
    (NULL, 5, '안마의자', '의료기기', 400, 1),
    (NULL, 2, 'SQL책', '도서', 2, 1);
INSERT INTO buy_tbl VALUES(NULL, 99, '핵미사일', '전략무기', 100000, 5);
SELECT * FROM buy_tbl;

DELETE FROM buy_tbl WHERE buy_num = 6;
-- 외래키 설정을 통해 있지 않은 유저는 등록될 수 없도록 처리하기
-- buy_tbl이 user_tbl을 참조하는 관계

			-- 참조하는									   -- 참조자의 어떤 컬럼
ALTER TABLE buy_tbl ADD CONSTRAINT FK_buy_tbl FOREIGN KEY (user_num)
			-- 참조 당하는 테이블과 컬럼명
		REFERENCES user_tbl(user_num);
SELECT * FROM buy_tbl;

INSERT INTO buy_tbl VALUES(NULL, 199, '오픈카','승용차',1000,5);
SELECT * FROM buy_tbl;

-- 만약 user_tbl에 있는 요소를 삭제 시, buy_tbl에 구매내역이 남은 user_num을 삭제한다면
-- 특별히 on_delete를 걸지 않은 경우에는 참조 무결성 원칙에 위배되어 삭제가 되지 않는다.
DELETE FROM user_tbl WHERE user_num = 4;

-- 만약 추가적인 설정 없이 user_tbl의 4번 유저를 삭제하고 싶다면
-- 먼저 buy_tbl의 4번 유저가 남긴 구매내역을 모두 삭제해야 한다.
DELETE FROM buy_tbl WHERE user_num = 1;
DELETE FROM buy_tbl WHERE user_num = 2;

-- DELETE FROM을 이용해서 user_tbl2의 2020-08-15 이후 가입자 삭제

DELETE FROM user_tbl2 WHERE entry_date > '2020-08-15';

-- DELETE FROM을 이용해서 2020-08-03일 가입한 유저만 삭제하는 쿼리문

DELETE FROM user_tbl2 WHERE entry_date = '2020-08-03';

-- DISTINCT는 특정 컬럼에 들어있는 데이터의 "종류"만 한 번씩 나열해서 보여준다.
-- 교안을 보고 user_birth_year에 들어있는 데이터의 종류를 DISTINCT를 이용해 조회하기

SELECT DISTINCT user_birth_year FROM user_tbl;

-- 컬럼 이름을 바꿔서 조회하고 싶다면, 컬럼명 AS 바꿀 이름 형식을 쓰기
SELECT user_name AS 유저명 FROM user_tbl;
SELECT user_name AS 유저명, entry_date AS 가입날짜 FROM user_tbl;
