USE 練習10

GO
●●-- P10-5a

SELECT 聯絡人 AS 邀請名單, 地址
FROM 合作廠商
UNION
SELECT 聯絡人, 地址
FROM 客戶
ORDER BY 聯絡人

GO
●●-- P10-5b

SELECT 聯絡人 AS 邀請名單, 地址
FROM 合作廠商
UNION ALL
SELECT 聯絡人, 地址
FROM 客戶
ORDER BY 聯絡人

GO
●●-- P10-6

SELECT 聯絡人 AS 邀請名單, 地址
FROM 合作廠商
UNION
SELECT 聯絡人, 地址
FROM 客戶
UNION 
SELECT '王大砲', '台北市南京東路三段34號5樓'
ORDER BY 聯絡人

GO
●●-- P10-7

SELECT 訂單編號, 下單日期, 
       總數量 = (SELECT SUM(數量) 
                 FROM  訂購項目 
                 WHERE 訂單編號 = 訂單.訂單編號)
FROM   訂單

GO
●●-- P10-8

SELECT 產品名稱, 
       百分比 = 價格 * 100 / ( SELECT SUM (價格) FROM 標標公司 ) 
FROM 標標公司

GO
●●-- P10-9a

SELECT 產品名稱, 價格 
FROM    旗旗公司 
WHERE 價格 > ( SELECT MAX(價格) FROM  標標公司 ) 

GO
●●-- P10-9b

SELECT * 
FROM 標標公司 
WHERE 產品名稱 IN ( SELECT 產品名稱 
                    FROM 旗旗公司 ) 

GO
●●-- P10-10a

SELECT 價格 
FROM 標標公司 
WHERE 價格 <= ALL ( SELECT 價格   
                    FROM  旗旗公司 
                    WHERE 價格 > 410)

GO
●●-- P10-10b

SELECT 價格 
FROM 標標公司 
WHERE 價格 <= ANY ( SELECT 價格
                    FROM 旗旗公司 
                    WHERE 價格 > 410 ) 

GO
●●-- P10-11a

SELECT * 
FROM 標標公司 
WHERE EXISTS ( SELECT * 
               FROM 旗旗公司 
               WHERE 產品名稱 = 標標公司.產品名稱
                     AND 價格 > 495) 

GO
●●-- P10-11b

SELECT 標標公司.* 
FROM 標標公司 JOIN 旗旗公司 
          ON 標標公司.產品名稱 = 旗旗公司.產品名稱
WHERE 旗旗公司.價格 > 495

GO
●●-- P10-11c

SELECT * 
FROM 標標公司 
WHERE 產品名稱 IN (SELECT 產品名稱 
                   FROM 旗旗公司 
                   WHERE 價格 > 495)

GO
●●--P10-12a

SELECT *
FROM 標標公司
WHERE 產品名稱 IN (SELECT 產品名稱
                   FROM 旗旗公司)

GO
●●-- P10-12b

SELECT * 
FROM 旗旗公司 
WHERE 產品名稱 IN (SELECT 產品名稱   
                   FROM 標標公司  
                   WHERE 旗旗公司.價格 > 標標公司.價格) 

GO
●●-- P10-35a

UPDATE  書籍
SET 價格 = 400
WHERE 書籍名稱 = 'Windows Server 系統實務'

GOU
●●-- P10-35b

DECLARE @number int
DECLARE @string char(20) 
SET @number = 100
SET @string = '天天書局'
SELECT @number AS 數字, @string AS 字串

GO
●●-- P10-36a

SELECT 書籍名稱, 價格 * 0.75 AS 特惠價
FROM 書籍

GO
●●-- P10-36b

PRINT CAST('2/20/2016' AS DATETIME) - 1 
PRINT CAST('2/20/2016' AS DATETIME) + 3.25 

GO
●●-- P10-37a

SELECT 書籍名稱, 價格
FROM 書籍
WHERE 價格 >= 390

GO
●●-- P10-37b

SELECT 書籍名稱, 價格
FROM 書籍 
WHERE 書籍名稱 = 'AutoCAD 電腦繪圖與圖學'

GO
●●-- P10-38a

SELECT * 
FROM 旗旗公司 
WHERE (價格 > 450 AND 價格 < 500) OR 價格 < 430

