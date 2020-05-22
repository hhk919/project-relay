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

-----------------------테이블생성시작--------------
-----------------------TABLE MEMBER--------------
ALTER TABLE MEMBER
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_MEM;

/* 회원 */
DROP TABLE MEMBER 
	CASCADE CONSTRAINTS;

/* 회원 */
CREATE TABLE MEMBER (
	mno NUMBER NOT NULL, /* 회원번호 */
	id VARCHAR2(50) NOT NULL, /* 아이디 */
	pw VARCHAR2(50) NOT NULL, /* 비밀번호 */
	name VARCHAR2(50) NOT NULL, /* 이름 */
	nick VARCHAR2(50) NOT NULL, /* 닉네임 */
	birth NUMBER NOT NULL, /* 주민등록번호앞 */
	sex NUMBER NOT NULL, /* 주민등록번호뒤 */
	addr VARCHAR2(200) NOT NULL /* 주소 */
);

COMMENT ON TABLE MEMBER IS '회원';

COMMENT ON COLUMN MEMBER.mno IS '회원번호';

COMMENT ON COLUMN MEMBER.id IS '아이디';

COMMENT ON COLUMN MEMBER.pw IS '비밀번호';

COMMENT ON COLUMN MEMBER.name IS '이름';

COMMENT ON COLUMN MEMBER.nick IS '닉네임';

COMMENT ON COLUMN MEMBER.birth IS '주민등록번호앞';

COMMENT ON COLUMN MEMBER.sex IS '주민등록번호뒤';

COMMENT ON COLUMN MEMBER.addr IS '주소';

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

/* 회원 추가정보 */
DROP TABLE DETAIL 
	CASCADE CONSTRAINTS;

/* 회원 추가정보 */
CREATE TABLE DETAIL (
	mno NUMBER NOT NULL, /* 회원번호 */
	gender VARCHAR2(50) NOT NULL, /* 성별 */
	age NUMBER NOT NULL, /* 연령대 */
	job VARCHAR2(100), /* 직업 */
	hobby VARCHAR2(200), /* 취미 */
	joindate DATE NOT NULL, /* 가입일자 */
	outdate DATE /* 탈퇴일자 */
);

COMMENT ON TABLE DETAIL IS '회원 추가정보';

COMMENT ON COLUMN DETAIL.mno IS '회원번호';

COMMENT ON COLUMN DETAIL.gender IS '성별';

COMMENT ON COLUMN DETAIL.age IS '연령대';

COMMENT ON COLUMN DETAIL.job IS '직업';

COMMENT ON COLUMN DETAIL.hobby IS '취미';

COMMENT ON COLUMN DETAIL.joindate IS '가입일자';

COMMENT ON COLUMN DETAIL.outdate IS '탈퇴일자';

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

/* 상품 */
DROP TABLE PRODUCT 
	CASCADE CONSTRAINTS;

/* 상품 */
CREATE TABLE PRODUCT (
	pno NUMBER NOT NULL, /* 상품번호 */
	pname VARCHAR2(1000) NOT NULL, /* 상품명 */
	phprice NUMBER NOT NULL, /* 상품최고가격 */
	plprice NUMBER NOT NULL, /* 상품최저가격 */
	pmall VARCHAR2(1000) NOT NULL, /* 판매처(name) */
	pmallurl VARCHAR2(1000) NOT NULL, /* 판매처(url) */
	pimg VARCHAR(1000) /* 상품이미지 */
);

COMMENT ON TABLE PRODUCT IS '상품';

COMMENT ON COLUMN PRODUCT.pno IS '상품번호';

COMMENT ON COLUMN PRODUCT.pname IS '상품명';

COMMENT ON COLUMN PRODUCT.phprice IS '상품최고가격';

COMMENT ON COLUMN PRODUCT.plprice IS '상품최저가격';

COMMENT ON COLUMN PRODUCT.pmall IS '판매처(name)';

COMMENT ON COLUMN PRODUCT.pmallurl IS '판매처(url)';

COMMENT ON COLUMN PRODUCT.pimg IS '상품이미지';

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

/* 기념일 */
DROP TABLE ANNIV 
	CASCADE CONSTRAINTS;

/* 기념일 */
CREATE TABLE ANNIV (
	ano NUMBER NOT NULL, /* 기념일번호 */
	aname VARCHAR2(200) NOT NULL, /* 기념일이름 */
	adate DATE /* 기념일날짜 */
);

COMMENT ON TABLE ANNIV IS '기념일';

COMMENT ON COLUMN ANNIV.ano IS '기념일번호';

COMMENT ON COLUMN ANNIV.aname IS '기념일이름';

COMMENT ON COLUMN ANNIV.adate IS '기념일날짜';

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

/* 릴레이(단체) */
DROP TABLE RELAY 
	CASCADE CONSTRAINTS;

