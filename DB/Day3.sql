use KDT;
select * from member;
# 오늘 목표 :큰테이블을 작은테이블로 나누기
# 큰 테이블은 자주쓰는것,작은 테이블은 자주 안쓰는것 모아두는 형태로
#RDBMS 특징 -> 다른 테이블을 쪼개놓고 서로 연관성을 주어 연계 시킬 수 있다.(관계성이 있는 필드 끼리 연결해준다.)

desc member;


#프로필 테이블 생성
create table profile(
	userid varchar(20) not null,
    height double,
    wight  double,
    blood  varchar(10),
    mbti   varchar(10),
	foreign key(userid) references member(userid)  #foreign key(테이블 컬럼)reference 연결할 테이블(연결할컬럼)
    
);


select * from profile;
select * from member;
insert into profile values('song',180,70,'AAA','ISTP'); # userid 필드 일치 member에 존재x #Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`kdt`.`profile`, CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `member` (`userid`))	0.000 sec

insert into profile values('apple',180,70,'A형','ISTP');
insert into profile values('banana',160,50,'B형','ISTP');
insert into profile values('grape',150,60,'AB형','ISTP');
insert into profile values('melon',180,70,'AB형','ISTP');
insert into profile values('orange',170,50,'O형','ISTP');


#조인 : 테이블을 합쳐서 표현
#select 필드명1,필드명2,..... from 테이블1[inner,left,right] join 테이블2 on 테이블1.연결할 필드 = 테이블2.연결할 필드;
 
#inner 조인
#조인하는 테이블의 on 절의 조건이 일치하는 결과만 출력
#join , inner join ,cross join 같은 의미로 사용됨

#select userid, username, hp, height, mbti from member inner join profile on member.userid = profile.userid; #Error Code: 1052. Column 'userid' in field list is ambiguous

#어떤 테이블의 userid인지 모르겟음 
 
 select * from member;
 select * from profile;
 
 select m.userid, m.username, m.hp, p.height, p.mbti 
 from member as m inner join profile as p on m.userid = p.userid;
 
 
 #left / right outer 조인
 #두 테이블이 조인 될 때 왼쪽/오른쪽 기준으로 햇느냐의 따라 기준 테이블의 것을 모두 출력
 #outer join은 조인하는 테이블의  on 절의 조건 중 한쪽의 데이터를 모두 가져옴
 #left outer join, right outert join ,full outer join 이렇게 3가지 있음
 #full outer join 은 거의 사용하지 않음 -> 성능상의 문제와 데이터가 모두 다 뿌려지기 때문에 굳이 사용 x
  
  
 select m.userid, m.username, m.hp, p.height, p.mbti 
 from member as m left outer join profile as p on m.userid = p.userid;    # member 기준으로 뽑으니 profile 에 없는 테이블은 null값으로 나옴

 select m.userid, m.username, m.hp, p.height, p.mbti 
 from member as m right outer join profile as p on m.userid = p.userid;   # 이것은 profile 테이블 자체를 foreign key로 묶엇기에 inner 와 다른게 없음
 
 
 
 
 /*
데이터 정규화
- 데이터 베이스를 설계할 때 중복을 최소화하는 것
- 크고 조직화되어 있지 않은 테이블과 관계들을 조직화된 테이블과 관계들로 나누는 것


데이터 정규화가 필요한 경우
-데이터를 갱신,삽입,삭제하는 등 테이블을 수정할 때 원하지 않게 데이터가 삭제되거나 가공되는 일이 발생하는데 이를 '이상 현상'이라고 함
-이상 현상이 발생하는 경우 데이터 정규화가 반드시 필요


정규화의 종류

1. 1NF (제 1 정규화)
테이블 안의 모든 값들은 단일값이어야 함 : 하나의 필드에는 하나의 값만

2. 2NF (제 2 정규화)
-1NF 를 만족하면서, 완전 함수 종속성을 가진 관계들로만 테이블을 생성하는 것
-종속성들 중 종속 관계에 있는 열들끼리 테이블을 구분해 주는것

✔함수 종속성
x값에 따라서 y값이 결정되는 경우

3. 3NF (제 3 정규화)
- 2NF를 만족하면서, 기본키에 대해 이행적 함수 종속이 되지 않는 것을 의미
- 이것을 무조건 지키는건 애매하다. 성능의 문제가 있고 실무자들끼리의 논의가 필요함

4. 비정규화
-정규형에 일치하게 되어 있는 테이블을 정규형을 지키지 않는 테이블로 만드는 것
-테이블을 조회하는 용도로 사용하거나, 너무 데이터가 많이 나뉘어 성능이 저하된다면 비정규화를 하여 테이블을 다루는 것이 더 효율적일 수 있다.
-어떤 작업을 수행하는지, 어떤 데이터를 사용하는지에 따라 적절한 정규화를 하는 것이 좋음




 
 */
 
 #auto_increment ( 필드의 indentity 한 숫자를 자동으로 부여)
 
 create table tel(
	idx int auto_increment primary key, # 자동 증가 되니까 값 너으면 안됨.
    name varchar(20) not null,
	hp   varchar(20) not null,
    job  varchar(20),
    regdate datetime default now()

 ); #Error Code: 1075. Incorrect table definition; there can be only one auto column and it must be defined as a key
 # auto_increment를 쓰면 primary key를 써야함 -> MySQL 에서만! 다른 DBMS는 아니다

