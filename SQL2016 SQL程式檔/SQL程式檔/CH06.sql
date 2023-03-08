GO
●● -- P6-6

CREATE DATABASE 藏經閣

GO 
●● -- P6-13a

CREATE DATABASE 產品資料庫
ON
(  NAME = 產品資料庫,
   FILENAME = 'C:\SQLTEST\產品資料庫.MDF' ) 

GO 
●● -- P6-13b

CREATE DATABASE 機密產品資料庫
ON 
( NAME = 機密產品資料_1,
   FILENAME = 'C:\SQLTEST\機密產品資料_1.MDF',
   SIZE = 10MB,
   MAXSIZE = 50MB,
   FILEGROWTH = 5 )

GO 
●● -- P6-13C

CREATE DATABASE 銷售資料庫
ON PRIMARY
( NAME = 銷售資料檔_1,
   FILENAME = 'C:\SQLTEST\銷售資料檔_1.MDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 15% ) ,
( NAME = 銷售資料檔_2,
   FILENAME = 'C:\SQLTEST\銷售資料檔_2.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 15% ) ,
FILEGROUP 銷售資料庫檔案群_1
( NAME = 銷售資料庫檔案群_1_檔案_1,
   FILENAME = 'C:\SQLTEST\銷售資料庫檔案群_1_檔案_1.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 ) ,
( NAME = 銷售資料庫檔案群_1_檔案_2,
   FILENAME = 'C:\SQLTEST\銷售資料庫檔案群_1_檔案_2.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 ) ,
FILEGROUP 銷售資料庫檔案群_2
( NAME = 銷售資料庫檔案群_2_檔案_1,
   FILENAME = 'C:\SQLTEST\銷售資料庫檔案群_2_檔案_1.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 ) ,
( NAME = 銷售資料庫檔案群_2_檔案_2,
   FILENAME = 'C:\SQLTEST\銷售資料庫檔案群_2_檔案_2.NDF',
   SIZE = 5, MAXSIZE = 10, FILEGROWTH = 5 )

GO 
●● -- P6-15

SELECT * 
FROM ::fn_helpcollations() 

GO 
●● -- P6-17a

EXEC sp_configure filestream_access_level, 2
RECONFIGURE

GO 
●● -- P6-17b

CREATE DATABASE 文件庫 
ON
PRIMARY 
    (NAME = 文件庫, FILENAME = 'C:\SQLTEST\文件庫.mdf'),
FILEGROUP fs_group CONTAINS FILESTREAM   -- 這是 FILESTREAM 檔案群組
	(NAME = fs, FILENAME = 'C:\SQLTEST\fs')
LOG ON 
	(NAME = 文件庫_log, FILENAME = 'C:\SQLTEST\文件庫.ldf')


GO 
●● -- P6-22

EXEC sp_detach_db '訂單資料庫'

GO 
●● -- P6-25a

CREATE DATABASE 產品資料庫
ON PRIMARY
(FILENAME = 'C:\SQLTEST\產品資料庫.MDF')
FOR ATTACH

GO 
●● -- P6-25b

EXEC sp_attach_db 產品資料庫, 
         'C:\SQLTEST\產品資料庫.MDF'

GO 
●● -- P6-32

ALTER DATABASE 文件庫         
ADD FILEGROUP fs_group2          --新增一個 FILESTREAM 群組
    CONTAINS FILESTREAM

ALTER DATABASE 文件庫
ADD FILE                         -- 新增 FILESTREAM 路徑           
(NAME= 'fs2', FILENAME = 'C:\SQLTEST\fs2')
    TO FILEGROUP fs_group2           -- 並指定所屬的群組

GO 
●● -- P6-33

-- 1. 將資料庫離線 (也可在資料庫上按右鈕執行『【工作/離線工作】』命令)
ALTER DATABASE 文件庫 SET OFFLINE

-- 2. 手動將 C:\SQLTEST\文件庫.mdf 
--      搬移到 C:\SQLTEST2 並更名為 文件庫02.mdf

-- 3. 更改路徑/檔名
ALTER database 文件庫
MODIFY FILE
(NAME = 文件庫, FILENAME = 'C:\SQLTEST2\文件庫02.mdf')

-- 4. 將資料庫連線 (也可在資料庫上按右鈕執行『【工作/線上工作】』命令)
ALTER DATABASE 文件庫 SET ONLINE

GO 
●● -- P6-34

USE 文件庫
exec sp_helpfile

GO 
●● -- P6-35a

ALTER DATABASE 藏經閣
MODIFY NAME = NEWAAA

GO 
●● -- P6-35b

EXEC sp_renamedb 'NEWAAA', '藏經閣'

GO 
●● -- P6-36a

ALTER DATABASE 銷售資料庫
MODIFY FILEGROUP 銷售資料庫檔案群_2 DEFAULT

GO 
●● -- P6-36b

ALTER DATABASE 銷售資料庫
ADD LOG FILE 
( NAME = 銷售日誌_2,
   FILENAME = 'C:\SQLTEST\銷售日誌_2.LDF',
   MAXSIZE = 100 MB )

GO 
●● -- P6-38

DROP DATABASE 藏經閣, 訂單資料庫

GO 
●● -- P6-39

EXEC sp_helpdb

