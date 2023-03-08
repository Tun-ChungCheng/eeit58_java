USE 練習12

GO
●●-- P12-6

CREATE TABLE TABLE_1 
( 
ProductID smallint NOT NULL, 
ProductName char(30) UNIQUE,  
Price smallmoney, 
Manufacturer char(30) 
) 

GO
●●-- P12-10

CREATE TABLE TABLE_2 
( 
ProductID smallint NOT NULL Primary Key,  
ProductName char(30), 
Price smallmoney, 
Manufacturer char(30) 
) 

GO
●●-- P12-22

CREATE TABLE TABLE_3   
( 
c1 int NOT NULL Primary key, 
c2 char(4), 
c3 char(6), 
c4 char(30) 
) 

CREATE INDEX MyIndex_1  
ON Table_3 (c1) 
CREATE INDEX MyIndex_2  
ON Table_3 (c2, c3)        

GO
●●-- P12-23

CREATE TABLE TABLE_4 
( 
ProductID smallint NOT NULL Primary Key,  
ProductName char(30), 
Price smallmoney, 
Manufacturer char(30) 
) 

CREATE UNIQUE NONCLUSTERED INDEX index_3 
ON TABLE_4 (ProductName)
INCLUDE (price)
WITH PAD_INDEX, FILLFACTOR=30, IGNORE_DUP_KEY 


GO
●●-- P12-24a

EXEC sp_helpindex TABLE_4

GO
●●-- P12-24b

DROP INDEX Table_4.index_3 

GO
●●-- P12-255a

CREATE TABLE MyTable 
( 
ProductID smallint NOT NULL Primary key, 
ProductName char(30) UNIQUE, 
Price smallmoney, 
Manufacturer char(30) 
) 

EXEC sp_helpindex MyTable

GO
●●-- P12-25b

DROP INDEX MyTable.PK__MyTable__B40CC6ED0B511B66
DROP INDEX MyTable.UQ__MyTable__DD5A978ABA979F6A

GO
●●-- P12-25c

ALTER TABLE MyTable DROP CONSTRAINT PK__MyTable__B40CC6ED62500D63
ALTER TABLE MyTable DROP CONSTRAINT UQ__MyTable__DD5A978ADF45C5FA

GO
●●-- P12-26

CREATE UNIQUE NONCLUSTERED INDEX MyIndex_1
ON TABLE_3 (c2)
WITH PAD_INDEX, FILLFACTOR=30, IGNORE_DUP_KEY, DROP_EXISTING

GO
●●-- P12-27

DBCC DBREINDEX (客戶, PK_客戶, 70) 

GO
●●-- P12-28

SELECT 電話  
FROM 員工
WHERE 姓名 = '趙飛燕'


GO
●●-- P12-31

SELECT 客戶名稱 
FROM 客戶
WHERE 簡要地址 Like '%仁愛路%'

GO
●●-- P12-36

SET ARITHABORT, CONCAT_NULL_YIELDS_NULL,
    QUOTED_IDENTIFIER, ANSI_NULLS,
    ANSI_PADDING, ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

CREATE VIEW dbo.產品日報
WITH SCHEMABINDING     
AS
SELECT 下單日期 AS 日期, 書籍編號 AS 書號, 
       SUM (數量) AS 每日銷售量, COUNT_BIG (*) AS 每日訂單數
FROM   dbo.訂單 INNER JOIN dbo.訂購項目 
                            ON 訂單.訂單編號 = 訂購項目.訂單編號
GROUP BY 下單日期, 書籍編號
GO

SELECT * FROM 產品日報

GO
●●-- P12-37

CREATE UNIQUE CLUSTERED INDEX PK_產品日報 
ON 產品日報 (日期, 書號)

GO
●●-- P12-38

CREATE INDEX IX_書號
ON 產品日報(書號)
INCLUDE (日期, 每日銷售量)

GO
●●-- P12-39

SELECT 日期, 書號, 每日銷售量, 每日訂單數 
FROM 產品日報
WHERE 日期 = '2016/9/11' 
ORDER BY 日期

GO
●●-- P12-40a

SELECT 日期, 書號,  每日銷售量
FROM 產品日報
WHERE 書號 = 2

GO
●●-- P12-40b

SELECT 下單日期, SUM(數量) AS 銷售量 
FROM    訂單 INNER JOIN 訂購項目
ON 訂單.訂單編號 = 訂購項目.訂單編號
GROUP BY 下單日期, 書籍編號
ORDER BY 下單日期

GO
●●-- P12-40c

SELECT 下單日期, SUM(數量) AS 銷售量 
FROM    訂單 INNER JOIN 訂購項目
ON 訂單.訂單編號 = 訂購項目.訂單編號
GROUP BY 下單日期, 書籍編號
ORDER BY 書籍編號

GO
●●-- P12-41a

SELECT 下單日期, SUM(數量) AS 銷售量
FROM    訂單 INNER JOIN 訂購項目 
ON 訂單.訂單編號 = 訂購項目.訂單編號
GROUP BY 下單日期
ORDER BY 下單日期 DESC

GO
●●-- P12-41b

SELECT 下單日期, 書籍編號, AVG(數量) AS 訂單平均銷售量
FROM     訂單 INNER JOIN 訂購項目 
ON 訂單.訂單編號 = 訂購項目.訂單編號
GROUP BY 下單日期, 書籍編號
ORDER BY 下單日期

GO
●●-- P12-42

DROP INDEX  產品日報.PK_產品日報

GO
●●-- P12-46

CREATE INDEX 女性應徵者索引
ON 應徵者 (姓名)
WHERE 性別 = '女'


GO
●●-- P12-47
SELECT 姓名
FROM 應徵者
WHERE 性別 = '女'

GO
●●-- P12-48

INSERT INTO 應徵者 (姓名,性別)
VALUES ('男應徵者','男'),
       ('女應徵者','女'),
       ('男應徵者','男'),
       ('男應徵者','男'),
       ('男應徵者','男')


