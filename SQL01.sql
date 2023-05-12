/*실행은 ctrl + enter
데이터베이스 생성 명령
데이터베이스 내부에 테이블들이 적재되기 때문에 먼저
데이터베이스를 생성해야 한다.
Default CHARCTER SET UTF8; 을 붙혀alter
한글설정으로 만든다.*/
CREATE DATABASE bitcamp06 DEFAULT CHARACTER SET UTF8;

/*데이터베이스 조회는 좌측 하단 중간의 SCHEMAS 클릭하고 -> 새로고침한 다음
bitcamp06이 생성된게 확인되면 우클릭 -> SET AS DEFAULT SCHMAS 선택시,
볼드처리되고 지금부터 적는 쿼리문은 해당 DB에 들어간다는 의미이다.*/

/*해당 DB에 접근할 수 있는 사용자 계정 생성
USER - ID 역할, IDENTIFIED BY - PW역할*/
CREATE USER 'adminid' IDENTIFIED BY '2023502';

/*사용자에게 권한 부여 : GRANT 주고싶은기능1, 기능2, ...
만약, 모든 권한을 주고 싶다면 ALL PRIVILEGES(모든권한)TO 부여대상계정*/
GRANT ALL PRIVILEGES ON bitcamp06.* TO 'adminid';

/*테이블 생성 명령
PRIMARY KEY : 컬럼의 주요 키를 뜻하고, 중복 데이터 방지도 겸함
모든 테이블의 컬럼 중 하나는 반드시 PK속성이 부여되어있어야 함
NOT NULL : 해당 컬럼을 비워둘 수 없다는 의미
UNIQUE : 중복데이터 입력 방지*/
CREATE TABLE users(
	u_number INT(3) PRIMARY KEY,
    u_id VARCHAR(20) UNIQUE NOT NULL,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
    );

/*데이터 적재
INSERT INTO 테이블명(컬럼1, 컬럼2,...) VALUES(값1, 값2, ...)
만약, 모든 컬럼에 값을 넣는다면 위 구문에서 테이블명 다음 오는 컬럼명 생략 가능*/
INSERT INTO users(u_number, u_id, u_name, email) VALUES 
	(1, 'abc1234', '가나다', NULL);
INSERT INTO users VALUES(2, 'abc3456', '마바사', 'abc@ab.com');

/*테이블 조회
SELECT * FROM 테이블명; 을 적으면
해당 테이블에 적재된 데이터를 조회할 수 있다.
SELECT (컬럼명1, 컬럼명2,...) FROM 테이블명;
을 이용해 특정 컬럼에 적재된 데이터만 조회 가능하다.*/

/*문제
3번 유저 임의로 추가하기
조회구문은 이메일, 회원번호, 아이디 순으로 세 컬럼만 조회하는 구문*/
INSERT INTO users (u_id, u_number, u_name)VALUES('abcde45', 3, '아자차');
SELECT email, u_number, u_id FROM users;

/*계정 하나 더 생성하기
이번 계정은 SELECT 권한 주기*/
CREATE USER 'adminid2' IDENTIFIED BY '2023502';
GRANT SELECT ON bitcamp06.* TO 'adminid2';


-- users 테이블에 주소 컬럼 추가하기
-- ALTER TABLE 테이블명 ADD (추가컬럼명 자료타입(크기));
ALTER TABLE users ADD (u_address varchar(30));

SELECT * FROM users;

-- 이메일 컬럼 삭제하기
ALTER TABLE users DROP email;

-- u_address 컬럼에 UNIQUE 제약조건 별칭 부여해서 걸기
ALTER TABLE users ADD CONSTRAINT u_address_unique UNIQUE (u_address);

-- INSERST INTO 구문으로 7, 8번 유저 추가하기
-- 단, 주소는 둘 다 '강남구'로 넣으려고 시도하기

INSERT INTO users (u_id, u_number, u_address, u_name)VALUES ('ASDF', 7, '강남구', '에에베');
INSERT INTO users VALUES ('SADFSF', 8, '강남구', '에베베');

-- 주소에 걸린 UNIQUE 제약 없애고 8번 마저 추가하기
ALTER TABLE users DROP CONSTRAINT u_address_unique;
INSERT INTO users (u_id, u_number, u_address, u_name)VALUES ('ASEF', 8, '강남구', '에베베');

-- users 테이블명을 members로 바꾸기
RENAME TABLE users TO members;

-- TRUNCATE TABLE은 내부 데이터만 소각하고, 빈 데이터는 남아있는다.
TRUNCATE TABLE members;
SELECT * FROM members;

-- DROP TABLE은 내부 데이터 및 테이블 구조 자체를 없앤다.
DROP TABLE members;
SELECT * FROM members;


