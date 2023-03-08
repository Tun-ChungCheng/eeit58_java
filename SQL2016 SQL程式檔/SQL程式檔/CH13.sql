USE 練習13

GO 
●● -- P13-2
 
INSERT INTO 員工 (姓名, 性別) 
VALUES ('楊大頭', '男') 
SELECT 員工編號, 姓名, 性別 
FROM 員工 

GO 
●● -- P13-3

USE 練習13
GO
SELECT *
FROM   客戶
SELECT *
FROM   訂單
GO

GO
●● -- P13-5a

/* 這是註解 */            
-- 這也是註解

SELECT *      /* 註解可以在這兒 */
FROM 員工     -- 當然也可以在這裡

GO
●● -- P13-5b

SELECT 客戶編號, 聯絡人 /*, 地址 AS 送貨地址, 電話 */
FROM 客戶
WHERE 客戶編號 > 5 /* AND 聯絡人 LIKE "江*"
ORDER BY 電話 */

/*
UPDATE 訂單細目
SET    數量 = 15
WHERE  訂單序號 = 201
*/

GO
●● -- P13-5c

SELECT 客戶編號, 聯絡人, 地址 AS 送貨地址, 電話 
FROM 客戶
WHERE 客戶編號 > 5  AND 聯絡人 LIKE '江*'
ORDER BY 電話 

UPDATE 訂單細目
SET    數量 = 15
WHERE  訂單序號 = 201

GO  
●● -- P13-7a

DECLARE @customer AS varchar(30) 
DECLARE @counter int, @today datetime

SET @customer = '天天書局' 
SET @counter = 1  
SET @today = getdate() 

SELECT @customer 
SELECT @counter 
SELECT @today 

GO
●● -- P13-7b

DECLARE @customer varchar(30) = '大雄書局',
        @counter  int = 1
SELECT @customer, @counter

GO
●● -- P13-7c

DECLARE @customer varchar(30) 
SELECT @customer = '大雄書局'
  
SELECT @customer 

GO 
●● -- P13-8a 

DECLARE @customer varchar(30) 
SELECT @customer = 客戶名稱  
FROM 客戶 
WHERE 客戶編號 = 4 

SELECT @customer 

GO
●● -- P13-8b

DECLARE @name char(10), @sex char (10) 
SELECT @name = 姓名, @sex = 性別       
FROM 員工 
WHERE 員工編號 = 3
 
SELECT @name AS '名字', @sex 

GO
●● -- P13-9

DECLARE @customer varchar(30)
SELECT @customer = '大雄書局'
GO

SELECT @customer

GO
●● -- P13-10

DECLARE @mybook TABLE ( 書籍編號 int PRIMARY KEY, 書籍名稱 varchar(50) )

INSERT @mybook
SELECT 書籍編號, 書籍名稱
FROM 書籍
WHERE 單價 >= 460

SELECT * FROM @mybook

UPDATE @mybook
SET 書籍名稱 += '(附CD)'

DELETE @mybook
WHERE 書籍編號 = 7

-- 必須使用資料表別名來指示欄位
SELECT m.書籍編號, m.書籍名稱, 單價 
FROM @mybook m JOIN 書籍 
     ON m.書籍編號 = 書籍.書籍編號
GO

SELECT 書籍編號, 書籍名稱
INTO @mybook             -- 語法錯誤！不可用在 INTO 中
FROM 書籍

GO
●● -- P13-13a

IF (SELECT SUM(價格) FROM 標標公司) > 1100 
   PRINT '標標公司共有資產大於 1100 元' 
ELSE 
   PRINT '標標公司共有資產小於 1100 元' 

GO
●● -- P13-13b

DECLARE @avg_price int 
SET @avg_price = (SELECT AVG(單價) FROM 書籍) 
IF @avg_price > 600 
   PRINT '書籍平均價格太高' 
ELSE 
   IF @avg_price > 400  -- 在 ELSE 中的 IF...ELSE 
      PRINT '書籍平均價格適中' 
   ELSE 
      PRINT '書籍平均價格太低' 

GO
●● -- P13-14a

IF 'Windows 使用手冊' IN (SELECT 書籍名稱 FROM 書籍) 
   PRINT '有 Windows 使用手冊' 
ELSE 
   PRINT '無 Windows 使用手冊'

GO
●● -- P13-14b

IF 1000 > ALL (SELECT 單價 FROM 書籍) 
   PRINT '沒有任何書籍超過 1000 元' 

GO
●● -- P13-15a

IF (SELECT 書籍名稱 FROM 書籍 WHERE 書籍編號 = '1001') IS NULL 
   PRINT '1001 的名稱未輸入' 
