
SELECT
    POST_ID,
    CREATION_DATE,
    to_char(CREATION_DATE,'yyyy"년"mm"월"dd"일" (day)') as 게시물작성일
    FROM POSTS
where post_id = 4
;

select
    USERNAME,
    nvl(to_char(MANAGER_ID),'최상위 관리자') as 매니저정보
from USERS
;

select
    USERNAME,
    LAST_LOGIN_DATE,
    case
    when LAST_LOGIN_DATE >= to_date('2024-01-01','yyyy-mm-dd') then '최근 활동유저'
    else '휴먼 유저'
        end as 활동상태
FROM USERS
;

select
    COMMENT_ID,
    case
    when MOD(COMMENT_ID,2) = 0 then '짝수 댓글'
    else '홀수 댓글'
        end as 활동상태
from COMMENTS
;
