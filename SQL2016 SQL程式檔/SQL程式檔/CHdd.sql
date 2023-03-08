USE 練習DD 

GO 
●●-- PD-2

INSERT 員工記錄 (異動日期, 員工編號, 薪資)  
VALUES ( GETDATE(), 5, 30000 )

SELECT * FROM 員工記錄

GO 
●●-- PD-3

UPDATE 員工記錄
SET 異動日期 = GETDATE()
WHERE 員工編號 = 5

SELECT * FROM 員工記錄

GO 
●●-- PD-4a

INSERT 員工記錄 (異動日期, 員工編號, 薪資)  
VALUES ( GETDATE(), 6, 32000 )

SELECT * FROM 員工記錄

GO 
●● --PB-4b

UPDATE 員工記錄
SET guid = NEWID()
WHERE 員工編號 = 6

SELECT * FROM 員工記錄

GO 
●● --PB-5a

DECLARE @TT varchar(30)
SET  @TT = '升官加薪'
INSERT 員工記錄 (異動日期, 員工編號, 薪資, 備註)  
VALUES ( GETDATE(), 1, 52000, @TT)

GO 
●● --PB-5b

DECLARE @DD decimal(5,2)
SET  @DD = 100.03
INSERT 員工記錄 (異動日期, 員工編號, 薪資, 備註)  
VALUES ( GETDATE(), 2, 50000, @DD)
 
SELECT * FROM 員工記錄

GO 
●● --PB-7a

SELECT SQL_VARIANT_PROPERTY (備註, 'BaseType') AS 基本資料型別,
       SQL_VARIANT_PROPERTY (備註, 'Precision') AS 精確度,
       SQL_VARIANT_PROPERTY (備註, 'Scale') AS 小數點位數,
       SQL_VARIANT_PROPERTY (備註, 'MaxLength') AS 最大長度
FROM 員工記錄

GO 
●● --PB-7b

SELECT CAST(備註 AS int) + 30
FROM 員工記錄
WHERE 員工編號 = 2

GO 
●● --PB-8

DECLARE @甲 hierarchyid, @乙 hierarchyid,    -- 宣告 4 個 hierarchyid 變數
        @丙 hierarchyid, @丁 hierarchyid        

SET @甲 = hierarchyid::GetRoot()           -- 存入根節點
SET @乙 = @甲.GetDescendant(NULL, NULL)    -- 存入@甲的下一層節點
SET @丙 = @甲.GetDescendant(@乙, NULL)     -- 存入@甲的下一層節點, 且在@乙的右邊                                                
SET @丁 = @乙.GetDescendant(NULL, NULL)    -- 存入@乙的下一層節點

PRINT @甲.ToString()
PRINT @乙.ToString()
PRINT @丙.ToString()
PRINT @丁.ToString()

GO 
●●-- PD-9

DECLARE @甲 hierarchyid, @乙 hierarchyid,    -- 宣告 4 個 hierarchyid 變數
        @丙 hierarchyid, @丁 hierarchyid        

SET @甲 = hierarchyid::GetRoot()           -- 存入根節點
SET @乙 = @甲.GetDescendant(NULL, NULL)    -- 存入@甲的下一層節點
SET @丙 = @甲.GetDescendant(@乙, NULL)     -- 存入@甲的下一層節點, 且在@乙的右邊                                                
SET @丁 = @乙.GetDescendant(NULL, NULL)    -- 存入@乙的下一層節點

PRINT @甲.ToString()
PRINT @乙.ToString()
PRINT @丙.ToString()
PRINT @丁.ToString()

DECLARE @中 hierarchyid = @甲.GetDescendant(@乙, @丙)
PRINT @中.ToString()

GO 
●●-- PD-10a

CREATE TABLE 員工階層
(
  階層 hierarchyid,
  員工編號 int IDENTITY PRIMARY KEY,
  姓名 nvarchar(50)
)

INSERT 員工階層(姓名, 階層)
VALUES	('甲', hierarchyid::GetRoot())

GO 
●●-- PD-10b

