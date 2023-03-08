●● -- 切換資料庫
USE 練習CC;

GO
●●-- PC-3

USE 練習CC;
GO

sp_fulltext_database 'enable';
GO

GO ●●-- PC-4

create fulltext catalog 全文目錄02

GO
●●-- PC-17a

SELECT * 
FROM 客戶
WHERE CONTAINS (地址, '師大路')

GO
●●-- PC-17b

SELECT * 
FROM 客戶
WHERE CONTAINS (地址, '  "Parkway Fremont" ')

GO
●●-- PC-17c

SELECT * 
FROM 客戶
WHERE CONTAINS (地址, ' "Parkway Fremont" 
                                OR "師大路" ')

GO
●●-- PC-18a

SELECT *
FROM 客戶
WHERE CONTAINS (地址, ' "Pa*" ')

GO
●●-- PC-18b

SELECT * 
FROM 客戶
WHERE CONTAINS (地址, ' "CA" NEAR "USA" ') 

GO
●●-- PC-19a

SELECT * 
FROM 客戶
WHERE CONTAINS (客戶名稱, 'FORMSOF (INFLECTIONAL, flag)' ,LANGUAGE 1033)

GO
●●-- PC-21a

SELECT * 
FROM 客戶
WHERE CONTAINS (地址, 
                'ISABOUT ( USA weight (0.8), 
                           重慶南路 weight (0.5), 
                           師大路 weight (0.1) )'
                )

GO
●●-- PC-21b

SELECT *
FROM 客戶
WHERE FREETEXT (*, ' Fremont CA USA ',LANGUAGE 1033)

GO
●●-- PC-22

SELECT 客戶編號, 地址, My_Table.*
FROM 客戶
       INNER JOIN 
         CONTAINSTABLE (客戶, 地址, ' 羅斯福 OR 一段 OR USA ' )
            AS My_Table
       ON 客戶編號 = My_Table.[KEY] 
ORDER BY My_Table.RANK DESC 

GO
●●-- PC-23a

SELECT 地址, My_Table.RANK
FROM 客戶
        INNER JOIN
          CONTAINSTABLE (客戶, 地址, ' ISABOUT ( 南京  WEIGHT(0.1), 
                                一段  WEIGHT(0.4), 敦化 WEIGHT(0.7) )', 3 )
                         AS My_Table
        ON 客戶編號 = My_Table.[KEY] 


GO
●●-- PC-23b

SELECT 地址, My_Table.*
FROM 客戶
      INNER JOIN FREETEXTTABLE (客戶, 地址, '88 Bayside', LANGUAGE 1033)
          AS My_Table
      ON 客戶編號 = My_Table.[KEY]


GO
●●-- PC-26a

SELECT 編號, 姓名, 性別
FROM 應徵者
WHERE CONTAINS (自傳, 'xml' )

GO
●●-- PC-26b

SELECT 編號, 姓名, 性別
FROM 應徵者
WHERE CONTAINS (自傳, ' "SQL Server"  OR HTML' )
