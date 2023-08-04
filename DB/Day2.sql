
/*
SQL 연산자
1. 산술연산자
	+,-,*,/, mod(나머지 연산자) , div(몫)
    

2. 비교 연산자
	=(같다) , <,>,>=,<=,<>(다르다)

3. 대입 연산자
	=       #이건 컬럼명사용시  #비교연산자와 대입연산자 구별은? -> 어차피 비교 연산자는 비교문에서만 나온다.
    
4. 논리 연산자
	and, or ,not ,xor

5.기타 연산자
	is : 양쪽이 모두 true 또는 false
    between A and B : 값이 A보다는 크거나 같고, B보다는 작거나 같으면 true 아니면 false
	in : 매개변수로 전달된 리스트에 값이 존재하면 true 아니면 false
    like: 패턴으로 문자열을 검색하여 값이 존재하면 true 아니면 false

*/



# 데이터 검색
# select 필드명1,필드명2.... from 테이블명;

select 100;
select 100 + 50;  # 이렇게 할수 있지만 필드명이 없엇기에 계산값 자체가 필드값이 된다.
#이런식으로 필드명이 잡히면 연동이 힘들기 때문에 별명 설정 필요

use kdt;
select userid,username,gender from member;
select username,userid,gender from member; #이럼 순서 바꿔서 가져옴 테이블에 순서가 확정되어있지 않다.



#별명
#selcet 필드명 as 별명 from 테이블명;

select 100 + 50  as '덧셈'; -- ''를 사용하는 이유는 띄어쓰기가 있을 수 있어서 사용
select 100 + 50 as '덧셈 연산';

select userid as 아이디, username as 이름, hp as 휴대폰번호 from member; # as 뒤에 ''없으면 띄어쓰기 X

#모든 컬럼 가져오기 (추천하지 않음)
select * from member; #연산이 너무 많아서 실서버에서 이러면 안됌 

#null 과 ''
select null; #데이터가 없음, insert가 되지 않은것

select '';   #해당 셀에 '' 데이터가 삽입된 것

select 100 + null; # 결과 :null ,연산할 수 없음
select 100 + '' ;  # 결과 :100  ,연산 가능

#조건절
#select 필드명1,필드명2,... from 테이블명 where 조건절

select userid,username,hp,email from member where userid ='apple';
select userid,username from member where gender ='남자';
select userid,username,point from member where point >=300; #비교 연산자

#로그인 ( 논리연산자)
select userid,username,hp,email from member where userid = 'apple' and userpw = 'le'; #이방식이 로그인 쿼리

# is  (주소 없는사람 찾기)
select userid,username,hp from member where address1 = 'null'; -- 틀린방법
select userid,username,hp from member where address1 = null;   -- 틀린방법2
select userid,username,hp from member where address1 is null;  -- is의 양옆이 모두 null이냐
select userid,username,hp from member where address1 is not null; -- is의 양옆이 모두 not null,즉 주소가 있는사람 

update member set point=300 where userid ='grape';
select userid,username,point from member where point between 300 and 600;
select userid,username,point from member where point >=300 and point <=600; #같은말

#in 
select * from member;
#포인트가 200 300 500 인 회원을 모두 출력

select userid,point from member where point in (200,300,500);




#like 연산자
select userid,username from member where userid like 'a%'; -- a로 시작하는 문자열
select userid,username from member where userid like '%a'; -- a로 끝나는 문자열   
select userid,username from member where userid like '%a%'; -- a가 들어가는 문자열
select userid,username from member where userid like '%app%'; -- app가 들어가는 문자열
select userid,username from member where userid like 'app__'; -- app으로 시작하는 5글자 문자열


#정렬 
#select 필드명1,필드명2, ... from 테이블명 order by 정렬할 필드명(asc,desc)
select userid,username,point from member order by userid asc; #아이디로 오름차순
select userid,username,point from member order by userid desc; #아이디로 내림차순
select userid,username,point from member order by userid;     #아이디로 오름차순

#point 내림차순으로 할건데 같을시 id로 내림차순 하고 싶다.
select userid,username,point from member order by point desc, userid desc; #뒤에 ,쓰고 적용하면 된다.

#조건절 + 정렬
#select 필드명1,필드명2,.... from 테이블명 where 조건절 order by 정렬할 필드명 (asc,desc) # 조건절 무조건 먼저
#성별이 여성인 회원을 point가 많은순으로 정렬 (단,포인트가 같을 경우 먼저 가입한 순으로 정렬)

select userid,username,gender,regdate,point from member where gender = '여자' order by point desc, regdate asc;

#limit
#select 필드명1,필드명2,...from 테이블명 limit 가져올 행의 갯수
#select 필드명1,필드명2,...from 테이블명 limit 시작행,가져올 행의 갯수

select *from member;

select userid,username,gender from member limit 3;
select userid,username,gender from member limit 3, 2; #인덱스 3행부터 2개의 행을 가져옴


#정렬 + limit
#select 필드명1,필드명2.... from 테이블명 order by 정렬할 필드명[asc,desc] limit 가져올 행의 갯수

select userid,username,point from member order by point desc limit 3;

#집계함수
#count : 행의 갯수를 세는 함수
#전체인원을 알고싶다! : primary key 읽어주기 /primary key가 적용되어 null이 포함될 수 없음

select count(userid) as 전체인원 from member;   #5

#주소를 입력한 인원을 알고싶다!:null이 있으면 주소를 입력하지 않앗음
select count(zipcode) as 우편번호 from member;  #1 , null을 제외하고 갯수를 셈

#sum:행의 값을 더함
select sum(point) as 포인트합 from member;
select userid,sum(point) as 포인트함 from member; #집계함수와 다른필드는 같이 못들어감 #Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'kdt.member.userid'; this is incompatible with sql_mode=only_full_group_by	0.000 sec


#avg :행 값의 평균을 구함
select avg(point) as 평균 from member;


#min : 행의 최소값을 구함
select min(point) as 최솟값 from member;

#max: 행의 최댓값을 구함
select max(point) as 최댓값 from member;

#그룹
#select 그룹을 맺은 컬럼 또는 집계함수 from 테이블명 group by 그룹을 맺을 필드명


select * from member;
select gender from member group by gender;
select gender,sum(point) from member group by gender;  #집계 함수도 가능! 일반함수는 그룹을 맺을 필드명만 포함할 수 있다.
select gender,avg(point) from member group by gender;
select count(point) from member group by gender;


#그룹 + 조건
# select  그룹을 맺은 컬럼 또는 집계함수 from 테이블명 groub by 그릅을 맺을 필드명 having 조건절;

select gender from member group by gender having gender ='여자'; #그룹을 맺을 필드명에 조건을 걸어준다.


select * from member;
insert into member (userid,userpw,username,hp,email,gender,ssn1,ssn2) values ('strawberry','ry','배애리','010-8845-5515','strawberry@gamil.com','남자','516155','1223456');

# 조건절 + 그룹 + 그룹조건 + 정렬
# select 그룹을 맺은 컬럼 또는 집계함수 from 테이블명 where 조건절 group by 그룹을 맺을 필드명 having 조건절 order by 정렬할 필드명 [asc, desc]
# 포인트가 0이 아닌 회원들 중에서 남,여로 그룹을 나눠 포인트의 평균을 구하고 평균 포인트가 100 이상인 성별을 검색하여 포인트로 내림차순 정렬

#select gender,avg(point) from member where point >0 group by gender having avg(point)>=100 order by gender desc;


#강사님 풀이
select gender,avg(point) as avg from member where point>0 group by gender having avg >=100 order by avg desc;














 




