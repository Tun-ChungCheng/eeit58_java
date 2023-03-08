●● -- 切換資料庫
USE 練習16

GO 
●● -- P16-7

CREATE TRIGGER 訂單異動通知 
ON 訂單T1 
AFTER INSERT, UPDATE 
AS 
PRINT '又有訂單異動了！' 
GO 

CREATE TRIGGER 訂單刪除通知 
ON 訂單T1 
AFTER DELETE 
AS 
PRINT '又有訂單被刪除了！' 
GO 

INSERT 訂單T1 (日期, 客戶編號)  
VALUES ('2016/1/1', 3)

DELETE 訂單T1                  
WHERE 日期 = '2016/1/1'

GO 
●● -- P16-9a

EXEC sp_helptrigger '訂單T1', 'DELETE'

GO 
●● -- P16-9b

EXEC sp_help 訂單刪除通知

GO 
●● -- P16-10

EXEC sp_helptext 訂單刪除通知 

GO 
●● -- P16-11

EXEC sp_rename '訂單刪除通知', '訂單刪除通知new'

GO 
●● -- P16-12

EXEC sp_helptext 訂單刪除通知new

GO 
●● -- P16-13

DISABLE TRIGGER 訂單異動通知   -- 停用觸發程序
ON dbo.訂單T1
GO

ENABLE TRIGGER ALL   -- 啟用【訂單T1】資料表中所有的觸發程序
ON dbo.訂單T1

GO 
●● -- P16-16

CREATE TRIGGER 測試異動筆數 
ON 客戶T1
FOR DELETE, INSERT, UPDATE 
AS 
PRINT '異動了 ' + CAST(@@ROWCOUNT AS VARCHAR) + ' 筆資料！'
ROLLBACK
GO

INSERT 客戶T1 (客戶名稱, 地址)  
VALUES ('楊小頭', '新竹市中山路')
GO
DELETE 客戶T1                  
WHERE 客戶編號 < 5
GO
DELETE 客戶T1                  
WHERE 客戶編號 >200

GO 
●● -- P16-18a

INSERT 客戶T1 (客戶名稱, 地址)
VALUES ('楊小頭', '新竹市中山路')

DELETE 客戶T1
WHERE 客戶編號 < 5


GO 
●● -- P16-18b

CREATE TRIGGER 檢查數量是否更改 
ON 訂單T2
AFTER UPDATE, INSERT  
AS 
IF UPDATE(數量)
   PRINT '數量欄已更改！' 
ELSE
   PRINT '數量欄沒有更改！' 
ROLLBACK
GO

UPDATE  訂單T2
SET 數量 =5
WHERE 訂單編號 = 10
GO
UPDATE  訂單T2
SET 是否付款 = 1
WHERE 訂單編號 = 11

GO 
●● -- P16-19

INSERT  訂單T2 (日期, 客戶編號)
VALUES ('2016/11/30', 5)

GO 
●● -- P16-20

CREATE TRIGGER 不允許修改日期
ON 訂單T2
AFTER UPDATE
AS
IF UPDATE(日期)
BEGIN
   PRINT '不可修改日期！' 
   ROLLBACK
END
GO

GO 
●● -- P16-22

   RAISERROR('任何人都不能修改日期！', 16, 1) 

GO 
●● -- P16-23

CREATE TRIGGER 檢查訂購數量
ON 訂單T3
AFTER INSERT
AS 
IF (SELECT 數量 FROM inserted) > 200
BEGIN 
   PRINT '數量不得大於 200！'
   ROLLBACK
END
GO

INSERT  訂單T3 (日期, 客戶編號, 數量)
VALUES ('2016/11/30', 5, 201)

GO 
●● -- P16-24a

INSERT INTO 訂單T3
(日期, 客戶編號, 數量, 是否付款)
SELECT 日期, 客戶編號, 數量, 是否付款
FROM 訂單T2

GO 
●● -- P16-24b

-- 更改為使用 MAX() 來查詢最大數量
ALTER TRIGGER 檢查訂購數量
ON 訂單T3
AFTER INSERT
AS 
IF (SELECT MAX(數量) FROM inserted) > 200
BEGIN 
   PRINT '數量不得大於 200！'
   ROLLBACK
END

GO 
●● -- P16-25a

CREATE TRIGGER 檢查訂購數量更改 
ON 訂單T3
AFTER UPDATE 
AS 
IF (SELECT MAX(數量) FROM inserted) > 200 
BEGIN 
   PRINT '數量更改不得大於 200！' 
   ROLLBACK
END 
GO

