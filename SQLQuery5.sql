Select CONCAT (Nacionalidade, ', ' ,Descr_pais) from TB_Pais 

DECLARE @tb TABLE(
exemplo CHAR(15))

INSERT @tb VALUES ('Este é um teste')

SELECT Nacionalidade FROM TB_Pais
