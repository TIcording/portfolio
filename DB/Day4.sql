/*
	MySQL사용자
    1.사용자 추가하기
		-MySQL 8.0 command Line Client 'root' 계정으로 로그인
		-로컬(내컴퓨터)에서 접속 가능한 사용자 추가하기
			create user '사용자명'@localhost' identified by '사용자 비밀번호';
			create user 'apple'@localhost' identified by '1111';
		-DB 권한 부여하기
			grant all privileges on *.* to '사용자'@'localhost'; # 모든 DB접근 가능
            grant all privileges on 데이터베이스명.* to '사용자'@'localhost'; 
            flush privileges; # 새로운 세팅을 적용함                             
            보통은 INSERT, DELETE, UPDATE를 통해 사용자를 추가, 삭제, 권한 변경 등을 수행하였을 때 
            이 변경 사항을 반영하기 위하여 사용한다. 이 떄 FLUSH PRIVILEGES는 grant 테이블을 reload함으로서 변경 사항을 즉시 반영하도록 한다.
            그런데 만약 INSERT, DELETE, UPDATE와 같은 SQL문을 사용하지 않고 바로 grant 명령어를 사용하여 작업하였다면 FLUSH PRIVILEGES를 실행할 필요가 없어진다.
            
        ✔ 할당 권한 상세 옵션
        create ,drop , alter : 테이블에 대한 생성, 삭제, 변경 권한
        select,insert,update,delete : 테이블의 데이터를 조회,삽입,변경,삭제에 대한 권한
        all : 모든 권한
        usage : 권한을 부여하지 않고 계정만 생성 -> 디폴트값
        예) grant select(줄 권한명) on 데이터베이스명.테이블명 to '사용자'@'localhost';
        
		✔ IP 권한 상세 옵션
        %: 모든 IP에서 접근이 가능
        127.0.0.1 : localhost 에서 접근이 가능 (localhost와 같은 의미)
        예) grant select(줄 권한명) on 데이터베이스명.테이블명 to '사용자'@'%'(모든 IP가능);
        예) grant select(줄 권한명) on 데이터베이스명.테이블명 to '사용자'@'특정 ip주소';    

		2.사용자 계정 삭제하기
			drop user '사용자명'@'localhost'

		database 가 어디사용하는지 보기
        use 데이터베이스명 '사용자명'@'localhost';

*/
#apple 데이터베이스에 kdt.member(kdt 데이터베이스의 member 테이블) 테이블을 복사하고 해당 테이블의 select 권한만 가능한 orange 계정을 만들어보자

#풀이
/*
mysql> use apple;

Database changed

mysql> create table apple.member(select*from kdt.member);
mysql> create user 'orange'@'localhost' identified by '1111';
mysql>grant select on apple.member to 'orange'@'localhost';
mysql> flush privileges;

*/

#orange 로 로그인 후 테스트
use apple;
select  * from member;
update member set point = 500 where userid ='strawberry' ; #Error code: 1142 # update권한 없음




#사용자 목록 조회
use mysql;
select user, host from user;

#사용자 제거
#drop user 계정명;  # 추천
#delete from user where user = 계정명;


#사용자 권한 조회하기
#show grants for '계정명'@'localhost';
show grants for 'apple'@'localhost';
show grants for 'orange'@'localhost';

grant all on kdt.* to 'apple'@'localhost';

# 사용자 권한 제거하기
#revoke 권한명 privileges on 데이터베이스명.테이블명(권한을 줄때 설정한 값들) from '계정명'@'localhost';


#revoke all privileges on kdt.* from 'apple'@'localhost';
#revoke all privileges on apple.member from 'orange'@'localhost';

/*
	뷰(view)
    - 가상의 테이블을 생성
    - 실제 테이블처럼 행과 열을 가지고 있지만, 데이터를 직접 저장하고 있지는 않음
    
    
    ※뷰를 만드는 이유
    - SQL 코드를 간결하게 만들기 위함
    - 삽입, 삭제, 수정 작업에 제한 사항을 가짐
    - 내부 데이터를 전체 공개하고 싶지 않을 때
    

    


*/

#create view 뷰이름 as 쿼리 .....
use kdt;
select * from member;

select userid, username, hp, gender from member;
create view vw_member as select userid, username, hp, gender from member;
select * from vw_member;


#문제
#member 의 userid, username, hp 와 profile의 mbti를 출력하는 view 를 만들고 select 할 수 있는 melon 계정을 생성


create view vw_memberprofile as select m.userid, m.username, m.hp, p.mbti 
 from member as m inner join profile as p on m.userid = p.userid; 
 
 
select * from vw_memberprofile;
create user 'melon'@'localhost' identified by '1111';
grant select on kdt.vw_memberprofile to 'melon'@'localhost';
flush privileges;
show grants for 'melon'@'localhost';


#강사님 풀이
select m.userid , m.username,m.hp,p.mbti from member as m left join profile as p on m.userid = p.userid;
#이후 동일

#테스트
use kdt;
#select * from member; #접근권한 없음
select * from vw_memberprofile;



/*
	뷰 수정하기
    alter view 뷰이름 as 쿼리 .....(거의 다시만들기와 동일하다.)
  
	뷰 대체하기
    create or replace view 뷰이름 as 쿼리
  
*/

use kdt;

create or replace view vw_memberprofile as select m.userid, m.username, m.hp, p.mbti 
 from member as m inner join profile as p on m.userid = p.userid; 

