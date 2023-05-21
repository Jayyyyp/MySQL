-- 트랜잭션은 2개 이상의 각종 쿼리문의 실행을 되돌리거나 영구히 반영할 때 사용한다.
-- 연습 테이블 생성
CREATE TABLE bank_account(
	act_num INT AUTO_INCREMENT PRIMARY KEY,
    act_owner VARCHAR(10) NOT NULL,
    balance INT(10) DEFAULT 0 NOT NULL
);

DROP TABLE bank_account;

-- 계좌 데이터 2개 집어넣기
INSERT INTO bank_account VALUES
						(NULL,'나구매',50000),
                        (NULL, '가판매', 0);

SELECT * FROM bank_account;

-- 트랜잭션 시작(시작점, ROLLBACK; 수행시 이 지점 이후의 내용을 전부 취소한다)
START TRANSACTION;
-- CTRL+ENTER로 실행

-- 나구매의 돈 30000원 차감
UPDATE bank_account SET balance = (balance - 30000) WHERE act_owner = '나구매';

-- 가판매의 돈 30000원 증가
UPDATE bank_account SET balance = (balance + 30000) WHERE act_owner = '가판매';
SET sql_safe_updates = 0;
SELECT * FROM bank_account;

-- 알고보니 25000원이어서 되돌리기
ROLLBACK;
SELECT * FROM bank_account;

START TRANSACTION;
-- CTRL+ENTER로 실행

-- 나구매의 돈 25000원 차감
UPDATE bank_account SET balance = (balance - 25000) WHERE act_owner = '나구매';

-- 가판매의 돈 25000원 증가
UPDATE bank_account SET balance = (balance + 25000) WHERE act_owner = '가판매';
SET sql_safe_updates = 0;
SELECT * FROM bank_account;

-- COMMIT시, 영구반영완료(롤백 불가능)
COMMIT;
SELECT * FROM bank_account;

-- SAVEPOINT는 ROLLBACK 해당 지점전까지는 반영, 해당 지점 이후는 반영 안하는경우, 사용한다.
START TRANSACTION;

-- 나구매의 돈 3000원 차감
UPDATE bank_account SET balance = (balance - 3000) WHERE act_owner = '나구매';

-- 가판매의 돈 3000원 증가
UPDATE bank_account SET balance = (balance + 3000) WHERE act_owner = '가판매';

SAVEPOINT first_tx; -- first_tx라는 저장지점 생성

-- 나구매의 돈 5000원 차감
UPDATE bank_account SET balance = (balance - 5000) WHERE act_owner = '나구매';

-- 가판매의 돈 5000원 증가
UPDATE bank_account SET balance = (balance + 5000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;
ROLLBACK TO first_tx;

SELECT * FROM bank_account;


