/* 릴레이(단체) */
CREATE TABLE RELAY (
	rno NUMBER NOT NULL, /* 릴레이번호 */
	mno NUMBER NOT NULL, /* 회원번호 */
	ano NUMBER, /* 기념일번호 */
	pno NUMBER, /* 상품번호 */
	rbegin DATE NOT NULL, /* 릴레이시작일자 */
	rend DATE /* 릴레이완료일자 */
);

COMMENT ON TABLE RELAY IS '릴레이(단체)';

COMMENT ON COLUMN RELAY.rno IS '릴레이번호';

COMMENT ON COLUMN RELAY.mno IS '회원번호';

COMMENT ON COLUMN RELAY.ano IS '기념일번호';

COMMENT ON COLUMN RELAY.pno IS '상품번호';

COMMENT ON COLUMN RELAY.rbegin IS '릴레이시작일자';

COMMENT ON COLUMN RELAY.rend IS '릴레이완료일자';

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

/* 나만의 릴레이 리스트 */
DROP TABLE MYLIST 
	CASCADE CONSTRAINTS;

/* 나만의 릴레이 리스트 */
CREATE TABLE MYLIST (
	mylno NUMBER NOT NULL, /* 나만의리스트번호 */
	pno NUMBER NOT NULL /* 상품번호 */
);

COMMENT ON TABLE MYLIST IS '나만의 릴레이 리스트';

COMMENT ON COLUMN MYLIST.mylno IS '나만의리스트번호';

COMMENT ON COLUMN MYLIST.pno IS '상품번호';

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

/* 나만의 릴레이 */
DROP TABLE MYRELAY 
	CASCADE CONSTRAINTS;

/* 나만의 릴레이 */
CREATE TABLE MYRELAY (
	myrno NUMBER NOT NULL, /* 나만의릴레이번호 */
	mno NUMBER, /* 회원번호 */
	mylno NUMBER, /* 나만의리스트번호 */
	pno NUMBER /* 상품번호 */
);

COMMENT ON TABLE MYRELAY IS '나만의 릴레이';

COMMENT ON COLUMN MYRELAY.myrno IS '나만의릴레이번호';

COMMENT ON COLUMN MYRELAY.mno IS '회원번호';

COMMENT ON COLUMN MYRELAY.mylno IS '나만의리스트번호';

COMMENT ON COLUMN MYRELAY.pno IS '상품번호';

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

/* 게시글 */
DROP TABLE BOARD 
	CASCADE CONSTRAINTS;

/* 게시글 */
CREATE TABLE BOARD (
	bno NUMBER NOT NULL, /* 게시글번호 */
	mno NUMBER NOT NULL, /* 회원번호 */
	btag VARCHAR2(50) NOT NULL, /* 말머리태그 */
	btitle VARCHAR2(1000) NOT NULL, /* 게시글 제목 */
	bcontent VARCHAR2(2000) NOT NULL, /* 게시글 내용 */
	bimg VARCHAR2(1000), /* 이미지(name) */
	bimgurl VARCHAR2(1000), /* 이미지(url) */
	bdate DATE NOT NULL, /* 게시글작성일자 */
	bupdate DATE, /* 게시글수정일자 */
	bvis NUMBER NOT NULL /* VISIBILITY */
);

COMMENT ON TABLE BOARD IS '게시글';

COMMENT ON COLUMN BOARD.bno IS '게시글번호';

COMMENT ON COLUMN BOARD.mno IS '회원번호';

COMMENT ON COLUMN BOARD.btag IS '말머리태그';

COMMENT ON COLUMN BOARD.btitle IS '게시글 제목';

COMMENT ON COLUMN BOARD.bcontent IS '게시글 내용';

COMMENT ON COLUMN BOARD.bimg IS '이미지(name)';

COMMENT ON COLUMN BOARD.bimgurl IS '이미지(url)';

COMMENT ON COLUMN BOARD.bdate IS '게시글작성일자';

COMMENT ON COLUMN BOARD.bupdate IS '게시글수정일자';

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

/* 댓글테이블 */
DROP TABLE COMM 
	CASCADE CONSTRAINTS;

/* 댓글테이블 */
CREATE TABLE COMM (
	bno NUMBER NOT NULL, /* 게시글번호 */
	cno NUMBER NOT NULL, /* 댓글번호 */
	ccontent VARCHAR2(500) NOT NULL, /* 댓글내용 */
	creplyer VARCHAR2(50) NOT NULL, /* 댓글작성자 */
	cdate DATE NOT NULL, /* 댓글작성일자 */
	cupdate DATE, /* 댓글수정일자 */
	cvis NUMBER NOT NULL /* VISIBILITY */
);

COMMENT ON TABLE COMM IS '댓글테이블';

COMMENT ON COLUMN COMM.bno IS '게시글번호';