CREATE PROC 加入子員工
(@姓名 nvarchar(8), 
 @父名 nvarchar(8), @弟名 nvarchar=NULL, @兄名 nvarchar(8)=NULL) 
AS
BEGIN
    DECLARE @父節點 hierarchyid, 
			@弟節點 hierarchyid,@兄節點 hierarchyid
			
    SELECT @父節點 = 階層 FROM 員工階層 WHERE 姓名 = @父名
    SELECT @弟節點 = 階層 FROM 員工階層 WHERE 姓名 = @弟名
    SELECT @兄節點 = 階層 FROM 員工階層 WHERE 姓名 = @兄名
   
    INSERT 員工階層(姓名, 階層)
    VALUES (@姓名, @父節點.GetDescendant(@弟節點, @兄節點))
END

GO 
●●-- PD-10c~11a

EXEC 加入子員工 '乙', '甲'
EXEC 加入子員工 '丙', '甲', '乙'
EXEC 加入子員工 '丁', '乙'
EXEC 加入子員工 '中', '甲', '乙', '丙'

SELECT 階層.ToString() 階層串, 階層.GetLevel() 層級, 姓名, 階層
FROM 員工階層
ORDER BY 階層

GO 
●●-- PD-11b

SELECT 階層.ToString() 階層串, 階層.GetLevel() 層級, 姓名, 階層
FROM 員工階層
ORDER BY 階層.GetLevel(), 階層

GO 
●●-- PD-12a

-- 1. 先在丁之下再加入一個節點
EXEC 加入子員工 '戊', '丁'

GO 
●●-- PD-12b

-- 2. 找出第 1 階層的所有主管
SELECT 階層.ToString(), 姓名 
FROM 員工階層
WHERE 階層.GetLevel()  = 1

GO 
●●-- PD-12c

-- 3. 找出【乙】之下的所有部屬
DECLARE @Str varchar(20)
SELECT @Str = 階層.ToString() FROM 員工階層 WHERE 姓名='乙'

SELECT 階層.ToString(), 姓名 
FROM 員工階層
WHERE 階層.ToString() LIKE @Str + '%'
		AND @Str <> 階層.ToString()

GO 
●●-- PD-12d
		
-- 4. 找出【戊】之上的所有主管
DECLARE @Str varchar(20)
SELECT @Str = 階層.ToString() FROM 員工階層 WHERE 姓名='戊'

SELECT 階層.ToString(), 姓名 
FROM 員工階層
WHERE @Str LIKE (階層.ToString() + '%') 
		AND @Str <> 階層.ToString()

GO 
●●-- PD-13a
		
-- 5. 找出【戊】往上 2 層的主管
--    使用：GetAncestor(n) 找出往上 n 層的父節點
DECLARE @node hierarchyid
SELECT @node = 階層 FROM 員工階層 WHERE 姓名='戊'

SELECT 階層.ToString(), 姓名 
FROM 員工階層
WHERE 階層 = @node.GetAncestor(2) 

GO 
●●-- PD-13b
		
-- 6. 將乙及其部屬全部移到丙之下
--    使用：A.GetReparentedValue(B, C) 
--          取得 A 由 B 之下移到 C 之下的新節點值
--    使用：A.IsDescendantOf(B) 
--          判斷 A 是 B 的部屬？1 為真, 0 為假

DECLARE @舊父 hierarchyid, @新父 hierarchyid,
		@本尊 hierarchyid
 
SELECT @舊父 = 階層 FROM 員工階層 WHERE 姓名='甲'
SELECT @新父 = 階層 FROM 員工階層 WHERE 姓名='丙'
SELECT @本尊 = 階層 FROM 員工階層 WHERE 姓名='乙'

UPDATE 員工階層
SET 階層 = 階層.GetReparentedValue(@舊父, @新父) 
WHERE 階層.IsDescendantOf(@本尊) = 1 

SELECT 階層.ToString(), 姓名 
FROM 員工階層
ORDER BY 階層

GO 
●●-- PD-15a

EXEC sp_tableoption '書籍', 'text in row', '200'

GO 
●●-- PD-15b

SELECT OBJECTPROPERTY (OBJECT_ID('書籍'), 'TableTextInRowlimit')

