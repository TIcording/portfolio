/*DataBase(데이터 베이스)

Data: 자료
DataBase: 자료를 통합하여 관리하는 집합체, 저장소 
DBMS(Database Management System, 데이터 베이스 관리 시스템)
	데이터 베이스를 관리해주는 소프트웨어

DBMS를 사용하는 이유
-중복된 데이터를 제거 또는 관리
-효율적인 데이터를 처리
-자료를 구조화 시킬 수 있음
-다양한 프로그램을 사용하는 사용자들과 데이터를 공유

MySQL :하나의 DBMS

MySQL 서버 다운로드 
1.https://dev.mysql.com/downloads/mysql/ 로 이동
2.Windows(x86, 32 & 64-bit), My SQL installer MSI 클릭
3.Window(x86, 32 & 64-bit), MSI Installer Downlead
4. NO thanks,just start my download.

설치시.
port : 3306
Authentication Method : use Legacy Authentication -> use strong을 한다면 파이썬과 연동하기 힘들다


정보를 요청하는쪽 / 정보를 제공하는 쪽
Client -------------->    Server

DBMS는 서버쪽에 설치 되어야함.

접속은 ip 로 그 이후 어떤 프로그램을 찾아가는것 ->포트번호

mysql 의 포트번호 : 3306 (바꿀수있다.)

하나의 컴퓨터에서 작동하는 포트번호는 서로 달라야한다.

관계형 데이터 베이스 (RDBMS)
- DataBase -> Table (엑셀과 비슷) 로 관리 
- 행,열 을 중심으로 저장한다.
- 행 -> 로우,레코드   /열 -> 컬럼,필드 / 행과 열을 합친 데이터들 -> 테이블
- SQL 언어를 사용


SQL(Structured Query Language)
- 데이터베이스에서 데이터를 정의,조작,제어하기 위해 사용하는 언어
- 대소문자를 구별하지 않음
- 문자열을 저장할 때 무조건 ''(싱클 쿼트) 만 사용.

주석문
한줄 주석문: # 또는 --

*/


# 데이터 베이스 확인하기
show databases;   # ; workbench에서 사용하면 하나 실행하고 밑으로

#데이터 베이스 생성하기
#create database 데이터 베이스명;
create database KDT;

#데이터베이스 삭제하기
#drop database 데이터베이스명;

drop database kdt;


/*
테이블 (Table)
데이터를 행과 열로 스키마에 따라 저장할 수 있는 구조
✔스키마란?
데이터베이스의 구조와 제약조건에 관한 명세를 기술한 집합의 의미

create table 테이블명(
	필드명1 데이터타입 제약조건,
    필드명2 데이터타입 제약조건,
    필드명3 데이터타입 제약조건,
    ....
    필드명n 데이터타입 제약조건
)

데이터 타입(Data Type)
1. 숫자형 타입
	tinyiny: 정수형 데이터 타입(1byte), -128~127 표현
    smalliny: 정수형 데이터 타입(2byte), -32768 ~ 32767 표현
    mediumint: 정수형 데이터 타입(30yte), -8388608 ~ 8388607 표현 
	int : 정수형 데이터 타입(4byte) , -21억 ~ 21억
    bigint: 정수형 데이터 타입(8byte)  ,모제한 표현
    float : 부동 소수형 데이터 타입(4byte) 
    decimal(길이, 소수) : 고정 소수형 데이터 타입(길이 + 1byte)
    double : 부동 소수형 데이터 타입(8byte)
    
2.문자형 타입
	char: 고정 길이 데이터 타입(최대 255byte). 지정된 길이보다 짧은 데이터를 입력할 때 나머지 공간을 공백으로 채움 ->왠만하면 쓰지말자 돌아가는 속도가 느려짐
	varchar: 가변 길이 데이터 타입(최대 65535byte).지정된 길이보다 짧은 데이트를 입력할 때 나머지 공간은 채우지 않음
	text: 문자열 데이터 타입
    longtext: 무제한 문자열 데이터 타입
    
3.이진 데이터 타입
	binary 또는 byte :char 형태의 이진 데이터 타입(최대 255byte)
    varbinary : varchar의 형태의 이진 데이터 타입(최대 65535byte)
    
    
4.날짜 데이터 타입
	date : 날짜(년도,월,일) 형태의 데이터 타입(3byte)
    time : 시간(시,분,초)  형태의 데이터 타입 (3byte)
	datetime : 날짜와 시간 형태의 데이터 타입(8byte)
    timestamp: 1970년 1월 1일부터 시작한 ms타입의 시간이 저장(4byte)
    
제약 조건(constraint)
데이터의 무결성을 지키기 위해 데이터를 입력 받을 때 실행되는 검사 규칙을 의미

not null
-null 값을 허용하지 않음
-중복값을 허용

unique
-중복값을 허용하지 않음
-null 값 허용

primary key
-null 값을 허용하지 않음
-중복값을 허용하지않음
-테이블에 단 하나

foreign key
-pirmary key 를 가진 테이블과 연결하는 역할

default
-null 값을 삽입할 때 기본이 되는 값을 저장할 수 있게 함

enum
-원하는 범위를 설정하소 해당 범위의 값만 저장 #권장하지 않음

*/

