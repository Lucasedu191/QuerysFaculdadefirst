create database DB_ControleLivros
use DB_ControleLivros

--------------------------------------------------------------------
create table TB_Assunto(
    Sigla char(1) primary key,
    Descr varchar(50))
insert into TB_Assunto values ('B', 'BANCO DE DADOS')
insert into TB_Assunto values ('P', 'PROGRAMA��O')
insert into TB_Assunto values ('R', 'REDES')
insert into TB_Assunto values ('S', 'SISTEMAS OPERACIONAIS')
insert into TB_Assunto values ('T', 'TEORIA GERAL DE SISTEMAS')
--------------------------------------------------------------------
create table TB_Editora(
    CodEditora int primary key,
    Nome varchar(80))
insert into TB_Editora values (1, 'MIRANDELA Editora')
insert into TB_Editora values (2, 'Editora Via-Norte')
insert into TB_Editora values (3, 'Editora Ilhas Tijucas')
insert into TB_Editora values (4, 'MARIA JOS� Editora')
insert into TB_Editora values (5, 'Editora Brasport')
--------------------------------------------------------------------    
create table TB_Autor(
	MatrAutor int primary key,
	NomeAutor varchar(80),
	CPFAutor varchar(12) NOT NULL UNIQUE,
	EndResidencialAutor varchar(120),
	DataNascimentoAutor date,
	NacionalidadeAutor  varchar(30)) 
insert into TB_Autor values (1,'Ramez Elmasri','456789012',' Isabel la Cat�lica 30 - Cidade do M�xico','04/04/1960','MEXICANA')
insert into TB_Autor values (2,'Shamkant B. Navathe','567890123','3700 O St NW - Washington, DC 20057','03/03/1965','NORTE AMERICANA')
insert into TB_Autor values (3,'Ralph Kimball','12345678','350 Fifth Avenue, 34th floor - New York','07/07/1980','NORTE AMERICANA')	
insert into TB_Autor values (4,'Mauricio Sucheuski','23456789','R.XV de Novembro,2222 - Curitiba-PR','06/06/1970','BRAS')
insert into TB_Autor values (5,'Margy Ross','34567890','25 Bedford St. - New York City, N.Y. 10014.','05/05/1970','NORTE AMERICANA')
insert into TB_Autor values (6,'Rog�rio Lu�s de C. Costa','789012345','R. XV de Novembro, 2222 - Curitiba-PR','02/02/1975','BRAS')
insert into TB_Autor values (7,'Marcelo Fermann Guimar�es','678901234','R. Konrad Adenauer, 442 - Tarum� - Curitiba-PR','02/02/1975','BRAS')
--------------------------------------------------------------------	
create table TB_Livro(
    CodLivro int primary key,
    Titulo varchar(80),
    Preco money,
    Lancamento date,
    Assunto char(1),
    Editora int,
    constraint FK_Assunto_Livro foreign key (Assunto) references TB_Assunto(Sigla),
    constraint FK_Editora_Livro foreign key (Editora) references TB_Editora(CodEditora))
insert into TB_Livro values(1,'BANCO DE DADOS PARA A WEB',31.20, '01/10/1999', 'B',1)
insert into TB_Livro values(2,'PROGRAMANDO EM LINGUAGEM C',30.00, '10/01/1997', 'P',1)
insert into TB_Livro values(3,'PROGRAMANDO EM LINGUAGEM C++',111.50, '11/01/1998', 'B',1)
insert into TB_Livro values(4,'BANCO DE DADOS NA BIOINFORM�TICA',48.00, NULL, 'B',2)
insert into TB_Livro values(5,'REDES DE COMPUTADORES',42.00, '09/01/1996', 'R',2)
--------------------------------------------------------------------    
create table TB_AutorLivro(
	CodLivro int,
	MatrAutor int,
	primary key (CodLivro, MatrAutor),
	constraint FK_Livro_AutorLivro foreign key (CodLivro) references TB_Livro(CodLivro),
	constraint FK_Autor_AutorLivro foreign key (MatrAutor) references TB_Autor(MatrAutor))
insert into TB_AutorLivro values (1,1)
insert into TB_AutorLivro values (1,2)
insert into TB_AutorLivro values (2,3)
insert into TB_AutorLivro values (3,4)
insert into TB_AutorLivro values (4,5)
insert into TB_AutorLivro values (5,6)

insert into TB_AutorLivro values (2,1)
insert into TB_AutorLivro values (3,1)

--------------------------------------------------------------------	

	