/*
	좌측의 SCHMAS의 DATEBASE는 더블클릭이나 우클릭으로도 호출할 수 있지만,
    user DB명; 을 수행하여 호출할 수도 있다.
*/

-- Workbench(윈도우)에서 수행 가능한 구문은 거의 모두 CLI 환경에서 수행 가능
-- DATABASE 변경 구문
USE sys; -- use bitcamp06

/* DATABASE 정보 조회 */
SHOW DATABASES;

-- 테이블생성
CREATE TABLE user_tbl(
	user_num INT(5) PRIMARY KEY AUTO_INCREMENT, # INSERT시, 숫자 자동 배정
    user_name VARCHAR(10) NOT NULL,
    user_birth_year INT NOT NULL,
    user_address CHAR(5) NOT NULL,
    user_height INT, # 자리수 제한 없음
    entry_date DATE # 회원가입일 
);

/*
	특정 테이블은 원래 조회할 때,
    SELECT * FROM 데이터베이스명.테이블명;
    형식으로 조회해야 한다.
    use 구문 등을 이용해 데이터베이스를 지정한 경우, 데이터베이스를 생략할 수 있다.
*/

SELECT * FROM bitcamp06.user_tbl;

-- PK가 걸린 컬럼은 NULL을 주면 알아서 숫자 배정
INSERT INTO user_tbl VALUES(NULL, '김자바',1987,'서울',180,'2020-05-03');
INSERT INTO user_tbl VALUES(NULL, '이연희',1992,'경기',164,'2020-05-12');
INSERT INTO user_tbl VALUES(NULL, '박종현',1990,'부산',177,'2020-06-01');

INSERT INTO user_tbl
	(user_name, user_birth_year, user_address, user_height, entry_date)
	VALUES('신영웅', 1995, '광주', 172, '2020-07-15');

-- WHERE 조건절을 이용하여 조회
-- 90년대 이후 출생자만 조회하기
SELECT * FROM user_tbl WHERE user_birth_year >= 1990;

-- 키 175 미만만 조회하는 SELECT 구문
SELECT * FROM user_tbl WHERE user_height < 175;
-- AND 혹은 OR을 이용하여 조건을 두 개 이상 걸 수 있다.
SELECT * FROM user_tbl WHERE user_num > 2 OR user_height < 175;

-- UPDATE FROM 테이블명 SET 컬럼명1 = 대입값1, 컬럼명2 = 대입값2, ...;
-- (주의) WHERE를 걸지 않으면 해당 컬럼의 모든 값을 다 통일한다.
UPDATE user_tbl SET user_address = '서울';

-- WHERE절 없는 UPDATE 구문 실행 방지, 0 대입시 해제, 1 대입시 실행 
SET sql_safe_updates = 1;
SELECT * FROM user_tbl;


DROP TABLE IF EXISTS user_tbl;
SELECT * FROM user_tbl;

-- 김자바가 강원으로 이사를 갔다.
UPDATE user_tbl SET user_address = '강원' WHERE user_num = 1;
SELECT * FROM user_tbl;

-- 삭제는 특정 컬럼만 떼서 삭제할 일이 없으므로, SELECT와 달리 * 등을 쓰지 않는다.
-- 박종현이 DB에서 삭제되는 상황
DELETE FROM user_tbl WHERE user_name = '박종현';

-- 만약, WHERE 없이 삭제시 TRUNCATE 
DELETE FROM user_tbl;

-- 다중 INSERT 구문 사용하기
/*
	INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3, ...)
	 VALUES (값1, 값2, 값3, ...),
			(값4, 값5, 값6, ...);
	컬럼명은 모든 컬럼에 값을 집어넣을 시, 생략 가능
*/
INSERT INTO user_tbl
	VALUES(NULL, '강개발', 1994, '경남', 178, '2020-08-02'),
		  (NULL, '최지선', 1998, '전북', 170, '2020-08-03'),
          (NULL, '류가연', 2000, '전남', 158, '2020-08-20');
SELECT * FROM user_tbl;





