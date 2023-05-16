-- GROUP BY는 기준컬럼을 하나 이상 제시할 수 있고, 기준 컬럼에서 동일한 값을 가지는 것끼리
-- 같은 집단으로 보고 집계하는 쿼리문이다.
-- SELECT 집계 컬럼명 FROM 테이블명 GROUP BY 기준컬럼명;

-- 지역별 평균키 구하기(지역정보 : user_address)

SELECT
	AVG(user_height) AS 평균키
FROM
	user_tbl
GROUP BY user_address;

-- 생년별 체중 평균 구하기
-- 생년, 체중 평균 컬럼이 노출되어야 한다.
SELECT * FROM user_tbl;

SELECT 
	user_birth_year,
    COUNT(user_num) AS 인원수, -- COUNT는 컬럼 내부의 열 개수만 세기 때문에 어떤 컬럼을 넣어도 동일하다.
	AVG(user_weight) AS 평균체중
FROM
	user_tbl
GROUP BY user_birth_year;

-- user_tbl의 가장 큰 키, 가장 빠른 출생년도가 각각 무슨값인지 구하기
SELECT
	user_name,
	max(user_height) AS 최대키를가진사람,
    min(user_birth_year) AS 가장빨리태어난사람,
    min(entry_date) AS 가입일자가장빠른사람
FROM
	user_tbl;
    
-- HAVING을 써서 거주자가 2명 이상인 지역만 카운팅
-- 거주지별 생년 평균 뽑기
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
    
-- HAVING 사용 문제
-- 생년 기준으로 평균 키가 160 이상인 생년만 출력하기
-- 생년별 평균 키도 출력하기
SELECT
	AVG(user_height) AS 평균키,
    user_birth_year
FROM
	user_tbl
GROUP BY
	user_birth_year
HAVING
	AVG(user_height) >= 160;