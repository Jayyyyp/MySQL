-- DATABASE 생성 명령
CREATE DATABASE bitcamp06 DEFAULT CHARACTER SET UTF8;

/* 
	데이터베이스 조회
	 좌측 하단 중간쯤의 Schemas를 클릭
     새로고침하고, bitcamp06이 생성된 것이 확인되면 우클릭
     set as default schemas 선택시, 볼드처리되고, 지금부터 적는 쿼리문이 해당 DB에 들어간다는 의미 
*/

/*
	해당 DB에 접근할 수 있는 사용자 계정 생성
    USER - id 역할, IDENTIFIED BY - pw 역할
*/
CREATE USER 'adminid' IDENTIFIED BY '2023502';

/*
	사용자에게 권한 부여 : GRANT 주고싶은 기능1, 기능 2, etc..
    만약, 모든 권한을 주고 싶다면 ALL PRIVILEGES ON (모든 권한) TO 부여 대상 계정
*/
GRANT ALL PRIVILEGES ON bitcamp06.* TO 'adminid';

/*
	테이블 생성 명령
	 PRIMARY KEY : 컬럼의 주요 키를 뜻하고, 중복 데이터 방지도 겸한다.
     모든 테이블의 컬럼 중 하나는 반드시 PK 속성이 부여되어있어야 한다.
     NOT NULL : 해당 컬럼을 비워둘 수 없다는 의미
     UNIQUE : 중복 데이터가 입력되는 것을 방지한다.
*/
CREATE TABLE users(
	u_number INT(3) PRIMARY KEY,
    u_id VARCHAR(20) UNIQUE NOT NULL,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
);

/*
	데이터 적재
	 INSERT INTO 테이블명(컬럼1, 컬럼2, ...) VALUES (값1, 값2, ...);
     만약 모든 컬럼에 값을 넣는다면 위 구문에서 테이블 명 다음 오는 컬럼명 생략 가능
*/
INSERT INTO users(u_number, u_id, u_name, email) VALUES
	(1, 'abc1234', '가나다', NULL);
INSERT INTO users VALUES (2, 'abc3456', '마바사', 'abc@ab.com');

/*
	데이터 조회
    SELECT * FROM 테이블명; 으로 조회 가능
    해당 테이블에 적재된 컬럼의 데이터 조회 가능
    SELECT (컬럼명1, 컬럼명2, ...) FROM 테이블명;
    으로 특정 컬럼에 적재되어있는 데이터만 조회도 가능
*/
SELECT * FROM users;

/*
	3번유저 임의 추가하기
    조회구문은 이메일, 회원번호, 아이디 순으로 세 컬럼만 조회하는 구문
*/
INSERT INTO users VALUES (3, 'dfs6789', '아자차', NULL);

SELECT email, u_number, u_id FROM users;

/*
	계정을 하나 더 생성하여 SELECT 권한만 주기
*/
CREATE USER 'adminid2' IDENTIFIED BY '2023502';
GRANT SELECT ON bitcamp06.* TO 'adminid2';

-- users 테이블에 주소컬럼 추가하기
-- ALTER TABLE 테이블명 ADD (추가컬럼명 자료타입(크기));
ALTER TABLE users ADD (u_address VARCHAR(30));

SELECT * FROM users;

-- users 테이블에서 이메일 컬럼 삭제하기
ALTER TABLE users DROP COLUMN email;

-- u_addresss 컬럼에 UNIQUE 제약조건 별칭 부여해서 걸기
ALTER TABLE users ADD CONSTRAINT u_address_unique UNIQUE (u_address);

-- INSERT INTO 구문으로 7, 8번 유저 추가하기 주소는 둘 다 강남구로 넣기

INSERT INTO users(u_number, u_id, u_name, u_address) VALUES
	(7, 'HIJ', '타파하', '강남구');
INSERT INTO users(u_number, u_id, u_name, u_address) VALUES
	(8, 'KLN', '기니디', '강남구');
SELECT * FROM users;

-- 주소에 걸린 UNIQUE제약을 없애고 8번 마저 추가하기

ALTER TABLE users DROP CONSTRAINT u_address_unique;

INSERT INTO users(u_number, u_id, u_name, u_address) VALUES
	(8, 'KLN', '기니디', '강남구');

-- users 테이블명을 members로 바꾸기
RENAME TABLE users TO members;
SELECT * FROM members;

-- TRUNCATE TABLE은 내부 데이터만 소각하고, 빈 테이블은 남아있는다.
TRUNCATE TABLE members;
SELECT * FROM members;

-- DROP TABLE은 내부 데이터 및 테이블 구조 자체를 없앤다.
DROP TABLE members;
SELECT * FROM members;
