���� -- ������Ʈw
USE �m��15

GO 
���� -- P15-3
DECLARE @TopProductID int
SET @TopProductID = dbo.GetTopProductID('2016')

SELECT �m�W, �ϰ�
FROM GetEmployeeFromProdId(@TopProductID)
WHERE �ϰ� = '�_��'

GO 
���� -- P15-8

/* �Ǧ^�b���w�~�פ��̺Z�P�����y */
CREATE FUNCTION GetTopProductID 
(@year varchar(5))
RETURNS int
BEGIN
    DECLARE @id int
    SELECT TOP 1 @id = ���y�s��
    FROM �q�� JOIN �q��ӥ�
               ON �q��.�q��Ǹ� =  �q��ӥ�.�q��Ǹ�
    WHERE DATEPART (YYYY, ���) = @year
    GROUP BY ���y�s��
    ORDER BY SUM(�ƶq) DESC
    IF @@ROWCOUNT = 0 
         RETURN 0
     RETURN @id
END
GO

SELECT dbo.GetTopProductID('2016') AS '���y�s��' 
GO

GO 
���� -- P15-9

CREATE TYPE NameValueTable AS TABLE  --  �إߡy�ϥΪ̩w�q��ƪ������z, 
(�W�� varchar(50), �ƭ� int )        --  ���t�i�W�١B�ƭȡj 2 �����
GO

CREATE FUNCTION �Ǧ^�̤j��
(@tab NameValueTable READONLY)
RETURNS varchar(50)
BEGIN
	DECLARE @maxName varchar(50)

	SELECT TOP 1 @maxName = �W��	-- ���[�`�ƶq���̤j��
	FROM @tab
	GROUP BY �W��					-- �̦W�٤���
	ORDER BY SUM(�ƭ�) DESC			-- �[�`�ƶq�û���Ƨ�   
	
	RETURN @maxName
END
GO

DECLARE @tab NameValueTable

INSERT @tab
SELECT �Ȥ�W��, �ƶq
FROM �X�f�O��

SELECT '�X�f�q�̤j���Ȥᬰ�G' + dbo.�Ǧ^�̤j��(@tab)

DELETE @tab

INSERT @tab
SELECT �Ѳ��W��, �ʶR�i��
FROM �Ѳ�����O��

SELECT  '�w�s�̦h���Ѳ����G' + dbo.�Ǧ^�̤j��(@tab)

GO 
���� -- P15-11a

CREATE FUNCTION �̰���d�߮��y
(@�� money, @�� money)
RETURNS TABLE
RETURN (SELECT ���y�s��, ���y�W��, ���
                FROM ���y
               WHERE ��� >=@�� AND ��� <= @��)
GO

SELECT * 
FROM �̰���d�߮��y(400, 450)
ORDER BY ���

GO 
���� -- P15-11b

SELECT *
FROM ::fn_helpcollations()

GO 
���� -- P15-14

/* ��X�Ҧ��t�d�P����w���y�������H�� */
CREATE FUNCTION GetEmployeeFromProdId
(@ProductId int)
RETURNS @Employee TABLE 
             ( ���u�s�� int NOT NULL,
  	           �m�W varchar (20) NOT NULL,
			   �ʧO char (2),
               �D�ޭ��u�s�� int, 
               ¾�� varchar (10),
               �ϰ� varchar (10))
BEGIN
    /* �N���~�t�d�H����ƥ[�J�n�Ǧ^�� @Employee ��*/
    INSERT @Employee
    SELECT ���u.* 
    FROM ���u JOIN ���y ON ���u�s�� = �t�d�H
    WHERE ���y�s�� = @ProductId

    /* �N�t�d�H�����u�s���s�J @id �� */
    DECLARE @id int
    SELECT @id  = ���u�s��
    FROM  @Employee

    /* �N�t�d�H�����ݾP����]�[�J�n�Ǧ^�� @Employee ��*/
    INSERT @Employee
    SELECT *
    FROM ���u 
    WHERE �D�ޭ��u�s�� = @id
   
    RETURN
END 

GO

SELECT *
FROM GetEmployeeFromProdId(6)

SELECT �m�W
FROM GetEmployeeFromProdId(6)
WHERE �ϰ� = '�_��'


GO 
���� -- P15-17

CREATE FUNCTION Calc
(@a int, @b int =3)
RETURNS int
BEGIN
    RETURN @a + @b
END
GO

SELECT dbo.Calc(5, 6)
SELECT dbo.Calc(5, Default)
GO
SELECT  dbo.Calc(5)

GO 
���� -- P15-18

CREATE FUNCTION NewID()
RETURNS varchar(5)
BEGIN
    DECLARE @id varchar(5), @i int

    /* ��X�ثe�̤j���s�� */
    SELECT TOP 1 @id = �s��
    FROM �X�f�O��
    ORDER BY �s�� DESC

    IF @@ROWCOUNT = 0   /* �p�G�S���O�� */
         RETURN 'A0001'

    SET @i = CAST(RIGHT(@id, 4) AS int) + 1
    SET @id = CAST(@i AS varchar)
    RETURN  'A' + REPLICATE('0', 4-LEN(@id)) + @id
END
GO
SELECT dbo.NewID()

GO 
���� -- P15-20

CREATE FUNCTION �p���u�f��
(@���O�s�� int, @��� money)
RETURNS money
BEGIN
    DECLARE @�u�f�� money
    SELECT @�u�f�� = �馩 * @���
    FROM ���y���O
    WHERE ���O�s�� = @���O�s��
    RETURN @�u�f��
END
GO

SELECT dbo.�p���u�f��(1, 20)

GO 
���� -- P15-25

CREATE SEQUENCE Seq123   -- �إ� Seq123 ���Ǫ���
START WITH 1          -- �� 1 �}�l����
INCREMENT BY 1        -- �C�� +1

