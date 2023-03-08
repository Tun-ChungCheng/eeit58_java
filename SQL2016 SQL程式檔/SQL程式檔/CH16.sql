���� -- ������Ʈw
USE �m��16

GO 
���� -- P16-7

CREATE TRIGGER �q�沧�ʳq�� 
ON �q��T1 
AFTER INSERT, UPDATE 
AS 
PRINT '�S���q�沧�ʤF�I' 
GO 

CREATE TRIGGER �q��R���q�� 
ON �q��T1 
AFTER DELETE 
AS 
PRINT '�S���q��Q�R���F�I' 
GO 

INSERT �q��T1 (���, �Ȥ�s��)  
VALUES ('2016/1/1', 3)

DELETE �q��T1                  
WHERE ��� = '2016/1/1'

GO 
���� -- P16-9a

EXEC sp_helptrigger '�q��T1', 'DELETE'

GO 
���� -- P16-9b

EXEC sp_help �q��R���q��

GO 
���� -- P16-10

EXEC sp_helptext �q��R���q�� 

GO 
���� -- P16-11

EXEC sp_rename '�q��R���q��', '�q��R���q��new'

GO 
���� -- P16-12

EXEC sp_helptext �q��R���q��new

GO 
���� -- P16-13

DISABLE TRIGGER �q�沧�ʳq��   -- ����Ĳ�o�{��
ON dbo.�q��T1
GO

ENABLE TRIGGER ALL   -- �ҥΡi�q��T1�j��ƪ��Ҧ���Ĳ�o�{��
ON dbo.�q��T1

GO 
���� -- P16-16

CREATE TRIGGER ���ղ��ʵ��� 
ON �Ȥ�T1
FOR DELETE, INSERT, UPDATE 
AS 
PRINT '���ʤF ' + CAST(@@ROWCOUNT AS VARCHAR) + ' ����ơI'
ROLLBACK
GO

INSERT �Ȥ�T1 (�Ȥ�W��, �a�})  
VALUES ('���p�Y', '�s�˥����s��')
GO
DELETE �Ȥ�T1                  
WHERE �Ȥ�s�� < 5
GO
DELETE �Ȥ�T1                  
WHERE �Ȥ�s�� >200

GO 
���� -- P16-18a

INSERT �Ȥ�T1 (�Ȥ�W��, �a�})
VALUES ('���p�Y', '�s�˥����s��')

DELETE �Ȥ�T1
WHERE �Ȥ�s�� < 5


GO 
���� -- P16-18b

CREATE TRIGGER �ˬd�ƶq�O�_��� 
ON �q��T2
AFTER UPDATE, INSERT  
AS 
IF UPDATE(�ƶq)
   PRINT '�ƶq��w���I' 
ELSE
   PRINT '�ƶq��S�����I' 
ROLLBACK
GO

UPDATE  �q��T2
SET �ƶq =5
WHERE �q��s�� = 10
GO
UPDATE  �q��T2
SET �O�_�I�� = 1
WHERE �q��s�� = 11

GO 
���� -- P16-19

INSERT  �q��T2 (���, �Ȥ�s��)
VALUES ('2016/11/30', 5)

GO 
���� -- P16-20

CREATE TRIGGER �����\�ק���
ON �q��T2
AFTER UPDATE
AS
IF UPDATE(���)
BEGIN
   PRINT '���i�ק����I' 
   ROLLBACK
END
GO

GO 
���� -- P16-22

   RAISERROR('����H������ק����I', 16, 1) 

GO 
���� -- P16-23

CREATE TRIGGER �ˬd�q�ʼƶq
ON �q��T3
AFTER INSERT
AS 
IF (SELECT �ƶq FROM inserted) > 200
BEGIN 
   PRINT '�ƶq���o�j�� 200�I'
   ROLLBACK
END
GO

INSERT  �q��T3 (���, �Ȥ�s��, �ƶq)
VALUES ('2016/11/30', 5, 201)

GO 
���� -- P16-24a

INSERT INTO �q��T3
(���, �Ȥ�s��, �ƶq, �O�_�I��)
SELECT ���, �Ȥ�s��, �ƶq, �O�_�I��
FROM �q��T2

GO 
���� -- P16-24b

-- ��אּ�ϥ� MAX() �Ӭd�̤߳j�ƶq
ALTER TRIGGER �ˬd�q�ʼƶq
ON �q��T3
AFTER INSERT
AS 
IF (SELECT MAX(�ƶq) FROM inserted) > 200
BEGIN 
   PRINT '�ƶq���o�j�� 200�I'
   ROLLBACK
END

GO 
���� -- P16-25a

CREATE TRIGGER �ˬd�q�ʼƶq��� 
ON �q��T3
AFTER UPDATE 
AS 
IF (SELECT MAX(�ƶq) FROM inserted) > 200 
BEGIN 
   PRINT '�ƶq��藍�o�j�� 200�I' 
   ROLLBACK