UPDATE 訂單T3
SET 數量 = 數量 + 30

GO 
●● -- P16-25b

CREATE TRIGGER 檢查訂購數量變化
ON 訂單T3
AFTER UPDATE 
AS 
IF (SELECT MAX(ABS(新.數量 - 舊.數量)) 
    FROM inserted AS 新 JOIN deleted AS 舊 
         ON 新.訂單編號 = 舊.訂單編號) > 50 
BEGIN 
   PRINT '數量變化不得大於 50！' 
   ROLLBACK
END 
GO

UPDATE 訂單T3
SET 數量 = 數量 / 2 

GO 
●● -- P16-26

CREATE TRIGGER 檢查數量及日期 
ON 訂單T3
AFTER UPDATE 
AS 
IF UPDATE(數量)
BEGIN 
   IF (SELECT MAX(數量) FROM inserted) > 200 
   BEGIN 
      PRINT '數量不得大於 200！' 
      ROLLBACK TRANSACTION 
      RETURN 
   END 
END
IF UPDATE(日期) 
BEGIN 
   IF (SELECT MIN(日期) FROM inserted) < '2016/1/1' 
   BEGIN 
      PRINT '日期不得早於 2016/1/1！' 
      ROLLBACK TRANSACTION 
   END 
END 
GO
UPDATE 訂單T3
SET 日期=  '2015/12/1' 
WHERE 訂單編號 = 3

GO 
●● -- P16-27

CREATE TRIGGER 檢查刪除數量及日期
ON dbo.訂單T3
AFTER DELETE 
AS 
IF (SELECT SUM(數量) FROM deleted) > 300
BEGIN 
   ROLLBACK
   RAISERROR('每次刪除之訂貨總數量不得大於300！', 16, 1) 
END
ELSE IF (SELECT MIN(日期) FROM deleted) < '2016/7/1' 
BEGIN 
   ROLLBACK
   RAISERROR('2012/7/1 之前的訂單不得刪除！', 16, 1) 
END
GO

DELETE 訂單T3
WHERE 數量 > 100 
GO
PRINT '-------------------------' 
DELETE 訂單T3
WHERE 日期 < '2016/7/5' 

GO 
●● -- P16-28

CREATE TRIGGER 訂單異動郵寄通知
ON 訂單T4
AFTER INSERT, UPDATE, DELETE 
AS 
EXEC msdb.dbo.sp_send_dbmail
     @recipients = 'ken@flag.com.tw',
     @body = '訂單資料被更改了！',
     @subject = '資料庫異動通知'

GO 
●● -- P16-29

CREATE TRIGGER 檢查上下限 
ON 訂單T5
FOR INSERT, UPDATE 
AS 
IF @@ROWCOUNT = 0 RETURN 
IF UPDATE(數量) 
BEGIN 
   IF EXISTS (SELECT A.* 
              FROM inserted A 
                JOIN 客戶T5 B ON A.客戶編號 = B.客戶編號 
                JOIN 客戶信用額度T5 C ON B.信用等級 = C.信用等級 
              WHERE A.數量 NOT BETWEEN C.下限 AND C.上限) 
   BEGIN 
      ROLLBACK TRANSACTION 
      RAISERROR('訂購數量不符合客戶的信用等級', 16, 1) 
   END
END
GO
INSERT 訂單T5 (日期, 客戶編號, 數量)
VALUES ( GETDATE(), 5, 201)

GO 
●● -- P16-30

CREATE TRIGGER 記錄薪資修改 
ON 員工T1 
AFTER UPDATE 
AS 
IF @@ROWCOUNT = 0 RETURN 
IF UPDATE(薪資) 
BEGIN 
   INSERT 員工記錄 (異動日期, 員工編號, 薪資) 
   SELECT GETDATE(), 員工編號, 薪資
   FROM deleted 
END

GO 
●● -- P16-31a

EXEC sp_settriggerorder '記錄薪資修改', 'First', 'UPDATE'

GO 
●● -- P16-31b

EXEC sp_configure 'nested triggers', 0

GO 

●● -- P16-34

