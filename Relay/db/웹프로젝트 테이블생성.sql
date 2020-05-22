DROP SEQUENCE MNO;
DROP SEQUENCE PNO;
DROP SEQUENCE RNO;
DROP SEQUENCE ANO;
DROP SEQUENCE MYRNO;
DROP SEQUENCE MYLNO;
DROP SEQUENCE BNO;
DROP SEQUENCE NNO;
DROP SEQUENCE CNO;
DROP SEQUENCE DNO;

SET PAGES 100;

-----------------------���̺��������--------------
-----------------------TABLE MEMBER--------------
ALTER TABLE MEMBER
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_MEM;

/* ȸ�� */
DROP TABLE MEMBER 
	CASCADE CONSTRAINTS;

/* ȸ�� */
CREATE TABLE MEMBER (
	mno NUMBER NOT NULL, /* ȸ����ȣ */
	id VARCHAR2(50) NOT NULL, /* ���̵� */
	pw VARCHAR2(50) NOT NULL, /* ��й�ȣ */
	name VARCHAR2(50) NOT NULL, /* �̸� */
	nick VARCHAR2(50) NOT NULL, /* �г��� */
	birth NUMBER NOT NULL, /* �ֹε�Ϲ�ȣ�� */
	sex NUMBER NOT NULL, /* �ֹε�Ϲ�ȣ�� */
	addr VARCHAR2(200) NOT NULL /* �ּ� */
);

COMMENT ON TABLE MEMBER IS 'ȸ��';

COMMENT ON COLUMN MEMBER.mno IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.id IS '���̵�';

COMMENT ON COLUMN MEMBER.pw IS '��й�ȣ';

COMMENT ON COLUMN MEMBER.name IS '�̸�';

COMMENT ON COLUMN MEMBER.nick IS '�г���';

COMMENT ON COLUMN MEMBER.birth IS '�ֹε�Ϲ�ȣ��';

COMMENT ON COLUMN MEMBER.sex IS '�ֹε�Ϲ�ȣ��';

COMMENT ON COLUMN MEMBER.addr IS '�ּ�';

CREATE UNIQUE INDEX PK_MEM
	ON MEMBER (
		mno ASC
	);

ALTER TABLE MEMBER
	ADD
		CONSTRAINT PK_MEM
		PRIMARY KEY (
			mno
		);


--------------------------TABLE DETAIL-----------------------------

ALTER TABLE DETAIL
	DROP
		CONSTRAINT FK_MEM_TO_DET
		CASCADE;

ALTER TABLE DETAIL
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_DET;

/* ȸ�� �߰����� */
DROP TABLE DETAIL 
	CASCADE CONSTRAINTS;

/* ȸ�� �߰����� */
CREATE TABLE DETAIL (
	mno NUMBER NOT NULL, /* ȸ����ȣ */
	gender VARCHAR2(50) NOT NULL, /* ���� */
	age NUMBER NOT NULL, /* ���ɴ� */
	job VARCHAR2(100), /* ���� */
	hobby VARCHAR2(200), /* ��� */
	joindate DATE NOT NULL, /* �������� */
	outdate DATE /* Ż������ */
);

COMMENT ON TABLE DETAIL IS 'ȸ�� �߰�����';

COMMENT ON COLUMN DETAIL.mno IS 'ȸ����ȣ';

COMMENT ON COLUMN DETAIL.gender IS '����';

COMMENT ON COLUMN DETAIL.age IS '���ɴ�';

COMMENT ON COLUMN DETAIL.job IS '����';

COMMENT ON COLUMN DETAIL.hobby IS '���';

COMMENT ON COLUMN DETAIL.joindate IS '��������';

COMMENT ON COLUMN DETAIL.outdate IS 'Ż������';

CREATE UNIQUE INDEX PK_DET
	ON DETAIL (
		mno ASC
	);

ALTER TABLE DETAIL
	ADD
		CONSTRAINT PK_DET
		PRIMARY KEY (
			mno
		);