END 
GO

UPDATE �q��T3
SET �ƶq = �ƶq + 30

GO 
���� -- P16-25b

CREATE TRIGGER �ˬd�q�ʼƶq�ܤ�
ON �q��T3
AFTER UPDATE 
AS 
IF (SELECT MAX(ABS(�s.�ƶq - ��.�ƶq)) 
    FROM inserted AS �s JOIN deleted AS �� 
         ON �s.�q��s�� = ��.�q��s��) > 50 
BEGIN 
   PRINT '�ƶq�ܤƤ��o�j�� 50�I' 
   ROLLBACK
END 
GO

UPDATE �q��T3
SET �ƶq = �ƶq / 2 

GO 
���� -- P16-26

CREATE TRIGGER �ˬd�ƶq�Τ�� 
ON �q��T3
AFTER UPDATE 
AS 
IF UPDATE(�ƶq)
BEGIN 
   IF (SELECT MAX(�ƶq) FROM inserted) > 200 
   BEGIN 
      PRINT '�ƶq���o�j�� 200�I' 
      ROLLBACK TRANSACTION 
      RETURN 
   END 
END
IF UPDATE(���) 
BEGIN 
   IF (SELECT MIN(���) FROM inserted) < '2016/1/1' 
   BEGIN 
      PRINT '������o���� 2016/1/1�I' 
      ROLLBACK TRANSACTION 
   END 
END 
GO
UPDATE �q��T3
SET ���=  '2015/12/1' 
WHERE �q��s�� = 3

GO 
���� -- P16-27

CREATE TRIGGER �ˬd�R���ƶq�Τ��
ON dbo.�q��T3
AFTER DELETE 
AS 
IF (SELECT SUM(�ƶq) FROM deleted) > 300
BEGIN 
   ROLLBACK
   RAISERROR('�C���R�����q�f�`�ƶq���o�j��300�I', 16, 1) 
END
ELSE IF (SELECT MIN(���) FROM deleted) < '2016/7/1' 
BEGIN 
   ROLLBACK
   RAISERROR('2012/7/1 ���e���q�椣�o�R���I', 16, 1) 
END
GO

DELETE �q��T3
WHERE �ƶq > 100 
GO
PRINT '-------------------------' 
DELETE �q��T3
WHERE ��� < '2016/7/5' 

GO 
���� -- P16-28

CREATE TRIGGER �q�沧�ʶl�H�q��
ON �q��T4
AFTER INSERT, UPDATE, DELETE 
AS 
EXEC msdb.dbo.sp_send_dbmail
     @recipients = 'ken@flag.com.tw',
     @body = '�q���ƳQ���F�I',
     @subject = '��Ʈw���ʳq��'

GO 
���� -- P16-29

CREATE TRIGGER �ˬd�W�U�� 
ON �q��T5
FOR INSERT, UPDATE 
AS 
IF @@ROWCOUNT = 0 RETURN 
IF UPDATE(�ƶq) 
BEGIN 
   IF EXISTS (SELECT A.* 
              FROM inserted A 
                JOIN �Ȥ�T5 B ON A.�Ȥ�s�� = B.�Ȥ�s�� 
                JOIN �Ȥ�H���B��T5 C ON B.�H�ε��� = C.�H�ε��� 
              WHERE A.�ƶq NOT BETWEEN C.�U�� AND C.�W��) 
   BEGIN 
      ROLLBACK TRANSACTION 
      RAISERROR('�q�ʼƶq���ŦX�Ȥ᪺�H�ε���', 16, 1) 
   END
END
GO
INSERT �q��T5 (���, �Ȥ�s��, �ƶq)
VALUES ( GETDATE(), 5, 201)

GO 
���� -- P16-30

CREATE TRIGGER �O���~��ק� 
ON ���uT1 
AFTER UPDATE 
AS 
IF @@ROWCOUNT = 0 RETURN 
IF UPDATE(�~��) 
BEGIN 
   INSERT ���u�O�� (���ʤ��, ���u�s��, �~��) 
   SELECT GETDATE(), ���u�s��, �~��
   FROM deleted 
END

GO 
���� -- P16-31a

EXEC sp_settriggerorder '�O���~��ק�', 'First', 'UPDATE'

GO 
���� -- P16-31b

EXEC sp_configure 'nested triggers', 0

GO 

���� -- P16-34

