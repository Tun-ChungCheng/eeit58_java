●● -- 切換資料庫
USE 練習15

GO 
●● -- P15-3
DECLARE @TopProductID int
SET @TopProductID = dbo.GetTopProductID('2016')

SELECT 姓名, 區域
FROM GetEmployeeFromProdId(@TopProductID)
WHERE 區域 = '北區'

GO 
●● -- P15-8

/* 傳回在指定年度中最暢銷的書籍 */
CREATE FUNCTION GetTopProductID 
(@year varchar(5))
RETURNS int
BEGIN
    DECLARE @id int
    SELECT TOP 1 @id = 書籍編號
    FROM 訂單 JOIN 訂單細目
               ON 訂單.訂單序號 =  訂單細目.訂單序號
    WHERE DATEPART (YYYY, 日期) = @year
    GROUP BY 書籍編號
    ORDER BY SUM(數量) DESC
    IF @@ROWCOUNT = 0 
         RETURN 0
     RETURN @id
END
GO

SELECT dbo.GetTopProductID('2016') AS '書籍編號' 
GO

GO 
●● -- P15-9

CREATE TYPE NameValueTable AS TABLE  --  建立『使用者定義資料表類型』, 
(名稱 varchar(50), 數值 int )        --  內含【名稱、數值】 2 個欄位
GO

CREATE FUNCTION 傳回最大者
(@tab NameValueTable READONLY)
RETURNS varchar(50)
BEGIN
	DECLARE @maxName varchar(50)

	SELECT TOP 1 @maxName = 名稱	-- 取加總數量的最大者
	FROM @tab
	GROUP BY 名稱					-- 依名稱分組
	ORDER BY SUM(數值) DESC			-- 加總數量並遞減排序   
	
	RETURN @maxName
END
GO

DECLARE @tab NameValueTable

INSERT @tab
SELECT 客戶名稱, 數量
FROM 出貨記錄

SELECT '出貨量最大的客戶為：' + dbo.傳回最大者(@tab)

DELETE @tab

INSERT @tab
SELECT 股票名稱, 購買張數
FROM 股票交易記錄

SELECT  '庫存最多的股票為：' + dbo.傳回最大者(@tab)

GO 
●● -- P15-11a

CREATE FUNCTION 依售價查詢書籍
(@由 money, @到 money)
RETURNS TABLE
RETURN (SELECT 書籍編號, 書籍名稱, 單價
                FROM 書籍
               WHERE 單價 >=@由 AND 單價 <= @到)
GO

SELECT * 
FROM 依售價查詢書籍(400, 450)
ORDER BY 單價

GO 
●● -- P15-11b

SELECT *
FROM ::fn_helpcollations()

GO 
●● -- P15-14

/* 找出所有負責銷售指定書籍的相關人員 */
CREATE FUNCTION GetEmployeeFromProdId
(@ProductId int)
RETURNS @Employee TABLE 
             ( 員工編號 int NOT NULL,
  	           姓名 varchar (20) NOT NULL,
			   性別 char (2),
               主管員工編號 int, 
               職稱 varchar (10),
               區域 varchar (10))
BEGIN
    /* 將產品負責人的資料加入要傳回的 @Employee 中*/
    INSERT @Employee
    SELECT 員工.* 
    FROM 員工 JOIN 書籍 ON 員工編號 = 負責人
    WHERE 書籍編號 = @ProductId

    /* 將負責人的員工編號存入 @id 中 */
    DECLARE @id int
    SELECT @id  = 員工編號
    FROM  @Employee

    /* 將負責人的直屬銷售員也加入要傳回的 @Employee 中*/
    INSERT @Employee
    SELECT *
    FROM 員工 
    WHERE 主管員工編號 = @id
   
    RETURN
END 

GO

SELECT *
FROM GetEmployeeFromProdId(6)

SELECT 姓名
FROM GetEmployeeFromProdId(6)
WHERE 區域 = '北區'


GO 
●● -- P15-17

CREATE FUNCTION Calc
(@a int, @b int =3)
RETURNS int
BEGIN
    RETURN @a + @b
END
GO

SELECT dbo.Calc(5, 6)
SELECT dbo.Calc(5, Default)
GO
SELECT  dbo.Calc(5)

GO 
●● -- P15-18

CREATE FUNCTION NewID()
RETURNS varchar(5)
BEGIN
    DECLARE @id varchar(5), @i int

    /* 找出目前最大的編號 */
    SELECT TOP 1 @id = 編號
    FROM 出貨記錄
    ORDER BY 編號 DESC

    IF @@ROWCOUNT = 0   /* 如果沒有記錄 */
         RETURN 'A0001'

    SET @i = CAST(RIGHT(@id, 4) AS int) + 1
    SET @id = CAST(@i AS varchar)
    RETURN  'A' + REPLICATE('0', 4-LEN(@id)) + @id