select * from tel;

# 값을 idx 와 regdate 는 사용하면 안되므로 일반 insert 구문 쓰지 않고 컬럼 = value 이런식으로 써야함

insert into tel(name,hp,job) values('김사과','010-1111-1111','학생');
insert into tel(idx,name,hp,job) values(2,'반하나','010-1111-1111','학생');
insert into tel(idx,name,hp,job) values(10,'오렌지','010-1111-1111','군인');   # idx가 자동증가여도 identity한 값만 잇으면 상관없다.
insert into tel(idx,name,hp,job) values(2,'이메론','010-1111-1111','군인');    # 중복값이라 불가 #Error Code: 1062. Duplicate entry '2' for key 'tel.PRIMARY'
insert into tel(name,hp,job,regdate) values('이메론','010-1111-1111','군인',now());    # 10 번 진행하다 다시 없으면 11번으로 자동 개행 
#insert into tel values('백지명','010-1111-1111','군인',now()); 이런형태 왜 불가할까 되넹

insert into tel values(13,'백지명','010-1111-1111','군인',now());


#유니온(union)
#합집합을 나타내는 연산자로,중복된 값을 제거함
#서로 같은 종류의 테이블(컬럼이 같아야 함)에서만 적용이 가능
# select 컬럼명1,컬럼명2 .... 테이블 1 union select 컬럼명1 , 컬럼명2 ... from 테이블 2

create table product(
	code varchar(6) not null,
    name varchar(50) not null,
    detail varchar(1000),
    price int default 0,
    regdate datetime default now()

);


create table product_new(
	code varchar(6) not null,
    name varchar(50) not null,
    detail varchar(1000),
    price int default 0,
    regdate datetime default now()
    
);



select * from product;
select * from product_new;


insert into product values('100000','아이폰14','예뻐요',1500000,now());
insert into product values('100001','갤럭시23','좋아요',1300000,now());
insert into product values('100002','맥북에어','가벼워요',1400000,now());
insert into product values('100003','Z플립4','잘접혀요',1800000,now());
insert into product values('100004','LG공기청저기','성능좋아요',600000,now());

insert into product_new values('200000','LG그램','가벼워요',1500000,now());
insert into product_new values('200001','삼성모니터','잘보여요',500000,now());
insert into product_new values('100001','갤럭시23','좋아요',1300000,now());

#날자는 중복되지 않아 출력이됨
select code,name,price,regdate from product 
union
select code,name,price,regdate from product_new;  #전체가 중복되야 안나오는것 , 다른게 있다면 표현된다.

#union all 
#합집합을 나타내는 연산자로,중복값을 제거하지 않음

select code,name,price from product
union all
select code,name,price from product_new;


/*
※ numCount :카멜 표기법          -> 보통 언어쪽
※ product_new : 스네이크 표기법   -> 보통 데이터쪽에서 DBMS 특히 RDBMS 쪽에서는 대문자 의미 X -> 이런식 표기

*/
 


/*
	서브쿼리(sub Query)
    -다른 쿼리 내부에 포함되어 있는 select 문을 의미
    -서브쿼리를 포함하고 있는 쿼리를 외부쿼리라고 부르고,서브쿼리는 내부쿼리라고도 부름
    -서브쿼리는 괄호()로 감싸져서 표현
    -서브쿼리는 메인쿼리 컬럼 사용이 가능하며,메인쿼리는 서브쿼리 컬럼을 사용하지 못함
    -select,where,from, having 절 등에서 사용할 수 있음
	
    

*/
 
select price from product where code='100001';
#100001코드의 상품 가격보다 크거나 같은 상품들의 모든 정보들을 보고싶다.

select * from product where price>=(select price from product where code='100001');
#강사님 풀이
select * from product where price >=(select price from product where code='100001');


#select 절
#코드, 이름, 가격,전체 데이터의 가격중 가장 큰 값/을 출력하는 쿼리
#서브 쿼리를 사용

select code,name,price,(select max(price) from product ) as max_price from product;



