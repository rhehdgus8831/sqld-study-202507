-- **문제 1. 게시물 종류별 개수 세기**
-- POSTS 테이블을 사용하여, 게시물 종류(post_type)별로 각각 몇 개의 게시물이 있는지 세어보세요. ('photo'는 몇 개, 'video'는 몇 개?)

SELECT POST_TYPE,
       COUNT(POST_TYPE) AS "종류별 게시물"
FROM POSTS
GROUP BY POST_TYPE
;

-- **문제 2. 댓글부자 게시물 찾기**
--COMMENTS 테이블을 post_id로 그룹화하여, 각 게시물에 몇 개의 댓글이 달렸는지 계산해주세요.

SELECT
    POST_ID,
    COUNT(PARENT_COMMENT_ID) AS "댓글 수"
FROM COMMENTS
GROUP BY POST_ID
ORDER BY POST_ID
;
-- 문제 3. 팔로워가 많은 인플루언서**
-- FOLLOWS 테이블을 following_id(팔로우 당하는 사람) 기준으로 그룹화하여, 각 사용자별로 총 몇 명의 팔로워가 있는지 계산해주세요.

SELECT
    FOLLOWING_ID,
    COUNT(FOLLOWER_ID) AS "팔로워 수"
FROM FOLLOWS
GROUP BY FOLLOWING_ID
ORDER BY FOLLOWING_ID
;

SELECT following_id, COUNT(*) AS "팔로워 수"
FROM FOLLOWS
GROUP BY following_id
ORDER BY FOLLOWING_ID
;

--문제 4. 댓글이 5개 이상 달린 인기 게시물**
-- COMMENTS 테이블을 post_id로 그룹화한 뒤, 댓글 수가5개 이상인 게시물의post_id와 댓글 수만 조회해주세요. (HAVING사용)
SELECT
POST_ID,
COUNT(POST_ID) AS 댓글수
FROM COMMENTS
GROUP BY POST_ID
HAVING COUNT(*) >= 5
;

--문제 5. 카카오프렌즈의 게시물 활동 요약**
--카카오프렌즈 사용자들(user_id1~8)이 작성한 게시물에 대해서만, 각 사용자별로 총 몇 개의 게시물을 작성했는지 요약해주세요. (WHERE와 GROUP BY사용)

SELECT
USER_ID,COUNT(*) AS "총게시물"
FROM POSTS
WHERE USER_ID BETWEEN 1 AND 8
GROUP BY USER_ID
;