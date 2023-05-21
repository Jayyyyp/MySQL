-- 영어로 된 사람 추가하기
SELECT * FROM user_tbl;

INSERT INTO user_tbl VALUES
	(NULL, 'ALEX', 1986, 'NY', 173, '2020-11-01'),
    (NULL, 'Smith', 1992, 'TEXAS', 181, '2020-11-05'),
    (NULL, 'Emma', 1995, 'TAMPA', 168, '2020-12-13'),
    (NULL, 'JANE', 1996, 'LA', 157, '2020-12-15');

SELECT
	user_name,
    UPPER(user_name) AS 대문자유저명,
    LOWER(user_name) AS 소문자유저명,
    LENGTH(user_name) AS 문자길이,
    SUBSTR(user_name, 1, 2) AS 첫글자두번째글자,
    CONCAT(user_name, '회원이 존재합니다.') AS 회원목록
FROM user_tbl;

-- 이름이 4글자 이상인 유저만 출력하기
-- LENGTH는 BYTE 길이이므로, 한글은 한글자에 3바이트로 간주
-- 따라서, CHAR_LENGTH()를 이용하면 그냥 글자숫자로 처리
SELECT CHAR_LENGTH(user_name) AS 글자길이 FROM user_tbl;
SELECT * FROM user_tbl
	WHERE CHAR_LENGTH(user_name) >= 4;

-- 함수 도움 없이 4글자만 뽑는 방법
SELECT * FROM user_tbl WHERE user_name LIKE  "____%";

-- user_tbl에 소수점 아래를 저장받을 수 있는 컬럼 추가하기
-- DECIMAL은 고정자리수이므로, 반드시 소수점 아래 2자리까지 표시해야 한다.
ALTER TABLE user_tbl ADD (user_weight DECIMAL(3, 2));
ALTER TABLE user_tbl MODIFY user_weight DECIMAL(5, 2);

SELECT * FROM user_tbl;

UPDATE user_tbl SET user_weight = 52.12 WHERE user_num = 10;

-- 숫자 함수 사용 예제
SELECT
	user_name, user_weight,
    ROUND(user_weight, 1) AS 반올림,
    TRUNCATE(user_weight, 1) AS 키소수점아래_1자리절사,
    MOD(user_height, 150) AS 키_150으로나눈나머지,
    CEIL(user_weight) AS 키올림,
    FLOOR(user_weight) AS 키내림,
    SIGN(user_weight) AS 양수음수_0여부,
	SQRT(user_height) AS 키_제곱근
FROM
	user_tbl;

-- user_tbl의 날짜 확인
SELECT * FROM user_tbl;

-- 날짜 함수를 활용한 예제
SELECT
	user_name, entry_date,
    DATE_ADD(entry_date, INTERVAL 50 DAY) AS _3개월후,
    LAST_DAY(entry_date) AS 해당월마지막날짜,
    TIMESTAMPDIFF(YEAR, entry_date, now()) AS 오늘과의개월수차이
FROM
	user_tbl;

SELECT now();

-- 변환함수를 활용한 예제
SELECT 
	user_num, user_name, entry_date,
	DATE_FORMAT(entry_date, '%Y%m%d') AS 일자표현변경,
    CAST(user_num AS CHAR) AS 문자로바꾼회원번호
FROM
	user_tbl;

-- user_height, user_weight이 NULL인 자료 추가
INSERT user_tbl VALUES (NULL, '임쿼리', 1986, '제주', NULL, '2021-01-03', NULL);

SELECT * FROM user_tbl;

-- NULL에 특정숫자 곱하기
SELECT NULL * 0.1; -- 일반직군
SELECT 1000000 * 0.1; -- 영업직군

-- 최종 수령금액은 기본급 + 인센
SELECT NULL + 500000;
SELECT 1000000 + 5000000;

-- IFNULL()을 사용하여 특정 컬럼이 NULL인 경우, 대체값으로 표현하는 예제
SELECT
	user_name, 
    IFNULL(user_height, 167) AS _NULL대체값넣은키, 
    IFNULL(user_weight, 67) AS _NULL대체값넣은체중 
FROM user_tbl;

-- SQL에서 0으로 나누기
SELECT 3 / 0;

-- user_tbl의 회원들 중 키 기준으로
-- 165미만은 평균 미만, 165는 평균, 165 이상은 평균이상으로 출력하기
SELECT
	user_name,
    user_height,
    CASE
		WHEN user_height < 165 THEN '평균미만'
		WHEN user_height = 165 THEN '평균'
        WHEN user_height > 165 THEN '평균이상'
	END AS 키분류,
	user_weight
FROM user_tbl;

/*
	문제
    user_tbl에 대하여 BMI 지수 구하기
    BMI 지수는 (체중/ 키M의 제곱)으로 구할 수 있다.
    BMI 지수의 결과를 18미만이면 저체중, 18~24면 일반체중, 25이상이면 고체중으로 CASE 구문을 이용하여 출력하기
    BMI 지수를 나타내는 컬럼은 BMI_RESULT이고, BMI 분류를 나타내는 컬럼은 BMI_CASE이다.
*/
SELECT
	user_name,
    user_height,
	user_weight,
    user_weight / POW(user_height / 100, 2) AS BMI_RESULT,
    CASE
		WHEN user_weight / POW(user_height / 100, 2) < 18 THEN '저체중'
        WHEN user_weight / POW(user_height / 100, 2) BETWEEN 18 AND 24 THEN '일반체중'
        WHEN user_weight / POW(user_height / 100, 2) > 24 THEN '고체중'
	END AS BMI_CASE
FROM
	user_tbl;
