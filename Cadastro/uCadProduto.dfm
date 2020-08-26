inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 544
  ExplicitTop = 2
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgPrincipal: TPageControl
    Height = 503
    ActivePage = tabListagem
    ExplicitHeight = 503
    inherited tabListagem: TTabSheet
      ExplicitHeight = 475
      inherited grdListagem: TDBGrid
        Left = 0
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            ReadOnly = True
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitHeight = 475
      object lblDescricao: TLabel
        Left = 6
        Top = 152
        Width = 46
        Height = 13
        Caption = 'Descri'#231'ao'
      end
      object Label1: TLabel
        Left = 3
        Top = 416
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label2: TLabel
        Left = 92
        Top = 416
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object lblCategoria: TLabel
        Left = 490
        Top = 99
        Width = 46
        Height = 13
        Caption = 'Descri'#231'ao'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 2
        Left = 6
        Top = 56
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 1
        Left = 6
        Top = 118
        Width = 478
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtDescricao: TMemo
        Tag = 1
        Left = 6
        Top = 171
        Width = 478
        Height = 225
        Lines.Strings = (
          'edtDescricao')
        TabOrder = 3
      end
      object combCategoria: TDBLookupComboBox
        Left = 490
        Top = 118
        Width = 271
        Height = 21
        KeyField = 'CategoriaID'
        ListField = 'Descricao'
        ListSource = dtsCategoria
        TabOrder = 2
      end
      object edtValor: TCurrencyEdit
        Left = 3
        Top = 435
        Width = 83
        Height = 21
        TabOrder = 4
      end
      object edtQuantidade: TCurrencyEdit
        Left = 92
        Top = 435
        Width = 83
        Height = 21
        DisplayFormat = ',0.00;-R$ ,0.00'
        TabOrder = 5
      end
    end
  end
  inherited pnRodape: TPanel
    Top = 503
    ExplicitTop = 503
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited btnCancelar: TBitBtn
    Top = 509
    ExplicitTop = 509
  end
  inherited brnFechar: TBitBtn
    Top = 514
    ExplicitTop = 514
  end
  inherited btnApagar: TBitBtn
    Top = 509
    ExplicitTop = 509
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select    a.produtoId,'
      '             a.descricao,'
      '             a.nome,'
      '             a.valor,'
      '            a.quantidade,'
      '            b.categoriaID,'
      '            b.Descricao as DescricaoCategoria'
      
        'from Produtos as a left join Categoria as b on (a.categoriaID = ' +
        'b.CategoriaID)')
    Left = 792
    Top = 32
    object QryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 255
    end
    object QryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object QryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object QryListagemcategoriaID: TIntegerField
      DisplayLabel = 'C'#243'digo Categoria'
      FieldName = 'categoriaID'
      ReadOnly = True
    end
    object QryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Descri'#231#227'o Categoria'
      FieldName = 'DescricaoCategoria'
      Required = True
      Size = 60
    end
  end
  inherited dsListagem: TDataSource
    Top = 32
  end
  object QryCategoria: TZQuery
    Connection = dtmConexaoPrincipal.ConexaoDB
    SQL.Strings = (
      'select CategoriaID,Descricao'
      'from Categoria')
    Params = <>
    Left = 552
    Top = 56
    object QryCategoriaCategoriaID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CategoriaID'
      ReadOnly = True
    end
    object QryCategoriaDescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 60
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 616
    Top = 56
  end
end
