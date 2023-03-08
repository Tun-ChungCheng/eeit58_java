●● -- 切換資料庫
USE  練習17

GO 
●● -- P17-2

DECLARE 書籍 CURSOR   
FOR SELECT 書籍名稱          
    FROM 書籍                
    WHERE 單價 < 400      

OPEN 書籍                    

DECLARE @name varchar(25),
        @list varchar(500),
        @cnt int
SET @list = '低於400的書有：'
SET @cnt = 0

FETCH NEXT FROM 書籍
INTO @name

WHILE (@@FETCH_STATUS  = 0)
BEGIN
     SET @list += @name + ', '
     SET @cnt += 1
     FETCH NEXT FROM 書籍
     INTO @name
END
SET @list += '共' + CAST(@cnt AS VARCHAR) + '本'

CLOSE 書籍
DEALLOCATE 書籍
PRINT @list

GO 
●● -- P17-3

DECLARE @list varchar(500);
SET @list = '低於400的書有：'

SELECT @list += 書籍名稱 + ', '
FROM 書籍
WHERE 單價 < 400

SET @list += '共' + CAST(@@ROWCOUNT AS VARCHAR) + '本'
PRINT @list

GO 
●● -- P17-6

DECLARE MyCursorl
SCROLL CURSOR
FOR SELECT * FROM 標標公司

GO 
●● -- P17-9a

DECLARE MyCursor2 CURSOR
GLOBAL
FOR SELECT * FROM 標標公司

GO 
●● -- P17-9b

DECLARE MyCursor3 CURSOR
SCROLL KEYSET SCROLL_LOCKS TYPE_WARNING
FOR SELECT * FROM 標標公司

GO 
●● -- P17-12a

DECLARE MyCursor CURSOR
SCROLL STATIC
FOR SELECT *
    FROM 標標公司

OPEN MyCursor
FETCH NEXT FROM MyCursor
FETCH LAST FROM MyCursor
CLOSE MyCursor
DEALLOCATE MyCursor

GO 
●● -- P17-12b

DECLARE MyCursor CURSOR
LOCAL SCROLL STATIC
FOR SELECT *
    FROM 標標公司

OPEN MyCursor
DECLARE @NAME char(20)
DECLARE @money money

FETCH ABSOLUTE 3 FROM MyCursor
INTO @name, @money
PRINT @name + '' + convert(varchar, @money)

FETCH RELATIVE -2 FROM MyCursor
INTO @name, @money
PRINT @name + '' + convert(varchar, @money)

GO 
●● -- P17-13

DECLARE MyCursor CURSOR
SCROLL STATIC
FOR SELECT *
FROM 標標公司

OPEN MyCursor
DECLARE @NAME char(20)
DECLARE @money money

FETCH NEXT FROM MyCursor
INTO @name, @money

WHILE (@@FETCH_STATUS = 0)
  BEGIN
    IF @money > 50
         SET @money = @money * 0.9
    ELSE SET @money = @money * 0.95

    PRINT @name + convert(varchar, @money)

    FETCH NEXT FROM MyCursor
    INTO @name, @money
  END

CLOSE MyCursor
DEALLOCATE MyCursor

GO 
●● -- P17-14

DECLARE CUR_客戶 CURSOR
FOR SELECT 客戶編號, 客戶名稱
    FROM 客戶

DECLARE @custno INT, @custname VARCHAR(20)
DECLARE @orderno INT,  @orderlist VARCHAR(200)

OPEN CUR_客戶
FETCH CUR_客戶
INTO @custno, @custname
WHILE (@@FETCH_STATUS = 0)
  BEGIN
    DECLARE CUR_訂單 CURSOR
    FOR SELECT 訂單序號
        FROM 訂單
        WHERE 客戶編號 = @custno

        SET @orderlist = @custname
        OPEN CUR_訂單
        FETCH CUR_訂單 INTO @orderno
        WHILE (@@FETCH_STATUS = 0)
            BEGIN
               SET @orderlist = @orderlist + ', '
                              + CAST (@orderno AS VARCHAR)
               FETCH CUR_訂單 INTO @orderno
            END
        PRINT @orderlist
        CLOSE CUR_訂單
        DEALLOCATE CUR_訂單
        FETCH CUR_客戶 INTO @custno, @custname
    END
