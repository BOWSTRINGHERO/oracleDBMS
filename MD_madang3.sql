create or replace procedure insertbook(
    mybookid in number,
    mybookname in varchar2,
    mypublisher in varchar2,
    myprice in number)
as
begin
    insert into book(bookid, bookname, publisher, price)
    values(mybookid, mybookname, mypublisher, myprice);
end;
/
EXEC insertbook(13, '스포츠과학', '마당과학서적', 25000);
select * from book;

