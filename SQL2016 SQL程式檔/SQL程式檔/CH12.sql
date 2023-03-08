USE �m��12

GO
����-- P12-6

CREATE TABLE TABLE_1 
( 
ProductID smallint NOT NULL, 
ProductName char(30) UNIQUE,  
Price smallmoney, 
Manufacturer char(30) 
) 

GO
����-- P12-10

CREATE TABLE TABLE_2 
( 
ProductID smallint NOT NULL Primary Key,  
ProductName char(30), 
Price smallmoney, 
Manufacturer char(30) 
) 

GO
����-- P12-22

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
����-- P12-23

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
����-- P12-24a

EXEC sp_helpindex TABLE_4

GO
����-- P12-24b

DROP INDEX Table_4.index_3 

GO
����-- P12-255a

CREATE TABLE MyTable 
( 
ProductID smallint NOT NULL Primary key, 
ProductName char(30) UNIQUE, 
Price smallmoney, 
Manufacturer char(30) 
) 

EXEC sp_helpindex MyTable

GO
����-- P12-25b

DROP INDEX MyTable.PK__MyTable__B40CC6ED0B511B66
DROP INDEX MyTable.UQ__MyTable__DD5A978ABA979F6A

GO
����-- P12-25c

ALTER TABLE MyTable DROP CONSTRAINT PK__MyTable__B40CC6ED62500D63
ALTER TABLE MyTable DROP CONSTRAINT UQ__MyTable__DD5A978ADF45C5FA

GO
����-- P12-26

CREATE UNIQUE NONCLUSTERED INDEX MyIndex_1
ON TABLE_3 (c2)
WITH PAD_INDEX, FILLFACTOR=30, IGNORE_DUP_KEY, DROP_EXISTING

GO
����-- P12-27

DBCC DBREINDEX (�Ȥ�, PK_�Ȥ�, 70) 

GO
����-- P12-28

SELECT �q��  
FROM ���u
WHERE �m�W = '�����P'


GO
����-- P12-31

SELECT �Ȥ�W�� 
FROM �Ȥ�
WHERE ²�n�a�} Like '%���R��%'

GO
����-- P12-36

SET ARITHABORT, CONCAT_NULL_YIELDS_NULL,
    QUOTED_IDENTIFIER, ANSI_NULLS,
    ANSI_PADDING, ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

CREATE VIEW dbo.���~���
WITH SCHEMABINDING     
AS
SELECT �U���� AS ���, ���y�s�� AS �Ѹ�, 
       SUM (�ƶq) AS �C��P��q, COUNT_BIG (*) AS �C��q���
FROM   dbo.�q�� INNER JOIN dbo.�q�ʶ��� 
                            ON �q��.�q��s�� = �q�ʶ���.�q��s��
GROUP BY �U����, ���y�s��
GO

SELECT * FROM ���~���

GO
����-- P12-37

CREATE UNIQUE CLUSTERED INDEX PK_���~��� 
ON ���~��� (���, �Ѹ�)

GO
����-- P12-38

CREATE INDEX IX_�Ѹ�
ON ���~���(�Ѹ�)
INCLUDE (���, �C��P��q)

GO
����-- P12-39

SELECT ���, �Ѹ�, �C��P��q, �C��q��� 
FROM ���~���
WHERE ��� = '2016/9/11' 
ORDER BY ���

GO
����-- P12-40a

SELECT ���, �Ѹ�,  �C��P��q
FROM ���~���
WHERE �Ѹ� = 2

GO
����-- P12-40b

SELECT �U����, SUM(�ƶq) AS �P��q 
FROM    �q�� INNER JOIN �q�ʶ���
ON �q��.�q��s�� = �q�ʶ���.�q��s��
GROUP BY �U����, ���y�s��
ORDER BY �U����

GO
����-- P12-40c

SELECT �U����, SUM(�ƶq) AS �P��q 
FROM    �q�� INNER JOIN �q�ʶ���
ON �q��.�q��s�� = �q�ʶ���.�q��s��
GROUP BY �U����, ���y�s��
ORDER BY ���y�s��

GO
����-- P12-41a

SELECT �U����, SUM(�ƶq) AS �P��q
FROM    �q�� INNER JOIN �q�ʶ��� 
ON �q��.�q��s�� = �q�ʶ���.�q��s��
GROUP BY �U����
ORDER BY �U���� DESC

GO
����-- P12-41b

SELECT �U����, ���y�s��, AVG(�ƶq) AS �q�業���P��q
FROM     �q�� INNER JOIN �q�ʶ��� 
ON �q��.�q��s�� = �q�ʶ���.�q��s��
GROUP BY �U����, ���y�s��
ORDER BY �U����

GO
����-- P12-42

DROP INDEX  ���~���.PK_���~���

GO
����-- P12-46

CREATE INDEX �k�����x�̯���
ON ���x�� (�m�W)
WHERE �ʧO = '�k'


GO
����-- P12-47
SELECT �m�W
FROM ���x��
WHERE �ʧO = '�k'

GO
����-- P12-48

INSERT INTO ���x�� (�m�W,�ʧO)
VALUES ('�k���x��','�k'),
       ('�k���x��','�k'),
       ('�k���x��','�k'),
       ('�k���x��','�k'),
       ('�k���x��','�k')


