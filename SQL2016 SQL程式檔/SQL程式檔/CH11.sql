USE �m��11

GO
����-- P11-3a

SELECT  �U����, �Ȥ�W��, �a�}
FROM    �q��, �Ȥ�
WHERE   �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��

GO
����-- P11-3b

CREATE VIEW �U��O��
AS 
SELECT  �U����, �Ȥ�W��, �a�}
FROM    �q��, �Ȥ�
WHERE   �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��

GO
����-- P11-4

SELECT * FROM �U��O��

GO
����-- P11-11

CREATE VIEW �U��O��_VIEW_1
AS 
SELECT  �U����, �Ȥ�W��, �a�}
FROM    �q��, �Ȥ�
WHERE   �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��
GO

SELECT * FROM �U��O��_VIEW_1

GO
����-- P11-12

CREATE VIEW �U��O��_VIEW_2 (���, �U��Ȥ�, �Ȥ�a�})
AS 
SELECT  �U����, �Ȥ�W��, �a�}
FROM    �q��, �Ȥ�
WHERE   �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��
GO

SELECT * FROM �U��O��_VIEW_2

GO
����-- P11-12b

CREATE VIEW �Ȥ��p���q��
WITH ENCRYPTION
AS 
SELECT �Ȥ�W��, �p���H, �q��
FROM �Ȥ�

GO
����-- P11-13

USE �m��11
SELECT * FROM sys.syscomments

GO
����-- P11-14

CREATE VIEW �U��O��_VIEW
WITH SCHEMABINDING
AS 
SELECT  �U����, �Ȥ�W��, �a�}
FROM    dbo.�q��, dbo.�Ȥ�
WHERE   �q��.�Ȥ�s�� = �Ȥ�.�Ȥ�s��

GO
����-- P11-15a

CREATE VIEW CheckOption
AS 
SELECT * 
FROM  ���y
WHERE  ���� > 400 AND ���� < 600
WITH CHECK OPTION
GO

SELECT * FROM CheckOption 

GO
����-- P11-15b

UPDATE CheckOption
SET ���� = 350 
WHERE ���y�s�� = 3

GO
����-- P11-16a

CREATE VIEW �Ȥ��p���q��
WITH ENCRYPTION
AS 
SELECT �Ȥ�W��, �p���H, �q��
FROM �Ȥ�

GO
����-- P11-16b

ALTER VIEW �Ȥ��p���q�� (�Ȥ�, �p���H�m�W, �p���q��)
AS
SELECT �Ȥ�W��, �p���H, �q��
FROM �Ȥ�

GO
����-- P11-17a

CREATE VIEW VIEW_CheckOption
AS 
SELECT * 
FROM  ���y
WHERE  ���� > 400 AND ���� < 600
WITH CHECK OPTION 

GO
����-- P11-17b

ALTER VIEW VIEW_CheckOption 
AS 
SELECT * 
FROM ���y
WHERE ���� > 300
WITH CHECK OPTION

GO
����-- P11-17c

CREATE VIEW �����ѥ[�H���W��
AS
SELECT �m�W, �a�} FROM ���u
UNION
SELECT �p���H, �a�} FROM �Ȥ�

GO
����-- P11-19a

DELETE �Ȥ��p���q��
WHERE �Ȥ� = '�ѤѮѧ�'

GO
����-- P11-19b

INSERT �Ȥ��p���q�� (�Ȥ�, �p���H�m�W, �p���q��)
VALUES ( '���Z�ѧ�', '�����W', '0272114517')

GO
����-- P11-21

DROP VIEW �Ȥ��p���q��, �U��O��_VIEW_1