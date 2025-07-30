
-- 라이언이 작성한 모든 게시물을 조회
SELECT *
FROM POSTS
WHERE USER_ID = (
        SELECT USER_ID
        FROM USERS
        WHERE USERNAME = 'ryan' -- 단일행 서브 쿼리 0개 or 1개 (2개 이상 나오면 오류 )
)
;

--------------------------------------------------------------------------------------------------------
-- 우리 피드 데이터에서 평균 조회수보다 높은 죄회수를 가진 게시물 조회
-- 평균 조회수를 구해봄
SELECT *
FROM POSTS
WHERE VIEW_COUNT > (
        SELECT AVG(VIEW_COUNT)
        FROM POSTS
        )
;


--카카오 그룹에 있는 사용자의 모든 아이디를 조회
SELECT user_id
FROM USERS
WHERE manager_id = 1
;
-- 카카오 그룹에 있는 사용자들이 작성한 모든 피드 조회
SELECT *
FROM POSTS
WHERE USER_ID IN ( --: 다중 행 서브쿼리 0개 이상 (다중행일 경우 IN 연산자 사용)
        SELECT user_id
        FROM USERS
        WHERE manager_id = 1
    )
;

--------------------------------------------------------------------------------------------------------

-- ANY는 서브쿼리의 결과 중 하나라도 만족하는 경우를 찾음
SELECT *
FROM POSTS
WHERE VIEW_COUNT > ANY (
    SELECT AVG(VIEW_COUNT)
    FROM POSTS
    GROUP BY USER_ID
)
;


-- ALL 는 서브쿼리의 결과 중 모두 만족하는 경우를 찾음
SELECT *
FROM POSTS
WHERE VIEW_COUNT > ALL (
    SELECT AVG(VIEW_COUNT)
    FROM POSTS
    GROUP BY USER_ID
)
;

-- =, <> , < , > , <= , >= 단일행 연산자는 단일행 서브쿼리에만 가능
-- IN, ANY , ALL 다중행 연산자는 다중행 서브쿼리에만 가능

--------------------------------------------------------------------------------------------------------

SELECT *
FROM POSTS
;

SELECT TAG_ID
FROM HASHTAGS
WHERE TAG_NAME = '#포켓몬';
;

SELECT POST_ID
FROM POST_TAGS
WHERE TAG_ID = 1003
;


SELECT *
FROM POSTS
WHERE POST_ID IN (
    SELECT POST_ID
    FROM POST_TAGS
    WHERE TAG_ID = (
        SELECT TAG_ID
        FROM HASHTAGS
        WHERE TAG_NAME = '#포켓몬'
        )
    )
;


SELECT P.*,
       U.USERNAME
FROM POSTS P
LEFT JOIN USERS U
ON P.USER_ID = U.USER_ID
WHERE POST_ID IN (
    SELECT POST_ID
    FROM POST_TAGS
    WHERE TAG_ID = (
        SELECT TAG_ID
        FROM HASHTAGS
        WHERE TAG_NAME = '#포켓몬'
    )
)
;

-- 피카츄가 올린 피드에 좋아요 찍은 사람들의 이름을 조회
SELECT *
FROM LIKES;

-- 피카츄 유저 아이디 찾기
SELECT USER_ID
FROM USERS
WHERE USERNAME = 'pikachu'
;
-- 피카츄가 올린 피드의 POST_ID를 찾음

SELECT POST_ID
FROM POSTS
WHERE USER_ID = 21;
;

-- 피카츄가 올린 피드에 좋아요 찍은 내용들을 필터링

SELECT USERNAME
FROM LIKES L
JOIN USERS U
ON L.USER_ID = U.USER_ID
WHERE POST_ID IN (
    SELECT POST_ID
    FROM POSTS
    WHERE USER_ID = (
        SELECT USER_ID
        FROM USERS
        WHERE USERNAME = 'pikachu'
        )
    )
;

-- 인라인 뷰 서브 쿼리 (FROM 절에 서브 쿼리 사용 )
-- 사용자별 피드 작성 개수
SELECT
    PC.USER_ID,
    U.USERNAME,
    PC.POST_COUNT
    FROM (
        SELECT USER_ID, COUNT(*) AS POST_COUNT
        FROM POSTS
        GROUP BY  USER_ID
         ) PC
    JOIN USERS U
    ON PC.USER_ID = U.USER_ID
;



SELECT
    PC.USER_ID,
    U.USERNAME,
    PC.POST_COUNT
FROM USERS U
JOIN (
        SELECT USER_ID, COUNT(*) AS POST_COUNT
        FROM POSTS
        GROUP BY  USER_ID
     ) PC
ON PC.USER_ID = U.USER_ID
;


SELECT
    USER_ID,
    COUNT(*) AS total_likes
FROM  LIKES
GROUP BY USER_ID
ORDER BY  USER_ID
;

SELECT
    USER_ID,
    U.USERNAME,
    A.total_likes
FROM (
    SELECT
        USER_ID,
        COUNT(*) AS total_likes
    FROM  LIKES
    GROUP BY USER_ID
) A
NATURAL JOIN USERS U
-- ON A.USER_ID = U.USER_ID
;

-- 스칼라 서브 쿼리 (SELECT 절에 서브쿼리 사용)
-- 유저정보를 조회(USERS) + 상세 bio(USER_PROFILES)도 같이 조회
SELECT * FROM USERS;
SELECT * FROM USER_PROFILES;

-- 스칼라 서브쿼리 == 연관 서브쿼리
-- 연관 서브쿼리: 서브쿼리가 한 번 실행되고 끝나는게 아니라
-- 바깥쪽 메인쿼리 한 행을 실행할때마다 반복 실행
SELECT
    U.USER_ID,
    U.USERNAME,
    (SELECT BIO FROM USER_PROFILES UP WHERE U.USER_ID = UP.USER_ID) AS BIO
FROM USERS U
;

SELECT * FROM USERS;

--피드별로 피드의 ID와 피드의 내용과 각 피드가 받은 좋아요 수를 한번에 조회

SELECT POST_ID , CONTENT FROM POSTS;

SELECT POST_ID,COUNT(*) AS LIKE_COUNT
FROM LIKES
GROUP BY POST_ID
ORDER BY POST_ID;

SELECT
    POST_ID,
    COUNT(*) AS REPLY_COUNT
FROM COMMENTS
GROUP BY POST_ID
ORDER BY POST_ID
;

SELECT
    P.POST_ID,
    P.CONTENT,
    NVL(LC.LIKE_COUNT, 0) AS LIKE_COUNT,
    NVL(RC.REPLY_COUNT, 0) AS REPLY_COUNT
FROM POSTS P
LEFT JOIN (SELECT
               POST_ID,
               COUNT(*) AS LIKE_COUNT
            FROM LIKES
            GROUP BY POST_ID
            ) LC
ON P.POST_ID = LC.POST_ID
LEFT JOIN (SELECT
                POST_ID,
                COUNT(*) AS REPLY_COUNT
           FROM COMMENTS
           GROUP BY POST_ID
           ) RC
ON RC.POST_ID = P.POST_ID
ORDER BY P.POST_ID
;

SELECT
    p.post_id,
    p.content,
    (SELECT COUNT(*) FROM LIKES l WHERE l.post_id = p.post_id) AS "좋아요 수",
    (SELECT COUNT(*) FROM COMMENTS c WHERE c.post_id = p.post_id) AS "댓글 수"
FROM
    POSTS p
;

