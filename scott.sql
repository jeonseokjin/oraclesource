--dept테이블 정보(부서정보-부서번호,부서명,위치)
DESC dept;

--사원정보(사원번호,사원명,직책,직속상관의 사원번호,입사일,급여,추가수당,부서번호)
DESC emp;

--급여구간(등급,최저급여,최고급여)
desc salgrade;

--조회(SELECT) : 가장 많이 사용
--SELECT 조회하고 싶은 열이름 나열
--FROM 조회할 테이블명

SELECT
    deptno
FROM
    dept;

SELECT
    deptno,
    dname
FROM
    dept;

SELECT
    *
FROM
    dept;

SELECT
    *
FROM
    emp;

SELECT
    empno,
    ename,
    deptno
FROM
    emp;

--DISTINCT : 중복 데이터 제거
SELECT DISTINCT
    deptno
FROM
    emp;

SELECT DISTINCT
    job,
    deptno
FROM
    emp;

--ALAIS(별칭)
--as 별칭 : as 생략가능
SELECT
    ename           AS 사원명,
    sal             AS 급여,
    comm            "추가 수당",
    sal * 12 + comm AS 연봉
FROM
    emp;
    
--원하는 순서로 출력 데이터를 정렬
--order by 정렬할 열이름[정렬옵션]

--emp 테이블에서 ename,sal 조회할 때 sal 내림차순 조회
--des : 내림차순(descending)
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;

--default 값이 오름차순 // 명시할 것이면 asc(ascending)
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal;

--EMP 테이블의 전체 열을 조회(부서번호는 오름차순이고, 급여의 내림차순)
SELECT
    *
FROM
    emp
ORDER BY
    deptno ASC,
    sal DESC;

--특정한 조건을 기준으로 데이터 조회
--SELECT ~ FROM ~ WHERE 기준 

SELECT
    *
FROM
    emp
WHERE
    deptno = 30;

--사원번호가 7782 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;

--부서번호가 30이고 사원직책이 salesman인 사원 조회
--문자열 표현 : 홑따옴표 사용
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';

--사원번호가 7499이고 부서번호가 30인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;

--부서번호가 30 이거나,  사원직책이 CLERK 인 사원조회

SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';
    
--연산자
--산술연산자
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;

--비교연산자(>,<,>=,<=)
SELECT
    *
FROM
    emp
WHERE
    sal >= 3000;

--문자도 대소비교 연산자가 가능
--ENAME 'F' 이상인 사원 조회(사원 이름의 첫문자가 F와 같거나 뒤쪽인 것 조회)
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

--급여가 2500이상이고, 직업이 ANAlYST 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        sal >= 2500
    AND job = 'ANALYST';
--직무가 MANAGER 이거나 SALESMAN 이거나 CLERK 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';

--등가비교연산자 ( 같다 : =, 같지않다 : !=, <>, ^=)

--급여가 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal^= 3000;

--논리부정연산자 : NOT
SELECT
    *
FROM
    emp
WHERE
    NOT sal = 3000;


-- IN 연산자 : =의 의미와 같음
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

--job이 'MANAGER' 아니고, 'SALEMAN'이 아니고 'CLERK'가 아닌 사원
SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job <> 'SALESMAN'
    AND job^= 'CLERK';

--NOT + IN
SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

--In 사용해서 부서번호가 10, 20번인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );

--BETWEEN A AND B 연산자 : 급여가 2000 이상 3000이하
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;

--NOT BETWEEN A AND B
SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;

