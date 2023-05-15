-- 트랜잭션은 2줄 이상의 쿼리문의 실행을 되돌리거나 영구히 반영할 때 사용
-- 연습 테이블 생성

DROP TABLE bank_account;
CREATE TABLE bank_account(
	act_num int(5) PRIMARY KEY AUTO_INCREMENT,
    act_owner varchar(10) NOT NULL,
    balance int(10) DEFAULT 0 NOT NULL
); 

-- 계좌 데이터 2개 집어넣기

INSERT INTO bank_account (act_num, balance, act_owner) VALUES
	(NULL, 50000, '나구매'),
    (NULL, 0, '가판매');

SELECT * FROM bank_account;

-- 트랜잭션 시작(시작점, ROLLBACK; 수행시 이 지점 이후의 내용을 전부 취소)
-- CTRL + ENTER로 실행해줘야함

START TRANSACTION;

-- 나구매의 돈 30,000원 차감
UPDATE bank_account SET balance = (balance - 30000) WHERE act_owner = '나구매';

-- 가판매의 돈 30,000원 증가

UPDATE bank_account SET balance = (balance + 30000) WHERE act_owner = '가판매';
SET sql_safe_updates = 0;
SELECT * FROM bank_account;

-- 알고보니 25000원이어서 되돌리기
ROLLBACK;
SELECT * FROM bank_account;

-- 25000원으로 다시 차감 및 증가하는 코드 작성 후, 커밋
START TRANSACTION;

UPDATE bank_account SET balance = (balance - 25000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 25000) WHERE act_owner = '가판매';

COMMIT;

SELECT * FROM bank_account;

-- SAVEPOINT는 ROLLBACK 해당 지점 전까지 반영, 해당 지점 이후는 반영하지 않는 경우 사용
START TRANSACTION;

UPDATE bank_account SET balance = (balance - 3000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 3000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;

SAVEPOINT first_tx;

UPDATE bank_account SET balance = (balance - 5000) WHERE act_owner = '나구매';
UPDATE bank_account SET balance = (balance + 5000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;

ROLLBACK TO first_tx;		-- 나구매 : 22,000, 가판매 : 28,000인 상태로 롤백
SELECT * FROM bank_account;








