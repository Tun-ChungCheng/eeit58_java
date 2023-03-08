���� -- ������Ʈw
USE  �m��17

GO 
���� -- P17-2

DECLARE ���y CURSOR   
FOR SELECT ���y�W��          
    FROM ���y                
    WHERE ��� < 400      

OPEN ���y                    

DECLARE @name varchar(25),
        @list varchar(500),
        @cnt int
SET @list = '�C��400���Ѧ��G'
SET @cnt = 0

FETCH NEXT FROM ���y
INTO @name

WHILE (@@FETCH_STATUS  = 0)
BEGIN
     SET @list += @name + ', '
     SET @cnt += 1
     FETCH NEXT FROM ���y
     INTO @name
END
SET @list += '�@' + CAST(@cnt AS VARCHAR) + '��'

CLOSE ���y
DEALLOCATE ���y
PRINT @list

GO 
���� -- P17-3

DECLARE @list varchar(500);
SET @list = '�C��400���Ѧ��G'

SELECT @list += ���y�W�� + ', '
FROM ���y
WHERE ��� < 400

SET @list += '�@' + CAST(@@ROWCOUNT AS VARCHAR) + '��'
PRINT @list

GO 
���� -- P17-6

DECLARE MyCursorl
SCROLL CURSOR
FOR SELECT * FROM �мФ��q

GO 
���� -- P17-9a

DECLARE MyCursor2 CURSOR
GLOBAL
FOR SELECT * FROM �мФ��q

GO 
���� -- P17-9b

DECLARE MyCursor3 CURSOR
SCROLL KEYSET SCROLL_LOCKS TYPE_WARNING
FOR SELECT * FROM �мФ��q

GO 
���� -- P17-12a

DECLARE MyCursor CURSOR
SCROLL STATIC
FOR SELECT *
    FROM �мФ��q

OPEN MyCursor
FETCH NEXT FROM MyCursor
FETCH LAST FROM MyCursor
CLOSE MyCursor
DEALLOCATE MyCursor

GO 
���� -- P17-12b

DECLARE MyCursor CURSOR
LOCAL SCROLL STATIC
FOR SELECT *
    FROM �мФ��q

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
���� -- P17-13

DECLARE MyCursor CURSOR
SCROLL STATIC
FOR SELECT *
FROM �мФ��q

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
���� -- P17-14

DECLARE CUR_�Ȥ� CURSOR
FOR SELECT �Ȥ�s��, �Ȥ�W��
    FROM �Ȥ�

DECLARE @custno INT, @custname VARCHAR(20)
DECLARE @orderno INT,  @orderlist VARCHAR(200)

OPEN CUR_�Ȥ�
FETCH CUR_�Ȥ�
INTO @custno, @custname
WHILE (@@FETCH_STATUS = 0)
  BEGIN
    DECLARE CUR_�q�� CURSOR
    FOR SELECT �q��Ǹ�
        FROM �q��
        WHERE �Ȥ�s�� = @custno

        SET @orderlist = @custname
        OPEN CUR_�q��
        FETCH CUR_�q�� INTO @orderno
        WHILE (@@FETCH_STATUS = 0)
            BEGIN
               SET @orderlist = @orderlist + ', '
                              + CAST (@orderno AS VARCHAR)
               FETCH CUR_�q�� INTO @orderno
            END
        PRINT @orderlist
        CLOSE CUR_�q��
        DEALLOCATE CUR_�q��
        FETCH CUR_�Ȥ� INTO @custno, @custname
    END
CLOSE CUR_�Ȥ�
DEALLOCATE CUR_�Ȥ�

GO 
���� -- P17-16

DECLARE MyCursor CURSOR 
LOCAL SCROLL_LOCKS 
FOR SELECT ���� FROM �X�X���q 
FOR UPDATE
 
OPEN MyCursor 
DECLARE @money money 
FETCH MyCursor INTO @money 
WHILE (@@FETCH_STATUS = 0) 
BEGIN 
    IF @money <= 50 
    BEGIN 
        SET @money = @money * 1.1 
        UPDATE �X�X���q 
        SET ���� = @money 
        WHERE CURRENT OF MyCursor   
    END 
FETCH MyCursor INTO @money 
END

GO 
���� -- P17-17

DECLARE cur_declare CURSOR 
FOR SELECT * 
        FROM �мФ��q 

DECLARE @cur_var CURSOR 
SET @cur_var = cur_declare 

OPEN @cur_var 
FETCH NEXT FROM @cur_var 
CLOSE @cur_var  
DEALLOCATE @cur_var 

GO 
���� -- P17-18

DECLARE @cur_var CURSOR 
SET @cur_var = CURSOR 
        FORWARD_ONLY KEYSET 
        FOR SELECT * 
            FROM �мФ��q 

OPEN @cur_var 
FETCH NEXT FROM @cur_var 

GO 
���� -- P17-19

CREATE PROC testproc 
@cur_parm CURSOR VARYING OUTPUT 
AS 
SET @cur_parm = CURSOR 
        FORWARD_ONLY STATIC 
        FOR SELECT * FROM �мФ��q 
OPEN @cur_parm 
GO 

DECLARE @cur_var CURSOR 
EXEC testproc @cur_var OUTPUT 
FETCH NEXT FROM @cur_var  

GO 
���� -- P17-20

DECLARE cur CURSOR 
FOR SELECT * FROM �мФ��q
 
DECLARE cur CURSOR LOCAL 
FOR SELECT * FROM �X�X���q
 
OPEN cur
FETCH cur
 
OPEN GLOBAL cur
FETCH GLOBAL cur 
CLOSE GLOBAL cur 
DEALLOCATE GLOBAL cur 

GO 
���� -- P17-22

CREATE PROCEDURE open_cursor 
@��ƪ�W�� varchar(30), 
@�d����� varchar(30), 
@cur_parm CURSOR VARYING OUTPUT 
AS 
/* �ˬd���w��ƪ�O�_�s�b */ 
IF OBJECTPROPERTY ( object_id(@��ƪ�W��),'ISTABLE') = 1
BEGIN 
    /* �إߤ@�Ӥ��t�ŧi Cursor ���r�� */ 
    DECLARE @sql_str varchar(200) 
    SET @sql_str = 'DECLARE global_cursor CURSOR' 
                         + ' FOR' 
                         + ' SELECT ' + @�d����� 
                         + ' FROM ' + @��ƪ�W�� 
    EXEC(@sql_str) 
    SET @cur_parm = global_cursor 
    OPEN @cur_parm 
    DEALLOCATE global_cursor 
END 
GO 

DECLARE @cur_var CURSOR 
EXECUTE open_cursor '�X�X���q', '*', @cur_var OUTPUT 

/* �ˬd Cursor �O�_���T�Ǧ^ */ 
IF CURSOR_STATUS ('variable', '@cur_var') = 1 
    FETCH @cur_var
ELSE 
    SELECT 'Cursor open fail!' 

GO 
���� -- P17-24

DECLARE test_cur CURSOR
FOR SELECT * FROM �мФ��q

DECLARE @test_cur CURSOR
SET @test_cur = test_cur
OPEN test_cur

DECLARE @result_cur CURSOR
-- �d�� @test_cur ����T, �Ӹ�T�� @result_cur �Ǧ^
EXEC sp_describe_cursor @result_cur OUTPUT, 'variable', '@test_cur'
FETCH @result_cur

CLOSE test_cur
DEALLOCATE test_cur

