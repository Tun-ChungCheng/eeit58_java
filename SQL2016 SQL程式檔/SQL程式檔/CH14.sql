●● -- 切換資料庫
USE 練習14

GO 
●● -- P14-5

EXEC sp_configure 'show advanced options', 1
RECONFIGURE
EXEC sp_configure 'xp_cmdshell', 1
RECONFIGURE

GO 
●● -- P14-6a

EXEC master..xp_cmdshell 'DIR C:\TEMP'

GO 
●● -- P14-6b

USE master
EXEC xp_cmdshell 'DIR C:\TEMP'

USE 練習14 -- 切換回原來的資料庫

GO 
●●-- P14-9a

CREATE PROCEDURE MyProc1
AS SELECT * FROM 標標公司 WHERE 價格 > 400
GO 
EXEC MyProc1

GO 
●● -- P14-9b

CREATE PROCEDURE MyProc2 
@param1 char(10), @param2 money 
WITH ENCRYPTION 
AS INSERT 標標公司 (產品名稱, 價格) 
     VALUES (@param1, @param2) 
GO 
EXEC MyProc2 '組合語言', 520
GO
SELECT * 
FROM 標標公司 

GO 
●● -- P14-10

/* MyProc3 預存程序 */ 
CREATE PROCEDURE MyProc3 
@param1 char(10), @param2 money, @param3 money OUTPUT 
AS INSERT 標標公司 (產品名稱, 價格) 
     VALUES (@param1, @param2) 
     SELECT @param3 = SUM(價格)
     FROM 標標公司 
GO 

/* MyProc4 預存程序 */ 
CREATE PROCEDURE MyProc4 
@param1 money 
AS PRINT '目前的總價為: ' + CONVERT(varchar, @param1) 
GO 

DECLARE @sum money 
EXEC MyProc3 'MATHLAB 手冊',320,@sum OUTPUT

EXEC MyProc4 @sum 

GO 
●● -- P14-11a

CREATE PROCEDURE 取得客戶地址 
@客戶編號 int, 
@地址 varchar(100) OUTPUT 
AS SELECT @地址 = 地址 
     FROM 客戶 
     WHERE 客戶編號 = @客戶編號 
IF @@rowcount > 0 
     RETURN 0   /* 如果查詢到則傳回 0 */ 
ELSE 
     RETURN 1   /* 沒有查到就傳回 1 */ 
GO 
DECLARE @ret int, @地址 varchar(100) 
EXEC @ret = 取得客戶地址 4, @地址 OUTPUT  /* 用 @ret 接收傳回值 */ 
IF @ret = 0 
     PRINT @地址 
ELSE 
     PRINT '找不到！' 

GO 
●● -- P14-11b

/* 建立 MyProc5 預存程序群組的第 1 個程序 */ 
CREATE PROCEDURE MyProc5;1 
AS SELECT * 
     FROM 旗旗公司 
GO

/* 建立 MyProc5 預存程序群組的第 2 個程序 */ 
CREATE PROCEDURE MyProc5;2 
AS 
SELECT * 
     FROM 標標公司 
GO 
MyProc5;1
EXEC MyProc5;2

GO 
●● -- P14-14

CREATE PROCEDURE MyProc6 
AS SELECT 產品名稱, 價格
     FROM 標標公司
     WHERE 產品名稱 LIKE '%SQL%'

GO 
●● -- P14-16

ALTER PROCEDURE MyProc2
AS SELECT * 
   FROM 標標公司 

GO 
●● -- P14-21

CREATE PROCEDURE test 
@a int, 
@b int = NULL, 
@c int = 3 
AS 
SELECT @a, @b, @c 
GO 

EXEC test     /* 錯誤, 第一個參數不可省 */ 
GO 
EXEC test 1  /* OK, 第 2、3 參數用預設值 */ 
GO 
EXEC test 1, DEFAULT      /* OK, 可用 DEFAULT 表示使用預設值 */ 
GO
EXEC test 1, DEFAULT, 5  /* OK */ 
GO 
EXEC test 1, 2, 5                 /* OK */ 
GO 

