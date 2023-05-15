-- user_tbl 사용하기
SELECT * FROM user_tbl;

-- 수도권(서울, 경기)에 사는 사람을 쿼리문 하나로 조회하기(IN 문법)
SELECT * FROM user_tbl WHERE user_address IN ('서울','경기');

-- IN 문법을 응용해 구매내역이 있는 유저만 출력하기
SELECT user_num FROM buy_tbl; -- 왼쪽 구문이 구매자 번호만 나타내는 리스트이므로

-- 서브쿼리를 활용한 조회구문
SELECT * FROM user_tbl WHERE user_num IN (SELECT user_num FROM buy_tbl);

-- LIKE 구문은 패턴 일치 여부를 통해 조회한다.
-- %는 와일드 카드 문자로, 어떤 문자가 몇 글자로 와도 좋다는 의미이다.
-- _는 와일 카드 문자로, _ 하나당 1 글자씩 처리한다.

SELECT * FROM user_tbl WHERE user_name LIKE '%희';

-- "XX남도에 사는 사람만 조회하기"

SELECT * FROM user_tbl WHERE user_address LIKE '_남';

-- 키가 165~175 인 사람 조회하기
SELECT * FROM user_tbl WHERE user_height BETWEEN 165 AND 175;

SELECT * FROM user_tbl WHERE user_height > 165 AND user_height < 175;

-- NULL을 갖는 데이터 생성
INSERT INTO user_tbl VALUES
		(NULL, '박진영', 1990, '제주', NULL, '2020-10-01'),
        (NULL, '김혜경', 1992, '강원', NULL, '2020-10-02'),
        (NULL, '신지수', 1993, '서울', NULL, '2020-10-05');
	
SELECT * FROM user_tbl;

-- NULL인 자료들만 얻어내기 위해서는 WHERE 절에 컬럼명 IS NULL;을 사용
SELECT * FROM user_tbl WHERE user_height IS NULL;







