obs.1: a interpretação faz parte da avaliação
obs.2: utilize comentários para deixar mais claro em caso de dúvidas

/*1)
1a) Apresente os comandos SQL para criação da nova tabela conforme o modelo relacional abaixo:
   TB_Pais (#Cod_pais: texto (2),
            Nacionalidade: texto (30),
          Descr_pais:  texto (50))
*/

CREATE TABLE TB_Pais(
	Cod_pais varchar(2) primary key,
	Nacionalidade varchar(30),
	Descr_pais varchar(50)
)
/*
1b) Apresente os comandos SQL para incluir x registros de paises na tabela TB_Pais. Sendo que:
    x = resto da divisão por 10 da quantidade de caracteres do seu nome completo. Se resto igual 0, então x = 1
    Exemplo:    MARCELO FERMANN GUIMARAES = 23 caracteres  sem espaços
    23/10 = 2,3
    x = 3
    -> para o nome do exemplo deve-se inserir 3 países na tabela TB_Pais
*/

INSERT INTO TB_Pais VALUES('BR', 'BRASIL', 'PAÍS LOUCO') 
INSERT INTO TB_Pais VALUES('AR', 'ARGENTINA', 'PAÍS LOUCO') 
INSERT INTO TB_Pais VALUES('PO', 'PORTUGAL', 'PAÍS LOUCO')
/*
1c) Apresente os comandos SQL para incluir o código do pais na tabela TB_Autor como chave estrangeira incluindo a integridade referencial e excluindo a coluna NacionalidadeAutor (não é mais necessária).
    Tabela TB_Autor final:
    TB_Autor(#MatrAutor inteiro,
             NomeAutor texto (80),
             CPFAutor texto (12) ,
             EndResidencialAutor texto (120),
             DataNascimentoAutor data,
             PaisAutor texto (2),
             PaisAutor referencia TB_Pais (CodPais))
*/


ALTER TABLE TB_Autor
DROP COLUMN  NacionalidadeAutor

ALTER TABLE TB_Autor
ADD pais VARCHAR(2);

ALTER TABLE TB_Autor
ADD CONSTRAINT fk_pais FOREIGN KEY (pais) REFERENCES TB_Pais (Cod_pais)

UPDATE TB_Autor
SET pais = 'BR'






--> inserir a resposta

/*
2) Apresente, em ordem alfabética, o nome dos autores que tenham livros lançados, com data de nascimento, idade prevista no ano que vem e nacionalidade.
*/

select *  from TB_Autor  order by NomeAutor 


 /*
3) Apresente 2 comandos SQL que listem o Cod. Pais e Descrição do pais que não têm autores cadastrados.
*/

SELECT * FROM TB_AUTOR  inner join  TB_Pais on (Cod_pais = pais) WHERE PAIS IS NULL 

/*
4) Apresente a lista de paises cadastrados e o respX’ectivo total de autores incluindo países que eventualmente não tenham nenhum autor).
*/

select 
 
 *,
 (select count(*) from TB_Autor where pais = Cod_pais)
from 
  TB_Pais 
/*
5)   Apresente a lista de paises cadastrados e a respectiva quantidade total de autores que possuam pelo menos 2 livros lançados.
*/

select 
 
 *,
 ( SELECT COUNT(*) FROM TB_Autor A WHERE  (select count(*) from TB_AutorLivro WHERE A. MatrAutor = MatrAutor) > 2   )
from 
  TB_Pais

/*6)
6a) Observando a integridade referencial entre TB_Autor e TB_Endereco,
    apresente os comandos SQL para criação da nova tabela conforme o modelo relacional abaixo:
    TB_Endereco (#TipoEndereco: inteiro , /*1 - residencial , 2 - comercial , 3 - outro */
                #MatrAutor inteiro,
                MatrAutor referencia TB_Autor (MatrAutor)
                Descr_Endereco texto (120))
*/