--LIKE 연산자와 와일드 카드( _ : 어떤 값이든 상관없이 단 한개의 문자 데이터
                          % : 어떤 값이든 상관없고 길이와 상관없이 모든 문자 데이터

--사원 이름이 S로 시작하는 사원 정보 조회 %
select *
from emp
where ename like 'S%';

--사원 이름의 두번째 글자가 L인 사원 정보 조회
select *
from emp
where ename like '_L%';
--사원 이름에 AM이 들어있는 사원 정보 조회
select *
from emp
where ename like '%AM%';

--사원 이름에 AM이 들어있지 않는 사원 정보 조회
select *
from emp
where ename not like '%AM%';

--IS NULL 연산자

--comm이 null인 사원 조회
select *
from emp
where comm is NULL;

--MGR이 널이 아닌 사원 조회
select *
from emp
where mgr is not null;

--집합 연산자
--union(합집합), minus(차집합), intersect(교집합)

--deptno=10 or deptno=20 사원 조회 : union 사용해서
select empno, ename, job
from emp
where deptno = 10
union all
select empno,ename,job
from emp
where deptno =20;

select empno, ename, job,deptno
from emp
minus
select empno,ename,job,deptno
from emp
where deptno =10;

select empno, ename, job, deptno
from emp
intersect
select empno,ename,job, deptno
from emp
where deptno =10;

--[문제] 사원 이름(ENAME)이 S로 끝나는 사원 데이터를 출력한다.
select *
from emp
where ename like '%S';
--[문제] 30번 부서(DEPTNO)에서 근무하고 있는 사원 중에 직책(JOB)이 
--SALESMAN 인 사원의 사원번호, 이름, 직책, 급여, 부서 번호를 출력한다
select empno, ename,  job, sal, deptno
from emp
where job in ('SALESMAN') and deptno=30;

--[문제] 20번, 30번 부서에 근무하고 있는 사원 중 급여(SAL)가 2000초과인
--사원을 다음 두 가지 방식의 SELECT 문을 사용하여 사원번호, 이름, 직책, 급여, 부서번호를 
--출력하는 SQL 문을 작성해 보시오
--집합 연산자를 사용하지 않은 방식
select empno, ename, job, sal, deptno
from emp
where deptno in(20,30) and sal>2000;
--집합 연산자를 사용한 방식
select empno, ename, job, sal, deptno
from emp
where deptno=20 or deptno=30
intersect
select empno, ename, job, sal , deptno
from emp
where sal>2000;

select empno,ename,sal,deptno
from emp
where sal>2000
minus
select empno,ename,sal,deptno
from emp
where deptno=10;

--[문제] NOT BETWEEN A AND B 연산자를 쓰지 않고, 급여(SAL) 열 값이
--2000이상 3000이하 범위 이외의 값을 가진 데이터만 출력하도록 SQL 문을 작성하시오
select *
from emp
where sal<2000 or sal>3000;
--[문제] 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가
--아닌 사원 이름, 사원 번호, 급여, 부서 번호를 출력하는 SQL문을 작성
select ename, empno, sal, deptno
from emp
where ename like '%E%' and deptno=30 and sal not between 1000 and 2000;

--[문제] 추가 수당이 존재하지 않고 상급자가 있고 직책이 MANAGER,CLERK인 사원
--중에서 사원 이름의 두 번째 글자가 L이 아닌 사원의 정보를 출력한S SQL문을 작성
select *
from emp
where comm is null and mgr is not null and job in('MANAGER', 'CLERK')
AND ENAME not like '_L%';

--오라클 함수

--대소문자 변경 : UPPER(), LOWER(),  INITCAP()

select ename,upper(ename), lower(ename), initcap(ename)
from emp;

--dual : sys가 소유하는 테이블
--       임시 연산이나 함수의 결과값 확인하는 용도
--문자열 길이 : LENGTH / 문자열 바이트 수 반환 : LENGTHB ex) '한글'은 글자당 3바이트
select length('한글'), lengthb('한글'), length('ab'), lengthb('ab')
from dual;

select ename, length(ename)
from emp;

--[실습] 직책 이름이 6글자 이상인 사원 조회
select *
from emp
where length(job)>=6;

--문자열 추출 : substr(원본데이터, 시작위치, [추출길이])
select job, substr(job,1,2), substr(job,3,2), substr(job,5)
from emp;

--[문제] emp 테이블의 모든 사원 이름을 세번째 글자부터 끝까지 출력
--      ename, 추출문자열 출력
select ename, substr(ename,3)
from emp;

--문자열 데이터 안에서 특정 문자 위치 찾기 : INSTR(문자열데이터, 위치를 찾으려고
--부분 문자, 시작위치, 시작위치에서 찾으려는 문자 몇 번째인지 위치 지정)
select instr('HELLO ORACLE!','L') AS INSTR1,
       instr('HELLO ORACLE!','L',5) AS INSTR2,
       instr('HELLO ORACLE!','L',2,2) as instr3
from dual;

-사원이름에 S가 있는 사원 조회
select *
from emp
where instr(ename, 'S') >0;

--특정문자를 다른 문자로 변경 : REPLACE(원본, 찾는문자, 바꿀문자)
select '010-1234-5678' as replace_before,
        replace('010-1234-5678','-',' ') as replace_after1,
        replace('010-1234-5678','-') as replace_after2
from dual;

--문자열 연결 : CONCAT
select concat(empno,concat(':',ename))
from emp;

--문자열 연결 : ||
select empno || ename
from emp;

select empno||':'||ename
from emp;

-특정 문자열 제거(아무것도 안주면 공백제거) : TRIM(), LTRIM(),RTRIM()
select '   이것이   ', trim('    이것이   '), ltrim('     이것이     '), rtrim('    이것이    ')
from dual;

--숫자함수
--round() : 반올림,     trunc() : 버림
--ceil() : 지정된 숫자보다 큰 정수 중에서 가장 작은 정수
--floor() : 지정된 숫자보다 작은 정수 중에서 가장 큰 정수
--mod() : 나머지

select round(1234.5678) as round, round(2134.5678,0) as round1,
round(1234.5678,1) as round2, round(1234.5678,2) as round3, 
round(1234.5678,-1) as round4, round(1234.5678, -2) as round5
from dual;

select trunc(1234.5678) as trunc, trunc(1234.5678,0) as trunc1,
trunc(1234.5678,1) as trunc2, trunc(1234.5678,2) as trunc3, 
trunc(1234.5678,-1) as trunc4, trunc(1234.5678, -2) as trunc5
from dual;

select ceil(3.14), floor(3.14), ceil(-3.14), floor(-3.14)
from dual;