ELSE 
   PRINT '1001 的名稱已輸入' 

GO
●● -- P13-15b

IF EXISTS (SELECT * FROM 書籍 WHERE 書籍編號 = '1001') 
   PRINT '1001 的名稱已輸入' 
ELSE 
   PRINT '1001 的名稱未輸入'

GO
●● -- P13-16

DECLARE @id int, @name varchar(50), @price int, @count int 
SET @id = 0 
SET @count = 1

WHILE @id < 500 
   BEGIN 
      SET @id = @id + 1 
      SELECT @name = 書籍名稱, @price = 單價
         FROM 書籍 WHERE 書籍編號 = @id
      IF @@ROWCOUNT = 0 /* @@ ROWCOUNT 中會儲存著 */
         BEGIN          /* SELECT 傳回的記錄筆數 */
             PRINT '*** The End ***'
             BREAK 
         END 
      IF @price >= 400 CONTINUE
      PRINT CAST(@price AS CHAR(4)) + ' -- ' +@name
      IF @count % 3 = 0 PRINT '......'
      SET @count = @count + 1
   END

GO
●● -- P13-18

DECLARE @a INT, @answer CHAR(10) 
SET @a = 3 
SET @answer = CASE @a 
   WHEN 1 THEN 'A' 
   WHEN 2 THEN 'B' 
   WHEN 3 THEN 'C' 
   WHEN 4 THEN 'D' 
   ELSE 'OTHERS' 
END 
PRINT 'IS ' + @answer 

GO
●● -- P13-19

SELECT '<' + 
             CASE RIGHT(書籍名稱, 2)   
                WHEN '手冊' THEN '1入門' 
                WHEN '實務' THEN '2實例' 
                WHEN '應用' THEN '3技巧' 
                WHEN '秘笈' THEN '4技術' 
                ELSE '5未分' 
             END + '類>' AS 類別 
            , 書籍名稱 
FROM 書籍 
ORDER BY 類別 

GO
●● -- P13-21

DECLARE @number smallint 
SET @number = 99 
IF (@number % 3) = 0 
   GOTO Three 
ELSE 
   GOTO NotThree 
Three: 
   PRINT '三的倍數' 
   GOTO TheEnd 
NotThree: 
   PRINT '不是三的倍數' 
TheEnd: 

GO
●● -- P13-22

DECLARE @count INT 
SET @count = 0 
WHILE @count < 5  /* 此迴圈最多做 5 次 */
  BEGIN 
	INSERT 員工記錄 (異動日期, 員工編號, 薪資) 
	VALUES ('2012/10/6', 15, 30000) 
	IF @@error = 0 BREAK  /* 如果成功即跳出迴圈 */
	SET @count = @count + 1 
	WAITFOR DELAY '00:00:05'  /* 等待 5 秒 */
  END 

GO
●● -- P13-23a

WAITFOR TIME '23:50'
SELECT * INTO 訂單備份 
FROM 訂單 

GO
●● -- P13-23b

CREATE PROCEDURE CheckOrder AS /* 建立自訂的預存程序 */

IF EXISTS (SELECT * FROM 訂單 WHERE 客戶編號 = 2) 
    RETURN 1                   /* 如果查詢到訂單, 則傳回 1 */
ELSE 
    RETURN 2                   /* 沒有訂單就傳回 2 */
GO 

DECLARE @value int 
EXEC @value = CheckOrder       /* 執行自訂預存程序 */
PRINT @value 

GO
●● -- P13-24

-- 執行系統預存程序, 並指定參數
EXEC sp_helpdb '練習13'

-- 作用同上一個範例, 但使用變數來指定預存程序名稱
DECLARE @pname varchar(30)
SET @pname = 'sp_helpdb'
EXEC @pname '練習13

GO 
●● -- P13-25a

DECLARE @tablename varchar(20)
WHILE 1 = 1
   BEGIN
       SELECT @tablename = 暫存資料表名稱 /* 從 『暫存資料表清單』 資料表
                                          中取得 『暫存資 */ 
       FROM 暫存資料表清單                /* 料表名稱』 欄位內的值, 並且指
                                          定給 @tablename */
       WHERE 建立日期 < getdate() -7
      
       IF @@ROWCOUNT > 0    /* @@ROWCOUNT 儲存著傳回的記錄筆數 */
          BEGIN
             EXEC ('DROP TABLE ' + @tablename)
             DELETE 暫存資料表清單
             WHERE 暫存資料表名稱 = @tablename
          END
       ELSE
          BREAK
   END

GO
●● -- P13-25b

