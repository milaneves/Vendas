object dtmConexaoPrincipal: TdtmConexaoPrincipal
  OldCreateOrder = False
  Height = 269
  Width = 508
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    SQLHourGlass = True
    HostName = '.\SQLEXPRESS'
    Port = 0
    Database = 'Vendas'
    User = ''
    Password = ''
    Protocol = 'mssql'
    LibraryLocation = 'C:\Users\Araujo\Documents\PROJETOS\vendas\Vendas-master\ntwdblib'
    Left = 40
    Top = 40
  end
  object QryScriptCategorias: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      ''
      'IF OBJECT_ID('#39'Categoria'#39') IS NULL'
      'begin'
      'CREATE TABLE Categoria('
      #9'CategoriaID int IDENTITY(1,1) NOT NULL,'
      #9'Descricao varchar(60) NOT NULL,'
      'PRIMARY KEY (CategoriaID) '
      ')'
      'end'
      '')
    Params = <>
    Left = 128
    Top = 40
  end
  object QryScriptProduto: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      ''
      ' IF OBJECT_ID('#39'Produtos'#39') IS NULL'
      'begin'
      'CREATE TABLE [dbo].[Produtos]('
      #9'[produtoId] [int] IDENTITY(1,1) NOT NULL,'
      #9'[nome] [varchar](60) NOT NULL,'
      #9'[descricao] [varchar](255) NOT NULL,'
      #9'[valor] [decimal](18, 5) NULL DEFAULT ((0.00000)),'
      #9'[quantidade] [decimal](18, 15) NULL DEFAULT ((0.00000)),'
      #9'[categoriaID] [int] NULL,'
      'PRIMARY KEY (produtoId), '
      ''
      'constraint  [Fk_ProdutorCategorias] '
      
        'FOREIGN KEY([categoriaID]) REFERENCES [dbo].[Categoria] ([Catego' +
        'riaID])'
      ')'
      'end'
      '')
    Params = <>
    Left = 232
    Top = 40
  end
  object QryScriptVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      ' IF OBJECT_ID('#39'Vendas'#39') IS NULL'
      'begin'
      'CREATE TABLE [dbo].[Vendas]('
      #9'[VendaId] [int] IDENTITY(1,1) NOT NULL,'
      #9'[clienteId] [int] NOT NULL,'
      #9'[dataVenda] [datetime] NULL,'
      #9'[totalVenda] [decimal](18, 5) NULL'
      ''
      #9'primary key (VendaId),'
      #9'constraint fk_vendasClientes foreign Key (clienteId)'
      #9'References clientes(clienteId)'
      ')  '
      ''
      'end'
      '')
    Params = <>
    Left = 320
    Top = 40
  end
  object QryScriptItensVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      ' IF OBJECT_ID('#39'VendasItens'#39') IS NULL'
      'begin '
      'CREATE TABLE [dbo].[VendasItens]('
      #9'[VendaId] [int] NOT NULL,'
      #9'[produtoId] [int] NOT NULL,'
      #9'[dataVenda] [datetime] NULL,'
      #9'[valorUnitario] [decimal](18, 5) NULL,'
      #9'[quantidade] [decimal](18, 5) NULL,'
      #9'[totalProduto] [decimal](18, 5) NULL,'
      'PRIMARY KEY (VendaId, produtoId )  ,'
      'constraint fk_vendasItensProdutos foreign key (produtoId)'
      'References produtos(produtoId)'
      ')'
      'end'
      '')
    Params = <>
    Left = 240
    Top = 120
  end
  object QryScriptClientes: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      ' IF OBJECT_ID('#39'Clientes'#39') IS NULL'
      'begin'
      'CREATE TABLE [dbo].[Clientes]('
      #9'[ClienteId] [int] IDENTITY(1,1) NOT NULL,'
      #9'[nome] [varchar](60) NOT NULL,'
      #9'[endereco] [varchar](60) NOT NULL,'
      #9'[cidade] [varchar](50) NOT NULL,'
      #9'[bairro] [varchar](40) NOT NULL,'
      #9'[estado] [varchar](2) NOT NULL,'
      #9'[cep] [varchar](10) NOT NULL,'
      #9'[telefone] [varchar](14) NOT NULL,'
      #9'[email] [varchar](70) NOT NULL,'
      #9'[dataNascimento] [datetime] NOT NULL,'
      'PRIMARY KEY ([ClienteId])'
      ')'
      'end'
      '')
    Params = <>
    Left = 120
    Top = 120
  end
end