GO
●●-- P10-48b

SELECT * 
FROM 旗旗公司 
WHERE 價格 BETWEEN 420 AND 510 

GO
●●--P10-38c

SELECT * 
FROM 標標公司 
WHERE 產品名稱 IN ( 'SQL 指令寶典', 'AutoCAD 教學', 'Linux 手冊' ) 

GO
●●-- P10-39

SELECT * 
FROM 標標公司 
WHERE 產品名稱 LIKE '%SQL%'

GO
●●-- P10-40a

SELECT  * 
FROM  標標公司
WHERE  NOT EXISTS ( SELECT  *  
                    FROM  旗旗公司 
                    WHERE  產品名稱 = 標標公司.產品名稱)

GO
●●-- P10-40b

PRINT 59 & 12 
PRINT 59 | 12 
PRINT 59 ^ 12 

GO
●●-- P10-41a

SELECT 'Linux 架站實務的價格是 ' + CONVERT(varchar, 價格) + ' 元' 
FROM 標標公司 
WHERE 產品名稱 = 'Linux 架站實務' 

GO
●●-- P10-41b

SELECT -價格 
FROM 標標公司 
WHERE 產品名稱 = 'Linux 架站實務' 

GO
●●-- P10-41c

PRINT ~ CAST(1 AS tinyint) 

GO
●●-- P10-42

UPDATE 書籍
SET 價格 += 100 
WHERE 書籍名稱 = 'Windows Server 系統實務'


GO
●●-- P10-43

SET ANSI_NULLS OFF
SELECT * 
FROM 員工 
WHERE 主管編號 = NULL

GO
●●-- P10-44

SELECT 姓名,
       ISNULL(CAST(主管編號 AS VARCHAR), '無') AS 主管
FROM 員工

GO
●●-- P10-45a

SELECT * 
FROM 員工
WHERE 主管編號 IS NULL 

GO
●●-- P10-45b

UPDATE 員工
SET 主管編號 = 0
WHERE 主管編號 IS NULL 

GO
●●-- P10-45c

SELECT *
FROM 員工
WHERE 主管編號 IS NOT NULL

GO
●●-- P10-46

SELECT IIF(性別=0, '女生', '男生') AS 性別, 滿意度, COUNT(*) AS 人數
FROM 問卷
GROUP BY 性別, 滿意度  -- 依性別及滿意度分組計數
ORDER BY 性別, 滿意度

GO
●●-- P10-47a

SELECT IIF(滿意度=3, '滿意', IIF(滿意度=2, '尚可', '差勁')) 評價, COUNT(*) 人數
FROM 問卷
GROUP BY 滿意度  -- 依滿意度分組計數
ORDER BY 滿意度 DESC

GO
●●-- P10-47b

SELECT CHOOSE(滿意度, '差勁', '尚可', '滿意') 評價, COUNT(*) 人數
FROM 問卷
GROUP BY 滿意度  -- 依滿意度分組計數
ORDER BY 滿意度 DESC

GO
●●-- P10-48

SELECT 書籍編號, 書籍名稱, 價格, 出版公司,
       ROW_NUMBER() OVER(ORDER BY 價格) AS 價格排名
FROM 書籍

GO
●●-- P10-49

SELECT 書籍編號, 書籍名稱, 價格, 出版公司,
   RANK() OVER(ORDER BY 價格) AS 價格排名
FROM 書籍

GO
●●-- P10-50a

SELECT 書籍編號, 書籍名稱, 價格, 出版公司,
  DENSE_RANK() OVER(ORDER BY 價格) AS 價格排名
FROM 書籍

GO
●●-- P10-50b

SELECT 書籍編號, 書籍名稱, 價格, 出版公司,
ROW_NUMBER() OVER(ORDER BY 價格) AS 價格排名
FROM 書籍
ORDER BY 價格排名                        -- 使用 ORDER BY...OFFSET...
OFFSET 4 ROWS FETCH NEXT 4 ROWS ONLY     --   指定傳回第 5~8 筆記錄

GO
●●-- P10-51

SELECT 書籍編號, 書籍名稱, 價格, 出版公司,
ROW_NUMBER() OVER(PARTITION BY 出版公司 ORDER BY 價格) AS 價格排名
FROM 書籍