IF (SELECT SUM(數量) FROM 訂單細目 WHERE 書籍編號 = 123) < 100 
    PRINT '訂購數量未達標準' 
ELSE 
    PRINT '訂購數量高於標準' 

GO
●● -- P13-26

IF ISNULL((SELECT SUM(數量) FROM 訂單細目 
           WHERE 書籍編號 = 123), 0) < 100 
    PRINT '訂購數量未達標準' 
ELSE 
    PRINT '訂購數量高於標準' 

GO
●● -- P13-27

EXEC sp_addmessage  66666, 7, 'Monsters!', @lang = 'us_english'
GO
EXEC sp_addmessage 66666, 7, '有怪獸!有怪獸!', @lang = '繁體中文'
GO
RAISERROR (66666, 7, 1)

GO
●● -- P13-28a

RAISERROR ('失敗為成功之母', 9, 1)

GO
●● -- P13-28b

RAISERROR ('發生嚴重錯誤！', 20, 1) WITH LOG 

GO
●● -- P13-29a

RAISERROR ('此訊息由 RAISERROR 產生', 0, 1)
PRINT '此訊息由 PRINT 產生'

GO
●● -- P13-29b

SELECT '此訊息由 SELECT 產生'

GO
●● -- P13-30

BEGIN TRANSACTION
INSERT 旗旗公司 (產品名稱, 價格)
  VALUES ('PHP程式語言', 500)

UPDATE 訂單
  SET    是否付款 = 1
  WHERE  訂單序號 = 3

IF @@ERROR !=0 OR @@ROWCOUNT = 0
   ROLLBACK TRANSACTION
ELSE
   COMMIT TRANSACTION

GO
●● -- P13-32

BEGIN TRY
    RAISERROR (66666, 19, 1) WITH LOG  
    PRINT '沒有發生重大錯誤'                   
END TRY                                        
BEGIN CATCH  
    IF ERROR_SEVERITY() > 16   
      PRINT '發生嚴重錯誤！請通知管理員, 錯誤編號為:' + 
			CAST(ERROR_NUMBER() AS CHAR)
    ELSE 
	  PRINT '發生錯誤！錯誤訊息為:' + ERROR_MESSAGE()
END CATCH

GO
●● -- P13-33

BEGIN TRY
    SELECT * FROM 資料表ABC
END TRY
BEGIN CATCH
    PRINT 'TRY…CATCH 發現一個錯誤：' + ERROR_MESSAGE()
END CATCH

GO
●● -- P13-34

CREATE PROCEDURE testTRYCATCHProc
AS
    SELECT * FROM 資料表ABC
GO

BEGIN TRY
    EXECUTE testTRYCATCHProc 
END TRY                          
BEGIN CATCH
    PRINT 'TRY…CATCH 發現一個錯誤：' + ERROR_MESSAGE()
END CATCH

GO
●● -- P13-36a

THROW 51000, '這是由 THROW 產生的自訂錯誤.', 1

GO
●● -- P13-36b


BEGIN TRY
	THROW 51000, '這是由 THROW 產生的自訂錯誤.', 1
END TRY                                        
BEGIN CATCH  
    PRINT '●進入 CATCH 區塊';
	THROW
    PRINT '●正常結束 CATCH 區塊'
END CATCH
PRINT '●批次結束'

GO
●● -- P13-37


-- 建立可傳回訂單筆數的預存程序
CREATE PROCEDURE CountOrder 
AS
    DECLARE @cnt INT
	SELECT @cnt = COUNT(*) FROM 訂單		
    RETURN @cnt   -- 傳回訂單筆數      

GO
●● -- P13-38

DECLARE @value int, @msg varchar(30)
SET @msg = '訂單筆數為：'

EXEC @value = CountOrder       /* 執行預存程序 */
IF @value > 0
	SET @msg += CAST(@value AS varchar)
ELSE
	SET @msg += '沒有訂單'
PRINT @msg 

GO
●● -- P13-46

CREATE VIEW 下單記錄_VIEW  
AS 
SELECT  日期, 客戶名稱, 地址
FROM    訂單, 客戶
WHERE   訂單.客戶編號 = 客戶.客戶編號
GO

SELECT * FROM 下單記錄_VIEW

GO
●● -- P13-47

WITH 下單記錄_CTE         
AS (
   SELECT  日期, 客戶名稱, 地址
   FROM    訂單, 客戶
   WHERE   訂單.客戶編號 = 客戶.客戶編號
)

SELECT * FROM 下單記錄_CTE

GO
●● -- P13-50

