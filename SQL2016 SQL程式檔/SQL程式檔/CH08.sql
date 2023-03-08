USE 練習08

GO
●●-- P8-12

INSERT 圖書室借用記錄 ( 員工編號, 書名, 數量, 附註 )
VALUES ( 3, 'Windows 架站實務', 1, '寫作參考用' )

INSERT 圖書室借用記錄 ( 員工編號, 書名 )
VALUES ( 5, 'Linux 技術手冊' ),
       ( 8, 'ASP.NET 程式語言' )

SELECT * FROM 圖書室借用記錄

GO
●●-- P8-14

SET IDENTITY_INSERT 圖書室借用記錄 ON
INSERT 圖書室借用記錄 ( 編號, 員工編號, 書名 ) 
VALUES ( 0, 5, 'Word 手冊')
SET IDENTITY_INSERT 圖書室借用記錄 OFF
SELECT *  FROM 圖書室借用記錄


GO
●●-- P8-16

INSERT  圖書室借用記錄  ( 員工編號, 書名 )
SELECT   3, 書籍名稱
FROM    書籍
WHERE   書籍編號 < 4

SELECT * 
FROM 圖書室借用記錄

GO
●●-- P8-17

CREATE TABLE #HELPDB
   ( 名稱          nvarchar(24) ,
     空間大小  nvarchar(13) ,
     擁有者      varchar(24) ,
     DBID           smallint ,
     建立日期  smalldatetime ,
     狀態          text ,
     相容性層級  tinyint )

INSERT #HELPDB 
   EXEC sp_helpdb

SELECT * FROM #HELPDB

GO
●●-- P8-18

SELECT  書名, 數量, 歸還日期
FROM    圖書室借用記錄
WHERE   員工編號 = 2

GO
●●-- P8-19

SELECT  書名, 數量, 歸還日期, 電話
FROM    圖書室借用記錄, 員工
WHERE   姓名 = '劉天王' 
        AND 圖書室借用記錄.員工編號 = 員工.編號

GO
●●-- P8-20

SELECT  書名, 數量, 歸還日期, 電話 AS 借用者電話
FROM    圖書室借用記錄 AS A, 員工 AS B
WHERE   姓名 = '劉天王' 
        AND A.員工編號 = B.編號 

GO
●●-- P8-21

SELECT   姓名 AS 借閱者, 書名, 數量 AS 本數
INTO     借閱清單
FROM     圖書室借用記錄, 員工
WHERE    圖書室借用記錄.員工編號 = 員工.編號

SELECT * FROM 借閱清單

GO
●●-- P8-22

SELECT  * 
INTO    聯絡名冊 
FROM    員工
WHERE  1 = 0 

SELECT * FROM 員工
GO
SELECT * FROM 聯絡名冊

GO
●●-- P8-23

SELECT * FROM 圖書室借用記錄

GO
●●-- P8-24

UPDATE  圖書室借用記錄
SET     員工編號 = 6 , 
        附註 = NULL 
WHERE   員工編號 = 3

SELECT * FROM 圖書室借用記錄

GO
●●-- P8-25a

UPDATE  圖書室借用記錄
SET     數量 = 數量 + 5 ,
        附註 = '業務人員借閱'
WHERE   員工編號 = 6

GO
●●-- P8-25b

UPDATE  圖書室借用記錄
SET     附註 = '借書人為' + 員工.姓名   
FROM    員工                            
WHERE   圖書室借用記錄.員工編號 = 員工.編號


GO
●●-- P8-27

DELETE 圖書室借用記錄
WHERE  書名 = 'Word 手冊'

SELECT * FROM 圖書室借用記錄

GO
●●-- P8-28a

DELETE  圖書室借用記錄
FROM    員工
WHERE   圖書室借用記錄.員工編號 = 員工.編號
        AND 員工.姓名 = '楊咩咩'

SELECT * 
FROM 圖書室借用記錄

GO
●●-- P8-28b

TRUNCATE TABLE  圖書室借用記錄

GO
●●-- P8-29

INSERT 圖書室借用記錄 ( 員工編號, 書名 )
VALUES ( 3, 'Linux 技術手冊' )

UPDATE 圖書室借用記錄 
SET 歸還日期 = '2016/10/28'
WHERE 員工編號 < 5

GO
●●-- P8-30

INSERT 圖書室借用記錄 ( 員工編號, 書名 )
OUTPUT INSERTED.*
VALUES ( '12', 'SQL 語法辭典' ),
       ( '25', 'Windows 使用手冊' ),
       ( '13', 'Linux 架站實務'),
       ( '12', 'VB 程式設計')

GO
●●-- P8-31a

UPDATE 圖書室借用記錄 
SET 書名 = 'C# 程式設計'
OUTPUT DELETED.編號, DELETED.書名 舊書名, INSERTED.書名 新書名
WHERE 編號 = 5

GO
●●-- P8-31b

DELETE 圖書室借用記錄
OUTPUT DELETED.*
WHERE 編號 = 3

GO
●●-- P8-32a

CREATE TABLE #OUTPUT_TB
   ( 編號  int IDENTITY,
     員工編號 int, 
     書名  nvarchar(16)
   )

GO
●●-- P8-32b

UPDATE 圖書室借用記錄
SET 員工編號 = '57'
OUTPUT INSERTED.編號, INSERTED.員工編號, INSERTED.書名 
   INTO #OUTPUT_TB (編號, 員工編號, 書名)
WHERE 員工編號 = '12'

SELECT * FROM #OUTPUT_TB
