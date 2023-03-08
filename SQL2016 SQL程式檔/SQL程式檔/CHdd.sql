USE �m��DD 

GO 
����-- PD-2

INSERT ���u�O�� (���ʤ��, ���u�s��, �~��)  
VALUES ( GETDATE(), 5, 30000 )

SELECT * FROM ���u�O��

GO 
����-- PD-3

UPDATE ���u�O��
SET ���ʤ�� = GETDATE()
WHERE ���u�s�� = 5

SELECT * FROM ���u�O��

GO 
����-- PD-4a

INSERT ���u�O�� (���ʤ��, ���u�s��, �~��)  
VALUES ( GETDATE(), 6, 32000 )

SELECT * FROM ���u�O��

GO 
���� --PB-4b

UPDATE ���u�O��
SET guid = NEWID()
WHERE ���u�s�� = 6

SELECT * FROM ���u�O��

GO 
���� --PB-5a

DECLARE @TT varchar(30)
SET  @TT = '�ɩx�[�~'
INSERT ���u�O�� (���ʤ��, ���u�s��, �~��, �Ƶ�)  
VALUES ( GETDATE(), 1, 52000, @TT)

GO 
���� --PB-5b

DECLARE @DD decimal(5,2)
SET  @DD = 100.03
INSERT ���u�O�� (���ʤ��, ���u�s��, �~��, �Ƶ�)  
VALUES ( GETDATE(), 2, 50000, @DD)
 
SELECT * FROM ���u�O��

GO 
���� --PB-7a

SELECT SQL_VARIANT_PROPERTY (�Ƶ�, 'BaseType') AS �򥻸�ƫ��O,
       SQL_VARIANT_PROPERTY (�Ƶ�, 'Precision') AS ��T��,
       SQL_VARIANT_PROPERTY (�Ƶ�, 'Scale') AS �p���I���,
       SQL_VARIANT_PROPERTY (�Ƶ�, 'MaxLength') AS �̤j����
FROM ���u�O��

GO 
���� --PB-7b

SELECT CAST(�Ƶ� AS int) + 30
FROM ���u�O��
WHERE ���u�s�� = 2

GO 
���� --PB-8

DECLARE @�� hierarchyid, @�A hierarchyid,    -- �ŧi 4 �� hierarchyid �ܼ�
        @�� hierarchyid, @�B hierarchyid        

SET @�� = hierarchyid::GetRoot()           -- �s�J�ڸ`�I
SET @�A = @��.GetDescendant(NULL, NULL)    -- �s�J@�Ҫ��U�@�h�`�I
SET @�� = @��.GetDescendant(@�A, NULL)     -- �s�J@�Ҫ��U�@�h�`�I, �B�b@�A���k��                                                
SET @�B = @�A.GetDescendant(NULL, NULL)    -- �s�J@�A���U�@�h�`�I

PRINT @��.ToString()
PRINT @�A.ToString()
PRINT @��.ToString()
PRINT @�B.ToString()

GO 
����-- PD-9

DECLARE @�� hierarchyid, @�A hierarchyid,    -- �ŧi 4 �� hierarchyid �ܼ�
        @�� hierarchyid, @�B hierarchyid        

SET @�� = hierarchyid::GetRoot()           -- �s�J�ڸ`�I
SET @�A = @��.GetDescendant(NULL, NULL)    -- �s�J@�Ҫ��U�@�h�`�I
SET @�� = @��.GetDescendant(@�A, NULL)     -- �s�J@�Ҫ��U�@�h�`�I, �B�b@�A���k��                                                
SET @�B = @�A.GetDescendant(NULL, NULL)    -- �s�J@�A���U�@�h�`�I

PRINT @��.ToString()
PRINT @�A.ToString()
PRINT @��.ToString()
PRINT @�B.ToString()

DECLARE @�� hierarchyid = @��.GetDescendant(@�A, @��)
PRINT @��.ToString()

GO 
����-- PD-10a

CREATE TABLE ���u���h
(
  ���h hierarchyid,
  ���u�s�� int IDENTITY PRIMARY KEY,
  �m�W nvarchar(50)
)

INSERT ���u���h(�m�W, ���h)
VALUES	('��', hierarchyid::GetRoot())

GO 
����-- PD-10b