CREATE SEQUENCE Seq246   -- �إ� Seq246 ���Ǫ���
START WITH 2          -- �� 2 �}�l����
INCREMENT BY 2        -- �C�� +2

SELECT NEXT VALUE FOR Seq123 AS ����1,  -- �� Seq123 ����
       NEXT VALUE FOR Seq246 AS ����2,  -- �� Seq246 ����
	   ���~�W��
FROM �X�X���q

GO 
���� -- P15-26

SELECT NEXT VALUE FOR Seq123 AS ����1, 
       NEXT VALUE FOR Seq246 AS ����2,
	   ���~�W��
FROM �мФ��q

ALTER SEQUENCE Seq123   -- �ק� Seq123 ���]�w
RESTART WITH -2      -- ���]�ҩl�s���� -2

SELECT NEXT VALUE FOR Seq123 AS ����1, 
       NEXT VALUE FOR Seq246 AS ����2,
	   ���~�W��
FROM �мФ��q

GO 
���� -- P15-30

CREATE SEQUENCE Seq0123
AS tinyint       -- �ϥ� tinyint ���O
START WITH 1     -- �}�l�Ȭ� 1
MAXVALUE 3       -- �̤j�Ȭ� 3
CYCLE            -- �n�`���s��

SELECT NEXT VALUE FOR Seq0123 AS �`���s��, ���~�W��
FROM �мФ��q

GO 
���� -- P15-32a

ALTER SEQUENCE Seq0123 
RESTART      -- �ѭ�Ӫ��}�l�ȭ��s�s��

SELECT NEXT VALUE FOR Seq0123 AS �`���s��

ALTER SEQUENCE Seq0123 
RESTART WITH 3      -- �ѷs���}�l�ȭ��s�s��

SELECT NEXT VALUE FOR Seq0123 AS �`���s��

GO 
���� -- P15-32b

DROP SEQUENCE Seq246, Seq0123

GO 
���� -- P15-35a

ALTER SEQUENCE Seq123 
RESTART WITH 1

DECLARE @var bigint = NEXT VALUE FOR Seq123
PRINT @var
SET @var = NEXT VALUE FOR Seq123
PRINT @var
SELECT @var = NEXT VALUE FOR Seq123
PRINT @var

GO 
���� -- P15-35b

SELECT NEXT VALUE FOR seq123 AS �Ǹ�, 
       ���~�W��, ����
INTO �j�j���q
FROM �X�X���q WHERE ���� = 500

INSERT �j�j���q
VALUES (NEXT VALUE FOR seq123, '��Ʈw���', 550)

SELECT * FROM  �j�j���q

GO 
���� -- P15-36a


UPDATE �j�j���q
SET �Ǹ� = NEXT VALUE FOR seq123
WHERE ���� = 500

SELECT * FROM  �j�j���q

GO 
���� -- P15-36b

ALTER TABLE �j�j���q
ADD DEFAULT NEXT VALUE FOR seq123 FOR �Ǹ�
  
INSERT �j�j���q (���~�W��, ����)
VALUES ('SQL�t�g', 780), ('��qSQL', 720)

SELECT * FROM  �j�j���q

GO 
���� -- P15-37

ALTER SEQUENCE Seq123 
RESTART WITH 1

SELECT NEXT VALUE FOR seq123 OVER(ORDER BY ���� DESC) AS ����ƦW, * 
FROM  �j�j���q

GO 
���� -- P15-38

DECLARE @�Ĥ@�� sql_variant,    -- �ŧi 2 ���ܼƨ��x�s���o���Ǹ�
        @�̫�� sql_variant

EXEC sp_sequence_get_range N'Seq123', 5,   -- �� Seq123 ���o 5 �ӳs��s��
        @�Ĥ@�� OUTPUT, @�̫�� OUTPUT     -- �ѰѼƶǦ^�s�����Ĥ@�Ȥγ̫��
  
SELECT @�Ĥ@�� AS �Ĥ@��, @�̫�� AS �̫��
