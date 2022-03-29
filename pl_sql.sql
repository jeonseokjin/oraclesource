--PL/SQL
--SQL 만으로는 구현이 어렵거나 구현 불가능한 작업들을 수행하기 위해서
--제공하는 프로그래밍 언어

--키워드
--DECLARE(선언부) : 변수, 상수, 커서 등을 선언(선택)
--BEGIN(실행부) : 조건문, 반복문, SELECT, DML(U,D,I), 함수 등을 정의(필수)
--EXCEPTION(예외처리부) : 오류(예외상황) 해결(선택)

--실행 결과를 화면에 출력
set SERVEROUTPUT ON;

-- Hello 출력
BEGIN
    dbms_output.put_line('Hello PL/SQL');
END;
/

CREATE PROCEDURE pro_noparam IS
    v_empno NUMBER(4) := 7788;
    v_ename VARCHAR2(10);
BEGIN
    v_ename := 'SCOTT';
    dbms_output.put_line('v_empno : ' || v_empno);
    dbms_output.put_line('v_ename : ' || v_ename);
END;
/

-- 프로시져 실행
execute pro_noparam;

-- 다른 PL/SQL 블록에서 프로시저 실행
BEGIN
    pro_noparam;
END;
/
------------------------------------------------------
CREATE OR REPLACE PROCEDURE pro_noparam_in IS
    v_empno NUMBER(4) := 7788;
    v_ename VARCHAR2(10);
BEGIN
    v_ename := 'SCOTT';
    dbms_output.put_line('v_empno : ' || v_empno);
    dbms_output.put_line('v_ename : ' || v_ename);
END;
/
-----------------------------------------------------
--프로시저 작성 시 파라미터가 존재하는 경우
--in 생략가능 (in) number
CREATE OR REPLACE PROCEDURE pro_param_in (
    param1 IN NUMBER,
    param2 NUMBER,
    param3 NUMBER := 3,
    param4 NUMBER DEFAULT 4
) IS
BEGIN
    dbms_output.put_line('param1 : ' || param1);
    dbms_output.put_line('param2 : ' || param2);
    dbms_output.put_line('param3 : ' || param3);
    dbms_output.put_line('param4 : ' || param4);
END;
/

execute pro_param_in(1,2);
execute pro_param_in(5,6,7,8);
execute pro_param_in(1,100);

--OUT 모드( in 은 변수를 받겠다는 뜻. out 은 변수를 내보내겠다는 뜻)

CREATE OR REPLACE PROCEDURE pro_param_out (
    in_empno  IN emp.empno%TYPE,
    out_ename OUT emp.ename%TYPE,
    out_sal   OUT emp.sal%TYPE
) IS
BEGIN
    SELECT
        ename,
        sal
    INTO
        out_ename,
        out_sal
    FROM
        emp
    WHERE
        empno = in_empno;

END;
/

DECLARE
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
BEGIN
    pro_param_out(7369, v_ename, v_sal);
    dbms_output.put_line('ename : ' || v_ename);
    dbms_output.put_line('sal : ' || v_sal);
END;
/

-------------------------------------
--in out 모드
CREATE OR REPLACE PROCEDURE pro_param_in_out (
    in_out_no IN OUT NUMBER
) IS
BEGIN
    in_out_no := in_out_no * 2;
END;
/

DECLARE
    no NUMBER;
BEGIN
    no := 5;
    pro_param_in_out(no);
    dbms_output.put_line('no : ' || no);
END;
/

-------------------------------------------------
-- 트리거
-- DML 트리거
-- CREATE OR REPLACE trigger 트리어 이름
-- before | after
-- insert | update | delete on 테이블이름
-- declare
-- begin
-- end

CREATE TABLE emp_trg
    AS
        SELECT
            *
        FROM
            emp;

-- emp_trg insert (주물에 사원정보 추가시 에러발생시킬 것), update, delete

CREATE OR REPLACE TRIGGER emp_trg_weekend 
BEFORE
    INSERT OR UPDATE OR DELETE ON emp_trg
BEGIN
    IF to_char(sysdate, 'DY') IN ( '토', '일' ) THEN
        IF inserting THEN
            raise_application_error(-30000, '주말 사원정보 추가 불가');
        ELSIF updating THEN
            raise_application_error(-30001, '주말 사원정보 수정 불가');
        ELSIF deleting THEN
            raise_application_error(-30002, '주말 사원정보 삭제 불가');
        ELSE
            raise_application_error(-30003, '주말 사원정보 변경 불가');
        END IF;

    END IF;
END;
/


------------------------------------------

--트리거 발생 저장 테이블 생성
CREATE TABLE EMP_TRG_LOG(
    TABLENAME VARCHAR2(20), --DML 이 수행된 테이블 이름
    DML_TYPE VARCHAR2(10),  --DML 명령어 종류
    EMPNO NUMBER(4),        --DML 대상이 된 사원번호
    USER_NAME VARCHAR2(30), --DML 을 수행한 USER 명
    CHANGE_DATE DATE);      --DML 시도 날짜
    
CREATE OR REPLACE TRIGGER emp_trg_weekend_log 
after
    INSERT OR UPDATE OR DELETE ON emp_trg
for each row --영향받는 모든 행별 실행
BEGIN
        IF inserting THEN
            insert into emp_trg_log
            values('emp_trg', 'insert', :new.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
        elsif updating then
            insert into emp_trg_log
            values('emp_trg', 'update', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
        elsif deleting then
            insert into emp_trg_log
            values('emp_trg', 'delete', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
        END IF;
END;
/

update emp_trg
set sal=3600
where empno=7369;

insert into emp_trg
values(9999,'TEST_TMP', 'CLERK', 7788, '2018-03-03', 1200, null, 20);
commit;

select * from emp_trg_log;

drop trigger emp_trg_weekend_log;