USE [TesteBicicleta]
GO

/****** Object:  Table [dbo].[TB_Pessoa]    Script Date: 20/11/2019 18:49:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_Pessoa](
	[CodPessoa] [int] NOT NULL,
	[TipoPessoa] [varchar](2) NOT NULL,
	[EstiloNome] [tinyint] NOT NULL,
	[Vocativo] [varchar](4) NOT NULL,
	[PrimeiroNome] [varchar](50) NOT NULL,
	[NomeMeio] [varchar](50) NOT NULL,
	[Sobrenome] [varchar](50) NOT NULL,
	[Sufixo] [varchar](10) NOT NULL,
	[MalaDireta] [tinyint] NOT NULL,
	[InfoXml] [xml] NULL,
	[InfoUtilOnline] [text] NULL,
	[DataHoraAtu] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CodPessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