GO 
●● -- P14-22a

EXEC test @c = 5, @b = DEFAULT, @a = 1

GO 
●● -- P14-22b

EXEC test 1, @c = 2
GO
EXEC test @c = 2, 1
GO
EXEC test @c = 5

GO 
●● -- P14-23

CREATE PROCEDURE TestRetVal 
@TableName varchar(30) OUTPUT 
AS 
DECLARE @sqlstr varchar(100) 
SET @sqlstr = 'SELECT * FROM ' + @TableName 
EXEC (@sqlstr)     /* 執行字串中的 SQL 敘述 */ 
IF @@ERROR = 0 
     BEGIN 
          SET @TableName = 'Hello' 
          RETURN 0 
     END 
ELSE 
     RETURN 1
GO
 
DECLARE @ret int, @name varchar(30) 
SET @name = '旗旗公司' 
EXEC @ret = TestRetVal @name OUTPUT 
PRINT @name + ', RETURN = ' + CAST(@ret AS CHAR) 

GO 
●● -- P14-24

CREATE PROCEDURE testWithResultSet     -- 建立預存程序
AS SELECT * FROM 旗旗公司
GO

EXEC testWithResultSet

EXEC testWithResultSet
WITH RESULT SETS
( (產品 nvarchar(20), 
   價格 int)
)

GO 
●● -- P14-26

CREATE PROCEDURE testWithResultSet2     -- 建立預存程序
AS SELECT * FROM 旗旗公司
   SELECT * FROM 標標公司
GO

EXEC testWithResultSet2
WITH RESULT SETS
( (旗旗產品 nvarchar(20), 價格 int),
  (標標產品 nvarchar(20), 價格 int)
)

GO 
●● -- P14-27

SELECT * 
FROM 客戶 
WHERE 聯絡人 = NULL

GO 
●● -- P14-29a

CREATE PROCEDURE #tempproc 
AS PRINT 'Test' 
GO 
EXEC #tempproc 

GO 
●● -- P14-29b

CREATE PROCEDURE proc3 
AS PRINT 'Proc3: at level ' + CAST(@@NESTLEVEL AS CHAR) 
GO 
CREATE PROCEDURE proc2 
AS PRINT 'Proc2 start: at level ' + CAST(@@NESTLEVEL AS CHAR) 
EXEC proc3 
PRINT 'Proc2 end: at level ' + CAST(@@NESTLEVEL AS CHAR) 
GO 
CREATE PROCEDURE proc1 
AS PRINT 'Proc1 start: at level ' + CAST(@@NESTLEVEL AS CHAR) 
EXEC proc2 
PRINT 'Proc1 end: at level ' + CAST(@@NESTLEVEL AS CHAR) 
GO 

EXEC proc1 

GO 
●● -- P14-31

CREATE PROC TestRPC
AS
SELECT * FROM 旗旗公司

GO 
●● -- P14-32

EXEC FLAG2.練習12.dbo.TestRPC


GO 
●● -- P14-33

CREATE TYPE IntTableType AS TABLE 
(名稱 VARCHAR(20), 數值 INT )
GO

CREATE PROC 找出最大者
@title varchar(30), @tab IntTableType READONLY
AS
DECLARE @maxv INT

SELECT @maxv = MAX(數值) FROM @tab

SELECT @title 說明, 名稱 最大者, @maxv 數量
FROM @tab
WHERE 數值 = @maxv
GO

GO 
●● -- P14-34

DECLARE @tab IntTableType

INSERT @tab
SELECT 客戶名稱, sum(數量)
FROM 出貨記錄
GROUP BY 客戶名稱

EXEC 找出最大者 '出貨量最大的客戶', @tab

DELETE @tab

INSERT @tab
SELECT 股票名稱, sum(購買張數)
FROM 股票交易記錄
GROUP BY 股票名稱

EXEC 找出最大者 '庫存最多的股票', @tab
GO