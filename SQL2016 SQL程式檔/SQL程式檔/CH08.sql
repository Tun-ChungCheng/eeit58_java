USE �m��08

GO
����-- P8-12

INSERT �ϮѫǭɥΰO�� ( ���u�s��, �ѦW, �ƶq, ���� )
VALUES ( 3, 'Windows �[�����', 1, '�g�@�Ѧҥ�' )

INSERT �ϮѫǭɥΰO�� ( ���u�s��, �ѦW )
VALUES ( 5, 'Linux �޳N��U' ),
       ( 8, 'ASP.NET �{���y��' )

SELECT * FROM �ϮѫǭɥΰO��

GO
����-- P8-14

SET IDENTITY_INSERT �ϮѫǭɥΰO�� ON
INSERT �ϮѫǭɥΰO�� ( �s��, ���u�s��, �ѦW ) 
VALUES ( 0, 5, 'Word ��U')
SET IDENTITY_INSERT �ϮѫǭɥΰO�� OFF
SELECT *  FROM �ϮѫǭɥΰO��


GO
����-- P8-16

INSERT  �ϮѫǭɥΰO��  ( ���u�s��, �ѦW )
SELECT   3, ���y�W��
FROM    ���y
WHERE   ���y�s�� < 4

SELECT * 
FROM �ϮѫǭɥΰO��

GO
����-- P8-17

CREATE TABLE #HELPDB
   ( �W��          nvarchar(24) ,
     �Ŷ��j�p  nvarchar(13) ,
     �֦���      varchar(24) ,
     DBID           smallint ,
     �إߤ��  smalldatetime ,
     ���A          text ,
     �ۮe�ʼh��  tinyint )

INSERT #HELPDB 
   EXEC sp_helpdb

SELECT * FROM #HELPDB

GO
����-- P8-18

SELECT  �ѦW, �ƶq, �k�٤��
FROM    �ϮѫǭɥΰO��
WHERE   ���u�s�� = 2

GO
����-- P8-19

SELECT  �ѦW, �ƶq, �k�٤��, �q��
FROM    �ϮѫǭɥΰO��, ���u
WHERE   �m�W = '�B�Ѥ�' 
        AND �ϮѫǭɥΰO��.���u�s�� = ���u.�s��

GO
����-- P8-20

SELECT  �ѦW, �ƶq, �k�٤��, �q�� AS �ɥΪ̹q��
FROM    �ϮѫǭɥΰO�� AS A, ���u AS B
WHERE   �m�W = '�B�Ѥ�' 
        AND A.���u�s�� = B.�s�� 

GO
����-- P8-21

SELECT   �m�W AS �ɾ\��, �ѦW, �ƶq AS ����
INTO     �ɾ\�M��
FROM     �ϮѫǭɥΰO��, ���u
WHERE    �ϮѫǭɥΰO��.���u�s�� = ���u.�s��

SELECT * FROM �ɾ\�M��

GO
����-- P8-22

SELECT  * 
INTO    �p���W�U 
FROM    ���u
WHERE  1 = 0 

SELECT * FROM ���u
GO
SELECT * FROM �p���W�U

GO
����-- P8-23

SELECT * FROM �ϮѫǭɥΰO��

GO
����-- P8-24

UPDATE  �ϮѫǭɥΰO��
SET     ���u�s�� = 6 , 
        ���� = NULL 
WHERE   ���u�s�� = 3

SELECT * FROM �ϮѫǭɥΰO��

GO
����-- P8-25a

UPDATE  �ϮѫǭɥΰO��
SET     �ƶq = �ƶq + 5 ,
        ���� = '�~�ȤH���ɾ\'
WHERE   ���u�s�� = 6

GO
����-- P8-25b

UPDATE  �ϮѫǭɥΰO��
SET     ���� = '�ɮѤH��' + ���u.�m�W   
FROM    ���u                            
WHERE   �ϮѫǭɥΰO��.���u�s�� = ���u.�s��


GO
����-- P8-27

DELETE �ϮѫǭɥΰO��
WHERE  �ѦW = 'Word ��U'

SELECT * FROM �ϮѫǭɥΰO��

GO
����-- P8-28a

DELETE  �ϮѫǭɥΰO��
FROM    ���u
WHERE   �ϮѫǭɥΰO��.���u�s�� = ���u.�s��
        AND ���u.�m�W = '������'

SELECT * 
FROM �ϮѫǭɥΰO��

GO
����-- P8-28b

TRUNCATE TABLE  �ϮѫǭɥΰO��

GO
����-- P8-29

INSERT �ϮѫǭɥΰO�� ( ���u�s��, �ѦW )
VALUES ( 3, 'Linux �޳N��U' )

UPDATE �ϮѫǭɥΰO�� 
SET �k�٤�� = '2016/10/28'
WHERE ���u�s�� < 5

GO
����-- P8-30

INSERT �ϮѫǭɥΰO�� ( ���u�s��, �ѦW )
OUTPUT INSERTED.*
VALUES ( '12', 'SQL �y�k���' ),
       ( '25', 'Windows �ϥΤ�U' ),
       ( '13', 'Linux �[�����'),
       ( '12', 'VB �{���]�p')

GO
����-- P8-31a

UPDATE �ϮѫǭɥΰO�� 
SET �ѦW = 'C# �{���]�p'
OUTPUT DELETED.�s��, DELETED.�ѦW �®ѦW, INSERTED.�ѦW �s�ѦW
WHERE �s�� = 5

GO
����-- P8-31b

DELETE �ϮѫǭɥΰO��
OUTPUT DELETED.*
WHERE �s�� = 3

GO
����-- P8-32a

CREATE TABLE #OUTPUT_TB
   ( �s��  int IDENTITY,
     ���u�s�� int, 
     �ѦW  nvarchar(16)
   )

GO
����-- P8-32b

UPDATE �ϮѫǭɥΰO��
SET ���u�s�� = '57'
OUTPUT INSERTED.�s��, INSERTED.���u�s��, INSERTED.�ѦW 
   INTO #OUTPUT_TB (�s��, ���u�s��, �ѦW)
WHERE ���u�s�� = '12'

SELECT * FROM #OUTPUT_TB