WITH 員工階層_CTE (員工編號, 姓名, 主管員工編號, level, sort)
AS (                                            
    /* 錨點成員先找出第 1 層的主管 */
    SELECT 員工編號, 
           姓名, 
           主管員工編號, 
           1,  
           CONVERT(varchar(255), 姓名)  
    FROM 員工                            
    WHERE 主管員工編號 = 0 

    UNION ALL

    /* 遞迴成員接著以自我呼叫的方式, 找出各主管的員工 */
    SELECT 員工.員工編號,
           員工.姓名,
           員工.主管員工編號,
           level+1, 
           CONVERT (varchar(255), sort + '-' + 員工.姓名)  
    FROM 員工
    JOIN 員工階層_CTE ON 員工.主管員工編號 = 員工階層_CTE.員工編號
                         
)

SELECT '|' + REPLICATE('-', level*2) + 姓名 AS 員工層級, 員工編號, 主管員工編號, level, sort
FROM 員工階層_CTE
ORDER BY sort

GO
●● -- P13-51

SELECT 員工編號, 姓名, 主管員工編號, 1, CONVERT(varchar(255), 姓名)
FROM 員工
WHERE 主管員工編號 = 0

GO
●● -- P13-55

SELECT * FROM 部門 

MERGE 部門 t             -- 目的資料表 (要被更新的資料表)
USING 部門草案 s         -- 來源資料
ON t.ID = s.ID           -- 指定二個資料表的撮合 (JOIN) 條件
WHEN MATCHED AND t.主管 <> s.主管 THEN  -- 條件符合且主管不同時, 就修改主管
     UPDATE 
     SET t.主管 = s.主管
WHEN NOT MATCHED BY TARGET THEN  -- 不在目的資料中的(但在來源資料中), 就新增
     INSERT (ID, 部門名稱, 主管)
     VALUES (s.ID, s.部門名稱, s.主管)
WHEN NOT MATCHED BY SOURCE THEN  -- 不在來源資料中的(但在目的資料中), 就刪除
     DELETE
OUTPUT $action, 
	deleted.ID, deleted.部門名稱, deleted.主管,
	inserted.ID, inserted.部門名稱, inserted.主管;

SELECT * FROM 部門

GO
●● -- P13-56

MERGE 股票庫存 t
USING (SELECT * FROM 股票交易記錄 WHERE 已處理 = 0) s
ON t.股票名稱 = s.股票名稱
WHEN MATCHED AND t.張數 + s.購買張數 = 0 THEN
	DELETE
WHEN MATCHED THEN
	UPDATE SET t.張數 = t.張數 + s.購買張數
WHEN NOT MATCHED THEN
	INSERT (股票名稱, 張數)
	VALUES (s.股票名稱, s.購買張數)
OUTPUT $action, 
	deleted.股票名稱, deleted.張數,
	inserted.股票名稱, inserted.張數;

SELECT * FROM 股票庫存

GO
●● -- P13-57

MERGE 股票庫存 t
USING (	SELECT 股票名稱, SUM(購買張數) AS 購買張數
		FROM 股票交易記錄 
		WHERE 已處理 = 0
		GROUP BY 股票名稱) s
ON t.股票名稱 = s.股票名稱
WHEN MATCHED AND t.張數 + s.購買張數 = 0 THEN
	DELETE
WHEN MATCHED THEN
	UPDATE SET t.張數 = t.張數 + s.購買張數
WHEN NOT MATCHED THEN
	INSERT (股票名稱, 張數)
	VALUES (s.股票名稱, s.購買張數)
OUTPUT $action, 
	deleted.股票名稱, deleted.張數,
	inserted.股票名稱, inserted.張數;


GO
●● -- P13-58

-- 本批次用於練習儲存為：顯示分類書單.sql
SELECT '<' + 
             CASE RIGHT(書籍名稱, 2)   
                WHEN '手冊' THEN '1入門' 
                WHEN '實務' THEN '2實例' 
                WHEN '應用' THEN '3技巧' 
                WHEN '秘笈' THEN '4技術' 
                ELSE '5未分' 
             END + '類>' AS 類別 
            , 書籍名稱 
FROM 書籍 
ORDER BY 類別 

GO
●● -- P13-62

/*
osql /S FLAG /d 練習13 /U sa /P abc /i 顯示分類書單.sql
*/

GO
●● -- P13-68

SELECT A.日期, B.客戶名稱
FROM   練習13..訂單 AS A JOIN 練習12..客戶 AS B 
       ON A.客戶編號 = B.客戶編號

GO
●● -- P13-76

SELECT *
FROM FLAG2.練習13.dbo.書籍


GO 
●● --結束