ALTER TABLE DETAIL
	ADD
		CONSTRAINT FK_MEM_TO_DET
		FOREIGN KEY (
			mno
		)
		REFERENCES MEMBER (
			mno
		);


---------------------------TABLE PRODUCT-------------------------------
ALTER TABLE PRODUCT
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_PDT;

/* ��ǰ */
DROP TABLE PRODUCT 
	CASCADE CONSTRAINTS;

/* ��ǰ */
CREATE TABLE PRODUCT (
	pno NUMBER NOT NULL, /* ��ǰ��ȣ */
	pname VARCHAR2(1000) NOT NULL, /* ��ǰ�� */
	phprice NUMBER NOT NULL, /* ��ǰ�ְ��� */
	plprice NUMBER NOT NULL, /* ��ǰ�������� */
	pmall VARCHAR2(1000) NOT NULL, /* �Ǹ�ó(name) */
	pmallurl VARCHAR2(1000) NOT NULL, /* �Ǹ�ó(url) */
	pimg VARCHAR(1000) /* ��ǰ�̹��� */
);

COMMENT ON TABLE PRODUCT IS '��ǰ';

COMMENT ON COLUMN PRODUCT.pno IS '��ǰ��ȣ';

COMMENT ON COLUMN PRODUCT.pname IS '��ǰ��';

COMMENT ON COLUMN PRODUCT.phprice IS '��ǰ�ְ���';

COMMENT ON COLUMN PRODUCT.plprice IS '��ǰ��������';

COMMENT ON COLUMN PRODUCT.pmall IS '�Ǹ�ó(name)';

COMMENT ON COLUMN PRODUCT.pmallurl IS '�Ǹ�ó(url)';

COMMENT ON COLUMN PRODUCT.pimg IS '��ǰ�̹���';

CREATE UNIQUE INDEX PK_PDT
	ON PRODUCT (
		pno ASC
	);

ALTER TABLE PRODUCT
	ADD
		CONSTRAINT PK_PDT
		PRIMARY KEY (
			pno
		);


------------------------------TABLE ANNIV-------------------------------------
ALTER TABLE ANNIV
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_ANN;

/* ����� */
DROP TABLE ANNIV 
	CASCADE CONSTRAINTS;

/* ����� */
CREATE TABLE ANNIV (
	ano NUMBER NOT NULL, /* ����Ϲ�ȣ */
	aname VARCHAR2(200) NOT NULL, /* ������̸� */
	adate DATE /* ����ϳ�¥ */
);

COMMENT ON TABLE ANNIV IS '�����';

COMMENT ON COLUMN ANNIV.ano IS '����Ϲ�ȣ';

COMMENT ON COLUMN ANNIV.aname IS '������̸�';

COMMENT ON COLUMN ANNIV.adate IS '����ϳ�¥';

CREATE UNIQUE INDEX PK_ANN
	ON ANNIV (
		ano ASC
	);

ALTER TABLE ANNIV
	ADD
		CONSTRAINT PK_ANN
		PRIMARY KEY (
			ano
		);



--------------------------TABLE RELAY--------------------------------------------------
ALTER TABLE RELAY
	DROP
		CONSTRAINT FK_PDT_TO_REL
		CASCADE;

ALTER TABLE RELAY
	DROP
		CONSTRAINT FK_MEM_TO_REL
		CASCADE;

ALTER TABLE RELAY
	DROP
		CONSTRAINT FK_ANN_TO_REL
		CASCADE;

ALTER TABLE RELAY
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_REL;

/* ������(��ü) */
DROP TABLE RELAY 
	CASCADE CONSTRAINTS;

/* ������(��ü) */
CREATE TABLE RELAY (
	rno NUMBER NOT NULL, /* �����̹�ȣ */
	mno NUMBER NOT NULL, /* ȸ����ȣ */
	ano NUMBER, /* ����Ϲ�ȣ */
	pno NUMBER, /* ��ǰ��ȣ */
	rbegin DATE NOT NULL, /* �����̽������� */
	rend DATE /* �����̿Ϸ����� */
);

COMMENT ON TABLE RELAY IS '������(��ü)';

