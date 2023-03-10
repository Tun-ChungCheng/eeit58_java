〈〈 -- ち传戈畐
USE 絤策18

GO
〈〈 -- P18-2

BEGIN TRAN                     -- 秨﹍ユ 
    UPDATE 珇恨瞶 
    SET 计秖 = 计秖 + 1 
    WHERE 场 = '穨叭场' AND 珇 = '快そ' 

    IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
        GOTO NeedRollBack 

    UPDATE 珇恨瞶 
    SET 计秖 = 计秖 - 1 
    WHERE 场 = '癩叭场' AND 珇 = '快そ' 

NeedRollBack: 
IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
    ROLLBACK TRAN       -- 確ユ 
ELSE 
    COMMIT TRAN           -- 絋粄ユ

SELECT * FROM 珇恨瞶 
WHERE 珇 = '快そ' 

GO
〈〈 -- P18-8

UPDATE 珇恨瞶
SET 计秖 = 计秖 - 10

GO
〈〈 -- P18-10

CREATE PROC TestTRAN 
AS BEGIN TRAN 
     SELECT 膟嘿 
     FROM 膟 
     ROLLBACK 
GO 

BEGIN TRAN 
EXEC TestTRAN 
ROLLBACK 

GO
〈〈 -- P18-12a

ALTER PROC TestTRAN 
AS BEGIN TRAN 
     SELECT 膟嘿 
     FROM 膟 
     COMMIT 
GO 

BEGIN TRAN 
EXEC TestTRAN 
ROLLBACK 

GO
〈〈 -- P18-12b

CREATE PROC 珇锣簿 
@珇 varchar(20), 
@ㄓ方场 varchar(20), 
@ヘ场 varchar(20), 
@计秖 int 
AS 
BEGIN TRAN 
    UPDATE 珇恨瞶 
    SET 计秖 = 计秖 + @计秖 
    WHERE 场 = @ヘ场 AND 珇 = @珇 
    IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
        GOTO NeedRollBack 

    UPDATE 珇恨瞶 
    SET 计秖 = 计秖 - @计秖 
    WHERE 场 = @ㄓ方场 AND 珇 = @珇 
 
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
〈〈 -- P18-14

DECLARE @ret int 
BEGIN TRAN 
    EXEC @ret = 珇锣簿 '穦某','穨叭场','ネ玻场',2 

    IF @ret = 0  
        EXEC @ret = 珇锣簿 '快そ','癩叭场','穨叭场',2 

    IF @ret = 0 
        COMMIT TRAN  
    ELSE 
        ROLLBACK TRAN  

GO
〈〈 -- P18-21

SET XACT_ABORT ON
BEGIN DISTRIBUTED TRAN 
    INSERT め (め嘿, 羛蹈) 
    VALUES ('弄┍', '朝') 
    IF @@ERROR <> 0 GOTO ERRORPROC 

    INSERT FLAG2.絤策18.dbo.め (め嘿, 羛蹈) 
    VALUES ('弄┍', '朝') 

ERRORPROC: 
    IF @@ERROR <> 0 
        ROLLBACK 
    ELSE 
        COMMIT TRAN  

GO
〈〈 -- P18-26

CREATE PROC GetAvgPriceDiff 
AS 
DECLARE @avg1 money, @avg2 money 
 
SELECT @avg1 = AVG(基) 
  FROM 篨篨そ 
  WHERE 玻珇嘿 IN ('Windows ㄏノも', 'Linux 琜龟叭') 
SELECT @avg2 = AVG(基) 
  FROM 夹夹そ 
  WHERE 玻珇嘿 IN ('Windows ㄏノも', 'Linux 琜龟叭') 
PRINT 'キА基篨篨='+CAST(@avg1 AS VARCHAR) 
                           +' 夹夹='+CAST(@avg2 AS VARCHAR) 
 
RETURN @avg1 - @avg2 
GO 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
SET NOCOUNT ON 
DECLARE @diff money 

BEGIN TRAN 
EXEC @diff = GetAvgPriceDiff 
 
UPDATE 篨篨そ 
  SET 基 = 基 - (@diff/2) 
  WHERE 玻珇嘿 IN ('Windows ㄏノも', 'Linux 琜龟叭') 
UPDATE 夹夹そ 
  SET 基 = 基 + (@diff/2) 
  WHERE 玻珇嘿 IN ('Windows ㄏノも', 'Linux 琜龟叭') 
IF @@ERROR <> 0 
    ROLLBACK 
ELSE 
    BEGIN 
        EXEC @diff = GetAvgPriceDiff 
        COMMIT 
    END 
GO 