select mod(15,6), mod(10,2), mod(11,2)
from dual;

--날짜 함수 : 연산이 가능함
--sysdate, current_date, current_timestamp

select sysdate, current_date, current_timestamp
from dual;

select sysdate as now, sysdate -1 as yesterday, sysdate +1 as tomorrow
from dual;

--add_months() : 몇 개월 이후 날짜 구하기

select sysdate, add_months(sysdate,3)
from dual;

--입사 20주년이 되는 사원들 조회
select empno, ename, hiredate, add_months(hiredate, 240)
from emp;

--현재 날짜를 기준으로 입사 45년 미만인 사원 조회
select *
from emp
where add_months(hiredate, 540) > sysdate;

--months_between(날짜1, 날짜2) : 두 날짜 테이터 간의 날짜 차이를 개월 수로 출력
select  empno, ename, hiredate, sysdate, months_between(hiredate, sysdate) as month1,
months_between(sysdate, hiredate) as month2,trunc(months_between(sysdate, hiredate)) as months3
from emp;

--next_day() :  특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--last_day() : 특정 날짜가 속한 달의 마지막 날짜
select sysdate, next_day(sysdate, '월요일'), las
next_day(sysdate)
from dual;

select emp,ename, 'abcd'+empno
from emp
where='SMITH';

--to_char() : 숫자, 날짜 테이터를문자 데이터로 변환
--to-number() : 문자 데이터를 숫자 데이터로 변환
--to-date() : 문자 데이터를 날짜 데이터로 변환

select to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') as 현재시간
from dual;

select to_char(sysdate, 'MM') as MM,
to_char(sysdate, 'MON') as MON,
to_char(sysdate, 'MONTH') as MONTH
from dual;

select to_char(sysdate, 'HH24:MI:SS') as HH24MISS,
to_char(sysdate, 'HH24:MI:SS AM') as HHMISS_AM,
to_char(sysdate, 'HH24:MI:SS P.M.') as HHMISS_PM,
to_char(sysdate, 'hh24:mi:ss') as hhmiss --12시간
from dual;

select  *
from emp
where hiredate>to_date('19810601', 'yyyy-dd-mm');

--DECODE 함수와 CASE 문
--job_id에  따라 비율을 다르게 준 다음 연산

--[문제]
--emp테이블의 mgr기준으로 출력
--mgr이 존재하지 않으면 0000
--mgr 75인 경우 : 5555
--mgr 76인 경우 : 6666
--mgr 77인 경우 : 7777
--mgr 78인 경우 : 8888
--그 외 원래대로 mgr출력

--select empno,ename,mgr,decode(substr(to_char(mgr),1,2),null,'0000','75','5555','76','6666','77','7777','78','8888'),substr(to_chr(mgr),1) as chg_mgr
--from emp;

--select
--empno,
--ename,
--mgr,
--case
    --when mgr is null then '0000'
    --when substr(to_char(mgr),1,2)='75' then '5555'
    --when substr(to_char(mgr),1,2)='76' then '6666'
    --when substr(to_char(mgr),1,2)='77' then '7777'
    --when substr(to_char(mgr),1,2)='78' then '8888'
    
--추가수당 합계
select
    sum(comm)
from
    emp;
    
select sum(distinct sal), sum(sal)
from emp;
    
--emp 테이블의 사원 수 출력(null값이 있는 열을 count하지 말자)
select count(*)
from emp;

--부서번호가 30번인 사원 수 출력
select count(*)
from emp
where deptno=30;

--급여의 최대값
select max(sal)
from emp;

--급여의 최소값
select min(sal)
from emp;

--부서번호가 20번인 사원 중 제일 오래된 입사일 구하기
select min(hiredate)
from emp
where deptno=20;

--가장 최근 입사일
select max(hiredate)
from emp
where deptno=20;

--부서번호가 30번인 사원들의 급여 평균 출력
select round(avg(sal))
from emp
where deptno=30;

--부서별 평균 급여 출력 : group by-결과값을 원하는 열로 묶어 출력할 때 사용
select
    deptno,
    avg(sal)
from
    emp
group by
    deptno;
    
--부서별, 직책별 급여 평균 출력
select
    deptno,
    job,
    avg(sal)
from 
    emp
group by
    deptno, job
order by
    deptno, job;

--group by : select 절에 group by 절에 포함안되는 열을 사용 불가
select
    ename,
    deptno,
    avg(sal)
from
    emp
group by
    deptno;
    
--group by ~ having : 그룹을 잡을 때 조건을 주는 경우

--각 부셔의 직책별 평균 급여를 구하되, 평균 급여가 2000이상인 그룹만 출력
select deptno ,job, avg(sal)
from emp
group by deptno,job
having avg(sal)>=2000;

--where : 출력 대상 행을 제한 // group 절에서 where 절은 사용 불가능 따로는 사용 가능
--having : 그룹화된 대상을 제한

--emp 테이블의 부서별 직책의 평균 급여가 500이상인 사원들의 부서번호, 직책,
--평균급여를 출력
select deptno,job,avg(sal)
from emp
group by deptno, job
having avg(sal)>=500
order by deptno;

