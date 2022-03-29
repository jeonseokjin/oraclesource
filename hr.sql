--hr(Oracle 연습용 계정)
--scott 가 가지고 있는 정보의 원본

--[문제1] employees 테이블 전체 내용 조회
SELECT
    *
FROM
    employees;

--[문제2] employees 테이블 first_name, last name, job_id 조회
SELECT
    *
FROM
    employees;

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;

--[문제3] employees 테이블의 모든 열을 조회
--employee_id : empno
--manager_id : mgr
--department_id : deptno
--위 세개의 열은 별칭을 붙여서 조회
--조회할 때 부서번호를 기준으로 내림차순으로 정렬하되 부서 번호가 같다면
--사원 이름(First_name)을 기준으로 오름차순 정렬
SELECT
    *
FROM
    employees;

desc employees;

SELECT
    employee_id   AS empno,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id    AS mgr,
    department_id AS deptno
FROM
    employees
ORDER BY
    department_id DESC,
    first_name ASC;
        
--[문제4] 사원번호가 176인 사원의 last_name과 deptno 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    employee_id = 176;

--[문제5] 연봉이 12,000이상 되는 직원들의 last_name 과 salary 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;

--[문제6] 연봉이 5000~ 12000범위 사이가 아닌 사원들 조회
SELECT
    employee_id,
    salary
FROM
    employees
WHERE
    salary < 5000
    OR salary > 12000;

--[문제7] 20번 혹은 50번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 department_id 조회
--후, last_name의 오름차순, department_id 의 오름차순으로 정렬
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name ASC,
    department_id ASC;

--[문제8] 커미션을 받는 모든 사원들의 last_name, salary, commission_pct를 조회한다
--연봉의 내림차순, commission_pct의 내림차순 정렬
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    salary DESC,
    commission_pct DESC;

--[문제9] 연봉이 2500, 3500, 7000이 아니며, 직업이 SA_REP, ST_CLERK인 사원 조회
--전체 정보 조회
SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id IN ( 'SA_REP', 'ST_CLERK' );

--[문제10] '2008-02-20'~'2008-05-01' 사이에 고용된 사원들의 last_name, employee_id, hire_date조회,
--hire_date 의 내림차순으로 정렬
SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2008-02-20'
    AND hire_date <= '2008-05-01'
ORDER BY
    hire_date DESC;

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2008-02-20' AND '2008-05-01'
ORDER BY
    hire_date DESC;

--[문제11] '2004'년도에 고용된 모든 사람들의 last_name, hire_date를 조회하여
--입사일 기준으로 오름차순 정렬
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2004-01-01'
    AND hire_date <= '2004-12-31'
ORDER BY
    hire_date ASC;

SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2004-01-01' AND '2004-12-31'
ORDER BY
    hire_date ASC;

--like 사용
--[문제12] '2004'년도에 고용된 모든 사람들의 last_name, hire_date를 조회하여
--입사일 기준으로 오름차순 정렬
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '04%'
ORDER BY
    hire_date ASC;;

--[문제13] last_name에 u가 포함되는 사원들의 사번 및 last_name 조회
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%u%';
--[문제14] last_name의 네번째 글자가 a인 사원들의 사번 및 last_name조회
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '___a%';
--[문제15] last_name에 a 혹은 e가 들어있는 사원들의 last_name 조회 후 
--last_name 오름차순 출력
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%'
    OR last_name LIKE '%e%'
ORDER BY
    last_name ASC;

--[문제16] last_name에 a와 e가 들어있는 사원들의 last_name 조회 후
--last_name 오름차순 출력
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%'
    AND last_name LIKE '%e%'
ORDER BY
    last_name ASC;

--[문제] 매니저가 없는 사원들의 last_name, job_id 조회
SELECT
    last_name,
    job_id,
    manager_id
FROM
    employees
WHERE
    manager_id IS NULL;

