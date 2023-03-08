���� -- ������Ʈw
USE �m��18

GO
���� -- P18-2

BEGIN TRAN                     -- �}�l��� 
    UPDATE ���~�޲z 
    SET �ƶq = �ƶq + 1 
    WHERE ���� = '�~�ȳ�' AND ���~ = '�줽��' 

    IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
        GOTO NeedRollBack 

    UPDATE ���~�޲z 
    SET �ƶq = �ƶq - 1 
    WHERE ���� = '�]�ȳ�' AND ���~ = '�줽��' 

NeedRollBack: 
IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
    ROLLBACK TRAN       -- �����æ^�_��� 
ELSE 
    COMMIT TRAN           -- �T�{���

SELECT * FROM ���~�޲z 
WHERE ���~ = '�줽��' 

GO
���� -- P18-8

UPDATE ���~�޲z
SET �ƶq = �ƶq - 10

GO
���� -- P18-10

CREATE PROC TestTRAN 
AS BEGIN TRAN 
     SELECT ���y�W�� 
     FROM ���y 
     ROLLBACK 
GO 

BEGIN TRAN 
EXEC TestTRAN 
ROLLBACK 

GO
���� -- P18-12a

ALTER PROC TestTRAN 
AS BEGIN TRAN 
     SELECT ���y�W�� 
     FROM ���y 
     COMMIT 
GO 

BEGIN TRAN 
EXEC TestTRAN 
ROLLBACK 

GO
���� -- P18-12b

CREATE PROC ���~�ಾ 
@���~ varchar(20), 
@�ӷ����� varchar(20), 
@�ت����� varchar(20), 
@�ƶq int 
AS 
BEGIN TRAN 
    UPDATE ���~�޲z 
    SET �ƶq = �ƶq + @�ƶq 
    WHERE ���� = @�ت����� AND ���~ = @���~ 
    IF @@ERROR > 0 OR @@ROWCOUNT <> 1 
        GOTO NeedRollBack 

    UPDATE ���~�޲z 
    SET �ƶq = �ƶq - @�ƶq 
    WHERE ���� = @�ӷ����� AND ���~ = @���~ 
 
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
���� -- P18-14

DECLARE @ret int 
BEGIN TRAN 
    EXEC @ret = ���~�ಾ '�|ĳ��','�~�ȳ�','�Ͳ���',2 

    IF @ret = 0  
        EXEC @ret = ���~�ಾ '�줽��','�]�ȳ�','�~�ȳ�',2 

    IF @ret = 0 
        COMMIT TRAN  
    ELSE 
        ROLLBACK TRAN  

GO
���� -- P18-21

SET XACT_ABORT ON
BEGIN DISTRIBUTED TRAN 
    INSERT �Ȥ� (�Ȥ�W��, �p���H) 
    VALUES ('�nŪ�ѩ�', '���j�j') 
    IF @@ERROR <> 0 GOTO ERRORPROC 

    INSERT FLAG2.�m��18.dbo.�Ȥ� (�Ȥ�W��, �p���H) 
    VALUES ('�nŪ�ѩ�', '���j�j') 

ERRORPROC: 
    IF @@ERROR <> 0 
        ROLLBACK 
    ELSE 
        COMMIT TRAN  

GO
���� -- P18-26

CREATE PROC GetAvgPriceDiff 
AS 
DECLARE @avg1 money, @avg2 money 
 
SELECT @avg1 = AVG(����) 
  FROM �X�X���q 
  WHERE ���~�W�� IN ('Windows �ϥΤ�U', 'Linux �[�����') 
SELECT @avg2 = AVG(����) 
  FROM �мФ��q 
  WHERE ���~�W�� IN ('Windows �ϥΤ�U', 'Linux �[�����') 
PRINT '��������G�X�X='+CAST(@avg1 AS VARCHAR) 
                           +' �м�='+CAST(@avg2 AS VARCHAR) 
 
RETURN @avg1 - @avg2 
GO 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
SET NOCOUNT ON 
DECLARE @diff money 

BEGIN TRAN 
EXEC @diff = GetAvgPriceDiff 
 
UPDATE �X�X���q 
  SET ���� = ���� - (@diff/2) 
  WHERE ���~�W�� IN ('Windows �ϥΤ�U', 'Linux �[�����') 
UPDATE �мФ��q 
  SET ���� = ���� + (@diff/2) 
  WHERE ���~�W�� IN ('Windows �ϥΤ�U', 'Linux �[�����') 
IF @@ERROR <> 0 
    ROLLBACK 
ELSE 
    BEGIN 
        EXEC @diff = GetAvgPriceDiff 
        COMMIT 
    END 
GO 