select deptno,job,avg(sal)
from emp
group by deptno, job;
---------------------------------------

select deptno, job, avg(sal)----------5
from emp       -----------------------1
where sal<=3000-----------------------2
group by deptno, job------------------3
having avg(sal)>=2000-----------------4
order by deptno, job asc;-------------6

--[실습] emp 테이블을 이용하여 부서번호(deptno), 평균급여(avg_sal), 최고급여(max_sal),
--최저급여(min_sal), 사원수(cnt)를 출력한다. 단, 평균 급여를 출력할 때 소수점을 제외하고
--각 부서번호별로 출력하는 sql문을 작성하시오.
select deptno, round(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(empno) as cnt
from emp
group by deptno
order by deptno asc;

--[실습] 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하는 sql문을 작성하시오
select job, count(*)
from emp
group by job
having count(job)>=3;

--[실습] 사원들의 입사연도(hire_year)를 기준으로 부서별로 몇 명이 입사 했는지 출력하는
--sql문 작성하시오
select to_char(hiredate, 'YYYY') as hire_year, deptno, count(*) as cnt
from emp
group by to_char(hiredate,'YYYY'), deptno; 

--join
--데이터가 여러 개의 테이블에 나뉘어 저장됨
select *
from emp;

select*
from dept;

--1) 내부조인 : 일치하는 컬럼을 기준으로 값 가져오기
--column ambiguously defined
select empno, ename, e.deptno, dname, loc
from emp e, dept d
where e.deptno=d.deptno;

--표준문법(inner 생략가능)
select e.empno, e.ename, e.deptno, dname, loc
from emp e
inner join dept d on e.deptno=d.deptno;

--부서번호가 일치하는 사원들의 정보 출력
--급여가 3000이상자만 출력
select e.empno, e.ename, e.deptno, dname, loc
from emp e
inner join dept d on e.deptno=d.deptno and sal>=3000;

--부서번호가 일치하는 사원들의 정보 출력
--급여가 2500 이하이고 , 사원번호가 9999이하인 사원 출력
select
    e.empno,
    e.ename,
    e.deptno,
    d.dname,
    d.loc
from
    emp e,
    dept d
where
    e.deptno=d.deptno and e.sal >=2500 and e.empno<=9999;
    
 --join
 select
    e.empno,
    e.ename,
    e.deptno,
    d.dname,
    d.loc
from
    emp e
join
    dept d on e.deptno=d.deptno and e.sal >=2500 and e.empno<=9999;
    
--emp, salgrade 조인

select*
from salgrade;

select empno, ename, job, sal, comm, deptno, grade
from emp e join salgrade s on e.sal between s.losal and s.hisal; 

--자기자신 테이블 조인 : 셀프조인

select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1, emp e2
where e1.mgr=e2.empno;

--outer join(외부조인)
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1 right outer join emp e2 on e1.mgr=e2.empno;

--[문제] 각 부서별 평균급여, 최대급여, 최소급여, 사원수 출력
--부서코드, 부서명, 평균급여, 최대급여, 최소급여, 사원수
select e.deptno, d.dname, round(avg(sal)), max(sal), min(sal), count(empno)
from emp e join dept d on e.deptno=d.deptno
group by e.deptno, d.dname;

--[문제] 모든 부서정보와 사원 정보를 출력(부서번호의 오름차순, 사원번호의 오름차순)
--부서번호, 부서명, 사원번호, 사원명, 직책, 급여
select d.deptno, dname, empno, ename, job, sal
from dept d, emp e
where d.deptno=e.deptno;
---------------
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e
right outer join dept d on d.deptno=e.deptno
order by d.deptno, e.empno;

--세 개의 테이블 조인
select e1.empno, e2.empno, e3.empno
from emp e1 join emp e2 on e1.empno=e2.empno join emp e3 on e2.empno=e3.empno;

--[실습4] 모든 부서정보와 사원 정보, 급여등급 정보, 각사원의 직속 상관의 정보 부서번호, 사원번호 순으로
--정렬하여 출력하는 sql문을 작성하시오
select 
    d.deptno, 
    d.dname, 
    e1.empno, 
    e1.ename, e1.mgr, e1.sal, e1.deptno as deptno_1, s.losal, s.hisal, s.grade, 
e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1 right outer
JOIN dept d ON e1.deptno = d.deptno
     left outer join salgrade s on e1.sal between s.losal and s.hisal
     left outer join emp e2 on e1.mgr=e2.empno
order by 
    d.deptno,
    e1.empno;
    
--실행결과가 여러개로 나오는 다중행 서브쿼리 사용 연산자
--IN, ANy(SOME), ALL, EXISTS


--in : 메인쿼리의 데이터가 서브쿼리 결과 중 하나라도 일치한 데이터가 있다면 true
--각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
select *
from emp
where
    sal in(select 
    max(sal)
    from
        emp
    group by
        deptno );


-- any(some) : 서브쿼리가 반환한 여러 결과 값 중에서 메인쿼리의 조건식 중 하나라도
-- true라면 메인쿼리 조건식을 TRUE로 반환
-- =any  == in
select *
from emp
where
    sal =any(select 
    max(sal)
    from
        emp
    group by
        deptno );
    