CREATE TRIGGER 處理新增的員工資料
ON 員工T2 
INSTEAD OF INSERT 
AS 
   SET NOCOUNT ON   -- 不要顯示 '(影響 ? 個資料列)' 訊息

   -- 更新已存在於【員工T2】中的資料
   UPDATE 員工T2
   SET 員工T2.姓名 = inserted.姓名, 
          員工T2.薪資= inserted.薪資
   FROM 員工T2 JOIN inserted 
              ON 員工T2.員工編號 = inserted.員工編號
   PRINT '更改已存在的資料 ' + CAST(@@ROWCOUNT AS VARCHAR) + ' 筆'

   -- 插入不存在於【員工T2】中的新資料 
   INSERT 員工T2
   SELECT *
   FROM inserted
   WHERE  inserted.員工編號 NOT IN
                   ( SELECT 員工編號 FROM 員工T2  )
   PRINT '加入新的資料 ' + CAST(@@ROWCOUNT AS VARCHAR) + ' 筆'
GO

GO 
●● -- P16-35

INSERT 員工T2
SELECT * FROM 員工T1

GO 
●● -- P16-36

CREATE TRIGGER 顯示新增或更改的資料 
ON 員工T2 
AFTER INSERT, UPDATE
AS
   IF EXISTS (SELECT  員工編號 FROM deleted)
      PRINT '-----UPDATE-----'
   ELSE
      PRINT '-----INSERT-----'
   SELECT *
   FROM inserted
GO

INSERT  員工T2 (員工編號, 姓名, 薪資)
VALUES (1, '王明明 ', 32000)

GO 
●● -- P16-37a

CREATE VIEW 員工列表
AS
SELECT 員工編號, 姓名 + '' + 職稱 AS 員工名稱
FROM 員工T1
GO

GO 
●● -- P16-37b

CREATE TRIGGER 處理新增員工
ON 員工列表
INSTEAD OF INSERT
AS
	SET NOCOUNT ON
    INSERT  員工T1 (姓名, 職稱)
    SELECT LEFT( 員工名稱, CHARINDEX(' ', 員工名稱) -1 ),
           RIGHT( 員工名稱, LEN( 員工名稱) - CHARINDEX(' ', 員工名稱) )
    FROM inserted
GO

INSERT 員工列表 (員工編號, 員工名稱)
VALUES (9999,  '陳小雄 主任')

GO 
●● -- P16-38

CREATE TRIGGER 處理更改員工
ON 員工列表
INSTEAD OF UPDATE
AS
	SET NOCOUNT ON
    UPDATE  員工T1
    SET 姓名  = LEFT( inserted.員工名稱, 
                             CHARINDEX(' ', inserted.員工名稱) -1 ),
            職稱 = RIGHT( inserted.員工名稱, 
                             LEN( inserted.員工名稱) - CHARINDEX(' ', inserted.員工名稱) )
    FROM inserted 
    WHERE  inserted.員工編號 = 員工T1.員工編號
GO

UPDATE 員工列表
SET 員工名稱 = '江母亞 副總'
WHERE 員工編號 = 1  

GO 
●● -- P16-40

CREATE TRIGGER 處理新增訂單
ON 檢視訂單
INSTEAD OF INSERT
AS
SET NOCOUNT ON

-- 必要時新增客戶資料, 
INSERT 客戶T6 (客戶名稱)
SELECT 客戶名稱
FROM inserted
WHERE  inserted.客戶編號 NOT IN ( SELECT 客戶編號 FROM 客戶T6  )

-- 新增訂單資料
IF @@ROWCOUNT = 0   -- 如果沒有新增客戶
    INSERT 訂單T6 (日期, 客戶編號, 數量, 是否付款)
    SELECT 日期, 客戶編號, 數量, 是否付款
    FROM inserted
ELSE                                   -- 否則以新的客戶編號來更新訂單
    INSERT 訂單T6 (日期, 客戶編號, 數量, 是否付款)
    SELECT 日期, 客戶T6.客戶編號, 數量, 是否付款
    FROM inserted JOIN 客戶T6 ON inserted.客戶名稱 =客戶T6.客戶名稱
GO

INSERT 檢視訂單 (客戶編號, 客戶名稱, 訂單編號, 日期, 數量, 是否付款)
VALUES(9999, '洋洋量販店', 9999, '2016/12/30', 130, 0)
INSERT 檢視訂單 (客戶編號, 客戶名稱, 訂單編號, 日期, 數量, 是否付款)
VALUES(3, 'XXXXX', 9999, '2016/12/30', 130, 0)
GO
SELECT * FROM 訂單T6

GO 
●● -- P16-41

CREATE TRIGGER 處理刪除訂單
ON 檢視訂單
INSTEAD OF DELETE
AS
SET NOCOUNT ON
DELETE 訂單T6
WHERE 訂單T6.訂單編號 IN (SELECT 訂單編號 FROM deleted)
GO

DELETE 檢視訂單
WHERE 訂單編號 = 6
GO
SELECT * FROM 訂單T6