END
GO
SELECT dbo.NewID()

GO 
●● -- P15-20

CREATE FUNCTION 計算優惠價
(@類別編號 int, @單價 money)
RETURNS money
BEGIN
    DECLARE @優惠價 money
    SELECT @優惠價 = 折扣 * @單價
    FROM 書籍類別
    WHERE 類別編號 = @類別編號
    RETURN @優惠價
END
GO

SELECT dbo.計算優惠價(1, 20)

GO 
●● -- P15-25

CREATE SEQUENCE Seq123   -- 建立 Seq123 順序物件
START WITH 1          -- 由 1 開始給號
INCREMENT BY 1        -- 每次 +1

CREATE SEQUENCE Seq246   -- 建立 Seq246 順序物件
START WITH 2          -- 由 2 開始給號
INCREMENT BY 2        -- 每次 +2

SELECT NEXT VALUE FOR Seq123 AS 順序1,  -- 由 Seq123 取號
       NEXT VALUE FOR Seq246 AS 順序2,  -- 由 Seq246 取號
	   產品名稱
FROM 旗旗公司

GO 
●● -- P15-26

SELECT NEXT VALUE FOR Seq123 AS 順序1, 
       NEXT VALUE FOR Seq246 AS 順序2,
	   產品名稱
FROM 標標公司

ALTER SEQUENCE Seq123   -- 修改 Seq123 的設定
RESTART WITH -2      -- 重設啟始編號為 -2

SELECT NEXT VALUE FOR Seq123 AS 順序1, 
       NEXT VALUE FOR Seq246 AS 順序2,
	   產品名稱
FROM 標標公司

GO 
●● -- P15-30

CREATE SEQUENCE Seq0123
AS tinyint       -- 使用 tinyint 型別
START WITH 1     -- 開始值為 1
MAXVALUE 3       -- 最大值為 3
CYCLE            -- 要循環編號

SELECT NEXT VALUE FOR Seq0123 AS 循環編號, 產品名稱
FROM 標標公司

GO 
●● -- P15-32a

ALTER SEQUENCE Seq0123 
RESTART      -- 由原來的開始值重新編號

SELECT NEXT VALUE FOR Seq0123 AS 循環編號

ALTER SEQUENCE Seq0123 
RESTART WITH 3      -- 由新的開始值重新編號

SELECT NEXT VALUE FOR Seq0123 AS 循環編號

GO 
●● -- P15-32b

DROP SEQUENCE Seq246, Seq0123

GO 
●● -- P15-35a

ALTER SEQUENCE Seq123 
RESTART WITH 1

DECLARE @var bigint = NEXT VALUE FOR Seq123
PRINT @var
SET @var = NEXT VALUE FOR Seq123
PRINT @var
SELECT @var = NEXT VALUE FOR Seq123
PRINT @var

GO 
●● -- P15-35b

SELECT NEXT VALUE FOR seq123 AS 序號, 
       產品名稱, 價格
INTO 大大公司
FROM 旗旗公司 WHERE 價格 = 500

INSERT 大大公司
VALUES (NEXT VALUE FOR seq123, '資料庫實務', 550)

SELECT * FROM  大大公司

GO 
●● -- P15-36a


UPDATE 大大公司
SET 序號 = NEXT VALUE FOR seq123
WHERE 價格 = 500

SELECT * FROM  大大公司

GO 
●● -- P15-36b

ALTER TABLE 大大公司
ADD DEFAULT NEXT VALUE FOR seq123 FOR 序號
  
INSERT 大大公司 (產品名稱, 價格)
VALUES ('SQL聖經', 780), ('精通SQL', 720)

SELECT * FROM  大大公司

GO 
●● -- P15-37

ALTER SEQUENCE Seq123 
RESTART WITH 1

SELECT NEXT VALUE FOR seq123 OVER(ORDER BY 價格 DESC) AS 價格排名, * 
FROM  大大公司

GO 
●● -- P15-38

DECLARE @第一值 sql_variant,    -- 宣告 2 個變數來儲存取得的序號
        @最後值 sql_variant

EXEC sp_sequence_get_range N'Seq123', 5,   -- 由 Seq123 取得 5 個連續編號
        @第一值 OUTPUT, @最後值 OUTPUT     -- 由參數傳回編號的第一值及最後值
  
SELECT @第一值 AS 第一值, @最後值 AS 最後值