--각 부서별 최고 급여보다 작은 급여를 받는 사원 정ㅂ초 출력
select *
from emp
where
    sal <any(select 
    max(sal)
    from
        emp
    group by
        deptno );
        
--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 출력
select *
from emp
where sal>any(
select distinct sal
from emp
where deptno=30);

--30번 부서 사원들의 최소 급여보다 적은 급여를 받는 사원 정보 출력
select *
from emp
where sal<all(
select distinct sal
from emp
where deptno=30);

--다중열 서브쿼리

--자신의 부서 내에서 최고 연봉과 동일한 사원 출력
select *
from emp
where (deptno,sal)>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            (
select distinct sal
from emp
where deptno=30);

--from 절에 사용하는 서브쿼리(인라인뷰)
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from (select*from emp where deptno=10) e10,
     (select*from dept) d
     where e10.deptno=d.deptno;
     
     
--DML(데이터 조작어 : 삽입, 삭제, 수정)
--commit(커밋) : 데이터 베이스에 최종 반영,
--rollback(롤백) : 지금 반영된걸 취소

--dept 테이블의 데이터를 추출하여 dept_temp 테이블 생성
create table dept_temp as select *from dept;

--insert(삽입)
--insert into 테이블명(열이름...)
--values(데이터....)

--문자, 날짜 데이터는 '' 사용
insert into dept_temp(deptno,dname,loc)
values(50,'DATABASE', 'SEOUL');

insert into dept_temp
values(60, 'NETWORK','BUSAN');

insert into dept_temp(deptno,dname)
values(70, 'NETWORK');

--insert into dept_temp
--values(800, 'NETWORK', 'BUSAN');

insert into dept_temp
values(60, 'NETWORK',null);

select * from dept_temp;

create table emp_temp as select * from emp where 1<>1;
insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(9999,'홍길동','manager',null,'2021-01-05',5000,1000,10);

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(8888,'성춘향','manager',9999,sysdate,4000,500,20);

--emp 테이블에서 부서번호가 20번인 사원들만 emp_temp 로 삽입
insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp
where deptno=20;
--emp 테이블에서 salgrade 테이블을 참조하여 등급이 1인 사원을
--emp_temp에 추가하고 싶을때
insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp e join salgrade s on e.sal between s.losal and s.hisal
where s.grade=1;


select*from emp_temp;

--수정
--update 테이블명
--set 변경할열 = 값,  변경할열 = 값
--[where]선택

select*from dept_temp;



--loc 를 seoul로 변경
update dept_temp
set loc='seoul';

update dept_temp
set loc='busan'
where deptno=50;

--emp_temp 사원 중 sal 3000이하인 사원만 comm 300으로 수정
update emp_temp
set comm=300
where sal<=3000;

--update 서브쿼리
--dept 테이블에서 부서번호가 40번인 부서명과 지역 추출
update dept_temp
set(dname, loc)=(select dname,loc from dept where deptno=40);

select * from dept_temp;
select * from emp_temp;

--dname이 operations인 부서번호 추출
--추출된 부서번호화 일치하는 부서번호의 지역을 'SEOUL'로 변경
update dept_temp
set loc='seoul'
where deptno=(select deptno from dept where dname='OPERATIONS');



--job이 analyst인 사원 삭제
delete from emp_temp
where job='ANALYST';

delete emp_temp;

update emp_temp
set sal=1800
where empno=7369;
-- EMP_TEMP에서 급여등급이 3이고, 20번 부서의 사원만 삭제
-- 서브쿼리 형태
delete from emp_temp
where empno in(select empno
                from emp_temp e join salgrade s on e.sal between s.losal and s.hisal
                where s.grade = 3 and e.deptno=20);

commit;
RollBack;


create table EXAM_EMP as select * from emp;
create table EXAM_DEPT as select * from dept;
create table EXAM_SALGRADE as select * from salgrade;

insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7201,'TEST_USER1', 'MANAGER', 7788,'2016-01-02',4500,50);

insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7202,'TEST_USER2', 'CELRK',7201,'2016-02-21',1800,50);

insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7203,'TEST_USER3', 'ANALYST',7201,'2016-04-11',3400,60);
insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(7204,'TEST_USER4', 'SALESMAN',7201,'2016-05-31',2700,300,60);
insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7205,'TEST_USER5', 'CELRK',7201,'2016-07-20',2600,70);
insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7206,'TEST_USER6', 'CELRK',7201,'2016-09-08',2600,70);

insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7207,'TEST_USER7', 'LECTURER',7201,'2016-10-28',2300,80);
insert into EXAM_EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values(7208,'TEST_USER8', 'STUDENT',7201,'2018-03-09',1200,80);

commit;



update exam_emp
set deptno=70
where sal>(select avg(sal) from exam_emp where deptno=50);

--[문제] 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원들의 급여를
--10% 인상하고 80번 부서로 변경
update exam_emp
set sal=sal*1.1, deptno=80
where hiredate>(select min(hiredate) from exam_emp where deptno=60);