--[문제 ST_CLERK인 JOB_ID를 가진 사원이 없는 부서 id 조회
--단, 부서번호가 NULL인 값은 제외한다.
SELECT
    department_id
FROM
    employees
WHERE
    job_id NOT IN ( 'ST_CLERK' )
    AND department_id IS NOT NULL;

--[문제] commision_pct 가 널이 아닌 사원들 중에서 commision = salary*commision_pct를 구하여,
-- employee_id, first_name, job_id와 함께 출력
SELECT
    employee_id,
    first_name,
    job_id,
    salary * commission_pct AS commission
FROM
    employees
WHERE
    commission_pct IS NOT NULL;


--[문제] first_name이 Curtis인 사람의 first_name, last_name, phone_number, job_id 조회
--단, job_id의 결과는 소문자로 출력하기
SELECT
    first_name,
    last_name,
    phone_number,
    lower(job_id)
FROM
    employees
WHERE
    first_name = 'Curtis';

--[문제] 부서번호가 60, 70, 80, 90인 사원들의 employee_id, first_name, last_name, department_id
--jod_id 조회하기, 단, job_id가 IT_PROG인 사원의 경우 프로그래머로 변경하여 출력
SELECT
    first_name,
    last_name,
    phone_number,
    lower(job_id),
    replace(job_id, 'IT_PROG', '프로그래머')
FROM
    employees
WHERE
    department_id IN ( 60, 70, 80, 90 );
--[문제] job_id가 AD_PRES, PU_CLERK인 사원들의 employee_id, first_name, last_name, department_id
--job_id 조회하기, 단 사원명은 first_name과 last_name을 연결하여 출력
SELECT
    employee_id,
    concat(first_name, concat(' ', last_name)),
    department_id,
    job_id
FROM
    employees
WHERE
    job_id IN ( 'AD_PRES', 'PU_CLERK' );

--[실습]SQL 작성(hr)
--[실습4] 부서80의 각 사원에 대해 적용 가능한 세율을 표시하시오
--2000 미만 - 0%, 4000미만 9%, 6000미만 20%,
--8000 미만 - 30%, 10,000미만 40%, 12000미만 42%,
--14000미만 44%, 나머지 45%

SELECT
    last_name,
    salary,
    decode(trunc(salary / 2000),
            0,0.00,
            1,0.09,
            2,0.20,
            3,0.30,
            4,0.40,
            5,0.42,
            6,0.44,
            0.45) AS tax_rate
FROM
    employees
WHERE
    department_id = 80;

--[문제] 회사 내의 최대 연봉 및 최소 연봉 차 출력
select max(salary)-min(salary)
from employees;
--[문제] 매니저로 근무하는 사원들의 총 숫자 출력
select count(distinct manager_id)
from employees;

--[문제] 부서별 직원수를 구하여, 부서번호의 오름차순으로 출력
select department_id,count(employee_id)
from employees
group by department_id
order by department_id asc;
--[문제] 부서별 급여의 평균 연봉 출력(부서번호별 오름차순)
select department_id, round(avg(salary))
from employees
group by department_id
order by department_id asc;
--[문제] 동일한 직업을 가진 사원들의 수 출력
select job_id,count(job_id)
from employees
group by job_id;

--[실습] 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기(셀프조인)
select e1.employee_id, e1.manager_id, e1.hire_date, e2.employee_id, e2.hire_date
from employees e1
join employees e2 on e1.manager_id=e2.employee_id and e1.hire_date<e2.hire_date;
--[실습] 도시 이름이 T로 시작하는 지역에 사는 사원들의 사번, last_name, department_id, city출력
--(employees, departments, locations 테이블 조인)
select e.employee_id, e.last_name, e.department_id, l.city
from employees e
join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id and city like 'T%';

--[실습] 위치 ID가 1700인 사원들의 employee_id, last_name, department_id, salary
--출력(employees, departments 조인)
select e.employee_id, e.last_name, e.department_id, e.salary, d.location_id
from employees e
join departments d on e.department_id=d.department_id and d.location_id=1700;


--[실습] 각 부서펼 평균 연봉(소숫점 2자리까지), 사원 수 조회
--department_name, location_id, sal_avg, cnt 출력
--(employees, departments 조인)
select d.department_name, d.location_id, round(avg(salary),2) as sal_avg, count(employee_id)
from employees e
join departments d on e.department_id=d.department_id
group by d.department_name, d.location_id;


--[실습] Executive 부서에 근무하는 모든 사원들의 department_id, last_name, job_id 출력
--(employees, departments 조인)
select d.department_id, d.department_name,e.last_name, e.job_id
from employees e
join departments d on e.department_id=d.department_id and d.department_name='Executive';

--[실습] 기존의 직업을 여전히 가지고 있는 사원들의 employee_id, job_id 출력
--employees 셀프 조인, job_history 내부조인
select e.employee_id, e.job_id
from employees e
join job_history j on e.employee_id!=j.employee_id;

--[실습] 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원의
--department_id, last_name, salary, hire_date 출력
--employees 셀프 조인
select e1.department_id, e1.last_name, e1.salary, e1.hire_date, e2.last_name,e2.hire_date, e2.salary, e2.department_id
from employees e1
join employees e2 on e1.department_id=e2.department_id and e1.hire_date<e2.hire_date and e1.salary<e2.salary
order by e1.department_id asc;

--index
create table indextbl as select distinct first_name, last_name, hire_date from employees;

select * from indextbl;
select * from indextbl where first_name='Jack';

create index idx_indextbl_firstname on  indextbl(first_name);




