inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categoria'
  ClientHeight = 533
  ClientWidth = 781
  ExplicitWidth = 787
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgPrincipal: TPageControl
    Width = 781
    Height = 492
    ActivePage = tabListagem
    ExplicitWidth = 781
    ExplicitHeight = 492
    inherited tabListagem: TTabSheet
      ExplicitWidth = 773
      ExplicitHeight = 464
      inherited pnListagem: TPanel
        Width = 773
        ExplicitWidth = 773
        inherited mskPesquisar: TMaskEdit
          Text = ''
          TextHint = 'Digite sua Pesquisa'
        end
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 773
      ExplicitHeight = 464
      object edtCategoriaId: TLabeledEdit
        Tag = 2
        Left = 38
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
      object edtDescricao: TLabeledEdit
        Tag = 1
        Left = 38
        Top = 112
        Width = 283
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 1
      end
    end
  end
  inherited pnRodape: TPanel
    Top = 492
    Width = 781
    ExplicitTop = 492
    ExplicitWidth = 781
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnAlterar: TBitBtn
      Left = 172
      ExplicitLeft = 172
    end
    inherited btnGravar: TBitBtn
      Left = 253
      ExplicitLeft = 253
    end
  end
  inherited btnCancelar: TBitBtn
    Left = 91
    Top = 498
    Width = 78
    ExplicitLeft = 91
    ExplicitTop = 498
    ExplicitWidth = 78
  end
  inherited brnFechar: TBitBtn
    Left = 688
    Top = 498
    ExplicitLeft = 688
    ExplicitTop = 498
  end
  inherited btnApagar: TBitBtn
    Left = 334
    Top = 498
    ExplicitLeft = 334
    ExplicitTop = 498
  end
  inherited QryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'select categoriaId,'
      '          Descricao'
      'from categoria')
    Left = 640
    Top = 32
    object QryListagemCategoriaID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CategoriaID'
      Required = True
    end
    object QryListagemDescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 50
    end
  end
  inherited dsListagem: TDataSource
    Left = 704
    Top = 32
  end
end
