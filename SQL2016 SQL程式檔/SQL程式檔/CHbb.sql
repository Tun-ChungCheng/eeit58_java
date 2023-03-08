USE 練習BB

GO
●●-- PB-2a

CREATE TABLE 員工薪資
(
 編號 int IDENTITY PRIMARY KEY, 
 薪資 smallmoney,
 CHECK (薪資 > 0 AND 薪資 <= 50000)
)

GO
●●--PB-2b

CREATE TABLE 經銷商
(
 編號 int IDENTITY PRIMARY KEY,
 姓名 char(20) NOT NULL,
 地址 char(50),
 電話 char(13),
 CHECK (地址 IS NOT NULL OR 電話 IS NOT NULL)
)

GO
●●-- PB-4a

CREATE RULE Price_rule
AS @price >= 1 AND @price <= 50000 

GO
●●-- PB-4b

CREATE RULE charset_rule 
AS @charset LIKE 'F0[1-9][1-9]-[A-E]_'

GO
●●-- PB-4c

CREATE RULE Gender_rule
AS @gender IN ('男', '女') 

GO
●●-- PB-5a

CREATE RULE payday_rule
AS @payday >= getdate()

GO
●●-- PB-5b

EXEC sp_bindrule Gender_rule, '員工.性別'

GO
●●-- PB-6

EXEC sp_unbindrule '員工.性別'

GO
●●-- PB-8

DROP RULE Price_rule, Gender_rule

GO
●●-- PB-9a

CREATE DEFAULT 性別_df
AS '男' 

GO
●●-- PB-9b

CREATE DEFAULT 地點_df
AS '台灣'

GO
●●-- PB-10

EXEC sp_bindefault 性別_df, '員工.性別'

GO
●●-- PB-10

EXEC sp_unbindefault '員工.性別'

GO
●●-- PB-12

DROP DEFAULT 地點_df

GO
●●-- PB-14a

CREATE TYPE Phone
FROM char(12) 
NOT NULL

GO
●●-- PB-14b

CREATE TYPE PayDay
FROM date
NULL

GO
●●-- PB-16a

DROP TYPE Phone

GO
●●-- PB-16b

DROP TYPE PayDay 

GO
●●-- PB-16c

CREATE TYPE MyBook AS TABLE   -- 必須使用 AS 而不是 FROM
(書籍編號 int PRIMARY KEY, 
 書籍名稱 varchar(50))
GO

DECLARE @mybook MyBook  -- 以『使用者定義資料表類型』宣告 table 變數

INSERT @mybook                
SELECT 書籍編號, 書籍名稱
FROM 書籍

SELECT * FROM @mybook 