COMMENT ON COLUMN RELAY.rno IS '�����̹�ȣ';

COMMENT ON COLUMN RELAY.mno IS 'ȸ����ȣ';

COMMENT ON COLUMN RELAY.ano IS '����Ϲ�ȣ';

COMMENT ON COLUMN RELAY.pno IS '��ǰ��ȣ';

COMMENT ON COLUMN RELAY.rbegin IS '�����̽�������';

COMMENT ON COLUMN RELAY.rend IS '�����̿Ϸ�����';

CREATE UNIQUE INDEX PK_REL
	ON RELAY (
		rno ASC,
		mno ASC
	);

ALTER TABLE RELAY
	ADD
		CONSTRAINT PK_REL
		PRIMARY KEY (
			rno,
			mno
		);

ALTER TABLE RELAY
	ADD
		CONSTRAINT FK_PDT_TO_REL
		FOREIGN KEY (
			pno
		)
		REFERENCES PRODUCT (
			pno
		);

ALTER TABLE RELAY
	ADD
		CONSTRAINT FK_MEM_TO_REL
		FOREIGN KEY (
			mno
		)
		REFERENCES MEMBER (
			mno
		);

ALTER TABLE RELAY
	ADD
		CONSTRAINT FK_ANN_TO_REL
		FOREIGN KEY (
			ano
		)
		REFERENCES ANNIV (
			ano
		);


----------------------------TABLE MYLIST-------------------------------------
ALTER TABLE MYLIST
	DROP
		CONSTRAINT FK_PDT_TO_MYL
		CASCADE;

ALTER TABLE MYLIST
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_MYL;

/* ������ ������ ����Ʈ */
DROP TABLE MYLIST 
	CASCADE CONSTRAINTS;

/* ������ ������ ����Ʈ */
CREATE TABLE MYLIST (
	mylno NUMBER NOT NULL, /* �����Ǹ���Ʈ��ȣ */
	pno NUMBER NOT NULL /* ��ǰ��ȣ */
);

COMMENT ON TABLE MYLIST IS '������ ������ ����Ʈ';

COMMENT ON COLUMN MYLIST.mylno IS '�����Ǹ���Ʈ��ȣ';

COMMENT ON COLUMN MYLIST.pno IS '��ǰ��ȣ';

CREATE UNIQUE INDEX PK_MYL
	ON MYLIST (
		mylno ASC,
		pno ASC
	);

ALTER TABLE MYLIST
	ADD
		CONSTRAINT PK_MYL
		PRIMARY KEY (
			mylno,
			pno
		);

ALTER TABLE MYLIST
	ADD
		CONSTRAINT FK_PDT_TO_MYL
		FOREIGN KEY (
			pno
		)
		REFERENCES PRODUCT (
			pno
		);

------------------------------TABLE MYR-------------------------------------
ALTER TABLE MYRELAY
	DROP
		CONSTRAINT FK_MYL_TO_MYR
		CASCADE;

ALTER TABLE MYRELAY
	DROP
		CONSTRAINT FK_MEM_TO_MYR
		CASCADE;

/* ������ ������ */
DROP TABLE MYRELAY 
	CASCADE CONSTRAINTS;

/* ������ ������ */
CREATE TABLE MYRELAY (
	myrno NUMBER NOT NULL, /* �����Ǹ����̹�ȣ */
	mno NUMBER, /* ȸ����ȣ */
	mylno NUMBER, /* �����Ǹ���Ʈ��ȣ */
	pno NUMBER /* ��ǰ��ȣ */
);

COMMENT ON TABLE MYRELAY IS '������ ������';

COMMENT ON COLUMN MYRELAY.myrno IS '�����Ǹ����̹�ȣ';

COMMENT ON COLUMN MYRELAY.mno IS 'ȸ����ȣ';

COMMENT ON COLUMN MYRELAY.mylno IS '�����Ǹ���Ʈ��ȣ';

COMMENT ON COLUMN MYRELAY.pno IS '��ǰ��ȣ';