#뷰 삭제하기
# drow view 뷰이름

drop view vw_member;
#select * from vw_member; 삭제잘됨.
create view vw_member as select userid, username, hp, gender from member;
select * from vw_member; 

update vw_member set hp = '01015612525' where userid = 'strawberry';
select * from vw_member;


insert into vw_member values ('avocado','안가도','010-8888-8888','남자'); # 테이블 not null 제약조건으로 인해 안됨 
#Error Code: 1423. Field of view 'kdt.vw_member' underlying table doesn't have a default value



/*
	트렌젝션(Transaction)
	- 분할이 불가능한 업무처리의 단위
    - 한꺼번에 수행되어야 할 연산 모음
	ex) 은행의 전산
    
    commit : 모든 작업들을 정상 처리하겟다고 확정하는 명령어로써, 해당 처리 과정을 DB에 영구적으로 저장
    rollback: 작업 중 문제가 발생되어 트렌젹션의 처리 과정에서 발생한 변경사항을 모두 취소하는 명령어
    
    start transaction
		블록안의 명령어들은 하나의 명령어 처럼 처리됨
        ....
        성공하던지, 실패하던지 하나의 결과가 됨
        문제가 발생하면 rollback;
	정상적인 처리가 완료되면 commit;

	트랜젝션의 특징
    - 원자성 : 트렌젝션이 데이터베이스에 모두 반영되던가, 아니면 전혀 반영되지 않아야 함
    - 일관성 : 트렌젝션의 작업 처리 결과가 항상 일관성이 있어야 함
    - 독립성 : 어떤 하나의 트렌젹선이라도, 다른 트렌젝션의 연산에 끼어들 수 없음
    - 영구성 : 결과는 영구적으로 반영되어야 함

	
*/

# 자동 커밋 확인
show variables like '%commit%';
# autocommit : ON -> 자동으로 commit을 해줌 
# set autocommit = 0 (off) , set autocommit = 1 (on)

set autocommit = 0;

delete from product where name ='고철';

select *from product;
start transaction; # 트렌젝션의 시작. commit 또는 rollback 으로 끝내야함
insert into product values('100005','고철','팔아요',100,now());
select * from product;
commit;   #트렌젹션을 DB에 적용하는것


start transaction; 
insert into product values('100006','공병','팔아요','50',now());
select *from product;
rollback;                # 트렌젹선을 취소하고 start transaction 실행 전 상태로 롤백함
select *from product;


# 트렌젝션의 예외
#DDL (create, drop, alter, rename, truncate) 에 대해 예외를 적용 --> rollback 대상이 아님

#truncate 란?
# 개별적으로 행을 삭제할 수 없으며, 테이블 내부의 모든행(데이터)를 삭제
#rollback 불가
#트렌젝션 로그에 한번만 기록하므로 delete 구문보다 성는 면에서 빠름
#truncate table 테이블명 = delete from 테이블명

select * from product_new;
start transaction;
delete from product_new;
select * from product_new;
rollback; # 데이터 돌아옴


start transaction;
truncate table product_new;
select * from product_new;
rollback;   # 안 돌아옴


set autocommit =1;
show variables like '%commit%';




/*

	인덱스(index)
    - 테이블의 동작속도(조회)를 높여주는 자료구조
	- MYI(MySQL Index)파일에 저장
    - 인덱스를 설정하지 않으면 Table full Scan이 일어나 성능이 저하되거나 장애가 발생할 수 잇음
    - 조회속도는 빨라지지만 update,insert,delete의 속도는 저하될 수 있음
    -  MySQL에서는 primary key,unique 제약조건을 사용하면 해당 컬럽에 index가 적용됨0
    - 인덱스는 하나 또는 여러 개의 컬럼에 설정할 수 있음
    -  where 절을 사용하지 않고 인덱스가 걸린 컬럼을 조회하면 성능에 아무런 효과가 없음(where절을 위함)
    - 가급적 update가 안되는 값을 설정하는 것이 좋음 -> 성능상 update가 자주되는 것을 설정하면 MYI 파일과 값 모두 바꿔야 하기 때문에 성능이 저하된다.
	
	order by, gruop by 와 index : index의 효과가 없는경우
    - order by 인덱스컬럼,일반컬럼: 복수의 키에 대해 order by를 사용한 경우 /효과 없음
    - where 컬럼1 ='값' order by 인덱스컬럼: 연속하지 않은 컬럼(중간의 데이터가 빈 데이터잇을때)에 대해 order by를 실행한 경우 /효과 없음
	- order by 인덱스 컬럼1 desc,인덱스컬럼2 asc : desc asc 혼합해서 사용할 경우 / 효과 없음
    - group by 일반컬럼1 order by 인덱스컬럼 : group by 와 order by의 컬럼이 다른경우/효과없음
    - order by 함수(인덱스컬럼) : order by 절에 컬럼이 아닌 다른 표현을 사용한 경우
    
    인덱스 문법
    create index 인덱스명 on 테이블이름(필드이름)
    create index 인덱스명 on 테이블명(필드이름1,필드이름2,...)
    
    인덱스 조회
    show index from 테이블명;
 
	인덱스 삭제하기
    alter table 테이블명 drop index 인덱스명;
    
 */
select * from member;
show index from member;


create index idx_hp on member(hp);
alter table member drop index idx_hp;












	