CLOSE CUR_客戶
DEALLOCATE CUR_客戶

GO 
●● -- P17-16

DECLARE MyCursor CURSOR 
LOCAL SCROLL_LOCKS 
FOR SELECT 價格 FROM 旗旗公司 
FOR UPDATE
 
OPEN MyCursor 
DECLARE @money money 
FETCH MyCursor INTO @money 
WHILE (@@FETCH_STATUS = 0) 
BEGIN 
    IF @money <= 50 
    BEGIN 
        SET @money = @money * 1.1 
        UPDATE 旗旗公司 
        SET 價格 = @money 
        WHERE CURRENT OF MyCursor   
    END 
FETCH MyCursor INTO @money 
END

GO 
●● -- P17-17

DECLARE cur_declare CURSOR 
FOR SELECT * 
        FROM 標標公司 

DECLARE @cur_var CURSOR 
SET @cur_var = cur_declare 

OPEN @cur_var 
FETCH NEXT FROM @cur_var 
CLOSE @cur_var  
DEALLOCATE @cur_var 

GO 
●● -- P17-18

DECLARE @cur_var CURSOR 
SET @cur_var = CURSOR 
        FORWARD_ONLY KEYSET 
        FOR SELECT * 
            FROM 標標公司 

OPEN @cur_var 
FETCH NEXT FROM @cur_var 

GO 
●● -- P17-19

CREATE PROC testproc 
@cur_parm CURSOR VARYING OUTPUT 
AS 
SET @cur_parm = CURSOR 
        FORWARD_ONLY STATIC 
        FOR SELECT * FROM 標標公司 
OPEN @cur_parm 
GO 

DECLARE @cur_var CURSOR 
EXEC testproc @cur_var OUTPUT 
FETCH NEXT FROM @cur_var  

GO 
●● -- P17-20

DECLARE cur CURSOR 
FOR SELECT * FROM 標標公司
 
DECLARE cur CURSOR LOCAL 
FOR SELECT * FROM 旗旗公司
 
OPEN cur
FETCH cur
 
OPEN GLOBAL cur
FETCH GLOBAL cur 
CLOSE GLOBAL cur 
DEALLOCATE GLOBAL cur 

GO 
●● -- P17-22

CREATE PROCEDURE open_cursor 
@資料表名稱 varchar(30), 
@查詢欄位 varchar(30), 
@cur_parm CURSOR VARYING OUTPUT 
AS 
/* 檢查指定資料表是否存在 */ 
IF OBJECTPROPERTY ( object_id(@資料表名稱),'ISTABLE') = 1
BEGIN 
    /* 建立一個內含宣告 Cursor 的字串 */ 
    DECLARE @sql_str varchar(200) 
    SET @sql_str = 'DECLARE global_cursor CURSOR' 
                         + ' FOR' 
                         + ' SELECT ' + @查詢欄位 
                         + ' FROM ' + @資料表名稱 
    EXEC(@sql_str) 
    SET @cur_parm = global_cursor 
    OPEN @cur_parm 
    DEALLOCATE global_cursor 
END 
GO 

DECLARE @cur_var CURSOR 
EXECUTE open_cursor '旗旗公司', '*', @cur_var OUTPUT 

/* 檢查 Cursor 是否正確傳回 */ 
IF CURSOR_STATUS ('variable', '@cur_var') = 1 
    FETCH @cur_var
ELSE 
    SELECT 'Cursor open fail!' 

GO 
●● -- P17-24

DECLARE test_cur CURSOR
FOR SELECT * FROM 標標公司

DECLARE @test_cur CURSOR
SET @test_cur = test_cur
OPEN test_cur

DECLARE @result_cur CURSOR
-- 查詢 @test_cur 的資訊, 該資訊由 @result_cur 傳回
EXEC sp_describe_cursor @result_cur OUTPUT, 'variable', '@test_cur'
FETCH @result_cur

CLOSE test_cur
DEALLOCATE test_cur