ALTER TABLE MYRELAY
	ADD
		CONSTRAINT FK_MYL_TO_MYR
		FOREIGN KEY (
			mylno,
			pno
		)
		REFERENCES MYLIST (
			mylno,
			pno
		);

ALTER TABLE MYRELAY
	ADD
		CONSTRAINT FK_MEM_TO_MYR
		FOREIGN KEY (
			mno
		)
		REFERENCES MEMBER (
			mno
		);

------------------------------TABLE BOARD--------------------------------------------
ALTER TABLE BOARD
	DROP
		CONSTRAINT FK_MEM_TO_BRD
		CASCADE;

ALTER TABLE BOARD
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_BRD;

/* �Խñ� */
DROP TABLE BOARD 
	CASCADE CONSTRAINTS;

/* �Խñ� */
CREATE TABLE BOARD (
	bno NUMBER NOT NULL, /* �Խñ۹�ȣ */
	mno NUMBER NOT NULL, /* ȸ����ȣ */
	btag VARCHAR2(50) NOT NULL, /* ���Ӹ��±� */
	btitle VARCHAR2(1000) NOT NULL, /* �Խñ� ���� */
	bcontent VARCHAR2(2000) NOT NULL, /* �Խñ� ���� */
	bimg VARCHAR2(1000), /* �̹���(name) */
	bimgurl VARCHAR2(1000), /* �̹���(url) */
	bdate DATE NOT NULL, /* �Խñ��ۼ����� */
	bupdate DATE, /* �Խñۼ������� */
	bvis NUMBER NOT NULL /* VISIBILITY */
);

COMMENT ON TABLE BOARD IS '�Խñ�';

COMMENT ON COLUMN BOARD.bno IS '�Խñ۹�ȣ';

COMMENT ON COLUMN BOARD.mno IS 'ȸ����ȣ';

COMMENT ON COLUMN BOARD.btag IS '���Ӹ��±�';

COMMENT ON COLUMN BOARD.btitle IS '�Խñ� ����';

COMMENT ON COLUMN BOARD.bcontent IS '�Խñ� ����';

COMMENT ON COLUMN BOARD.bimg IS '�̹���(name)';

COMMENT ON COLUMN BOARD.bimgurl IS '�̹���(url)';

COMMENT ON COLUMN BOARD.bdate IS '�Խñ��ۼ�����';

COMMENT ON COLUMN BOARD.bupdate IS '�Խñۼ�������';

COMMENT ON COLUMN BOARD.bvis IS 'VISIBILITY';

CREATE UNIQUE INDEX PK_BRD
	ON BOARD (
		bno ASC
	);

ALTER TABLE BOARD
	ADD
		CONSTRAINT PK_BRD
		PRIMARY KEY (
			bno
		);

ALTER TABLE BOARD
	ADD
		CONSTRAINT FK_MEM_TO_BRD
		FOREIGN KEY (
			mno
		)
		REFERENCES MEMBER (
			mno
		);

---------------------------------TABLE COMM---------------------------------------------
ALTER TABLE COMM
	DROP
		CONSTRAINT FK_BRD_TO_COM
		CASCADE;

ALTER TABLE COMM
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_COM;

/* ������̺� */
DROP TABLE COMM 
	CASCADE CONSTRAINTS;

/* ������̺� */
CREATE TABLE COMM (
	bno NUMBER NOT NULL, /* �Խñ۹�ȣ */
	cno NUMBER NOT NULL, /* ��۹�ȣ */
	ccontent VARCHAR2(500) NOT NULL, /* ��۳��� */
	creplyer VARCHAR2(50) NOT NULL, /* ����ۼ��� */
	cdate DATE NOT NULL, /* ����ۼ����� */
	cupdate DATE, /* ��ۼ������� */
	cvis NUMBER NOT NULL /* VISIBILITY */
);

COMMENT ON TABLE COMM IS '������̺�';

COMMENT ON COLUMN COMM.bno IS '�Խñ۹�ȣ';

COMMENT ON COLUMN COMM.cno IS '��۹�ȣ';

