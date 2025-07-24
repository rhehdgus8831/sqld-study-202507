DROP TABLE EMPLOYEES;
DROP TABLE DEPARTMENTS;

-- 1. 부서 테이블 (DEPARTMENTS) 생성
CREATE TABLE DEPARTMENTS
(
    id   NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

-- 2. 사원 테이블 (EMPLOYEES) 생성
CREATE TABLE EMPLOYEES
(
    id      NUMBER PRIMARY KEY,
    name    VARCHAR2(50) NOT NULL,
    dept_id NUMBER -- DEPARTMENTS 테이블의 id를 참조할 연결고리
);


-- 3. 각 테이블에 예시 데이터 삽입
-- 부서 테이블에는 3개의 부서를 넣어봅시다.
INSERT INTO DEPARTMENTS (id, name)
VALUES (10, '기획팀');
INSERT INTO DEPARTMENTS (id, name)
VALUES (20, '개발팀');
INSERT INTO DEPARTMENTS (id, name)
VALUES (30, '디자인팀');


-- 사원 테이블에는 4명의 사원을 넣어봅시다.
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (101, '김철수', 10); -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (102, '박영희', 20); -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (103, '이지은', 20); -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (104, '최민준', 30);
-- 기획팀


--------------------------------------------------------------------------------------------------------

-- 단순 테이블 조회
SELECT *
FROM EMPLOYEES
;

SELECT *
FROM DEPARTMENTS
;

-- JOIN은 기본 테이블을 가로로 합치는 문법이다
-- X * Y 형태로 결과가 나옵니다.
SELECT EMPLOYEES.ID,
       EMPLOYEES.name,
       DEPARTMENTS.ID,
       DEPARTMENTS.NAME
FROM EMPLOYEES,
     DEPARTMENTS
WHERE EMPLOYEES.dept_id = DEPARTMENTS.id
;

--------------------------------------------------------------------------------------------------------
-- 오라클 조인
SELECT E.ID,
       E.name,
       D.ID,
       D.NAME AS DEPT_NAME
FROM EMPLOYEES E,
     DEPARTMENTS D
WHERE E.dept_id = D.id
;

--------------------------------------------------------------------------------------------------------

-- 표준 조인 MARIA DB에서는 표준 조인 사용해야함
SELECT E.ID,
       E.name,
       D.ID,
       D.NAME AS DEPT_NAME
FROM EMPLOYEES E
         JOIN DEPARTMENTS D
              ON E.dept_id = D.id
;

--------------------------------------------------------------------------------------------------------

-- 피드 조인 (피드번호, 회원이름, 회원 이메일, 피드 내용)
SELECT P.POST_ID,
       U.USERNAME,
       U.EMAIL,
       P.CONTENT
FROM POSTS P,
     USERS U
WHERE P.USER_ID = U.USER_ID
;

SELECT P.POST_ID,
       U.USERNAME,
       U.EMAIL,
       P.CONTENT
FROM POSTS P
INNER JOIN USERS U
ON P.USER_ID = U.USER_ID
;

--------------------------------------------------------------------------------------------------------

-- 해시태그 테이블 조회
SELECT * FROM HASHTAGS;
SELECT * FROM POSTS;

--------------------------------------------------------------------------------------------------------

-- 해시태그에 일상이 포함된 게시글을 다 가져와
SELECT
    PT.POST_ID,
    H.TAG_NAME,
    P.CONTENT
FROM POST_TAGS PT, HASHTAGS H, POSTS P
WHERE PT.TAG_ID = H.TAG_ID
    AND PT.POST_ID = P.POST_ID
    AND H.TAG_NAME  LIKE '%일상%'
ORDER BY PT.POST_ID
;

--------------------------------------------------------------------------------------------------------
-- 표준 조인

SELECT
    PT.POST_ID,
    H.TAG_NAME,
    P.CONTENT
FROM POST_TAGS PT
INNER JOIN HASHTAGS H
ON PT.TAG_ID = H.TAG_ID
INNER JOIN  POSTS P
ON PT.POST_ID = P.POST_ID
WHERE  H.TAG_NAME  LIKE '%일상%'
ORDER BY PT.POST_ID
;



