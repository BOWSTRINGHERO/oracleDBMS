create table lotto_main(
seq_no number not null, -- 회차
lottery_date date, -- 당첨날짜
num1 number,-- 당첨번호 1
num2 number,-- 당첨번호 2
num3 number,-- 당첨번호 3
num4 number,-- 당첨번호 4
num5 number,-- 당첨번호 5
num6 number,-- 당첨번호 6
bonus number-- 보너스번호
);

desc lotto_main;

alter table lotto_main --pk 지정과 제약조건 설정
add constraints lotto_main_pk primary key(seq_no); 

select * from tab;
desc lotto_main

create table lotto_detail(
seq_no number not null,
rank_no number not null,
win_person_no number,
win_money number
);

alter table lotto_detail
add constraints lotto_detail_pk primary key(seq_no, rank_no);

select * from lotto_main;

select num1, num2, num3, num4, num5, num6, bonus, count(*)
from lotto_main
group by num1, num2, num3, num4, num5, num6, bonus;

select num1, num2, num3, num4, num5, num6, bonus, count(*)
from lotto_main
group by num1, num2, num3, num4, num5, num6, bonus
having count(*) >1;

select num1 lotto_num, count(*) cnt
from lotto_main
group by num1
order by 2 desc;

select lotto_num, sum(cnt) as cnt
from(select num1 lotto_num, count(*) cnt
    from lotto_main
    group by num1
    union all
    
    select num2 lotto_num, count(*) cnt
    from lotto_main
    group by num2
    union all
    
    select num3 lotto_num, count(*) cnt
    from lotto_main
    group by num3
    union all

    select num4 lotto_num, count(*) cnt
    from lotto_main
    group by num4
    union all
    
    select num5 lotto_num, count(*) cnt
    from lotto_main
    group by num5
    union all
    
    select num6 lotto_num, count(*) cnt
    from lotto_main
    group by num6
    )
group by lotto_num
order by 2 desc;

select * from lotto_detail;

select a.seq_no,
    a.lottery_date,
    b.win_person_no,
    b.win_money,
    a.num1, a.num2, a.num3,
    a.num4, a.num5, a.num6, a.bonus
from lotto_main a,
    lotto_detail b
where a.seq_no = b.seq_no
and b.rank_no=1
order by b.win_money desc;

commit;

    