CREATE TRIGGER �B�z�s�W�����u���
ON ���uT2 
INSTEAD OF INSERT 
AS 
   SET NOCOUNT ON   -- ���n��� '(�v�T ? �Ӹ�ƦC)' �T��

   -- ��s�w�s�b��i���uT2�j�������
   UPDATE ���uT2
   SET ���uT2.�m�W = inserted.�m�W, 
          ���uT2.�~��= inserted.�~��
   FROM ���uT2 JOIN inserted 
              ON ���uT2.���u�s�� = inserted.���u�s��
   PRINT '���w�s�b����� ' + CAST(@@ROWCOUNT AS VARCHAR) + ' ��'

   -- ���J���s�b��i���uT2�j�����s��� 
   INSERT ���uT2
   SELECT *
   FROM inserted
   WHERE  inserted.���u�s�� NOT IN
                   ( SELECT ���u�s�� FROM ���uT2  )
   PRINT '�[�J�s����� ' + CAST(@@ROWCOUNT AS VARCHAR) + ' ��'
GO

GO 
���� -- P16-35

INSERT ���uT2
SELECT * FROM ���uT1

GO 
���� -- P16-36

CREATE TRIGGER ��ܷs�W�Χ�諸��� 
ON ���uT2 
AFTER INSERT, UPDATE
AS
   IF EXISTS (SELECT  ���u�s�� FROM deleted)
      PRINT '-----UPDATE-----'
   ELSE
      PRINT '-----INSERT-----'
   SELECT *
   FROM inserted
GO

INSERT  ���uT2 (���u�s��, �m�W, �~��)
VALUES (1, '������ ', 32000)

GO 
���� -- P16-37a

CREATE VIEW ���u�C��
AS
SELECT ���u�s��, �m�W + '' + ¾�� AS ���u�W��
FROM ���uT1
GO

GO 
���� -- P16-37b

CREATE TRIGGER �B�z�s�W���u
ON ���u�C��
INSTEAD OF INSERT
AS
	SET NOCOUNT ON
    INSERT  ���uT1 (�m�W, ¾��)
    SELECT LEFT( ���u�W��, CHARINDEX(' ', ���u�W��) -1 ),
           RIGHT( ���u�W��, LEN( ���u�W��) - CHARINDEX(' ', ���u�W��) )
    FROM inserted
GO

INSERT ���u�C�� (���u�s��, ���u�W��)
VALUES (9999,  '���p�� �D��')

GO 
���� -- P16-38

CREATE TRIGGER �B�z�����u
ON ���u�C��
INSTEAD OF UPDATE
AS
	SET NOCOUNT ON
    UPDATE  ���uT1
    SET �m�W  = LEFT( inserted.���u�W��, 
                             CHARINDEX(' ', inserted.���u�W��) -1 ),
            ¾�� = RIGHT( inserted.���u�W��, 
                             LEN( inserted.���u�W��) - CHARINDEX(' ', inserted.���u�W��) )
    FROM inserted 
    WHERE  inserted.���u�s�� = ���uT1.���u�s��
GO

UPDATE ���u�C��
SET ���u�W�� = '������ ���`'
WHERE ���u�s�� = 1  

GO 
���� -- P16-40

CREATE TRIGGER �B�z�s�W�q��
ON �˵��q��
INSTEAD OF INSERT
AS
SET NOCOUNT ON

-- ���n�ɷs�W�Ȥ���, 
INSERT �Ȥ�T6 (�Ȥ�W��)
SELECT �Ȥ�W��
FROM inserted
WHERE  inserted.�Ȥ�s�� NOT IN ( SELECT �Ȥ�s�� FROM �Ȥ�T6  )

-- �s�W�q����
IF @@ROWCOUNT = 0   -- �p�G�S���s�W�Ȥ�
    INSERT �q��T6 (���, �Ȥ�s��, �ƶq, �O�_�I��)
    SELECT ���, �Ȥ�s��, �ƶq, �O�_�I��
    FROM inserted
ELSE                                   -- �_�h�H�s���Ȥ�s���ӧ�s�q��
    INSERT �q��T6 (���, �Ȥ�s��, �ƶq, �O�_�I��)
    SELECT ���, �Ȥ�T6.�Ȥ�s��, �ƶq, �O�_�I��
    FROM inserted JOIN �Ȥ�T6 ON inserted.�Ȥ�W�� =�Ȥ�T6.�Ȥ�W��
GO

INSERT �˵��q�� (�Ȥ�s��, �Ȥ�W��, �q��s��, ���, �ƶq, �O�_�I��)
VALUES(9999, '�v�v�q�c��', 9999, '2016/12/30', 130, 0)
INSERT �˵��q�� (�Ȥ�s��, �Ȥ�W��, �q��s��, ���, �ƶq, �O�_�I��)
VALUES(3, 'XXXXX', 9999, '2016/12/30', 130, 0)
GO
SELECT * FROM �q��T6

GO 
���� -- P16-41

CREATE TRIGGER �B�z�R���q��
ON �˵��q��
INSTEAD OF DELETE
AS
SET NOCOUNT ON
DELETE �q��T6
WHERE �q��T6.�q��s�� IN (SELECT �q��s�� FROM deleted)
GO

DELETE �˵��q��
WHERE �q��s�� = 6
GO
SELECT * FROM �q��T6

