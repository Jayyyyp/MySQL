/*
	조인 Join
    2개 이상의 테이블을 결합, 여러 테이블에 나누어 삽입된 연관된 데이터를 결합해주는 기능
    같은 내용의 컬럼이 존재해야만 사용할 수 있음
    SELECT 테이블1.컬럼1, 테이블1.컬럼2 ... 테이블2.컬럼1, 테이블2.컬럼2 ...
    FROM 테이블1 JOIN 구문 테이블2
    ON 테이블1.공통컬럼 = 테이블2.공통컬럼;
    
    WHERE구문을 이용해 ON절로 합쳐진 결과 컬럼에 대한 필터링이 가능
*/

-- 예제 데이터를 삽입하기 위한 테이블 2개 생성(외래키 걸지않고)
CREATE TABLE member_tbl(
	mem_num INT PRIMARY KEY AUTO_INCREMENT,
    mem_name VARCHAR(10) NOT NULL,
    mem_addr VARCHAR(10) NOT NULL
);

CREATE TABLE purchase_tbl(
	pur_num INT PRIMARY KEY AUTO_INCREMENT,
    mem_num INT,
    pur_date DATETIME DEFAULT now(),
    pur_price INT
);

-- 예제 데이터 삽입
INSERT INTO member_tbl VALUES
	(NULL, '김회원', '서울'),
    (NULL, '박회원', '경기'),
    (NULL, '최회원', '제주'),
    (NULL, '박성현', '경기'),
    (NULL, '이성민', '서울'),
    (NULL, '강영호', '충북');
    
INSERT INTO purchase_tbl VALUES
	(NULL, 1, '2023-05-12', 50000),
    (NULL, 3, '2023-05-12', 20000),
    (NULL, 4, '2023-05-12', 10000),
    (NULL, 1, '2023-05-13', 40000),
    (NULL, 1, '2023-05-14', 30000),
    (NULL, 3, '2023-05-14', 30000),
    (NULL, 5, '2023-05-14', 50000),
    (NULL, 5, '2023-05-15', 60000),
    (NULL, 1, '2023-05-15', 15000);

SELECT * FROM member_tbl;
SELECT * FROM purchase_tbl;

SELECT member_tbl.mem_num, member_tbl.mem_name, member_tbl.mem_addr,
	   purchase_tbl.pur_date, purchase_tbl.pur_num, purchase_tbl.pur_price
FROM member_tbl INNER JOIN purchase_tbl
ON  member_tbl.mem_num = purchase_tbl.mem_num;

-- buy_tbl과 user_tbl이 원래 있었는데, 그 둘을 조인하기
-- user_tbl에서 조회할 컬럼 : user_name, user_address, user_num
-- buy_tbl에서 조회할 컬럼 : buy_num, prod_name, prod_cate, price, amount

SELECT user_tbl.user_name, user_tbl.user_address, user_tbl.user_num,
	   buy_tbl.buy_num, buy_tbl.prod_name, buy_tbl.prod_cate, buy_tbl.price, buy_tbl.amount
FROM user_tbl INNER JOIN buy_tbl
ON user_tbl.user_num = buy_tbl.user_num;

-- 테이블명을 전부 적으면 귀찮기 때문에 테이블명을 별칭으로 줄여 쓰기
-- FROM절에서 테이블명을 지정할 때, FROM 테이블명 별칭1 JOIN 테이블명 별칭 2
-- 형식을 사용하여 별칭을 테이블명으로 대신 쓸수있다.

SELECT m.mem_num, m.mem_name, m.mem_addr,
	   p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m INNER JOIN purchase_tbl p
ON  m.mem_num = p.mem_num;

-- buy_tbl과 user_tbl을 별칭으로 사용하여 조인하기

SELECT u.user_name, u.user_address, u.user_num,
	   b.buy_num, b.prod_name, b.prod_cate, b.price, b.amount
FROM user_tbl u INNER JOIN buy_tbl b
ON u.user_num = b.user_num;

-- LEFT JOIN, RIGHT JOIN은 JOIN절 왼쪽이나 오른쪽 테이블은 전부 데이터를 남기고
-- 반대쪽 방향 테이블은 교집합만 남긴다.
SELECT m.mem_num, m.mem_name, m.mem_addr,
	   p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m RIGHT JOIN purchase_tbl p
ON  m.mem_num = p.mem_num;

SELECT * FROM purchase_tbl;

INSERT INTO purchase_tbl VALUES
	(NULL, 8, '2023-05-16, 25000'),
    (NULL, 9, '2023-05-16, 25000'),
    (NULL, 8, '2023-05-17, 35000');

-- MySQL에서는 FULL OUTER JOIN을 지원하지 않는다.
-- 따라서, 뒤에 배울 UNION이라는 구문을 응용해 처리

-- 조인할 컬럼명이 동일하다면, ON 대신 USING(공통컬럼명) 구문 사용
SELECT m.mem_num, m.mem_name, m.mem_addr,
	   p.pur_date, p.pur_num, p.pur_price
FROM member_tbl m LEFT JOIN purchase_tbl p
USING  (mem_num);




