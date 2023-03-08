
���� -- ������Ʈw
USE �m��07

GO 
���� -- P7-40

CREATE TABLE �Ϯw
( �ϰ�s�� int IDENTITY (1001, 1),              -- �� 100 �}�l�۰ʽs��
  ����s�� uniqueidentifier DEFAULT NEWID() ROWGUIDCOL,  -- GUID ���
  �ɦW     nvarchar(20) NOT NULL,                   -- ���i�� NULL
  ���ɤ�   date DEFAULT CONVERT(date, GETDATE())    -- �w�]������
)

GO 
���� -- P7-41a

INSERT �Ϯw (�ɦW) VALUES ('Flag01.jpg')
SELECT * FROM �Ϯw

GO 
���� -- P7-41b

SELECT $ROWGUID
FROM �Ϯw
WHERE  $IDENTITY = 1001

GO 
���� -- P7-42a

CREATE DATABASE �m��fs     -- �Х��إ� C:\data ��Ƨ�
ON
PRIMARY
  (NAME = �m��fs, FILENAME = 'C:\data\�m��fs.mdf'),
FILEGROUP fs_group1 
  CONTAINS FILESTREAM
	(NAME = fs1, FILENAME = 'C:\data\fs1')
LOG ON 
	(NAME = �m��fs_log, FILENAME = 'C:\data\�m��fs.ldf')

GO 
���� -- P7-42b

CREATE TABLE �m��fs.dbo.���
( �s�� uniqueidentifier DEFAULT NEWID() 
					    ROWGUIDCOL NOT NULL UNIQUE,
  �ɦW nvarchar(20) NOT NULL,
  ���e varbinary(max) FILESTREAM NULL  
)

INSERT �m��fs.dbo.��� (�ɦW, ���e) 
VALUES ('Doc01.txt', CONVERT(varbinary(max), '�����x�s'))

SELECt CONVERT(varchar(max), ���e) 
FROM �m��fs.dbo.���

GO 
���� -- P7-43

SELECT �ɦW, ���e.PathName()
FROM �m��fs.dbo.���

GO 
���� -- P7-45

CREATE TABLE �q��01
  ( �q��s��  int PRIMARY KEY,
    �U����  date, 
    �Ȥ�s��  int CONSTRAINT FK_�q��P�Ȥ�01
                      FOREIGN KEY
                      REFERENCES �Ȥ�01 (�Ȥ�s��))

GO 
���� -- P7-47a

CREATE TABLE �Ȥ�02
(  �Ȥ�s��  int IDENTITY PRIMARY KEY,
   �����Ҧr��  char(10)  NOT NULL  UNIQUE,
   �~��  int  CHECK (�~�� > 0)  DEFAULT 25,
   �a�}  varchar(50),
   �q��  varchar(12),
   ���x�s�� int 
         REFERENCES  ���x���� (���x�s��), 
   �q��s�� int NOT NULL,
   
   FOREIGN KEY (���x�s��, �q��s��)
         REFERENCES  ���x�q�� (���x�s��, �q��s��),
   CHECK (�a�} is not null or �q�� is not null)
)

GO 
���� -- P7-47b

EXEC sp_helpconstraint �Ȥ�02


GO 
���� -- P7-48a

