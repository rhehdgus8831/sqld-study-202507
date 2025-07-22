-- USERS 테이블의 모든 컬럼과 모든 데이터를 조회한다.
SELECT *   -- * 전체 조회 - 실무에서는 사용 X 다 쓰셈
FROM USERS
;

-- USERS테이블에서 사용자 이름과 이멜만 보고싶음
SELECT USERNAME, EMAIL --순서 상관 x
FROM USERS
;

-- POST 테이블에서 게시물의 타입의 게시물의 정보를 보고 싶음

-- DISTINCT : 중복값을 제거하고 조회
SELECT ALL POST_TYPE -- ALL 중복포함하여 전체조회(기본값 ALL)
FROM POSTS
;

-- 열 별칭 정하기
SELECT 
USERNAME AS"사용자 이름"
, EMAIL AS "이메일"
FROM USERS
;

-- AS는 생략가능
SELECT 
USERNAME "사용자 이름"
, EMAIL "이메일"
FROM USERS
;

-- 띄어쓰기가 없으면 쌍따옴표 생략 가능
SELECT 
USERNAME AS"사용자 이름"
, EMAIL 이메일
FROM USERS
;


-- 사용자 이름에 추가 문자열을 연결해서 조회
-- '' : String , "" : Alias
SELECT USERNAME || '님,환영합니다!' AS "환영인사말"
FROM USERS
;


SELECT FOLLOWER_ID || '님이 ' || FOLLOWING_ID  || '님을 팔로우합니다.'
FROM FOLLOWS
;

-- 사용자의 이름과 가입일을 조합
SELECT USERNAME || '(가입일: ' || REGISTRATION_DATE || ')' AS "사용자 정보"
FROM USERS;

