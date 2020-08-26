 IF OBJECT_ID('Clientes') IS NULL
begin
CREATE TABLE [dbo].[Clientes](
	[ClienteId] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](60) NOT NULL,
	[endereco] [varchar](60) NOT NULL,
	[cidade] [varchar](50) NOT NULL,
	[bairro] [varchar](40) NOT NULL,
	[estado] [varchar](2) NOT NULL,
	[cep] [varchar](10) NOT NULL,
	[telefone] [varchar](14) NOT NULL,
	[email] [varchar](70) NOT NULL,
	[dataNascimento] [datetime] NOT NULL,
PRIMARY KEY ([ClienteId])
)
end


IF OBJECT_ID('Categoria') IS NULL
begin
CREATE TABLE Categoria(
	CategoriaID int IDENTITY(1,1) NOT NULL,
	Descricao varchar(60) NOT NULL,
PRIMARY KEY (CategoriaID) 
)
end



 IF OBJECT_ID('Produtos') IS NULL
begin
CREATE TABLE [dbo].[Produtos](
	[produtoId] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](60) NOT NULL,
	[descricao] [varchar](255) NOT NULL,
	[valor] [decimal](18, 5) NULL DEFAULT ((0.00000)),
	[quantidade] [decimal](18, 15) NULL DEFAULT ((0.00000)),
	[categoriaID] [int] NULL,
PRIMARY KEY (produtoId), 

constraint  [Fk_ProdutorCategorias] 
FOREIGN KEY([categoriaID]) REFERENCES [dbo].[Categoria] ([CategoriaID])
)
end


 IF OBJECT_ID('Vendas') IS NULL
begin
CREATE TABLE [dbo].[Vendas](
	[VendaId] [int] IDENTITY(1,1) NOT NULL,
	[clienteId] [int] NOT NULL,
	[dataVenda] [datetime] NULL,
	[totalVenda] [decimal](18, 5) NULL

	primary key (VendaId),
	constraint fk_vendasClientes foreign Key (clienteId)
	References clientes(clienteId)
)  

end


 IF OBJECT_ID('VendasItens') IS NULL
begin 
CREATE TABLE [dbo].[VendasItens](
	[VendaId] [int] NOT NULL,
	[produtoId] [int] NOT NULL,
	[dataVenda] [datetime] NULL,
	[valorUnitario] [decimal](18, 5) NULL,
	[quantidade] [decimal](18, 5) NULL,
	[totalProduto] [decimal](18, 5) NULL,
PRIMARY KEY (VendaId, produtoId )  ,
constraint fk_vendasItensProdutos foreign key (produtoId)
References produtos(produtoId)
)
end







 