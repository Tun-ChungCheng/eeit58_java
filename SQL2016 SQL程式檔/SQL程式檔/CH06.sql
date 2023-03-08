GO
���� -- P6-6

CREATE DATABASE �øg��

GO 
���� -- P6-13a

CREATE DATABASE ���~��Ʈw
ON
(  NAME = ���~��Ʈw,
   FILENAME = 'C:\SQLTEST\���~��Ʈw.MDF' ) 

GO 
���� -- P6-13b

CREATE DATABASE ���K���~��Ʈw
ON 
( NAME = ���K���~���_1,
   FILENAME = 'C:\SQLTEST\���K���~���_1.MDF',
   SIZE = 10MB,
   MAXSIZE = 50MB,
   FILEGROWTH = 5 )

GO 
���� -- P6-13C

CREATE DATABASE �P���Ʈw
ON PRIMARY
( NAME = �P������_1,
   FILENAME = 'C:\SQLTEST\�P������_1.MDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 15% ) ,
( NAME = �P������_2,
   FILENAME = 'C:\SQLTEST\�P������_2.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 15% ) ,
FILEGROUP �P���Ʈw�ɮ׸s_1
( NAME = �P���Ʈw�ɮ׸s_1_�ɮ�_1,
   FILENAME = 'C:\SQLTEST\�P���Ʈw�ɮ׸s_1_�ɮ�_1.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 ) ,
( NAME = �P���Ʈw�ɮ׸s_1_�ɮ�_2,
   FILENAME = 'C:\SQLTEST\�P���Ʈw�ɮ׸s_1_�ɮ�_2.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 ) ,
FILEGROUP �P���Ʈw�ɮ׸s_2
( NAME = �P���Ʈw�ɮ׸s_2_�ɮ�_1,
   FILENAME = 'C:\SQLTEST\�P���Ʈw�ɮ׸s_2_�ɮ�_1.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 ) ,
( NAME = �P���Ʈw�ɮ׸s_2_�ɮ�_2,
   FILENAME = 'C:\SQLTEST\�P���Ʈw�ɮ׸s_2_�ɮ�_2.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 )

GO 
���� -- P6-15

SELECT * 
FROM ::fn_helpcollations() 

GO 
���� -- P6-17a

EXEC sp_configure filestream_access_level, 2
RECONFIGURE

GO 
���� -- P6-17b

CREATE DATABASE ���w 
ON
PRIMARY 
    (NAME = ���w, FILENAME = 'C:\SQLTEST\���w.mdf'),
FILEGROUP fs_group CONTAINS FILESTREAM   -- �o�O FILESTREAM �ɮ׸s��
	(NAME = fs, FILENAME = 'C:\SQLTEST\fs')
LOG ON 
	(NAME = ���w_log, FILENAME = 'C:\SQLTEST\���w.ldf')


GO 
���� -- P6-22

EXEC sp_detach_db '�q���Ʈw'

GO 
���� -- P6-25a

CREATE DATABASE ���~��Ʈw
ON PRIMARY
(FILENAME = 'C:\SQLTEST\���~��Ʈw.MDF')
FOR ATTACH

GO 
���� -- P6-25b

EXEC sp_attach_db ���~��Ʈw, 
         'C:\SQLTEST\���~��Ʈw.MDF'

GO 
���� -- P6-32

ALTER DATABASE ���w         
ADD FILEGROUP fs_group2          --�s�W�@�� FILESTREAM �s��
    CONTAINS FILESTREAM

ALTER DATABASE ���w
ADD FILE                         -- �s�W FILESTREAM ���|           
(NAME= 'fs2', FILENAME = 'C:\SQLTEST\fs2')
    TO FILEGROUP fs_group2           -- �ë��w���ݪ��s��

GO 
���� -- P6-33

-- 1. �N��Ʈw���u (�]�i�b��Ʈw�W���k�s����y�i�u�@/���u�u�@�j�z�R�O)
ALTER DATABASE ���w SET OFFLINE

-- 2. ��ʱN C:\SQLTEST\���w.mdf 
--      �h���� C:\SQLTEST2 �ç�W�� ���w02.mdf

-- 3. �����|/�ɦW
ALTER database ���w
MODIFY FILE
(NAME = ���w, FILENAME = 'C:\SQLTEST2\���w02.mdf')

-- 4. �N��Ʈw�s�u (�]�i�b��Ʈw�W���k�s����y�i�u�@/�u�W�u�@�j�z�R�O)
ALTER DATABASE ���w SET ONLINE

GO 
���� -- P6-34

USE ���w
exec sp_helpfile

GO 
���� -- P6-35a

ALTER DATABASE �øg��
MODIFY NAME = NEWAAA

GO 
���� -- P6-35b

EXEC sp_renamedb 'NEWAAA', '�øg��'

GO 
���� -- P6-36a

ALTER DATABASE �P���Ʈw
MODIFY FILEGROUP �P���Ʈw�ɮ׸s_2 DEFAULT

GO 
���� -- P6-36b

ALTER DATABASE �P���Ʈw
ADD LOG FILE 
( NAME = �P���x_2,
   FILENAME = 'C:\SQLTEST\�P���x_2.LDF',
   MAXSIZE = 100 MB )

GO 
���� -- P6-38

DROP DATABASE �øg��, �q���Ʈw

GO 
���� -- P6-39

EXEC sp_helpdb

