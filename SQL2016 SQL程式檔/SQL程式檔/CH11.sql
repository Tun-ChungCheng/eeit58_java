USE 練習11

GO
●●-- P11-3a

SELECT  下單日期, 客戶名稱, 地址
FROM    訂單, 客戶
WHERE   訂單.客戶編號 = 客戶.客戶編號

GO
●●-- P11-3b

CREATE VIEW 下單記錄
AS 
SELECT  下單日期, 客戶名稱, 地址
FROM    訂單, 客戶
WHERE   訂單.客戶編號 = 客戶.客戶編號

GO
●●-- P11-4

SELECT * FROM 下單記錄

GO
●●-- P11-11

CREATE VIEW 下單記錄_VIEW_1
AS 
SELECT  下單日期, 客戶名稱, 地址
FROM    訂單, 客戶
WHERE   訂單.客戶編號 = 客戶.客戶編號
GO

SELECT * FROM 下單記錄_VIEW_1

GO
●●-- P11-12

CREATE VIEW 下單記錄_VIEW_2 (日期, 下單客戶, 客戶地址)
AS 
SELECT  下單日期, 客戶名稱, 地址
FROM    訂單, 客戶
WHERE   訂單.客戶編號 = 客戶.客戶編號
GO

SELECT * FROM 下單記錄_VIEW_2

GO
●●-- P11-12b

CREATE VIEW 客戶聯絡電話
WITH ENCRYPTION
AS 
SELECT 客戶名稱, 聯絡人, 電話
FROM 客戶

GO
●●-- P11-13

USE 練習11
SELECT * FROM sys.syscomments

GO
●●-- P11-14

CREATE VIEW 下單記錄_VIEW
WITH SCHEMABINDING
AS 
SELECT  下單日期, 客戶名稱, 地址
FROM    dbo.訂單, dbo.客戶
WHERE   訂單.客戶編號 = 客戶.客戶編號

GO
●●-- P11-15a

CREATE VIEW CheckOption
AS 
SELECT * 
FROM  書籍
WHERE  價格 > 400 AND 價格 < 600
WITH CHECK OPTION
GO

SELECT * FROM CheckOption 

GO
●●-- P11-15b

UPDATE CheckOption
SET 價格 = 350 
WHERE 書籍編號 = 3

GO
●●-- P11-16a

CREATE VIEW 客戶聯絡電話
WITH ENCRYPTION
AS 
SELECT 客戶名稱, 聯絡人, 電話
FROM 客戶

GO
●●-- P11-16b

ALTER VIEW 客戶聯絡電話 (客戶, 聯絡人姓名, 聯絡電話)
AS
SELECT 客戶名稱, 聯絡人, 電話
FROM 客戶

GO
●●-- P11-17a

CREATE VIEW VIEW_CheckOption
AS 
SELECT * 
FROM  書籍
WHERE  價格 > 400 AND 價格 < 600
WITH CHECK OPTION 

GO
●●-- P11-17b

ALTER VIEW VIEW_CheckOption 
AS 
SELECT * 
FROM 書籍
WHERE 價格 > 300
WITH CHECK OPTION

GO
●●-- P11-17c

CREATE VIEW 尾牙參加人員名單
AS
SELECT 姓名, 地址 FROM 員工
UNION
SELECT 聯絡人, 地址 FROM 客戶

GO
●●-- P11-19a

DELETE 客戶聯絡電話
WHERE 客戶 = '天天書局'

GO
●●-- P11-19b

INSERT 客戶聯絡電話 (客戶, 聯絡人姓名, 聯絡電話)
VALUES ( '企鵝書局', '陳佑淵', '0272114517')

GO
●●-- P11-21

DROP VIEW 客戶聯絡電話, 下單記錄_VIEW_1