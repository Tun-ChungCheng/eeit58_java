●● -- 切換資料庫
USE 練習18

GO
●● -- P18-2

BEGIN TRAN                     -- 開始交易 
    UPDATE 物品管理 
    SET 數量 = 數量 + 1 
    WHERE 部門 = '業務部' AND 物品 = '辦公桌' 

    IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
        GOTO NeedRollBack 

    UPDATE 物品管理 
    SET 數量 = 數量 - 1 
    WHERE 部門 = '財務部' AND 物品 = '辦公桌' 

NeedRollBack: 
IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
    ROLLBACK TRAN       -- 取消並回復交易 
ELSE 
    COMMIT TRAN           -- 確認交易

SELECT * FROM 物品管理 
WHERE 物品 = '辦公桌' 

GO
●● -- P18-8

UPDATE 物品管理
SET 數量 = 數量 - 10

GO
●● -- P18-10

CREATE PROC TestTRAN 
AS BEGIN TRAN 
     SELECT 書籍名稱 
     FROM 書籍 
     ROLLBACK 
GO 

BEGIN TRAN 
EXEC TestTRAN 
ROLLBACK 

GO
●● -- P18-12a

ALTER PROC TestTRAN 
AS BEGIN TRAN 
     SELECT 書籍名稱 
     FROM 書籍 
     COMMIT 
GO 

BEGIN TRAN 
EXEC TestTRAN 
ROLLBACK 

GO
●● -- P18-12b

CREATE PROC 物品轉移 
@物品 varchar(20), 
@來源部門 varchar(20), 
@目的部門 varchar(20), 
@數量 int 
AS 
BEGIN TRAN 
    UPDATE 物品管理 
    SET 數量 = 數量 + @數量 
    WHERE 部門 = @目的部門 AND 物品 = @物品 
    IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
        GOTO NeedRollBack 

    UPDATE 物品管理 
    SET 數量 = 數量 - @數量 
    WHERE 部門 = @來源部門 AND 物品 = @物品 
 
NeedRollBack: 
IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
    BEGIN 
        IF @@TRANCOUNT = 1  
            ROLLBACK TRAN  
        ELSE 
            COMMIT TRAN  
        RETURN 1 
    END 
ELSE 
    BEGIN 
        COMMIT TRAN 
        RETURN 0 
    END 

GO
●● -- P18-14

DECLARE @ret int 
BEGIN TRAN 
    EXEC @ret = 物品轉移 '會議桌','業務部','生產部',2 

    IF @ret = 0  
        EXEC @ret = 物品轉移 '辦公桌','財務部','業務部',2 

    IF @ret = 0 
        COMMIT TRAN  
    ELSE 
        ROLLBACK TRAN  

GO
●● -- P18-21

SET XACT_ABORT ON
BEGIN DISTRIBUTED TRAN 
    INSERT 客戶 (客戶名稱, 聯絡人) 
    VALUES ('好讀書店', '陳大大') 
    IF @@ERROR <> 0 GOTO ERRORPROC 

    INSERT FLAG2.練習18.dbo.客戶 (客戶名稱, 聯絡人) 
    VALUES ('好讀書店', '陳大大') 

ERRORPROC: 
    IF @@ERROR <> 0 
        ROLLBACK 
    ELSE 
        COMMIT TRAN  

GO
●● -- P18-26

CREATE PROC GetAvgPriceDiff 
AS 
DECLARE @avg1 money, @avg2 money 
 
SELECT @avg1 = AVG(價格) 
  FROM 旗旗公司 
  WHERE 產品名稱 IN ('Windows 使用手冊', 'Linux 架站實務') 
SELECT @avg2 = AVG(價格) 
  FROM 標標公司 
  WHERE 產品名稱 IN ('Windows 使用手冊', 'Linux 架站實務') 
PRINT '平均價格：旗旗='+CAST(@avg1 AS VARCHAR) 
                           +' 標標='+CAST(@avg2 AS VARCHAR) 
 
RETURN @avg1 - @avg2 
GO 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
SET NOCOUNT ON 
DECLARE @diff money 

BEGIN TRAN 
EXEC @diff = GetAvgPriceDiff 
 
UPDATE 旗旗公司 
  SET 價格 = 價格 - (@diff/2) 
  WHERE 產品名稱 IN ('Windows 使用手冊', 'Linux 架站實務') 
UPDATE 標標公司 
  SET 價格 = 價格 + (@diff/2) 
  WHERE 產品名稱 IN ('Windows 使用手冊', 'Linux 架站實務') 
IF @@ERROR <> 0 
    ROLLBACK 
ELSE 
    BEGIN 
        EXEC @diff = GetAvgPriceDiff 
        COMMIT 
    END 
GO 

