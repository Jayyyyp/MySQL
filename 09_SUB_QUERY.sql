-- SUB QUERY란 쿼리문 내에 쿼리문을 중첩하는 것
-- 기본적으로 SELECT문의 범위를 좁히는 경우 많이 사용한다.

-- 회원별 평균 키를 구하는 GROUP BY 구문을 수행한다.
SELECT AVG(user_height) FROM user_tbl;

SELECT user_name, AVG(user_height) FROM user_tbl
GROUP BY user_name;
-- GROUP BY는 우선 동명이인을 하나의 집단으로 보기 때문에 문제가 되고,
-- 하나의 테이블에 전체 평균을 넣을 수 없다.
-- 이 경우 서브쿼리를 이용한다.

SELECT user_name, (SELECT AVG(user_height) FROM user_tbl) AS avg_height FROM user_tbl;

-- FROM절 SUB QUERY를 활용한 범위좁히기 개념
-- FROM절 다음에는 테이블명만 올 수 있는게 아니고, 데이터 시트 형식을 갖춘 자료이면,
-- 모든 형태의 자료를 적어줄 수 있다.
-- user_tbl 중 키가 170 미만인 요소만 1차적으로 조회한 결과시트를 토대로 전체 데이터 조회구문 
-- 서브쿼리를 FROM절에서 사용할 때는 별칭을 무조건 붙혀야 한다.
SELECT A.* FROM 
	(SELECT * FROM user_tbl WHERE user_height < 170) A;
    
SELECT * FROM user_tbl;

-- 서브쿼리의 실제 활용 : 최지선보다 키가 큰 사람을 한 줄로 결과 얻기
-- 기존 방식으로 처리하는 경우
-- 1. 최지선의 키를 WHERE 절을 이용해 확인
SELECT user_height FROM user_tbl WHERE user_name = '최지선';

-- 2. 얻은 170을 토대로 쿼리문에 다시 WHERE절로 집어넣어 조회
SELECT * FROM user_tbl WHERE user_height > 170;

-- 개선방안 : WHERE절에, user_height > (서브쿼리로 최지선의 키를 구하기);
SELECT * FROM user_tbl WHERE user_height >
(SELECT user_height FROM user_tbl WHERE user_name = '최지선');

-- 위 코드를 참조해서 평균보다 체중이 낮은 사람만 조회하는 서브쿼리문
SELECT * FROM user_tbl 
	WHERE user_weight < (SELECT AVG(user_weight) FROM user_tbl);

-- 지역이 경기인 사람들 중 키가 제일 큰 사람보다 키가 더 큰 사람 조회하기
SELECT * FROM user_tbl
	WHERE user_height > (SELECT MAX(user_height) FROM user_tbl WHERE user_address = '경기');

-- 전체 평균보다 키가 큰 지역에 속하는 유저만 출력하기
SELECT * FROM user_tbl -- 전체 테이블에서
	WHERE user_address IN  -- user_address가 속하는
    (SELECT user_address FROM user_tbl  -- 키가 큰 지역
    WHERE user_height > (SELECT AVG(user_height) FROM user_tbl) -- 전체키평균보다
GROUP BY user_address);