CREATE TABLE ����
  ( �s�� int  IDENTITY,
    ��� numeric(5,1),
    �ƶq int,
    �`�� AS ��� * �ƶq
  ) 

GO 
���� -- P7-48b

INSERT ���� VALUES (21.5, 8)
INSERT ���� VALUES (12, 3)
SELECT * FROM ����

GO 
���� -- P7-51

ALTER TABLE �Ȥ�A
   ALTER COLUMN �p���H
            varchar(30) NULL

GO 
���� -- P7-53

ALTER TABLE �Ȥ�A
    ADD
      ���O�s�� int 
         DEFAULT 1 WITH VALUES
         CONSTRAINT FK_���O�s��
         FOREIGN KEY 
              REFERENCES �Ȥ����O(���O�s��) 
         
GO 
���� -- P7-54a

ALTER TABLE �q�ʶ���A
     WITH CHECK ADD
     CONSTRAINT PK_�q�ʶ���A
     PRIMARY KEY (�q��s��, ���ؽs��)

GO 
���� -- P7-54b

ALTER TABLE �q�ʶ���A
    DROP CONSTRAINT PK_�q�ʶ���A

GO 
���� -- P7-54c

ALTER TABLE �q�ʶ���A
    DROP COLUMN �q��s��, ���ؽs��

GO 
���� -- P7-55a

ALTER TABLE �Ȥ�A
    NOCHECK CONSTRAINT FK_���O�s��

GO 
���� -- P7-55b

ALTER TABLE �Ȥ�A
    CHECK CONSTRAINT FK_���O�s��

GO 
���� -- P7-56a

EXEC sp_rename '�q��A', '�q�ʳ�A'

GO 
���� -- P7-56b

EXEC sp_rename '�Ȥ�A.�a�}' , '�q�T�B', 'COLUMN'

GO 
���� -- P7-56c

DROP TABLE ���yA

GO 
���� -- P7-58

CREATE TABLE #�q�� ( �s�� int, �ƶq int ) 

CREATE TABLE ##�Ȥ� ( �s�� int, �m�W char(10) ) 

GO
���� -- P7-61

CREATE TABLE ���yT
(
	���y�s�� INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	���y�W�� VARCHAR(50) NULL,
	���� SMALLMONEY NULL,
	�X�����q CHAR(20) NULL,
	�_�l�ɶ� DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
	����ɶ� DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
   PERIOD FOR SYSTEM_TIME (�_�l�ɶ�,����ɶ�) 
) WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.���yT_History));

GO

���� -- P7-62a

insert into ���yT (���y�W��, ����, �X�����q) values ('Windows �ϥΤ�U', 500, '�X�X�X�����q')
insert into ���yT (���y�W��, ����, �X�����q) values ('Office �ϥΤ�U', 500, '�мХX�����q')
insert into ���yT (���y�W��, ����, �X�����q) values ('Linux �ϥΤ�U', 500, '�X�X�X�����q')

GO
���� -- P7-62b

SELECT * FROM ���yT

GO
���� -- P7-62c

SELECT	*,
	�_�l�ɶ�,
	����ɶ�
  FROM	���yT

GO

���� -- P7-63a

SELECT * FROM ���yT_History

GO

���� -- P7-63b

UPDATE ���yT SET ���� = 600 WHERE ���y�s�� = 3

SELECT	*, �_�l�ɶ�, ����ɶ� FROM ���yT

SELECT * FROM ���yT_History

GO
���� -- P7-64a

Delete ���yT WHERE ���y�s�� = 3

SELECT	*, �_�l�ɶ�, ����ɶ� FROM ���yT

SELECT * FROM ���yT_History

GO
���� -- P7-64b

DROP TABLE ���yT

GO
���� -- P7-65a

ALTER TABLE ���yT
  SET (SYSTEM_VERSIONING = OFF)

DROP TABLE ���yT

DROP TABLE ���yT_History

GO
���� -- P7-65b

CREATE TABLE ���yS
(
	���y�s�� INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	���y�W�� VARCHAR(50) NULL,
	���� SMALLMONEY NULL,
	�X�����q CHAR(20) NULL
)

GO
���� -- P7-66

--�[�J2�� DATETIME2 ���, �ë��w�g�J�t�ήɶ�
ALTER TABLE ���yS
ADD PERIOD FOR SYSTEM_TIME (�_�l�ɶ�,����ɶ�),
�_�l�ɶ� DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
����ɶ� DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN

GO

--�ҥ�SYSTEM_VERSIONING�Ѽ�

ALTER TABLE ���yS
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.���yS_History)) 

GO