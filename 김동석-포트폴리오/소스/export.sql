--------------------------------------------------------
--  File created - Friday-August-30-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_BOARD
--------------------------------------------------------

   CREATE SEQUENCE  "SPRING"."SEQ_BOARD"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 181 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_CHAT
--------------------------------------------------------

   CREATE SEQUENCE  "SPRING"."SEQ_CHAT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1181 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_QUIZ
--------------------------------------------------------

   CREATE SEQUENCE  "SPRING"."SEQ_QUIZ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 161 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_REPLY
--------------------------------------------------------

   CREATE SEQUENCE  "SPRING"."SEQ_REPLY"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 181 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_REPORT
--------------------------------------------------------

   CREATE SEQUENCE  "SPRING"."SEQ_REPORT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table TBL_BOARD
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_BOARD" 
   (	"BNO" NUMBER(10,0), 
	"TITLE" VARCHAR2(200 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"WRITER" VARCHAR2(50 BYTE), 
	"REGDATE" DATE DEFAULT SYSDATE, 
	"UPDATEDATE" DATE DEFAULT SYSDATE, 
	"CATEGORY" VARCHAR2(200 BYTE), 
	"THUMBNAIL" VARCHAR2(4000 BYTE), 
	"VIEW_COUNT" NUMBER DEFAULT 0, 
	"LIKE_COUNT" NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_CHAT
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_CHAT" 
   (	"CNO" NUMBER, 
	"USER_ID" VARCHAR2(50 BYTE), 
	"USER_NAME" VARCHAR2(100 BYTE), 
	"CHAT_LOG" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_LIKE
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_LIKE" 
   (	"USER_ID" VARCHAR2(50 BYTE), 
	"BNO" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_NOTICE
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_NOTICE" 
   (	"N_NO" NUMBER, 
	"TITLE" VARCHAR2(100 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"WRITE_DATE" DATE DEFAULT SYSDATE, 
	"IMAGE" VARCHAR2(200 BYTE), 
	"IMPORTANT" CHAR(1 BYTE) DEFAULT 'N'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_QUIZ
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_QUIZ" 
   (	"BNO" NUMBER, 
	"USER_ID" VARCHAR2(50 BYTE), 
	"USER_NAME" VARCHAR2(100 BYTE), 
	"SCORE" NUMBER, 
	"GAMEDATE" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_REPLY
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_REPLY" 
   (	"RNO" NUMBER(10,0), 
	"BNO" NUMBER(10,0), 
	"REPLY" VARCHAR2(1000 BYTE), 
	"REPLYER" VARCHAR2(50 BYTE), 
	"REPLYDATE" DATE DEFAULT sysdate, 
	"UPDATEDATE" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_REPORTPOST
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_REPORTPOST" 
   (	"RE_NO" NUMBER, 
	"POST_URL" VARCHAR2(4000 BYTE), 
	"POST_ID" VARCHAR2(50 BYTE), 
	"RE_REASON" VARCHAR2(300 BYTE), 
	"RE_ID" VARCHAR2(50 BYTE), 
	"RE_DATE" DATE DEFAULT SYSDATE, 
	"STATUS" VARCHAR2(20 BYTE) DEFAULT '???', 
	"DELETE_URL" VARCHAR2(300 BYTE), 
	"CATEGORY" VARCHAR2(20 BYTE), 
	"WRITE_NUM" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TBL_USER
--------------------------------------------------------

  CREATE TABLE "SPRING"."TBL_USER" 
   (	"USER_ID" VARCHAR2(50 BYTE), 
	"USER_PW" VARCHAR2(50 BYTE), 
	"USER_NAME" VARCHAR2(100 BYTE), 
	"USER_POINT" NUMBER DEFAULT 0, 
	"GRADE" VARCHAR2(100 BYTE), 
	"ADDRESS" VARCHAR2(300 BYTE), 
	"USER_PHONE" VARCHAR2(50 BYTE), 
	"BUSINESS" NUMBER DEFAULT 0, 
	"BUSINESS_NUM" VARCHAR2(20 BYTE), 
	"LAST_LOGIN" DATE, 
	"USER_EMAIL" VARCHAR2(500 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into SPRING.TBL_BOARD
SET DEFINE OFF;
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (121,'??? ??????','<p><img src="/resources/assets/images/upload/2af1703e-cde7-45b9-a928-ce71660c448a.jpg" style="width: 25%;"><br></p>','user01',to_date('24-AUG-24','DD-MON-RR'),to_date('24-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/2af1703e-cde7-45b9-a928-ce71660c448a.jpg',4,1);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (131,'???? ?????!','<p><img src="/resources/assets/images/upload/575b13a7-6fd3-419a-ab5d-52ae2c63dab1.jpg" style="width: 25%;"><br></p>','user04',to_date('27-AUG-24','DD-MON-RR'),to_date('27-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/575b13a7-6fd3-419a-ab5d-52ae2c63dab1.jpg',38,1);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (123,'??? ?????!','<p><img src="/resources/assets/images/upload/18bda363-b578-4a25-849b-c308d32a6ae5.png" style="width: 25%;"><br></p>','user01',to_date('24-AUG-24','DD-MON-RR'),to_date('24-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/18bda363-b578-4a25-849b-c308d32a6ae5.png',17,1);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (125,'?? ??? ?????','<p><img src="/resources/assets/images/upload/1ff60ba2-62d5-4655-9514-e91d26ae90f4.jpg" style="width: 25%;"><br></p>','user01',to_date('24-AUG-24','DD-MON-RR'),to_date('24-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/1ff60ba2-62d5-4655-9514-e91d26ae90f4.jpg',14,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (130,'?? ??? ?????','<p><img src="/resources/assets/images/upload/70c64247-7627-4be3-bea9-f882049877cc.jpg" style="width: 25%;"><br></p>','user01',to_date('25-AUG-24','DD-MON-RR'),to_date('25-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/70c64247-7627-4be3-bea9-f882049877cc.jpg',16,2);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (135,'???? ???','<p><img src="/resources/assets/images/upload/5984c75d-2371-47f7-961e-2bb17b82f109.png" style="width: 25%;"><br></p>','user01',to_date('27-AUG-24','DD-MON-RR'),to_date('27-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/5984c75d-2371-47f7-961e-2bb17b82f109.png',32,1);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (144,'??? ??????','<p><img src="/resources/assets/images/upload/22e524e9-15d7-486c-b77e-a645d552f267.jpg" style="width: 25%;"><br></p>','user01',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/22e524e9-15d7-486c-b77e-a645d552f267.jpg',3,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (150,'????? ?????~~','<p><img src="/resources/assets/images/upload/675d893a-8f47-4b33-9edc-95d548eec85b.jpg" style="width: 25%;"></p><p>?? ????</p>','user04',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/675d893a-8f47-4b33-9edc-95d548eec85b.jpg',5,1);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (143,'?? ??? ?? ??','<p><img src="/resources/assets/images/upload/9eb749fb-b13b-4652-a861-36b12934c798.jpg" style="width: 25%;"></p><p>??</p>','user01',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/9eb749fb-b13b-4652-a861-36b12934c798.jpg',1,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (145,'?? ???','<p><img src="/resources/assets/images/upload/32182f82-bea1-4d49-b55e-e099118f2234.jpg" style="width: 25%;"><br></p>','user01',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/32182f82-bea1-4d49-b55e-e099118f2234.jpg',6,1);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (146,'???? ???','<p><img src="/resources/assets/images/upload/60a39758-c991-49f4-bae7-17f62c3daec3.jpg" style="width: 25%;"><br></p>','user01',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/60a39758-c991-49f4-bae7-17f62c3daec3.jpg',12,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (147,'??? ??','<p><img src="/resources/assets/images/upload/33aa86cc-7dc4-4582-ace7-96becf17f326.jpg" style="width: 25%;"><br></p>','user01',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/33aa86cc-7dc4-4582-ace7-96becf17f326.jpg',2,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (160,'??? ????? ?? ?? ???','<p><img src="/resources/assets/images/upload/f9d26dd9-02ae-4866-8a9f-80d4ef5efef5.jpg" style="width: 25%;"><br></p>','user02',to_date('29-AUG-24','DD-MON-RR'),to_date('29-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/f9d26dd9-02ae-4866-8a9f-80d4ef5efef5.jpg',0,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (149,'?????','<p><img src="/resources/assets/images/upload/7f16c17a-ee59-4de1-8a1d-67bf235715e8.jpg" style="width: 25%;"><br></p>','user04',to_date('28-AUG-24','DD-MON-RR'),to_date('28-AUG-24','DD-MON-RR'),'?????','/resources/assets/images/upload/7f16c17a-ee59-4de1-8a1d-67bf235715e8.jpg',2,0);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (154,'??? ??','<p><img src="/resources/assets/images/upload/e9c50f63-a33e-43c8-b5ee-673fbe39afe1.jpg" style="width: 50%;"></p><p><span style="font-family: Roboto, " noto="" sans="" kr",="" notosanskr,="" "malgun="" gothic",="" "??="" ??",="" applegothic,="" dotum,="" ??,="" sans-serif;="" font-size:="" 20px;"=""><b>??? ??</b></span></p><p><span style="font-family: Roboto, " noto="" sans="" kr",="" notosanskr,="" "malgun="" gothic",="" "??="" ??",="" applegothic,="" dotum,="" ??,="" sans-serif;="" font-size:="" 14px;"="">???? ???B1? ???C? ???? ??? ??? ?? ??????. </span></p><p><span style="font-family: Roboto, " noto="" sans="" kr",="" notosanskr,="" "malgun="" gothic",="" "??="" ??",="" applegothic,="" dotum,="" ??,="" sans-serif;="" font-size:="" 14px;"="">??? ???? ???? ??? ???? 3?? ?? ???C? ???? ????. </span></p><p><span style="font-family: Roboto, " noto="" sans="" kr",="" notosanskr,="" "malgun="" gothic",="" "??="" ??",="" applegothic,="" dotum,="" ??,="" sans-serif;="" font-size:="" 14px;"="">???C? ??? ????? ????? ??? ???? ??? ??,&nbsp;</span><span style="background-color: var(--bs-body-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);">???B1? ??? ??? ?? ?? ?? ??? ???? ????? ????? ??? ???.</span></p><p><span style="font-family: Roboto, " noto="" sans="" kr",="" notosanskr,="" "malgun="" gothic",="" "??="" ??",="" applegothic,="" dotum,="" ??,="" sans-serif;="" font-size:="" 14px;"="">??? ??? ???? ?? ???? ??? ???? ???A? ? ?????. ???A? ??? ????? ??? ???? ???? ????.</span><br></p>','user01',to_date('29-AUG-24','DD-MON-RR'),to_date('29-AUG-24','DD-MON-RR'),'?????','/resources/assets/images/upload/e9c50f63-a33e-43c8-b5ee-673fbe39afe1.jpg',24,3);
Insert into SPRING.TBL_BOARD (BNO,TITLE,CONTENT,WRITER,REGDATE,UPDATEDATE,CATEGORY,THUMBNAIL,VIEW_COUNT,LIKE_COUNT) values (161,'???? ???','<p><img src="/resources/assets/images/upload/d1ba90f3-dff5-4c20-a1f7-27dfd52374ef.jpg" style="width: 25%;"><br></p>','user02',to_date('29-AUG-24','DD-MON-RR'),to_date('29-AUG-24','DD-MON-RR'),'??? ???','/resources/assets/images/upload/d1ba90f3-dff5-4c20-a1f7-27dfd52374ef.jpg',0,0);
REM INSERTING into SPRING.TBL_CHAT
SET DEFINE OFF;
Insert into SPRING.TBL_CHAT (CNO,USER_ID,USER_NAME,CHAT_LOG) values (1159,'user01','???','?????');
Insert into SPRING.TBL_CHAT (CNO,USER_ID,USER_NAME,CHAT_LOG) values (1161,'user01','???','????? ????');
Insert into SPRING.TBL_CHAT (CNO,USER_ID,USER_NAME,CHAT_LOG) values (1162,'user02','???','? ?? ??? ?? ???');
Insert into SPRING.TBL_CHAT (CNO,USER_ID,USER_NAME,CHAT_LOG) values (1160,'user02','???','????? ????');
Insert into SPRING.TBL_CHAT (CNO,USER_ID,USER_NAME,CHAT_LOG) values (1163,'user01','???','???? ??');
REM INSERTING into SPRING.TBL_LIKE
SET DEFINE OFF;
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',121);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',123);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',130);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',131);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',135);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',145);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',150);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user01',154);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user02',154);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user04',130);
Insert into SPRING.TBL_LIKE (USER_ID,BNO) values ('user04',154);
REM INSERTING into SPRING.TBL_NOTICE
SET DEFINE OFF;
REM INSERTING into SPRING.TBL_QUIZ
SET DEFINE OFF;
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (82,'user01','??1',13,to_date('15-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (83,'user01','??1',90,to_date('15-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (84,'user01','??1',1,to_date('15-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (85,'user01','??1',0,to_date('15-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (86,'user01','??1',2,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (87,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (88,'user01','??1',1,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (89,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (90,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (91,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (92,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (93,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (94,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (95,'user01','??1',0,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (96,'user01','??1',2,to_date('16-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (101,'user01','??1',0,to_date('20-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (102,'user01','??1',1,to_date('20-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (103,'user01','??1',3,to_date('21-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (104,'user01','??1',0,to_date('21-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (121,'user01','??1',1,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (122,'user01','??1',1,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (123,'user01','??1',3,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (124,'user01','??1',2,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (125,'user01','??1',1,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (126,'user01','??1',38,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (127,'user01','??1',2,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (128,'user01','??1',25,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (129,'user01','??1',18,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (130,'user01','??1',1,to_date('24-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (131,'user01','??1',1,to_date('25-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (132,'user01','??1',12,to_date('25-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (133,'user01','??1',2,to_date('25-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (134,'user01','??1',0,to_date('25-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (135,'user01','??1',2,to_date('25-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (136,'user01','??1',1,to_date('25-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (137,'user01','??1',20,to_date('26-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (138,'user01','??1',0,to_date('26-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (139,'user01','????',1,to_date('27-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (141,'user01','????',0,to_date('28-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (142,'user01','????',23,to_date('28-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (143,'user01','????',0,to_date('28-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (144,'user01','????',1,to_date('28-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (145,'user01','????',14,to_date('29-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (62,'user01','??1',3,to_date('14-AUG-24','DD-MON-RR'));
Insert into SPRING.TBL_QUIZ (BNO,USER_ID,USER_NAME,SCORE,GAMEDATE) values (81,'user01','??1',114,to_date('15-AUG-24','DD-MON-RR'));
REM INSERTING into SPRING.TBL_REPLY
SET DEFINE OFF;
Insert into SPRING.TBL_REPLY (RNO,BNO,REPLY,REPLYER,REPLYDATE,UPDATEDATE) values (166,154,'????? ??????','user04',to_date('29-AUG-24','DD-MON-RR'),to_date('29-AUG-24','DD-MON-RR'));
REM INSERTING into SPRING.TBL_REPORTPOST
SET DEFINE OFF;
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (1,'http://localhost/ds/board/read?bno=86','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',86);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (2,'http://localhost/ds/board/read?bno=86','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',86);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (3,'http://localhost/ds/board/read?bno=82','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',82);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (4,'http://localhost/ds/board/read?bno=82','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',82);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (5,'http://localhost/ds/board/read?bno=82','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',82);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (6,'http://localhost/ds/board/read?bno=82','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',82);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (7,'http://localhost/ds/board/read?bno=83','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',83);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (8,'http://localhost/ds/board/read?bno=84','user01','??','user02',to_date('22-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',84);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (9,'http://localhost/ds/board/read?bno=114','user01','??','user02',to_date('23-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',114);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (21,'http://localhost/ds/board/read?bno=129','user01','??','user02',to_date('25-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',129);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (23,'http://localhost/ds/board/read?bno=134','????','??','user01',to_date('27-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',134);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (24,'http://localhost/ds/board/read?bno=133','user04','??','user01',to_date('27-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',133);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (41,'http://localhost/ds/board/read?bno=123','user01','??','user01',to_date('28-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',123);
Insert into SPRING.TBL_REPORTPOST (RE_NO,POST_URL,POST_ID,RE_REASON,RE_ID,RE_DATE,STATUS,DELETE_URL,CATEGORY,WRITE_NUM) values (42,'/ds/board/read?bno=','user01','??','user02',to_date('29-AUG-24','DD-MON-RR'),'???','/ds/board/delete','bno',154);
REM INSERTING into SPRING.TBL_USER
SET DEFINE OFF;
Insert into SPRING.TBL_USER (USER_ID,USER_PW,USER_NAME,USER_POINT,GRADE,ADDRESS,USER_PHONE,BUSINESS,BUSINESS_NUM,LAST_LOGIN,USER_EMAIL) values ('user01','user01','????',950,null,null,null,0,null,null,null);
Insert into SPRING.TBL_USER (USER_ID,USER_PW,USER_NAME,USER_POINT,GRADE,ADDRESS,USER_PHONE,BUSINESS,BUSINESS_NUM,LAST_LOGIN,USER_EMAIL) values ('user02','1234','???',0,null,'afdss','safd',0,null,null,'sdaf');
Insert into SPRING.TBL_USER (USER_ID,USER_PW,USER_NAME,USER_POINT,GRADE,ADDRESS,USER_PHONE,BUSINESS,BUSINESS_NUM,LAST_LOGIN,USER_EMAIL) values ('user04','user04','sfafdasf',0,null,'sadff','dfsafdas',0,null,null,'afdsdsf');
Insert into SPRING.TBL_USER (USER_ID,USER_PW,USER_NAME,USER_POINT,GRADE,ADDRESS,USER_PHONE,BUSINESS,BUSINESS_NUM,LAST_LOGIN,USER_EMAIL) values ('testuser','testuser','???',0,null,'?????','0101234567',0,null,null,'test@email.com');
Insert into SPRING.TBL_USER (USER_ID,USER_PW,USER_NAME,USER_POINT,GRADE,ADDRESS,USER_PHONE,BUSINESS,BUSINESS_NUM,LAST_LOGIN,USER_EMAIL) values ('usertest','usertest','??',0,null,'sdfaff','010-1351-1632',0,null,null,'sadfdf');
--------------------------------------------------------
--  DDL for Index PK_REPLY
--------------------------------------------------------

  CREATE UNIQUE INDEX "SPRING"."PK_REPLY" ON "SPRING"."TBL_REPLY" ("RNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index TBL_NOTICE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SPRING"."TBL_NOTICE_PK" ON "SPRING"."TBL_NOTICE" ("N_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index PK_LIKE
--------------------------------------------------------

  CREATE UNIQUE INDEX "SPRING"."PK_LIKE" ON "SPRING"."TBL_LIKE" ("USER_ID", "BNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table TBL_CHAT
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_CHAT" ADD PRIMARY KEY ("CNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TBL_REPLY
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_REPLY" ADD CONSTRAINT "PK_REPLY" PRIMARY KEY ("RNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SPRING"."TBL_REPLY" MODIFY ("REPLYER" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPLY" MODIFY ("REPLY" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPLY" MODIFY ("BNO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TBL_LIKE
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_LIKE" ADD CONSTRAINT "PK_LIKE" PRIMARY KEY ("USER_ID", "BNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TBL_BOARD
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY ("BNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SPRING"."TBL_BOARD" MODIFY ("CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_BOARD" MODIFY ("WRITER" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_BOARD" MODIFY ("CONTENT" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_BOARD" MODIFY ("TITLE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TBL_QUIZ
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_QUIZ" ADD PRIMARY KEY ("BNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SPRING"."TBL_QUIZ" MODIFY ("SCORE" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_QUIZ" MODIFY ("USER_NAME" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_QUIZ" MODIFY ("USER_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TBL_NOTICE
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_NOTICE" ADD CONSTRAINT "TBL_NOTICE_PK" PRIMARY KEY ("N_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SPRING"."TBL_NOTICE" MODIFY ("CONTENT" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_NOTICE" MODIFY ("TITLE" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_NOTICE" MODIFY ("N_NO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TBL_REPORTPOST
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_REPORTPOST" ADD PRIMARY KEY ("RE_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SPRING"."TBL_REPORTPOST" ADD CHECK (status IN ('????', '???', '??')) ENABLE;
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("WRITE_NUM" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("DELETE_URL" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("RE_DATE" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("RE_ID" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("RE_REASON" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("POST_ID" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_REPORTPOST" MODIFY ("POST_URL" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TBL_USER
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_USER" ADD PRIMARY KEY ("USER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "SPRING"."TBL_USER" MODIFY ("USER_NAME" NOT NULL ENABLE);
  ALTER TABLE "SPRING"."TBL_USER" MODIFY ("USER_PW" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table TBL_LIKE
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_LIKE" ADD FOREIGN KEY ("USER_ID")
	  REFERENCES "SPRING"."TBL_USER" ("USER_ID") ENABLE;
  ALTER TABLE "SPRING"."TBL_LIKE" ADD FOREIGN KEY ("BNO")
	  REFERENCES "SPRING"."TBL_BOARD" ("BNO") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table TBL_REPLY
--------------------------------------------------------

  ALTER TABLE "SPRING"."TBL_REPLY" ADD CONSTRAINT "FK_REPLY_BOARD" FOREIGN KEY ("BNO")
	  REFERENCES "SPRING"."TBL_BOARD" ("BNO") ON DELETE CASCADE ENABLE;