COMMENT ON COLUMN COMM.cno IS '댓글번호';

COMMENT ON COLUMN COMM.ccontent IS '댓글내용';

COMMENT ON COLUMN COMM.creplyer IS '댓글작성자';

COMMENT ON COLUMN COMM.cdate IS '댓글작성일자';

COMMENT ON COLUMN COMM.cupdate IS '댓글수정일자';

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

/* 공지글 */
DROP TABLE NOTICE 
	CASCADE CONSTRAINTS;

/* 공지글 */
CREATE TABLE NOTICE (
	nno NUMBER NOT NULL, /* 게시글번호 */
	mno NUMBER NOT NULL, /* 관리자번호 */
	ntitle VARCHAR2(200) NOT NULL, /* 게시글 제목 */
	ncontent VARCHAR2(2000) NOT NULL, /* 게시글 내용 */
	ndate DATE NOT NULL, /* 공지글작성일자 */
	nupdate DATE, /* 공지글수정일자 */
	nvis NUMBER NOT NULL /* VISIBILITY */
);

COMMENT ON TABLE NOTICE IS '공지글';

COMMENT ON COLUMN NOTICE.nno IS '게시글번호';

COMMENT ON COLUMN NOTICE.mno IS '관리자번호';

COMMENT ON COLUMN NOTICE.ntitle IS '게시글 제목';

COMMENT ON COLUMN NOTICE.ncontent IS '게시글 내용';

COMMENT ON COLUMN NOTICE.ndate IS '공지글작성일자';

COMMENT ON COLUMN NOTICE.nupdate IS '공지글수정일자';

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



------------------------속성 DEFAULT 값 생성------------------------------
ALTER TABLE DETAIL MODIFY (JOINDATE DEFAULT SYSDATE);

ALTER TABLE RELAY MODIFY (RBEGIN DEFAULT SYSDATE);

ALTER TABLE BOARD MODIFY (BDATE DEFAULT SYSDATE);

ALTER TABLE BOARD MODIFY (BVIS DEFAULT 1);

ALTER TABLE NOTICE MODIFY (NDATE DEFAULT SYSDATE);

ALTER TABLE NOTICE MODIFY (NVIS DEFAULT 1);


ALTER TABLE COMM MODIFY (CDATE DEFAULT SYSDATE);

ALTER TABLE COMM MODIFY (CVIS DEFAULT 1);


--------------------------테이블 체크 옵션--------------------------------------

--notice mno 1~5까지

ALTER TABLE MEMBER ADD CONSTRAINT SEX_CH CHECK(SEX IN (1,2,3,4) );

ALTER TABLE DETAIL ADD CONSTRAINT AGE_CH CHECK(AGE IN (10, 20, 30, 40, 50, 60));

ALTER TABLE BOARD ADD CONSTRAINT BVIS_CH CHECK(BVIS IN (0, 1));

ALTER TABLE NOTICE ADD CONSTRAINT NVIS_CH CHECK(NVIS IN (0, 1));

ALTER TABLE NOTICE ADD CONSTRAINT MNO_CH CHECK(MNO IN (1, 2, 3, 4, 5) );

ALTER TABLE COMM ADD CONSTRAINT CVIS_CH CHECK(CVIS IN (0, 1));



----------------------SEQUENCE 생성------------------------------------

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

-----------------------------테이블 구조 확인-----------------------------------

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

------------------------------------기본값 입력--------------------------------------


INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'BKD', 'admin1234', '백경동', 'KD', 930818, 1, '서울시 노원구');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '남자', 20, '학생', '게임', DEFAULT, '');
 
INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'LHC', 'admin1234', '이힘찬', 'REDMONKEY', 921018, 1, '부천');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '남자', 20, '인턴', '퇴근', DEFAULT, '');

INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'HHG', 'admin1234', '황한결', 'ANNOTATION', 921010, 1, '중국');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '남자', 20, '지질학자', '오토체스', DEFAULT, '');

INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'KJI', 'admin1234', '김종일', 'HARRY', 931111, 1, '남양주');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '남자', 20, '회사원', '운동', DEFAULT, '');

INSERT INTO MEMBER VALUES(MNO.NEXTVAL, 'KKH', 'admin1234', '김경훈', 'AI', 890526, 1, '샌디에고');
INSERT INTO DETAIL VALUES(MNO.CURRVAL, '남자', 30, 'CEO', '코딩', DEFAULT, '');


