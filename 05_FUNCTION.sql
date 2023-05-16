-- 영어로 된 사람 추가하기
SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES
		(NULL, 'alex', 1986, 'NY', 173, '2020-11-01'),
        (NULL, 'Smith', 1992, 'TEXAS', 181, '2020-11-05'),
        (NULL, 'Emma', 1995, 'TAMPA', 168, '2020-12-13'),
        (NULL, 'JANE', 1996, 'LA', 157, '2020-12-15');

-- 문자열 함수를 활용해 하나의 컬럼을 여러 형식으로 조회
SELECT
	user_name,
    UPPER(user_name) AS 대문자유저명,
    LOWER(user_name) AS 소문자유저명,
    LENGTH(user_name) AS 문자길이,
    SUBSTR(user_name, 1, 2) AS 첫글자두번째글자,
    CONCAT(user_name, '회원이 존재합니다.') AS 회원목록
FROM user_tbl;

-- 이름이 4글자 이상인 유저만 출력하기
SELECT user_name FROM user_tbl WHERE CHAR_LENGTH(user_name) > 3;

-- 함수 도움없이 4글자 뽑기
SELECT * FROM user_tbl WHERE user_name LIKE "____%";

-- user_tbl에 소수점 아래를 저장받을 수 있는 컬럼 추가하기
-- DECIMAL은 고정자리수 이므로 반드시 소수점 아래 2자리까지 표시해야 함
-- 전체 3자리 중 소수점 아래에 두 자리를 배정하겠다.
ALTER TABLE user_tbl ADD (user_weight DECIMAL(3, 2));
ALTER TABLE user_tbl MODIFY user_weight DECIMAL(5, 2);

SELECT * FROM user_tbl;

UPDATE user_tbl SET user_weight = 81.50 WHERE user_num = 1;

-- 숫자 함수 사용 예제
SELECT
	user_name, user_weight,
    ROUND(user_weight, 1) AS 키반올림,
    TRUNCATE(user_weight, 1) AS 소수점아래1자리절사,
    MOD(user_height, 150) AS 키_150으로나눈나머지,
    CEIL(user_weight) AS 키올림,
    FLOOR(user_weight) AS 키내림,
    SIGN(user_weight) AS 양수음수_0여부,
    SQRT(user_height) AS 키_제곱근
FROM
	user_tbl;
    
-- 날짜함수 활용 예제
SELECT 
		user_name, entry_date,
        DATE_ADD(entry_date, INTERVAL 3 MONTH) AS _3개월후,
        LAST_DAY(enrty_date) AS 해당월마지막날짜,
        TIMESTAMPDIFF (MONTH, entry_date, now()) AS 오늘과의개월차이
FROM
	user_tbl;

-- 현재 시각을 조회하는 구문
SELECT now();

SELECT * FROM user_tbl;
-- 변환함수를 활용한 예제
SELECT 
	user_num, user_name, entry_date,
    DATE_FORMAT(entry_date, '%Y%m%d') AS 일자표현변경,
    CAST(user_num AS CHAR) AS 문자로바꾼회원번호
FROM
	user_tbl;

-- user_height, user_weight이 NULL인 자료를 추가하기
INSERT INTO user_tbl VALUES (NULL, '임쿼리', 1986, '제주', NULL, '2021-01-03', NULL);

SELECT * FROM user_tbl;

-- NULL에다가 특정숫자 곱하기
SELECT NULL * 0.1; -- 일반 직군
SELECT 1000000 * 0.1; -- 영업직군

-- 최종수령금액은 기본급 + 인센
SELECT NULL + 500000;
SELECT 1000000 + 500000;

-- user_tbl 테이블 조회
SELECT * FROM user_tbl;

-- ifnull() 을 이용해 특정 컬럼이 NULL인 경우 대체값으로 표현하는 예제
SELECT
	user_name, 
    ifnull(user_height, 167) AS _null대체값넣은키,
    ifnull(user_weight, 65) AS _null대체값넣은체중
FROM
	user_tbl;
    
-- SQL에서 0으로 나누면 무슨일이 벌어지는지 보기
SELECT 3 / 0 ;

-- user_tbl의 회원들 중 키 기준으로 165 미만은 평균 미만, 165는 평균, 165 이상은 평균이상으로 출력하기

SELECT * FROM user_tbl;

SELECT
	user_name,
    user_height,
    CASE
		WHEN user_height < 165 THEN '평균미만'
        WHEN user_height = 164 THEN '평균'
        WHEN user_height > 165 THEN '평균이상'
	END AS 키분류,
    user_weight
FROM user_tbl;

-- 문제 user_tbl에 대해서, BMI 지수를 구하기
-- BMI 지수 (체중/키(M)의 제곱)으로 구할 수 있다.
-- BMI 지수의 결과를 18미만이면 '저체중', 18~24면 '일반체중', 25이상이면 '고체중'으로
-- CASE구문을 이용해 나타내기
-- BMI지수를 나타내는 컬럼은 BMI_RESULT이고, BMI분류를 나타내는 컬럼은 BMI_CASE이다.
SELECT
	user_name,
    user_height,
    (user_weight / ((user_height / 100) * (user_height / 100))) AS BMI_RESULT,
    (CASE
		WHEN (user_weight / ((user_height / 100) * (user_height / 100))) < 18 THEN '저체중'
        WHEN (user_weight / ((user_height / 100) * (user_height / 100))) BETWEEN 18 AND 24 THEN '일반체중'
        ELSE '고체중'
	 END) AS BMI_CASE
FROM user_tbl;
	