CREATE PROC �[�J�l���u
(@�m�W nvarchar(8), 
 @���W nvarchar(8), @�̦W nvarchar=NULL, @�S�W nvarchar(8)=NULL) 
AS
BEGIN
    DECLARE @���`�I hierarchyid, 
			@�̸`�I hierarchyid,@�S�`�I hierarchyid
			
    SELECT @���`�I = ���h FROM ���u���h WHERE �m�W = @���W
    SELECT @�̸`�I = ���h FROM ���u���h WHERE �m�W = @�̦W
    SELECT @�S�`�I = ���h FROM ���u���h WHERE �m�W = @�S�W
   
    INSERT ���u���h(�m�W, ���h)
    VALUES (@�m�W, @���`�I.GetDescendant(@�̸`�I, @�S�`�I))
END

GO 
����-- PD-10c~11a

EXEC �[�J�l���u '�A', '��'
EXEC �[�J�l���u '��', '��', '�A'
EXEC �[�J�l���u '�B', '�A'
EXEC �[�J�l���u '��', '��', '�A', '��'

SELECT ���h.ToString() ���h��, ���h.GetLevel() �h��, �m�W, ���h
FROM ���u���h
ORDER BY ���h

GO 
����-- PD-11b

SELECT ���h.ToString() ���h��, ���h.GetLevel() �h��, �m�W, ���h
FROM ���u���h
ORDER BY ���h.GetLevel(), ���h

GO 
����-- PD-12a

-- 1. ���b�B���U�A�[�J�@�Ӹ`�I
EXEC �[�J�l���u '��', '�B'

GO 
����-- PD-12b

-- 2. ��X�� 1 ���h���Ҧ��D��
SELECT ���h.ToString(), �m�W 
FROM ���u���h
WHERE ���h.GetLevel()  = 1

GO 
����-- PD-12c

-- 3. ��X�i�A�j���U���Ҧ�����
DECLARE @Str varchar(20)
SELECT @Str = ���h.ToString() FROM ���u���h WHERE �m�W='�A'

SELECT ���h.ToString(), �m�W 
FROM ���u���h
WHERE ���h.ToString() LIKE @Str + '%'
		AND @Str <> ���h.ToString()

GO 
����-- PD-12d
		
-- 4. ��X�i���j���W���Ҧ��D��
DECLARE @Str varchar(20)
SELECT @Str = ���h.ToString() FROM ���u���h WHERE �m�W='��'

SELECT ���h.ToString(), �m�W 
FROM ���u���h
WHERE @Str LIKE (���h.ToString() + '%') 
		AND @Str <> ���h.ToString()

GO 
����-- PD-13a
		
-- 5. ��X�i���j���W 2 �h���D��
--    �ϥΡGGetAncestor(n) ��X���W n �h�����`�I
DECLARE @node hierarchyid
SELECT @node = ���h FROM ���u���h WHERE �m�W='��'

SELECT ���h.ToString(), �m�W 
FROM ���u���h
WHERE ���h = @node.GetAncestor(2) 

GO 
����-- PD-13b
		
-- 6. �N�A�Ψ䳡�ݥ�����������U
--    �ϥΡGA.GetReparentedValue(B, C) 
--          ���o A �� B ���U���� C ���U���s�`�I��
--    �ϥΡGA.IsDescendantOf(B) 
--          �P�_ A �O B �����ݡH1 ���u, 0 ����

DECLARE @�¤� hierarchyid, @�s�� hierarchyid,
		@���L hierarchyid
 
SELECT @�¤� = ���h FROM ���u���h WHERE �m�W='��'
SELECT @�s�� = ���h FROM ���u���h WHERE �m�W='��'
SELECT @���L = ���h FROM ���u���h WHERE �m�W='�A'

UPDATE ���u���h
SET ���h = ���h.GetReparentedValue(@�¤�, @�s��) 
WHERE ���h.IsDescendantOf(@���L) = 1 

SELECT ���h.ToString(), �m�W 
FROM ���u���h
ORDER BY ���h

GO 
����-- PD-15a

EXEC sp_tableoption '���y', 'text in row', '200'

GO 
����-- PD-15b

SELECT OBJECTPROPERTY (OBJECT_ID('���y'), 'TableTextInRowlimit')

