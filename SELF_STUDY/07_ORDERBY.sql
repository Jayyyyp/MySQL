-- ORDER BY 는 SELECT문의 질의결과를 정렬할 때 사용한다.
-- ORDER BY 절 다음에는 어떤 컬럼을 기준으로 어떤 방식으로 정렬할 지 적어줘야 한다.

-- user_tbl에 대해 키순으로 내림차순 정렬한 예시
SELECT * FROM user_tbl ORDER BY user_height DESC;

-- 문제
-- user_tbl에 대해 키순으로 오름차순, 키가 동률이라면 체중순으로 내림차순 정렬하기
SELECT * 
	FROM user_tbl
    ORDER BY user_height ASC,
			user_weight DESC;
            
-- 이름을 가나다라 순으로 정보를 정렬하되, un이라는 별칭 활용하기
SELECT 
	user_num,
	user_name AS un,
    user_birth_year,
    user_address
	FROM user_tbl
    ORDER BY un DESC ;
            
-- 지역별 키 평균을 내림차순으로 정렬하기
SELECT 
    AVG(user_height) AS 키평균,
    user_address
		FROM user_tbl
        GROUP BY user_address
		ORDER BY AVG(user_height) DESC;
            
-- 경기지역 사람들만 체중을 기준으로 내림차순 정렬하기
SELECT * FROM user_tbl;

SELECT
	user_name, user_birth_year, user_weight, user_address, user_height
    FROM
		user_tbl
	ORDER BY
		CASE user_address
        WHEN '경기' THEN user_weight
        ELSE NULL
	END DESC;

-- 생년도가 1992년인 사람은 키 기준 오름차순,
-- 생년도가 1998인 사람은 이름 기준 오름차순으로 정렬하여 출력하기
SELECT *
	FROM user_tbl
    ORDER BY
    CASE user_birth_year
    WHEN 1992 THEN user_height
    WHEN 1998 THEN user_name
    ELSE NULL
END ASC;
	
            