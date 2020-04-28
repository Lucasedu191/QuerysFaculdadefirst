create table TB_Pais(
CodPais int primary key,
Nacionalidade varchar (30),
Descr_pais  varchar (50)
)

insert into TB_Pais values (1, 'Estados Unidos', 'continente americano.')
insert into TB_Pais values (2, 'Africa do Sul',	'Localizado entre os oceanos Atlântico e Índico.')
insert into TB_Pais values (3, 'Autralia', 'Localizado na Oceania')


INSERT INTO TB_Pais VALUES(4, 'BRASIL', 'PAÍS LOUCO') 
INSERT INTO TB_Pais VALUES(5, 'ARGENTINA', 'PAÍS LOUCO') 
INSERT INTO TB_Pais VALUES(6, 'PORTUGAL', 'PAÍS LOUCO')


SELECT Nacionalidade, CONVERT(int,Nacionalidade) FROM TB_Pais

select dataLength ('LUCAS EDUARDO LUZ DA SILVA')

Select  Count (Nacionalidade) from TB_Pais

SELECT SUBSTRING(Nacionalidade, 1,5) FROM TB_Pais