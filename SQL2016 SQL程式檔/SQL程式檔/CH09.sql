USE  練習09

GO
●●-- P9-4a

SELECT * 
FROM 書籍 

GO
●●-- P9-4b

SELECT 書籍名稱, CAST(價格 * 0.8 AS numeric(4, 0) )  AS  折扣價
FROM 書籍 

GO
●●-- P9-5a

SELECT '大家好' , 3+5 , LOWER('ABC')

GO
●●-- P9-5b

SELECT 出版公司 
FROM  書籍 

GO
●●-- P9-6a

SELECT DISTINCT 出版公司
FROM 書籍 

GO
●●-- P9-6b

SELECT TOP 2 * 
FROM 書籍

GO
●●-- P9-7a

SELECT TOP 30 PERCENT * 
FROM 書籍

GO
●●-- P9-7b

SELECT TOP 3*
FROM  書籍
ORDER BY 價格

GO
●●-- P9-8

SELECT TOP 3   WITH TIES *
FROM 書籍
ORDER BY 價格

GO
●●-- P9-10a

SELECT IDENTITYCOL, ROWGUIDCOL 
FROM 書籍 

GO
●●-- P9-10b

SELECT 書籍名稱 AS 電腦書籍名稱 
FROM 書籍 

GO
●●-- P9-11

SELECT 客.客戶名稱, 客.聯絡人, 數量, 書名
FROM   客戶 AS 客 JOIN 出貨記錄 AS 出
       ON 客.客戶名稱 = 出.客戶名稱

GO
●●-- P9-12

SELECT 企劃書籍.編號, 名稱, 價錢
FROM   企劃書籍 JOIN 企劃書籍預定價
       ON 企劃書籍.編號 = 企劃書籍預定價.編號 

GO
●●-- P9-13             

SELECT 企劃書籍.編號, 名稱, 價錢
FROM  企劃書籍, 企劃書籍預定價
WHERE 企劃書籍.編號 = 企劃書籍預定價.編號
 

GO
●●-- P9-14a

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 , 
             標.產品名稱 AS 標標公司產品名稱, 標.價格 
FROM    旗旗公司 AS 旗  JOIN  標標公司 AS 標 
             ON  旗.產品名稱 = 標.產品名稱

GO
●●-- P9-14b

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 , 
             標.產品名稱 AS 標標公司產品名稱, 標.價格
FROM   旗旗公司 AS 旗  LEFT JOIN  標標公司 AS 標 
             ON  旗.產品名稱 = 標.產品名稱

GO
●●-- P9-15a

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 ,
             標.產品名稱 AS 標標公司產品名稱, 標.價格 
FROM    旗旗公司 AS 旗  RIGHT JOIN  標標公司 AS 標
            ON  旗.產品名稱 = 標.產品名稱

GO
●●-- P9-15b

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 , 
             標.產品名稱 AS 標標公司產品名稱, 標.價格 
FROM   旗旗公司 AS 旗  FULL JOIN  標標公司 AS 標 
            ON 旗.產品名稱 = 標.產品名稱 

GO
●●-- P9-15c

SELECT 旗.產品名稱 AS 旗旗公司產品名稱, 旗.價格 ,
             標.產品名稱 AS 標標公司產品名稱, 標.價格 
FROM   旗旗公司 AS 旗  CROSS JOIN  標標公司 AS 標 

GO
●●-- P9-17a

SELECT 員工.姓名, 員工.職位, 
             長官.姓名 AS 主管
FROM    員工  LEFT JOIN  員工 AS 長官
             ON  員工.主管編號 = 長官.編號

GO
●●-- P9-17b

SELECT  *
FROM    員工
WHERE   性別 = '女' 

GO
●●-- P9-19a

SELECT  客戶名稱, SUM(數量) AS 出貨數量 
FROM     出貨記錄
GROUP BY  客戶名稱 

GO
●●-- P9-19b

SELECT 客戶名稱 , 
              DATEPART(MONTH, 日期) AS 月份 ,
              SUM(數量) AS 出貨數量
FROM   出貨記錄
GROUP BY 客戶名稱, DATEPART(MONTH, 日期)
ORDER BY 客戶名稱, DATEPART(MONTH, 日期)

GO
●●-- P9-20

SELECT  客戶名稱, 書名, SUM(數量) AS 總數量 
FROM     出貨記錄 
GROUP BY  CUBE (書名, 客戶名稱)

GO
●●-- P9-21a

SELECT 客戶名稱, 書名, SUM(數量) AS 總數量 
FROM  出貨記錄
GROUP BY ROLLUP(客戶名稱, 書名)

GO
●●-- P9-21b

SELECT  客戶名稱, 書名, SUM(數量) AS 總數量 
FROM    出貨記錄
GROUP BY ROLLUP(書名, 客戶名稱) 

GO
●●-- P9-23a

SELECT   客戶名稱, 書名, SUM(數量) AS 總數量 
FROM      出貨記錄
GROUP BY  客戶名稱, 書名 
HAVING SUM(數量) >= 6 

GO
●●-- P9-23b

SELECT  客戶名稱, 書名, COUNT(*) AS 次數 
FROM     出貨記錄
GROUP BY  客戶名稱, 書名 
HAVING COUNT(*) > 1 

GO
●●-- P9-25a

SELECT * 
FROM   出貨記錄 
ORDER BY  客戶名稱 DESC,  數量 ASC 

GO
●●-- P9-25b

SELECT *
FROM 出貨記錄
ORDER BY 客戶名稱 DESC, 數量 ASC
OFFSET 3 ROWS

GO
●●-- P9-26

SELECT *
FROM 出貨記錄
ORDER BY 客戶名稱 DESC, 數量 ASC
OFFSET 3 ROWS FETCH NEXT 4 ROWS ONLY