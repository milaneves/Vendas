object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 261
  Width = 429
  object QryClientes: TZQuery
    Connection = dtmConexaoPrincipal.ConexaoDB
    SQL.Strings = (
      'select ClienteId,'
      '     nome'
      'from clientes')
    Params = <>
    Left = 40
    Top = 40
    object QryClientesClienteId: TIntegerField
      DisplayLabel = 'Codigo'
      FieldName = 'ClienteId'
      ReadOnly = True
    end
    object QryClientesnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmConexaoPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtoId,'
      '       nome,'
      #9'   valor,'
      #9'   quantidade'
      'FROM Produtos')
    Params = <>
    Left = 112
    Top = 40
    object QryProdutosprodutoId: TIntegerField
      DisplayLabel = 'Codigo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryProdutosnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryProdutosvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object QryProdutosquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 40
    object cdsItensVendaProdutoId: TIntegerField
      DisplayLabel = 'Codigo'
      FieldName = 'ProdutoId'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaQuantidade: TFloatField
      FieldName = 'Quantidade'
    end
    object cdsItensVendaValorUnitario: TFloatField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'ValorUnitario'
    end
    object cdsItensVendaValorTotalProduto: TFloatField
      FieldName = 'ValorTotalProduto'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryClientes
    Left = 32
    Top = 128
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 104
    Top = 128
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 192
    Top = 128
  end
end