--[문제] 급여등급이 5인 사원 삭제
delete from exam_emp
where empno in (select empno from exam_emp e join exam_salgrade s on e.sal between s.losal and s.hisal
                where s.grade=5);

select *
from exam_emp;  

select * from emp where empno=7369;

----트랜젝션
create table dept_tcl as select deptno,dname,loc from
dept;

SELECT
    *
FROM
    dept_tcl;

--트랜젝션과 관련있는 명령어
INSERT INTO dept_tcl VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

UPDATE dept_tcl
SET
    loc = 'BUSAN'
WHERE
    deptno = 40;

DELETE FROM dept_tcl
WHERE
    dname = 'RESEARCH';

--하나의 트랜젝션
ROLLBACK;

COMMIT;

--세션(session) : 어떤 활동을 위한 시간이나 기간 
--데이터베이스 세션 : 데이터베이스 접속을 시작으로 여러 데이터베이스에서 작업을 수행한 후 접속 종료
DELETE FROM dept_tcl
WHERE
    deptno = 50;

COMMIT;

UPDATE dept_tcl
SET
    loc = 'SEOUL'
WHERE
    deptno = 30;

COMMIT;


--DDL(데이터 정의어) : 객체 생성(CREATE), 변경(ALTER), 삭제(DROP)

--테이블 생성

--CREATE TABLE 테이블명 (
--    열이름 (자료형),
--    열이름 (자료형),
--    열이름 (자료형),
--    열이름 (자료형)
--);

--테이블명 규칙
--문자로 시작
--같은 사용자 소유의 테이블명 중복 불가
--영문자(한글 가능), 특수문자 가능($, #, _)
--SQL 키워드(select, delete ...)는 테이블명 사용 불가

--자료형
--문지 :
--CHAR(n) - 고정길이 ex) name char(10); --10개문자 허용(영어기준)
--VARCHAR2(n)- variable char, 가변길이 ex) name varchar2(10);  => 10자리를 먼저 잡아도 실제 문자가 3자리 들어오면 3자리만 사용
--NCHAR(n) - 고정길이(유니코드) ex) name nchar(10); => 한글/영어 모두 10개의 문자
--NVARCHAR(n) - 가변길이(유니코드)

--숫자형
--NUMBER(숫자1, 숫자2) 숫자1(자릿수), 숫자2(소수점자릿수)
--ex) empno(4) : 숫자로 4자리 허용
--    price number(7,2) : 숫자로 7자리 허용되는데 (소수점이 들어온다면 2자리 허용)
--    job number : 저장 데이터 크기에 맞게 자동 조절

--날짜형
--DATE : 년, 월, 일, 시, 분, 초
--TIMESTAMP : 년, 월, 일, 시, 분, 초, + 밀리초 입력가능

create table emp_ddl(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2));
    
drop table emp_ddl;
--다른 테이블 구조 이용해서 생성(데이터 포함)
create table emp_ddl as select * from emp;
--다른 테이블 구조 이용해서 구조만 생성
create table emp_ddl1 as select * from emp where 1<>1;

--테이블 변경 : ALTER

select  * from emp_ddl;

--열(칼럼) 추가 : ADD
alter table emp_ddl add hp varchar2(20); 

--열 이름을 변경 : RENAME
alter table emp_ddl rename column hp to tel;

--열 자료형 변경 : MODIFY
alter  table emp_ddl modify empno number(5);
--데이터가 이미 담겨있을경우에는 담겨있는데이터와 바꾸려는 데이터형태가 맞아야한다
desc emp_ddl;

--열 삭제 : DROP COLUMN
alter table emp_ddl drop column tel;

--테이블 명 변경 : RENAME
rename emp_ddl to emp_rename;

--테이블 삭제 : drop
drop table emp_rename;


--[실습1] emp_hw 테이블 작성
create table emp_hw(
    id char(8),
    name varchar2(10),
    addr varchar2(50),
    nation 
    char(4),
    email varchar(50),
    age number(7,2));
    
desc emp_hw;

alter table emp_hw add bigo varchar2(20);
alter table emp_hw modify bigo varchar2(30);
alter table emp_hw rename column bigo to remark;

--제약조건
--1) not null : 지정한 열에 null 을 허용하지 않음
--2) UNIQUE : 지정한 열이 유일한 값을 가져야 함 (null 제외)
--3) PRIMARY KEY : 지정한 열이 유일값이면서 NULL이 아님(하나만 지정)
--4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력 가능
--5) CHECK : 설정한 조건식을 만족하는 데이터만 입력 가능
create table table_notnull(
    login_id varchar(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20));
    
insert into table_notnull(login_id,login_pwd, tel)
values('test_id_01','12345','010-1234-5678');

update table_notnull
set login_pwd=null
where login_id='test_id_01';

--scott가 사용한 모든 제약조건 확인
select * from user_constraints;

--제약조건명 지정
create table table_notnull2(
    login_id varchar(20) constraint tblnn2_lgnid_nn not null,
    login_pwd varchar2(20) constraint tblnn2_lhnpwed not null,
    tel varchar2(20));
    