COMMENT ON COLUMN COMM.ccontent IS '��۳���';

COMMENT ON COLUMN COMM.creplyer IS '����ۼ���';

COMMENT ON COLUMN COMM.cdate IS '����ۼ�����';

COMMENT ON COLUMN COMM.cupdate IS '��ۼ�������';

COMMENT ON COLUMN COMM.cvis IS 'VISIBILITY';

CREATE UNIQUE INDEX PK_COM
	ON COMM (
		bno ASC,
		cno ASC
	);

ALTER TABLE COMM
	ADD
		CONSTRAINT PK_COM
		PRIMARY KEY (
			bno,
			cno
		);

ALTER TABLE COMM
	ADD
		CONSTRAINT FK_BRD_TO_COM
		FOREIGN KEY (
			bno
		)
		REFERENCES BOARD (
			bno
		);


-------------------------------TABLE NOTICE--------------------------------------------
ALTER TABLE NOTICE
	DROP
		CONSTRAINT FK_MEM_TO_NOT
		CASCADE;

ALTER TABLE NOTICE
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_NOT;

/* ������ */
DROP TABLE NOTICE 
	CASCADE CONSTRAINTS;

/* ������ */
CREATE TABLE NOTICE (
	nno NUMBER NOT NULL, /* �Խñ۹�ȣ */
	mno NUMBER NOT NULL, /* �����ڹ�ȣ */
	ntitle VARCHAR2(200) NOT NULL, /* �Խñ� ���� */
	ncontent VARCHAR2(2000) NOT NULL, /* �Խñ� ���� */
	ndate DATE NOT NULL, /* �������ۼ����� */
	nupdate DATE, /* �����ۼ������� */
	nvis NUMBER NOT NULL /* VISIBILITY */
);

COMMENT ON TABLE NOTICE IS '������';

COMMENT ON COLUMN NOTICE.nno IS '�Խñ۹�ȣ';

COMMENT ON COLUMN NOTICE.mno IS '�����ڹ�ȣ';

COMMENT ON COLUMN NOTICE.ntitle IS '�Խñ� ����';

COMMENT ON COLUMN NOTICE.ncontent IS '�Խñ� ����';

COMMENT ON COLUMN NOTICE.ndate IS '�������ۼ�����';

COMMENT ON COLUMN NOTICE.nupdate IS '�����ۼ�������';

COMMENT ON COLUMN NOTICE.nvis IS 'VISIBILITY';

CREATE UNIQUE INDEX PK_NOT
	ON NOTICE (
		nno ASC
	);

ALTER TABLE NOTICE
	ADD
		CONSTRAINT PK_NOT
		PRIMARY KEY (
			nno
		);

ALTER TABLE NOTICE
	ADD
		CONSTRAINT FK_MEM_TO_NOT
		FOREIGN KEY (
			mno
		)
		REFERENCES MEMBER (
			mno
		);



------------------------�Ӽ� DEFAULT �� ����------------------------------
ALTER TABLE DETAIL MODIFY (JOINDATE DEFAULT SYSDATE);

ALTER TABLE RELAY MODIFY (RBEGIN DEFAULT SYSDATE);

ALTER TABLE BOARD MODIFY (BDATE DEFAULT SYSDATE);

ALTER TABLE BOARD MODIFY (BVIS DEFAULT 1);

ALTER TABLE NOTICE MODIFY (NDATE DEFAULT SYSDATE);

ALTER TABLE NOTICE MODIFY (NVIS DEFAULT 1);


ALTER TABLE COMM MODIFY (CDATE DEFAULT SYSDATE);

ALTER TABLE COMM MODIFY (CVIS DEFAULT 1);


--------------------------���̺� üũ �ɼ�--------------------------------------

--notice mno 1~5����

ALTER TABLE MEMBER ADD CONSTRAINT SEX_CH CHECK(SEX IN (1,2,3,4) );

ALTER TABLE DETAIL ADD CONSTRAINT AGE_CH CHECK(AGE IN (10, 20, 30, 40, 50, 60));

