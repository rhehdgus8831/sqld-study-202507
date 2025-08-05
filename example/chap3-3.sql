-- 트랜잭션 실습

-- 안전을 위해 테이블 복사 CTAS
CREATE TABLE user_copy AS
SELECT * FROM USERS;

SELECT *
FROM user_copy;

DELETE FROM user_copy;

COMMIT;
ROLLBACK;

