
CREATE TABLE NewBook
(
	bookid               CHAR(18) NOT NULL ,
	bookname             VARCHAR2(40) NULL ,
	price                NUMBER NULL ,
	pubname              VARCHAR2(40) NOT NULL 
);



CREATE UNIQUE INDEX XPK���� ON NewBook
(bookid   ASC);



CREATE TABLE NewCustomer
(
	name                 VARCHAR2(40) NOT NULL ,
	custid               NUMBER NULL ,
	address              VARCHAR2(40) NULL ,
	phone                VARCHAR2(30) NULL 
);



CREATE UNIQUE INDEX XPK�� ON NewCustomer
(name   ASC);



CREATE TABLE NewOrder
(
	orderid              INTEGER NOT NULL ,
	name                 VARCHAR2(40) NOT NULL ,
	bookid               NUMBER NOT NULL ,
	orderdate            DATE NULL ,
	saleprice            NUMBER NULL 
);



CREATE UNIQUE INDEX XPK����_�� ON NewOrder
(orderid   ASC);



CREATE TABLE NewPublisher
(
	pubname              VARCHAR2(40) NOT NULL ,
	stname               VARCHAR2(40) NULL ,
	officephone          VARCHAR2(30) NULL 
);



CREATE UNIQUE INDEX XPK���ǻ� ON NewPublisher
(pubname   ASC);