SELECT * FROM MEMBER;
SELECT * FROM DETAIL;


Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '지오다노 여 크루넥 경량다운 자켓 378905', 58550, 31300, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=15337277338', 'https://shopping-phinf.pstatic.net/main_1533727/15337277338.20191018002250.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '내셔널지오그래픽 코우너스 플리스 롱기장 뽀글이 풀 집업 CARBON N193UFT950 IVORY', 179000, 179000, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=20364067234', 'https://shopping-phinf.pstatic.net/main_2036406/20364067234.20190724145845.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '지오다노 목넥 푸파 다운 079920', 158000, 108810, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=21023371145', 'https://shopping-phinf.pstatic.net/main_2102337/21023371145.20191005160826.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '내셔널지오그래픽 N194UDW810 브레디 라이트 구스 다운 자켓 CARBON BLACK', 0, 99000, 'NGstore', 
    'https://search.shopping.naver.com/gate.nhn?id=82212525441', 'https://shopping-phinf.pstatic.net/main_8221252/82212525441.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '다이나핏 롱<b>패딩</b> YMW18529', 233080, 165040, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=15030663370', 'https://shopping-phinf.pstatic.net/main_1503066/15030663370.20191015003856.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '론즈데일 TV방송상품 여성 경량 구스다운 자켓 2종세트 LD1808WD0506', 29900, 26910, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=20540776177', 'https://shopping-phinf.pstatic.net/main_2054077/20540776177.20190807145414.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '[바스키아X원빈] 19WINTER 얼라이드 헝가리 구스다운 남성 3종 패키지', 0, 189050, 'CJmall', 
    'https://search.shopping.naver.com/gate.nhn?id=20966287650', 'https://shopping-phinf.pstatic.net/main_2096628/20966287650.2.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '스파이더 유니섹스 퍼포먼스 롱 <b>패딩</b> SPDWCNDJ001UBLK', 299400, 299400, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=20951797431', 'https://shopping-phinf.pstatic.net/main_2095179/20951797431.20190925161817.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '몽클레어 클로에 KHLOE 롱<b>패딩</b>', 2790000, 2054000, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=14969935776', 'https://shopping-phinf.pstatic.net/main_1496993/14969935776.20181121111517.jpg');
Insert into PRODUCT
   (PNO, PNAME, PHPRICE, PLPRICE, PMALL, 
    PMALLURL, PIMG)
 Values
   (PNO.NEXTVAL, '노카라 라운드 경량 웰론 다이아 퀄팅 누빔 숏 <b>패딩</b> 자켓 충전재 솜', 29800, 20670, '네이버', 
    'https://search.shopping.naver.com/gate.nhn?id=17845253706', 'https://shopping-phinf.pstatic.net/main_1784525/17845253706.20190307164814.jpg');

SELECT * FROM PRODUCT;



INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '생일', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '스승의날', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '크리스마스', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '사귄지100일', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '입학식', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '졸업식', '');
INSERT INTO ANNIV VALUES(ANO.NEXTVAL, '결혼식', '');

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




INSERT INTO BOARD VALUES(BNO.NEXTVAL, 1, '자랑해요', '아파요', '팔이 빠졌어요', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 2, '건의해요', 'IT는나랑안맞아', '붕어빵팔사람구함', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 3, '건의해요', '홍삼액키스 드실분', '28살 이상만 줄꺼야', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 4, '건의해요', '종진이 형이예요', '우리 동생 이쁘다', '', '', DEFAULT, '', DEFAULT);
INSERT INTO BOARD VALUES(BNO.NEXTVAL, 5, '자랑해요', '다 배운거예요', '미쳤습니까닝겐', '', '', DEFAULT, '', DEFAULT);

SELECT * FROM BOARD;



INSERT INTO NOTICE VALUES(NNO.NEXTVAL, 1, '김경훈 해내다', '자바가 제일 쉬웠어요. 릴레이 구현 성공', DEFAULT, '', 1);
INSERT INTO NOTICE VALUES(NNO.NEXTVAL, 2, '서종태 떠나다', '형 왜갔어요. 보고싶어요 ㅠㅠ', DEFAULT, '', 1);
INSERT INTO NOTICE VALUES(NNO.NEXTVAL, 4, '종일이 마지막 사랑을 찾다', '소개팅 성공!!', DEFAULT, '', 1);

SELECT * FROM NOTICE;




INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '슬퍼요', 'REDMONKEY', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '푹쉬다와', 'HARRY', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(2, CNO.NEXTVAL, '함께해요', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '꼭 나아서 와', 'ANNOTATION', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(3, CNO.NEXTVAL, '내꺼는', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(1, CNO.NEXTVAL, '스프링 공부해와', 'AI', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(3, CNO.NEXTVAL, '우리는 입도 아니냐', 'HARRY', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(2, CNO.NEXTVAL, '난 옆에서 커피 팜', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(4, CNO.NEXTVAL, 'ㅇㅈ', 'KD', DEFAULT, '', DEFAULT);

INSERT INTO COMM VALUES(5, CNO.NEXTVAL, '역시 AI', 'REDMONKEY', DEFAULT, '', DEFAULT);
SELECT * FROM COMM;

COMMIT;
