���� -- ������Ʈw
USE �m��CC;

GO
����-- PC-3

USE �m��CC;
GO

sp_fulltext_database 'enable';
GO

GO ����-- PC-4

create fulltext catalog ����ؿ�02

GO
����-- PC-17a

SELECT * 
FROM �Ȥ�
WHERE CONTAINS (�a�}, '�v�j��')

GO
����-- PC-17b

SELECT * 
FROM �Ȥ�
WHERE CONTAINS (�a�}, '  "Parkway Fremont" ')

GO
����-- PC-17c

SELECT * 
FROM �Ȥ�
WHERE CONTAINS (�a�}, ' "Parkway Fremont" 
                                OR "�v�j��" ')

GO
����-- PC-18a

SELECT *
FROM �Ȥ�
WHERE CONTAINS (�a�}, ' "Pa*" ')

GO
����-- PC-18b

SELECT * 
FROM �Ȥ�
WHERE CONTAINS (�a�}, ' "CA" NEAR "USA" ') 

GO
����-- PC-19a

SELECT * 
FROM �Ȥ�
WHERE CONTAINS (�Ȥ�W��, 'FORMSOF (INFLECTIONAL, flag)' ,LANGUAGE 1033)

GO
����-- PC-21a

SELECT * 
FROM �Ȥ�
WHERE CONTAINS (�a�}, 
                'ISABOUT ( USA weight (0.8), 
                           ���y�n�� weight (0.5), 
                           �v�j�� weight (0.1) )'
                )

GO
����-- PC-21b

SELECT *
FROM �Ȥ�
WHERE FREETEXT (*, ' Fremont CA USA ',LANGUAGE 1033)

GO
����-- PC-22

SELECT �Ȥ�s��, �a�}, My_Table.*
FROM �Ȥ�
       INNER JOIN 
         CONTAINSTABLE (�Ȥ�, �a�}, ' ù���� OR �@�q OR USA ' )
            AS My_Table
       ON �Ȥ�s�� = My_Table.[KEY] 
ORDER BY My_Table.RANK DESC 

GO
����-- PC-23a

SELECT �a�}, My_Table.RANK
FROM �Ȥ�
        INNER JOIN
          CONTAINSTABLE (�Ȥ�, �a�}, ' ISABOUT ( �n��  WEIGHT(0.1), 
                                �@�q  WEIGHT(0.4), ���� WEIGHT(0.7) )', 3 )
                         AS My_Table
        ON �Ȥ�s�� = My_Table.[KEY] 


GO
����-- PC-23b

SELECT �a�}, My_Table.*
FROM �Ȥ�
      INNER JOIN FREETEXTTABLE (�Ȥ�, �a�}, '88 Bayside', LANGUAGE 1033)
          AS My_Table
      ON �Ȥ�s�� = My_Table.[KEY]


GO
����-- PC-26a

SELECT �s��, �m�W, �ʧO
FROM ���x��
WHERE CONTAINS (�۶�, 'xml' )

GO
����-- PC-26b

SELECT �s��, �m�W, �ʧO
FROM ���x��
WHERE CONTAINS (�۶�, ' "SQL Server"  OR HTML' )