create table orders(
	no int not null,
    userid varchar(20) not null,
    product varchar(100) not null,
    cnt int default 1,
    regdate datetime default now(),
	foreign key(userid) references member(userid)
);


select * from orders;

desc orders;

insert into orders(no,userid,product,cnt) values (1,'apple','사과',3);
insert into orders(no,userid,product,cnt) values (2,'apple','꿀사과',2);
insert into orders(no,userid,product,cnt) values (3,'banana','바나나',5);
insert into orders(no,userid,product,cnt) values (4,'banana','딸바',1);
insert into orders(no,userid,product,cnt) values (5,'orange','오렌지',2);
insert into orders(no,userid,product,cnt) values (6,'strawberry','딸기',3);



select * from orders;

drop table orders;



#상품을 최소 2번 이상 구입한 회원의 아이디와, 이름 성별을 출력

select userid,username,gender from member where userid =(select userid from orders where cnt>=2);
 
select * from orders;
select userid from orders where cnt>=2;
 
#강사님 풀이
select userid, username, gender from member where userid in (select userid from orders group by userid having count(no) >= 2);

#select userid,count(no)as cnt from orders group by userid having count(no) >=2; 

/*
MySQL 문자열 함수


*/



#concat : 복수의 문자열을 연결해주는 함수
select concat('안녕','하세요') as concat;
select * from member;
select address1,address2,address3 from member where userid='orange';
#이것을 하나의 컬럼으로 내보내고 싶다.
select concat(address1,' ', address2,' ', address3) as 주소 from member where userid='orange';


#left,right : 왼쪽 또는 오른쪽에서 길이만큼 문자열을 가져옴
select left('ABCDEFGHIJKLMN',5);
select right('ABCDEFGHIJKLMN',5);
select userid,left(email,5) as email  from member where userid='apple';
 
#substring(문자열,시작위치,길이) : 문자열 일부를 가져옴
select substring('ABCDEFGHIJKLMN',3,2) as 추출 ;
select substring(address1,1,3) as 주소 from member where userid ='orange';
 
 
#char_length: 문자열 길이를 반환
select char_length('ABCDEFGHIJKLMN')as 길이 ;
select char_length(email)as len from member; 

#lpad,rpad : 왼쪽 또는 오른쪽의 해당 길이만큼 늘리고 빈 공간을 채울 문자열을 반환
select lpad('ABCDEFG',10,'0');
select lpad(point,5,'0') as lpad from member;

#ltrim,rtrim,trim : 왼쪽 ,오른쪽,모든 공백을 제거
select ltrim('                ABCDEFG          ') as ltrim;
select rtrim('                ABCDEFG          ') as rtrim;
select trim('                 ABCDEFG          ') as trim;

#replace : 문자열에서 특정 문자열을 변경
#repalce(문자열,대상,바꿀문자열)

select replace('ABCDEFG','CD','✔') as repl;

select * from member;
select * from orders;

#문제 : 상품을 2번 이상 구입한 사용자의 아이디,상품 구입횟수, 시도이름을 출력  , 서브쿼리를 사용
/*
select userid,(select count(no) from orders) as 구입횟수,concat(address1,' ',address2) as 주소 
from member where userid 
in (select userid from orders group by userid having count(no) >=2);

select count(no) from orders;
select userid,count(no) from orders group by userid having count(no)>=2;
select userid from orders group by userid having count(no) >=2
*/

# 강사님 풀이
# 만약 서브쿼리을 안썻을때

select userid,substring(address1,1,3) as address from member;
select count(no) as cnt from orders group by userid;
select count(no) as cnt from orders group by userid having cnt>=2;

#조인 이용
select m.userid,count(o.no) as cnt,substring(m.address1,1,3) as address
from member as m right outer join orders as o on m.userid = o.userid group by userid
having cnt >=2;  

#서브쿼리를 이용 :from 절 이용

select userid,count(no) as ocnt from orders group by userid having count(no)>=2;  #이것을 하나의 테이블로이용


select m.userid,t.ocnt,substring(m.address1,1,3) as address from member as m
right outer join 
(select userid,count(no) as ocnt from orders group by userid having count(no)>=2) as t
on m.userid =t.userid ;





create table orders2(
	no int not null,
    userid varchar(20) not null,
    product varchar(100) not null,
    cnt int default 1,
    regdate datetime default now(),
	foreign key(userid) references member(userid)
);

use kdt;
select * from orders2;

#orders 와 동일한 테이블 orders2 를 만들고 orders 에 존재하는 데이터를 모두 복사하여 orders2에 저장

insert into orders2(select * from orders);

#처음부터 복사하여 생성하기
create table orders3(select * from orders);
select * from orders3











                                                                    






