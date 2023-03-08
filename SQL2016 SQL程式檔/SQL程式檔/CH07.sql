
●● -- 切換資料庫
USE 練習07

GO 
●● -- P7-40

CREATE TABLE 圖庫
( 區域編號 int IDENTITY (1001, 1),              -- 由 100 開始自動編號
  全域編號 uniqueidentifier DEFAULT NEWID() ROWGUIDCOL,  -- GUID 欄位
  檔名     nvarchar(20) NOT NULL,                   -- 不可為 NULL
  建檔日   date DEFAULT CONVERT(date, GETDATE())    -- 預設為今天
)

GO 
●● -- P7-41a

INSERT 圖庫 (檔名) VALUES ('Flag01.jpg')
SELECT * FROM 圖庫

GO 
●● -- P7-41b

SELECT $ROWGUID
FROM 圖庫
WHERE  $IDENTITY = 1001

GO 
●● -- P7-42a

CREATE DATABASE 練習fs     -- 請先建立 C:\data 資料夾
ON
PRIMARY
  (NAME = 練習fs, FILENAME = 'C:\data\練習fs.mdf'),
FILEGROUP fs_group1 
  CONTAINS FILESTREAM
	(NAME = fs1, FILENAME = 'C:\data\fs1')
LOG ON 
	(NAME = 練習fs_log, FILENAME = 'C:\data\練習fs.ldf')

GO 
●● -- P7-42b

CREATE TABLE 練習fs.dbo.文件
( 編號 uniqueidentifier DEFAULT NEWID() 
					    ROWGUIDCOL NOT NULL UNIQUE,
  檔名 nvarchar(20) NOT NULL,
  內容 varbinary(max) FILESTREAM NULL  
)

INSERT 練習fs.dbo.文件 (檔名, 內容) 
VALUES ('Doc01.txt', CONVERT(varbinary(max), '測試儲存'))

SELECt CONVERT(varchar(max), 內容) 
FROM 練習fs.dbo.文件

GO 
●● -- P7-43

SELECT 檔名, 內容.PathName()
FROM 練習fs.dbo.文件

GO 
●● -- P7-45

CREATE TABLE 訂單01
  ( 訂單編號  int PRIMARY KEY,
    下單日期  date, 
    客戶編號  int CONSTRAINT FK_訂單與客戶01
                      FOREIGN KEY
                      REFERENCES 客戶01 (客戶編號))

GO 
●● -- P7-47a

CREATE TABLE 客戶02
(  客戶編號  int IDENTITY PRIMARY KEY,
   身份證字號  char(10)  NOT NULL  UNIQUE,
   年齡  int  CHECK (年齡 > 0)  DEFAULT 25,
   地址  varchar(50),
   電話  varchar(12),
   雜誌編號 int 
         REFERENCES  雜誌種類 (雜誌編號), 
   訂戶編號 int NOT NULL,
   
   FOREIGN KEY (雜誌編號, 訂戶編號)
         REFERENCES  雜誌訂戶 (雜誌編號, 訂戶編號),
   CHECK (地址 is not null or 電話 is not null)
)

GO 
●● -- P7-47b

EXEC sp_helpconstraint 客戶02


GO 
●● -- P7-48a

CREATE TABLE 估價
  ( 編號 int  IDENTITY,
    單價 numeric(5,1),
    數量 int,
    總價 AS 單價 * 數量
  ) 

GO 
●● -- P7-48b

INSERT 估價 VALUES (21.5, 8)
INSERT 估價 VALUES (12, 3)
SELECT * FROM 估價

GO 
●● -- P7-51

ALTER TABLE 客戶A
   ALTER COLUMN 聯絡人
            varchar(30) NULL

GO 
●● -- P7-53

ALTER TABLE 客戶A
    ADD
      類別編號 int 
         DEFAULT 1 WITH VALUES
         CONSTRAINT FK_類別編號
         FOREIGN KEY 
              REFERENCES 客戶類別(類別編號) 
         
GO 
●● -- P7-54a

ALTER TABLE 訂購項目A
     WITH CHECK ADD
     CONSTRAINT PK_訂購項目A
     PRIMARY KEY (訂單編號, 項目編號)

GO 
●● -- P7-54b

ALTER TABLE 訂購項目A
    DROP CONSTRAINT PK_訂購項目A

GO 
●● -- P7-54c

ALTER TABLE 訂購項目A
    DROP COLUMN 訂單編號, 項目編號

GO 
●● -- P7-55a

ALTER TABLE 客戶A
    NOCHECK CONSTRAINT FK_類別編號

GO 
●● -- P7-55b

ALTER TABLE 客戶A
    CHECK CONSTRAINT FK_類別編號

GO 
●● -- P7-56a

EXEC sp_rename '訂單A', '訂購單A'

GO 
●● -- P7-56b

EXEC sp_rename '客戶A.地址' , '通訊處', 'COLUMN'

GO 
●● -- P7-56c

DROP TABLE 書籍A

GO 
●● -- P7-58

CREATE TABLE #訂單 ( 編號 int, 數量 int ) 

CREATE TABLE ##客戶 ( 編號 int, 姓名 char(10) ) 

GO
●● -- P7-61

CREATE TABLE 書籍T
(
	書籍編號 INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	書籍名稱 VARCHAR(50) NULL,
	價格 SMALLMONEY NULL,
	出版公司 CHAR(20) NULL,
	起始時間 DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
	迄止時間 DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
   PERIOD FOR SYSTEM_TIME (起始時間,迄止時間) 
) WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.書籍T_History));

GO

●● -- P7-62a

insert into 書籍T (書籍名稱, 價格, 出版公司) values ('Windows 使用手冊', 500, '旗旗出版公司')
insert into 書籍T (書籍名稱, 價格, 出版公司) values ('Office 使用手冊', 500, '標標出版公司')
insert into 書籍T (書籍名稱, 價格, 出版公司) values ('Linux 使用手冊', 500, '旗旗出版公司')

GO
●● -- P7-62b

SELECT * FROM 書籍T

GO
●● -- P7-62c

SELECT	*,
	起始時間,
	迄止時間
  FROM	書籍T

GO

●● -- P7-63a

SELECT * FROM 書籍T_History

GO

●● -- P7-63b

UPDATE 書籍T SET 價格 = 600 WHERE 書籍編號 = 3

SELECT	*, 起始時間, 迄止時間 FROM 書籍T

SELECT * FROM 書籍T_History

GO
●● -- P7-64a

Delete 書籍T WHERE 書籍編號 = 3

SELECT	*, 起始時間, 迄止時間 FROM 書籍T

SELECT * FROM 書籍T_History

GO
●● -- P7-64b

DROP TABLE 書籍T

GO
●● -- P7-65a

ALTER TABLE 書籍T
  SET (SYSTEM_VERSIONING = OFF)

DROP TABLE 書籍T

DROP TABLE 書籍T_History

GO
●● -- P7-65b

CREATE TABLE 書籍S
(
	書籍編號 INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	書籍名稱 VARCHAR(50) NULL,
	價格 SMALLMONEY NULL,
	出版公司 CHAR(20) NULL
)

GO
●● -- P7-66

--加入2個 DATETIME2 欄位, 並指定寫入系統時間
ALTER TABLE 書籍S
ADD PERIOD FOR SYSTEM_TIME (起始時間,迄止時間),
起始時間 DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
迄止時間 DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN

GO

--啟用SYSTEM_VERSIONING參數

ALTER TABLE 書籍S
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.書籍S_History)) 

GO