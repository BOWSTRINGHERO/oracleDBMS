create table R2(B NUMBER, C NUMBER, D NUMBER);

create table R1(A NUMBER, B NUMBER, C NUMBER);

insert into R1(A,B,C) values(1,2,3);
insert into R1(A,B,C) values(4,2,3);
insert into R1(A,B,C) values(7,8,9);

SELECT
    * FROM
        R1;

drop table R1;

create table R1(A NUMBER, B NUMBER, C NUMBER);
insert into R1(A,B,C) values(1,2,3);
insert into R1(A,B,C) values(4,2,3);
insert into R1(A,B,C) values(7,8,9);

select*from R1;

insert into R2(B,C,D) values(2,3,10);
insert into R2(B,C,D) values(2,3,11);
insert into R2(B,C,D) values(6,7,12);

select*from R2;

select R1.A, R1.B, R1.C, R2.B, R2.C, R2.D
from R1 right outer join R2 on R1.B=R2.B;

select R1.A, R1.B, R1.C, R2.B, R2.C, R2.D
from R1 left outer join R2 on R1.B=R2.B;