--table_notnull tel 컬럼을 not null 제약 조건 추가
desc table_notnull;

alter table table_notnull  modify(tel not null);

update table_notnull
set tel='010-1234-5678'
where login_id='test_id_01';

--제약조건 이름 변경
alter table table_notnull2 rename constraint tblnn2_lgnid_nn to tblnn2_id_nn;

--제약조건 삭제
alter table table_notnull2 drop constraint tblnn2_id_nn;

select * from user_constraints;

--2) UNIQUE : 지정한 열이 유일한 값을 가져야 함(NULL 제외)
create table table_unique(
    login_id varchar2(20) unique,
    login_pwd varchar2(20) not null,
    tel varchar2(20));
    
insert into table_unique(login_id, login_pwd, tel)
values('test_id_01', '12345', '010-1234-5678');

insert into table_unique(login_id, login_pwd, tel)
values('test_id_01', '54321', '010-1234-5678');

insert into table_unique(login_id, login_pwd, tel)
values(null,'12345', '010-1234-5678');

delete from table_unique where login_pwd='12345';

create table table_unique2(
    login_id varchar2(20) constraint tblunq2_lgnid_unq unique,
    login_pwd varchar2(20) constraint tblunq2_lgnpwd_nn not null,
    tel varchar2(20));
    
alter table table_unique2 modify(tel unique);


--3)PRIMAY KEY : 지정한 열이 유일값이면서 null이 아님(하나만  지정)
-- not null+unique

create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20));
    
insert into table_pk values('test_01','pw01', '010-1234-5678');
insert into table_pk values('test_01','pw01', '010-1234-5678'); 

create table table_pk2(
    login_id varchar2(20) constraint tblpk2_lgnid_pk primary key,
    login_pwd varchar2(20) constraint tblpk2_lgnpwd_nn not null,
    tel varchar2(20));

--제약조건 지정시 다른 방식
create table table_con(
    col1 varchar2(20),
    col2 varchar2(20),
    primary key(col1),
    constraint tblcon_unq unique(col2);

--4) foreign key : 다른 테이블의 열을 참조하여 존재하는 값만 입력 가능
create table dept_fk(
    deptno number(2) constraint deptfk_deptno_pk primary key,
    dname varchar2(20),
    loc varchar2(13));
    
create table emp_fk(
    empno number(4) constraint empfk_empno_pk primary key,
    ename varchar2(10),
    deptno number(2) constraint empfk_deptno_fk references dept_fk(deptno));
 
--error : parent key not found    
insert into emp_fk(empno, ename,deptno)
values(7899,'hong',20);

--외래키 수행순서
--부모테이블에 데이터가 먼저 삽입되어야 함
--자식테이블 데이터 삽입

insert into dept_fk values(10,'DATABASE','SEOUL');

insert into emp_fk(empno, ename,deptno)
values(7899,'hong',10);

--Child record found
delete from dept_fk where deptno=10;

--외래키 삭제 수행 순서
--자식 테이블에 해당하는 데이터 삭제
--부모 테이블에 해당하는 데이터 삭제

delete from emp_fk where deptno=10;
delete from dept_fk where deptno=10;

--부모 데이터를 삭제할 때 참조하고 있는 데이터도 함께 삭제
--부모 데이터를 삭제할 때 참조하고 있는 데이터를 null 로 수정
create table dept_fk2(
    deptno number(2) constraint deptfk_deptno_pk2 primary key,
    dname varchar2(20),
    loc varchar2(13));
 --on delete cascade : 부모의 열 데이터 삭제시 참조 데이터 함께 삭제   
create table emp_fk2(
    empno number(4) constraint empfk_empno_pk2 primary key,
    ename varchar2(10),
    deptno number(2) constraint empfk_deptno_fk2 references dept_fk2(deptno)
    on delete cascade);
    
insert into dept_fk2 values(10,'DATABASE','SEOUL');
insert into emp_fk2(empno, ename,deptno)
values(7899,'hong',10);

delete from dept_fk2 where deptno=10;
select * from emp_fk2; 

--on delete set null : 열 데이터 삭제시 참조 데이터를 null로 수정
create table dept_fk3(
    deptno number(2) constraint deptfk_deptno_pk3 primary key,
    dname varchar2(20),
    loc varchar2(13));
 
create table emp_fk3(
    empno number(4) constraint empfk_empno_pk3 primary key,
    ename varchar2(10),
    deptno number(2) constraint empfk_deptno_fk3 references dept_fk3(deptno)
    on delete set null);

insert into dept_fk3 values(10,'DATABASE','SEOUL');
insert into emp_fk3(empno, ename,deptno)
values(7899,'hong',10);

delete from dept_fk3;

select * from emp_fk3;

--5) CHECK : 설정한 조건식을 만족하는 데이터만 입력 가능
create table tbl_check(
    login_id varchar2(20) constraint tblck_lgnid_pk primary key,
    login_pwd varchar2(20) constraint tblck_lgnpwd_ck check (length(login_pwd)>3),
    tel varchar2(20));

