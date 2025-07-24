-- **문제 1. 자기소개 길이 순으로 정렬하기**
--
-- > USER_PROFILES 테이블에서 자기소개(bio)의 길이를 계산하여 '소개글길이'라는 별명을 붙여주세요.
--   그리고 이 '소개글길이'가 긴 순서대로 사용자들의 full_name과 bio를 정렬하여 조회하세요.

SELECT
    FULL_NAME,
    BIO,
    LENGTH(BIO) AS 소개글길이
FROM USER_PROFILES
ORDER BY BIO DESC
;
--------------------------------------------------------------------

-- **문제 2. 댓글 많은 순으로 정렬하기**
--
-- > 5강에서 풀었던 '댓글부자 게시물 찾기' 문제를 다시 가져와봅시다.
-- COMMENTS 테이블을 post_id로 그룹화하여 각 게시물의 댓글 수를 계산하고,
-- 그 댓글 수가 많은 순서대로 post_id와 댓글 수를 정렬하여 보여주세요.

SELECT
    POST_ID,
    COUNT(*) AS 댓글수
FROM COMMENTS
GROUP BY POST_ID
ORDER BY COUNT(*) DESC
;
SELECT *
FROM COMMENTS;

--------------------------------------------------------------------

--  **문제 3. 'photo' 게시물 우선 정렬**
--
-- > POSTS 테이블의 모든 게시물을 조회하되, post_type이 'photo'인 게시물을 무조건 위로, 'video'인 게시물은 아래로 정렬하고 싶어요.
-- 같은 종류 내에서는 최신순으로 정렬해주세요. (CASE사용)

SELECT
    POST_ID,
    POST_TYPE,
    CREATION_DATE
FROM POSTS
ORDER BY
CASE
WHEN POST_TYPE = 'photo' THEN 1
WHEN POST_TYPE = 'video' THEN 2
END,
    CREATION_DATE DESC
;