#데이터베이스 선택
#use 데이터베이스명

use kdt;

#테이블 만들기alter

create table member(
	userid varchar(20) primary key,
    userpw varchar(200) not null,
    username varchar(20) not null,
    hp varchar(20) not null,
    email varchar(50) not null,
    gender varchar(10) not null,
    ssn1 varchar(6) not null,
    ssn2 varchar(7) not null,
    zipcode varchar(5),
    address1 varchar(100),
    address2 varchar(100),
    address3 varchar(100),
    regdate datetime default now(),
    point int default 0
);

#테이블 확인하기
#desc 테이블명
desc member;

#테이블 삭제하기
#drop table 테이블명
drop table member;

#테이블 필드 추가
#alter table 테이블명 add 컬럼명 데이터타입 제약조건
alter table member add mbti varchar(10);

#데이터 필드 수정하기
#alter table 테이블명 modify column 컬럼명 데이터타입 제약조건
alter table member modify column mbti varchar(20);

#데이터 필드 삭제
#alter table 테이블명 drop 컬럼명
alter table member drop mbti;

#데이터 삽입하기
#insert into 테이블명 values (값1,값2,값3 ... ) #테이블 필드수에 맞게
#insert into 테이블명 (필드명1,필드명2,필드명3,...)values(값1,값2,값3 ...)


create table word(
	eng varchar(50) primary key,
    kor varchar(50) not null,
    lev int

);

desc word;

insert into word values('apple','사과',1);
    
select * from word;  #데이터 확인

insert into word values('banana','바나나'); #Error Code: 1136. Column count doesn't match value count at row 1

insert into word values('banana','바나나',null);

insert into word values('banana',null,null); #Error Code: 1048. Column 'kor' cannot be null

insert into word (eng,kor,lev) values('melon','메론',1);

insert into word (eng,kor) values ('orange' , '오렌지');

insert into word(eng) values ('grape'); #Error Code: 1364. Field 'kor' doesn't have a default value

create table member(
	userid varchar(20) primary key,
    userpw varchar(200) not null,
    username varchar(20) not null,
    hp varchar(20) not null,
    email varchar(50) not null,
    gender varchar(10) not null,
    ssn1 varchar(6) not null,
    ssn2 varchar(7) not null,
    zipcode varchar(5),
    address1 varchar(100),
    address2 varchar(100),
    address3 varchar(100),
    regdate datetime default now(),
    point int default 0
);



insert into member(userid,userpw,username,hp,email,gender,ssn1,ssn2) values('apple','le','김사과','01015624525','apple@gamil.com','여자','980209','2245625');
insert into member(userid,userpw,username,hp,email,gender,ssn1,ssn2) values('banana','na','박나나','01025624525','banana@gamil.com','여자','980209','4567891');
insert into member(userid,userpw,username,hp,email,gender,ssn1,ssn2) values('orange','ge','이렌지','01000624525','orange@gamil.com','여자','980209','6789123');
insert into member(userid,userpw,username,hp,email,gender,ssn1,ssn2) values('melon','on','나메론','01019214525','melon@gamil.com','여자','980209','8912345');
insert into member(userid,userpw,username,hp,email,gender,ssn1,ssn2) values('grape','pe','백포도','01015612525','grape@gamil.com','여자','980209','1234567');


select * from member;

#데이터 삭제하기
#delete from 테이블명;
#delete from 테이블명; where 조건절;

delete from member; #Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

delete from member where userid = '1'; #userid 가 apple인 사용자를 삭제

delete from member where gender ='남자';

#데이터 수정하기
#update 테이블명 set 필드명1=값1,필드명2=값2 .....;
#update 테이블명 set 필드명1=rkqt1,필드명2=값2 .... where 조건절;


update member set point = 100;

update member set point=point+300 where gender = '여자'; #여자인 필드의 300 포인트 더하기 -> 조건과 인플레이스 연산 필요

update member set email = 'banana@naver.com' where userid ='banana';

#오렌지 회원의 우편번호를 12345 , 주소1은 서울시 서초구 , 주소2는 양재동 , 주소3은 아파트 101동 101호

#update member set (zipcode,address1,address2,address3) = ('12345','서울시 서초구','양재동','101동 101호') where userid ='orange'; membermembermembermember-> 이건 문법상 안됨
update member set zipcode = '12345' , address1='서울시 서초구',address2 = '양재동',address3 ='101동 101호' where userid ='orange';

#데이터 관리 차원에서 update 와 delete를 조심해서 쓰자 (사탄임)

# CRUD -> Create Read Update Delete 이것을 잘하자