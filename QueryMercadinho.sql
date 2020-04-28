CREATE DATABASE MercadinhoOLTPAluno
USE MercadinhoOLTPAluno

/* CRIA��O DAS TABELAS  */
CREATE TABLE tbCliente
( ClienteID INT IDENTITY(1,1) PRIMARY KEY,
  ClienteNome VARCHAR(50),
  ClienteTelefone VARCHAR(15),
  ClienteDataCadastro DATE)

 CREATE TABLE tbPagamento
( PagamentoID INT IDENTITY(1,1) PRIMARY KEY,
  ClienteID INT,
  PedidoID INT,
  PagamentoValor DECIMAL(8,2),
  PagamentoData DATE)

CREATE TABLE tbPedido
( PedidoID INT IDENTITY(1,1) PRIMARY KEY,
  PedidoData DATE,
  ClienteID INT)

CREATE TABLE tbProduto
( ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
  ProdutoNome VARCHAR(50),
  ProdutoValor DECIMAL(5,2))

CREATE TABLE tbPedidoItem
( PedidoItemID INT IDENTITY(1,1) PRIMARY KEY,
  PedidoID INT,
  ProdutoID INT)

ALTER TABLE tbPagamento  WITH CHECK 
ADD  CONSTRAINT FK_tbPagamento_tbCliente
FOREIGN KEY(ClienteID) REFERENCES tbCliente (ClienteID)

ALTER TABLE tbPagamento  WITH CHECK 
ADD  CONSTRAINT FK_tbPagamento_tbPedido
FOREIGN KEY(PedidoID) REFERENCES tbPedido (PedidoID)

ALTER TABLE tbPedido  WITH CHECK 
ADD  CONSTRAINT FK_tbPedido_tbCliente
FOREIGN KEY(ClienteID) REFERENCES tbCliente (ClienteID)

ALTER TABLE tbPedidoItem  WITH CHECK 
ADD  CONSTRAINT FK_tbPedidoItem_tbPedido
FOREIGN KEY(PedidoID) REFERENCES tbPedido (PedidoID)

ALTER TABLE tbPedidoItem  WITH CHECK 
ADD  CONSTRAINT FK_tbPedidoItem_tbProduto
FOREIGN KEY(ProdutoID) REFERENCES tbProduto (ProdutoID)

CREATE TABLE tbVendedor
(VendedorID INT IDENTITY(1,1) PRIMARY KEY,
  VendedorNome VARCHAR(50),
  VendedorRG   VARCHAR(15),
  VendedorDataAdmissao DATE)

/*  INSERT DE DADOS ALEAT�RIOS    */
-- 10.000 Clientes
INSERT INTO tbCliente (ClienteNome, ClienteTelefone, ClienteDataCadastro)
       VALUES (NEWID(), '(XX) 1234-5678', CONVERT(DATE,CONVERT(DATETIME, CONVERT(INT,(RAND()*356)+40710))))
GO 10000

-- 100 Produtos
INSERT INTO tbProduto(ProdutoNome, ProdutoValor)
VALUES ( NEWID(), CONVERT(DECIMAL(5,2),(RAND()*100)+1,2)  )
GO 100

-- 1.000 Pedidos
WITH Clientes AS
( SELECT ClienteID, CONVERT(DATE, DATEADD(DAY,RAND()*100,CONVERT(DATETIME,ClienteDataCadastro))) [ClienteDataCadastro]
FROM tbCliente
WHERE ClienteID = CONVERT(INT,(RAND()*10000)+1) )
INSERT INTO tbPedido(ClienteID,PedidoData)
SELECT ClienteID, ClienteDataCadastro FROM Clientes
GO 1000

-- 2.500 Itens nos Pedidos
INSERT INTO tbPedidoItem(PedidoID, ProdutoID)
SELECT (SELECT CONVERT(INT,RAND()*MAX(PedidoID)-1) FROM tbPedido)
,(SELECT CONVERT(INT,RAND()*MAX(ProdutoID)-1) FROM tbProduto)
GO 2500

-- Itens de Pagamento
INSERT INTO tbPagamento (ClienteID, PedidoID, PagamentoValor, PagamentoData)
   SELECT PE.ClienteID, PE.PedidoID, SUM(PR.ProdutoValor), CONVERT(DATE, DATEADD(DAY,RAND()*5, CONVERT(DATETIME,PE.PedidoData))) 
FROM tbPedido PE
INNER JOIN tbPedidoItem PI ON PE.PedidoID = PI.PedidoID
INNER JOIN tbProduto PR ON PR.ProdutoID = PI.ProdutoID
GROUP BY PE.ClienteID, PE.PedidoID, CONVERT(DATE, DATEADD(DAY,RAND()*5, CONVERT(DATETIME,PE.PedidoData)))
ORDER BY ClienteID, PedidoID

-- 3 vendedores
INSERT INTO tbVendedor (VendedorNome, VendedorRG, VendedorDataAdmissao)
       VALUES (NEWID(), 
       CONVERT(VARCHAR,(CONVERT(INT,(RAND()*100000000+1)))) , 
       CONVERT(DATE,CONVERT(DATETIME, CONVERT(INT,(RAND()*356)+40710))))
GO 3

CREATE TABLE tbPessoa
( ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
  ProdutoNome VARCHAR(50))

 SELECT cliente.ClienteNome, pedido.PedidoID, pedido.PedidoData, pagamento.PagamentoValor , 
 pagamento.PagamentoData, pagamento.PagamentoID, produto.ProdutoNome FROM 
TbCliente AS cliente
FULL OUTER JOIN tbPedido AS pedido ON pedido.PedidoID = cliente.ClienteID 
FULL OUTER JOIN tbPagamento AS pagamento ON pagamento.PagamentoID = pedido.PedidoID
FULL OUTER JOIN tbProduto AS produto ON produto.produtoID = pagamento.PagamentoID
WHERE pagamento.PagamentoValor > 80;

SELECT T1.ClienteID ,T1.ClienteNome,T1.ClienteTelefone 
FROM tbCliente T1 
inner join tbPedido T2 on T2.ClienteID = T1.ClienteID
inner JOIN tbPedidoItem T3  on T3.PedidoID = T2.PedidoID
inner join tbProduto T4  on T3.ProdutoID = t4.ProdutoID
group by T1.ClienteID ,T1.ClienteNome,T1.ClienteTelefone 
having count (T4.ProdutoValor) > 100

SELECT cliente.ClienteID, pessoa.PessoaNome, pagamento.PagamentoValor 
	FROM tbPessoa AS pessoa
	FULL OUTER JOIN tbCliente AS cliente ON pessoa.PessoaID = cliente.ClienteID
	FULL OUTER JOIN tbPagamento AS pagamento ON pagamento.PagamentoID = cliente.ClienteID;
	

	
	select ProdutoID, ProdutoNome, ProdutoValor from tbProduto where not exists 
       (select 'x' from tbPedidoItem where tbPedidoItem.ProdutoID = tbProduto.ProdutoID)
	

	select ProdutoID, ProdutoNome, ProdutoValor from tbProduto where tbProduto.ProdutoID NOT IN
       (select tbPedidoItem.ProdutoID from tbPedidoItem)

	   ALTER TABLE tbPessoa
(PessoaID INT IDENTITY(1,1) PRIMARY KEY,
  PessoaNome VARCHAR(50))