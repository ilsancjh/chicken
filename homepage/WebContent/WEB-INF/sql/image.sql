
drop table image


create table image(

ino number 					not null,
title varchar(50) 				not null,
content  varchar(1000)       	not null,
mname    varchar(50)       		not null,
passwd   varchar(20)       		not null,
wdate    date       			not null,
fname    varchar(50) default 0    not null,

primary key (ino)
);

--파일사이즈 추가
alter table image
add(fsize number default 0);



--select
select * from image;


--create
insert into image(ino,title,content,mname,fname,passwd,wdate)
           values((select NVL(max(ino), 0) + 1 FROM image),
         'test','testtest','inputtest','abc.jpg',1234,sysdate);
         
insert into image(ino,title,content,mname,fname,passwd,wdate)
           values((select NVL(max(ino), 0) + 1 FROM image),
         '어서옵쇼','이것은 내용입니다.','후니짱','abc2.jpg',1234,sysdate);
         
--list
select ino,title,content,mname,fname,passwd,wdate,r
from(
	select ino,title,content,mname,fname,passwd,wdate,rownum r         
	from(
		select ino,title,content,mname,fname,passwd,wdate
		from image
		where ino order by wdate desc;
		)
	)
	where r>=1 and r<=5;

--delete
delete from image where ino=2;




--pwCheck
select count(*) as cnt
from image
where ino=7 and passwd='123';

--total
select count(*) as cnt
from image
WHERE "+col+" like '%'||?||'%';