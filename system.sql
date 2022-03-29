--sql 구문은 대소문자를 구분하지 않음(비밀번호는 대소문자 구분해야함)
--scott/TIGER

--hr 사용자의 비밀번호 변경


ALTER USER hr IDENTIFIED BY hr ACCOUNT UNLOCK;
//lock 푸는 법 cmd 에서
//lock 해제
ALTER USER system account unlock;
//비밀번호 설정
alter user system identified by 12345;





--오라클 데이터베이스 특징
--테이블, 인덱스, 뷰 ....여러가지 객체가 사용자별로 생성되고 관리\
--사용자 ==스키마(데이터베이스 구조 범위)

--사용자 생성
--create user 아이디 identified BY 비밀번호;

create user test1 identified by 12345;

--권한 부여
--grant create 권한명 to 사용자;
--user TEST1 lacks CREATE SESSION pivilaege; logon denied

grant create session to test1;

--table 생성 권한 부여
grant create table to test1;

--롤(여러권한들을 묶어놓은 개념)
--resource : 시퀀스, table, trigger.. 객체 생성할 수 있는 권한이 모여 있음
--connect : create session이 들어 있음
grant resource, connect to test1;

--사용자 비밀번호 변경
alter user test1 identified by 54321;

--사용자 삭제
drop user test1 cascade;

--수업중 사용할 생성자
create user javadb identified by 12345;
grant resource, connect to javadb;

select * from all_users;

--scott에게 view 생성 권한 부여
grant create view to scott;