ALTER TABLE BOARD ADD CONSTRAINT BVIS_CH CHECK(BVIS IN (0, 1));

ALTER TABLE NOTICE ADD CONSTRAINT NVIS_CH CHECK(NVIS IN (0, 1));

ALTER TABLE NOTICE ADD CONSTRAINT MNO_CH CHECK(MNO IN (1, 2, 3, 4, 5) );

ALTER TABLE COMM ADD CONSTRAINT CVIS_CH CHECK(CVIS IN (0, 1));



----------------------SEQUENCE ����------------------------------------

CREATE SEQUENCE MNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE PNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE ANO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE RNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE MYRNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE MYLNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE BNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE CNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE NNO START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

CREATE SEQUENCE DNO START WITH 11111111 INCREMENT BY 1;

-----------------------------���̺� ���� Ȯ��-----------------------------------

desc member;

desc detail;

desc product;

desc relay;

desc anniv;

desc myrelay;

desc mylist;

desc board;

desc comm;

desc notice;

------------------------------------�⺻�� �Է�--------------------------------------


INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'BKD', 'admin1234', '��浿', 'KD', 930818, 1, '����� �����');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '����', 20, '�л�', '����', DEFAULT, '');
 
INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'LHC', 'admin1234', '������', 'REDMONKEY', 921018, 1, '��õ');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '����', 20, '����', '���', DEFAULT, '');

INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'HHG', 'admin1234', 'Ȳ�Ѱ�', 'ANNOTATION', 921010, 1, '�߱�');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '����', 20, '��������', '����ü��', DEFAULT, '');

INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'KJI', 'admin1234', '������', 'HARRY', 931111, 1, '������');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '����', 20, 'ȸ���', '�', DEFAULT, '');

INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'KKH', 'admin1234', '�����', 'AI', 890526, 1, '���𿡰�');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '����', 30, 'CEO', '�ڵ�', DEFAULT, '');


SELECT * FROM MEMBER;
SELECT * FROM DETAIL;


Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '�����ٳ� �� ũ��� �淮�ٿ� ���� 378905', 58550, 31300, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=15337277338', 'https://shopping-phinf.pstatic.net/main_1533727/15337277338.20191018002250.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '���ų������׷��� �ڿ�ʽ� �ø��� �ձ��� �Ǳ��� Ǯ ���� CARBON N193UFT950 IVORY', 179000, 179000, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=20364067234', 'https://shopping-phinf.pstatic.net/main_2036406/20364067234.20190724145845.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '�����ٳ� ��� Ǫ�� �ٿ� 079920', 158000, 108810, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=21023371145', 'https://shopping-phinf.pstatic.net/main_2102337/21023371145.20191005160826.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '���ų������׷��� N194UDW810 �극�� ����Ʈ ���� �ٿ� ���� CARBON BLACK', 0, 99000, 'NGstore', 
    'https://search.shopping.naver.com/gate.nhn?id=82212525441', 'https://shopping-phinf.pstatic.net/main_8221252/82212525441.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '���̳��� ��<b>�е�</b> YMW18529', 233080, 165040, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=15030663370', 'https://shopping-phinf.pstatic.net/main_1503066/15030663370.20191015003856.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '����� TV��ۻ�ǰ ���� �淮 �����ٿ� ���� 2����Ʈ LD1808WD0506', 29900, 26910, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=20540776177', 'https://shopping-phinf.pstatic.net/main_2054077/20540776177.20190807145414.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '[�ٽ�Ű��X����] 19WINTER ����̵� �밡�� �����ٿ� ���� 3�� ��Ű��', 0, 189050, 'CJmall', 
    'https://search.shopping.naver.com/gate.nhn?id=20966287650', 'https://shopping-phinf.pstatic.net/main_2096628/20966287650.2.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '�����̴� ���ϼ��� �����ս� �� <b>�е�</b> SPDWCNDJ001UBLK', 299400, 299400, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=20951797431', 'https://shopping-phinf.pstatic.net/main_2095179/20951797431.20190925161817.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '��Ŭ���� Ŭ�ο� KHLOE ��<b>�е�</b>', 2790000, 2054000, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=14969935776', 'https://shopping-phinf.pstatic.net/main_1496993/14969935776.20181121111517.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '��ī�� ���� �淮 ���� ���̾� ���� ���� �� <b>�е�</b> ���� ������ ��', 29800, 20670, '���̹�', 
    'https://search.shopping.naver.com/gate.nhn?id=17845253706', 'https://shopping-phinf.pstatic.net/main_1784525/17845253706.20190307164814.jpg');

