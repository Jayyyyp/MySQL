-- GROUP BY는 기준컬럼을 하나 제시할 수 있고, 기준컬럼에서 동일한 값을 가지는것끼리
-- 같은 집단으로 보고 집계하는 쿼리문이다.
-- SELECT 집계컬럼명 FROM 테이블명 GROUP BY 기준컬럼명;

-- 지역별 평균키 구하기
SELECT
	user_address AS 지역명,
	AVG(user_height) AS 평균키
FROM
	user_tbl
GROUP BY
	user_address;

-- 생년별 체중평균 구하기
SELECT 
	user_birth_year,
    COUNT(user_num) AS 인원수, # COUNT는 컬럼 내부의 열 개수만 세기때문에 어떤 컬럼을 넣어도 동일
    AVG(user_weight) AS 평균체중
FROM
	user_tbl
GROUP BY
	user_birth_year;

-- user_tbl의 가장 큰 키, 가장 빠른 출생년도가 각각 무슨값인지 구하기
SELECT
	MAX(user_height) AS 키큰사람,
    MIN(user_birth_year) AS 젊은이
FROM
	user_tbl;

-- HAVING을 사용하여 거주자가 2명 이상인 지역만 카운팅
-- 거주지 별 생년평균
SELECT
	user_address,
    AVG(user_birth_year) AS 생년평균,
    COUNT(*) AS 거주자수
FROM
	user_tbl
GROUP BY
	user_address
HAVING
	COUNT(*) > 1;

-- 문제
-- 생년기준 평균 키 160 이상인 생년만 출력하기
-- 생년 별 평균 키도 같이 출력
SELECT 
	AVG(user_height) AS 평균키,
    user_birth_year
FROM
	user_tbl
GROUP BY
	user_birth_year
HAVING
	AVG(user_height) >= 160;