CREATE TABLE TB_Endereco (
  TipoEndereco INT,
  MatrAutorEND INT,
  Descr_Endereco VARCHAR(120)
)

ALTER TABLE TB_Endereco
ADD CONSTRAINT fk_AUTOR FOREIGN KEY (MatrAutorEND) REFERENCES TB_Autor (MatrAutor)

/*
6b) Considerando que para Endereço Residencial o TipoEndereco deve ser 1, apresente comandos SQL para:
    - incluir os endereços residenciais dos autores na TB_Endereco e
    - excluir os endereços residenciais da TB_Autor
*/

INSERT INTO TB_Endereco(TipoEndereco, MatrAutorEND, Descr_Endereco)
SELECT 
  1,
  MatrAutor,
  EndResidencialAutor
FROM 
  TB_Autor

UPDATE TB_Autor
SET EndResidencialAutor = NULL

/*
6c) Apresente os comandos SQL para incluir x novos endereços na TB_Endereco. Sendo que:
    x = resto da divisão por 10 da quantidade de caracteres do seu nome completo. Se resto igual 0, então x = 1
    Exemplo:    MARCELO FERMANN GUIMARAES = 23 caracteres  sem espaços
    23/10 = 2,3
    x = 3
    -> para o nome do exemplo deve-se inserir 3 novos endereços na tabela TB_Endereco
*/

--NÃO CONSENGUI ENTENDER 

/*
7) Apresente, em ordem de nome de Pais, os assuntos de todos os livros que já tenham sido lançados, incluindo o nome dos autores e das respectivas Editoras
*/

SELECT DISTINCT Assunto, NomeAutor, Nome FROM TB_Livro A INNER JOIN TB_AutorLivro B ON (A.CodLivro = B.CodLivro) INNER JOIN TB_Autor C ON(C.MatrAutor = B.MatrAutor) INNER JOIN TB_Editora ON(A.Editora = Editora)
WHERE Lancamento IS NOT NULL 

/*
8) Apresente 2 comandos SQL diferentes que listem Matricula e Nome dos Autores que não têm endereço comercial cadastrado
              obs.: endereço comercial é aquele em que TipoEndereco = 2.
*/

SELECT MatrAutor AS MATRICULA, NomeAutor FROM TB_Autor A INNER JOIN TB_Endereco B ON (A.MatrAutor = B.MatrAutorEND) WHERE TipoEndereco <> 2

SELECT MatrAutor AS MATRICULA, NomeAutor FROM TB_Autor A,TB_Endereco B  WHERE A.MatrAutor = B.MatrAutorEND AND  TipoEndereco <> 2 

/*
9) Apresente a quantidade total de endereços cadastrados para cada matrícula e nome autor, incluindo os autores que eventualmente  não tenham nenhum endereço.
*/

SELECT 
(SELECT COUNT(*) FROM TB_Endereco WHERE A.MatrAutor = MatrAutor) QTDE,
  *
  FROM 
  TB_Autor A 

/*
10) Apresente, em ordem alfabética, o nome dos autores e a Descrição do Pais para os autores de livros que já tenham sido lançados que tenham menos de 3 Endereços cadastrados.
             Observação: incluir na listagem eventuais autores que não tenham endereços
*/

SELECT DISTINCT
  NomeAutor,
  Descr_pais
FROM
  TB_Livro A INNER JOIN TB_AutorLivro B ON (A.CodLivro = B.CodLivro) INNER JOIN TB_Autor C ON(C.MatrAutor = B.MatrAutor) INNER JOIN TB_Editora ON(A.Editora = Editora)
  inner join TB_Pais ON(Cod_pais = C.pais )
WHERE Lancamento IS NOT NULL AND (SELECT COUNT(*) FROM TB_Endereco WHERE MatrAutorEND = C.MatrAutor) < 3


SELECT * FROM TB_Autor
SELECT * FROM TB_Livro
SELECT * FROM TB_AutorLivro
SELECT * FROM TB_Pais
SELECT * FROM TB_Endereco
