USE �m��BB

GO
����-- PB-2a

CREATE TABLE ���u�~��
(
 �s�� int IDENTITY PRIMARY KEY, 
 �~�� smallmoney,
 CHECK (�~�� > 0 AND �~�� <= 50000)
)

GO
����--PB-2b

CREATE TABLE �g�P��
(
 �s�� int IDENTITY PRIMARY KEY,
 �m�W char(20) NOT NULL,
 �a�} char(50),
 �q�� char(13),
 CHECK (�a�} IS NOT NULL OR �q�� IS NOT NULL)
)

GO
����-- PB-4a

CREATE RULE Price_rule
AS @price >= 1 AND @price <= 50000 

GO
����-- PB-4b

CREATE RULE charset_rule 
AS @charset LIKE 'F0[1-9][1-9]-[A-E]_'

GO
����-- PB-4c

CREATE RULE Gender_rule
AS @gender IN ('�k', '�k') 

GO
����-- PB-5a

CREATE RULE payday_rule
AS @payday >= getdate()

GO
����-- PB-5b

EXEC sp_bindrule Gender_rule, '���u.�ʧO'

GO
����-- PB-6

EXEC sp_unbindrule '���u.�ʧO'

GO
����-- PB-8

DROP RULE Price_rule, Gender_rule

GO
����-- PB-9a

CREATE DEFAULT �ʧO_df
AS '�k' 

GO
����-- PB-9b

CREATE DEFAULT �a�I_df
AS '�x�W'

GO
����-- PB-10

EXEC sp_bindefault �ʧO_df, '���u.�ʧO'

GO
����-- PB-10

EXEC sp_unbindefault '���u.�ʧO'

GO
����-- PB-12

DROP DEFAULT �a�I_df

GO
����-- PB-14a

CREATE TYPE Phone
FROM char(12) 
NOT NULL

GO
����-- PB-14b

CREATE TYPE PayDay
FROM date
NULL

GO
����-- PB-16a

DROP TYPE Phone

GO
����-- PB-16b

DROP TYPE PayDay 

GO
����-- PB-16c

CREATE TYPE MyBook AS TABLE   -- �����ϥ� AS �Ӥ��O FROM
(���y�s�� int PRIMARY KEY, 
 ���y�W�� varchar(50))
GO

DECLARE @mybook MyBook  -- �H�y�ϥΪ̩w�q��ƪ������z�ŧi table �ܼ�

INSERT @mybook                
SELECT ���y�s��, ���y�W��
FROM ���y

SELECT * FROM @mybook 