--check constraint violated
insert into tbl_check values('test_id1', '123','010-1234-5678');

insert into tbl_check values('test_id1','1234','010-1234-5678');
select * from tbl_check;

--기본값 지정 : default

create table tbl_default(
    login_id varchar2(20) constraint tbl_lgnid_pk primary key,
    login_pwd varchar2(20) default '1234',
    tel varchar2(20));

insert into tbl_default values('test_id1', null, '010-1234-5678');
select* from  tbl_default;
insert into tbl_default(login_id,tel) values('test_id2','010-1234-5678');
select * from tbl_default;

[실습1]dept_cost 테이블과 emp_const 테이블을 다음과 같은 특성 및 제약조건을 지정하여 생성하시오.

create table dept_cost(
    deptno number(2) constraint DEPTCONST_DEPTNO_PK primary key,
    dname varchar2(14) constraint DEPTCONST_DNAME_UNQ unique,
    loc varchar2(13) constraint DEPTCONST_LOC_NN not null
    );
    
--create table dept_cost2(
--    deptno number(2),
--    dname varchar2(14),
--    loc varchar2(13),
--    constratin deptconst_deptno_pk primary key(deptno),
--    dname varchar2(14) constraint DEPTCONST_DNAME_UNQ unique(dname),
--    loc varchar2(13) constraint DEPTCONST_LOC_NN not null(loc)
--    );

--EMP_CONST table
create table emp_const(
    empno number(2) constraint empconst_empno_pk primary key,
    ename varchar2(10) constraint empconst_ename_nn not null,
    job varchar2(9) , 
    tel varchar2(20) constraint empconst_tel_unq unique,
    hiredate date,
    sal number(7,2) constraint empconst_sal_chk check (sal between 1000 and 9999),
    comm number(7,2),
    deptno number(2)  constraint empconst_deptno_fk references dept_cost(deptno)
     );
     
commit;

--시퀀스(squence) : 규칙에 따라 순번을 생성

create sequence dept_seq;

create table dept_sequence as select * from dept where 1<>1;

select * from dept_sequence;

select dept_seq.currval from dept_sequence;

insert into dept_sequence(deptno, dname,loc)
values(dept_seq.nextval, 'DATABASE','SEOUL');

drop sequence dept_seq;

create sequence dept_seq
increment by 10 --시퀀스에서 생성할 번호의 증가값
start with 10   --시퀀스에서 생성할 번호의 시작값
maxvalue 90 --시퀀스에서 생성할 번호의 최댓값
minvalue 0  --시퀀스에서 생성할 번호의 최소값
nocycle  --시퀀스에서 생성한 번호가 최댓값에 도달할 경우  다시 시작할 것인가 여부(cycle or no cycle)
cache 2; --시퀀스가 생성할 번호를 메모리에 미리 할당해 놓은 수를 지정
     
insert into dept_sequence(deptno, dname, loc)
values(dept_seq.nextval,'DATABASE','SEOUL');

select * from dept_sequence; 

--시퀀스 수정
alter sequence dept_seq increment by 3 maxvalue 99 cycle;

-- 뷰(view) : 가상 테이블
--            하나 이상의 테이블을 조회하는 select 문을 저장한 객체
--            편리성 - select 문의 복잡도를 완화
--            보안성 - 테이블의 특정 열을 노출하고 싶지 않은 경우
     
-- 뷰 생성시 원본 데이터 수정 불가하도록 작성
-- with read olny : 뷰의 열람
-- 생성
create view vm_emp20 as ( select empno,ename,job,deptno from emp where deptno=20);
select * from vm_emp20;

-- insert
insert into vm_emp20(empno, ename, job, deptno)
values(8000,'TEST', 'MANAGER', 20);
select * from vm_emp20;

-- view 와 원본테이블 연결 여부
select * from emp; // 원본테이블도 변화가 됨. // 연결되어있음

-- 생성된 뷰들의 속성 확인하기
select *
from USER_UPDATABLE_COLUMNS
where TABLE_NAME= 'VM_EMP20';

-- 뷰 생성시 원본 데이터 수정 불가하도록 작성
-- with read only : 뷰의 열람만. //수정불가
create view vm_emp_read as select empno, ename, job from emp with read only;
select *
from USER_UPDATABLE_COLUMNS
where TABLE_NAME='VM_EMP_READ';

insert into vm_emp_read(empno,ename,job)
values(8001, 'TEST', 'MANAGER');

-- 뷰 삭제
drop view vm_emp20;

-- 인덱스 : 빠른 검색
-- 인덱스 사용 여부에 따라 Table Full Scan, Index Scan

--scott 가 가지고 있는 인덱스 확인하기
select * from user_indexes; --pk 설정된 값들은 인덱스로 사용됨

--인덱스 생성
--create index 인덱스명 on 테이블명(열이름1 ,asc, 열이름2 desc,....)
create index idx_emp_sal on emp(sal);

--index가 설정된 컬럼 조회
select * from user_ind_columns;

select * from emp where deptno=20;

--index 삭제
drop index idx_emp_sal;

     
     
     
     
    