SELECT * FROM PRODUCT;



INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '����', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '�����ǳ�', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, 'ũ��������', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '�����100��', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '���н�', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '������', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '��ȥ��', '');

SELECT * FROM ANNIV;



INSERT INTO RELAY VALUES(RNO.NEXTVAL, 1, 1, 1, DEFAULT, '');
INSERT INTO RELAY VALUES(RNO.CURRVAL, 2, '', '', DEFAULT, '');
INSERT INTO RELAY VALUES(RNO.NEXTVAL, 1, 1, 2, DEFAULT, '');
SELECT * FROM RELAY;



INSERT INTO MYLIST VALUES(MYLNO.NEXTVAL, 1);
INSERT INTO MYLIST VALUES(MYLNO.CURRVAL, 2);
INSERT INTO MYLIST VALUES(MYLNO.NEXTVAL, 1);
INSERT INTO MYLIST VALUES(MYLNO.CURRVAL, 2);
INSERT INTO MYLIST VALUES(MYLNO.CURRVAL, 7);
INSERT INTO MYLIST VALUES(MYLNO.CURRVAL, 10);

SELECT * FROM MYLIST;



INSERT INTO MYRELAY VALUES(MYRNO.NEXTVAL, 1, '','');
INSERT INTO MYRELAY VALUES(MYRNO.CURRVAL, 1, 1, 1);
INSERT INTO MYRELAY VALUES(MYRNO.CURRVAL, 1, 1, 2);

SELECT * FROM MYRELAY;




INSERT INTO BOARD VALUES(BNO.NEXTVAL, 1, '�ڶ��ؿ�', '���Ŀ�', '���� �������', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 2, '�����ؿ�', 'IT�³����ȸ¾�', '�ؾ�Ȼ������', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 3, '�����ؿ�', 'ȫ���Ű�� ��Ǻ�', '28�� �̻� �ٲ���', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 4, '�����ؿ�', '������ ���̿���', '�츮 ���� �̻ڴ�', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 5, '�ڶ��ؿ�', '�� ���ſ���', '���ƽ��ϱ�װ�', '', '', DEFAULT, '', DEFAULT);

SELECT * FROM BOARD;



INSERT INTO NOTICE VALUES(NNO.NEXTVAL, 1, '����� �س���', '�ڹٰ� ���� �������. ������ ���� ����', DEFAULT, '', 1);
INSERT INTO NOTICE VALUES(NNO.NEXTVAL, 2, '������ ������', '�� �ְ����. ����;�� �Ф�', DEFAULT, '', 1);
INSERT INTO NOTICE VALUES(NNO.NEXTVAL, 4, '������ ������ ����� ã��', '�Ұ��� ����!!', DEFAULT, '', 1);

SELECT * FROM NOTICE;




INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '���ۿ�', 'REDMONKEY', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(1, CNO.NEXTVAL, 'ǫ���ٿ�', 'HARRY', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(2, CNO.NEXTVAL, '�Բ��ؿ�', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '�� ���Ƽ� ��', 'ANNOTATION', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(3, CNO.NEXTVAL, '������', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '������ �����ؿ�', 'AI', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(3, CNO.NEXTVAL, '�츮�� �Ե� �ƴϳ�', 'HARRY', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(2, CNO.NEXTVAL, '�� ������ Ŀ�� ��', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(4, CNO.NEXTVAL, '����', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(5, CNO.NEXTVAL, '���� AI', 'REDMONKEY', DEFAULT, '', DEFAULT);
SELECT * FROM COMM;

COMMIT;
