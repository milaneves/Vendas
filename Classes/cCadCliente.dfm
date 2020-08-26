inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 647
  ClientWidth = 910
  ExplicitWidth = 916
  ExplicitHeight = 676
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgPrincipal: TPageControl
    Width = 910
    Height = 606
    inherited tabListagem: TTabSheet
      inherited pnListagem: TPanel
        Width = 902
      end
      inherited grdListagem: TDBGrid
        Left = 0
        Columns = <
          item
            Expanded = False
            FieldName = 'ClienteId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 22
      ExplicitWidth = 902
      ExplicitHeight = 578
      object lblCEP: TLabel
        Left = 520
        Top = 95
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lblTelefone: TLabel
        Left = 526
        Top = 196
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object lblDtNascimento: TLabel
        Left = 36
        Top = 293
        Width = 81
        Height = 13
        Caption = 'Data Nascimento'
      end
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
      object LabeledEdit1: TLabeledEdit
        Tag = 1
        Left = 36
        Top = 114
        Width = 478
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 60
        TabOrder = 1
      end
      object edtCEP: TMaskEdit
        Tag = 1
        Left = 520
        Top = 114
        Width = 197
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Tag = 1
        Left = 36
        Top = 164
        Width = 480
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        TabOrder = 3
      end
      object edtBairro: TLabeledEdit
        Tag = 1
        Left = 522
        Top = 164
        Width = 197
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 40
        TabOrder = 4
      end
      object edtCidade: TLabeledEdit
        Tag = 1
        Left = 36
        Top = 215
        Width = 416
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 30
        TabOrder = 5
      end
      object edtTelefone: TMaskEdit
        Tag = 1
        Left = 526
        Top = 214
        Width = 198
        Height = 21
        EditMask = '(99)9999-9999;'
        MaxLength = 13
        TabOrder = 6
        Text = '(  )    -    '
      end
      object edtEmail: TLabeledEdit
        Tag = 1
        Left = 36
        Top = 263
        Width = 484
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        MaxLength = 30
        TabOrder = 7
      end
      object edtDtNascimento: TDateTimePicker
        Tag = 1
        Left = 36
        Top = 312
        Width = 91
        Height = 21
        Date = 44056.403842557870000000
        Time = 44056.403842557870000000
        TabOrder = 8
      end
      object edtEstado: TLabeledEdit
        Tag = 1
        Left = 458
        Top = 215
        Width = 58
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Estado'
        MaxLength = 2
        TabOrder = 9
      end
    end
  end
  inherited pnRodape: TPanel
    Top = 606
    Width = 910
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited btnCancelar: TBitBtn
    Top = 612
    ExplicitTop = 612
  end
  inherited brnFechar: TBitBtn
    Left = 825
    Top = 601
    ExplicitLeft = 825
    ExplicitTop = 368
  end
  inherited btnApagar: TBitBtn
    Left = 340
    Top = 612
    ExplicitLeft = 340
    ExplicitTop = 612
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select        ClienteId,'
      '                  nome,'
      #9'   endereco,'
      #9'   cidade,'
      #9'   bairro,'
      #9'   estado,'
      #9'   cep,'
      #9'   telefone,'
      #9'   email,'
      #9'   dataNascimento'
      'from clientes')
    object QryListagemClienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ClienteId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryListagemendereco: TWideStringField
      DisplayLabel = 'Endereco'
      FieldName = 'endereco'
      Required = True
      Size = 60
    end
    object QryListagemcidade: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Required = True
      Size = 50
    end
    object QryListagembairro: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Required = True
      Size = 40
    end
    object QryListagemestado: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Required = True
      Size = 2
    end
    object QryListagemcep: TWideStringField
      DisplayLabel = 'Cep'
      FieldName = 'cep'
      Required = True
      Size = 10
    end
    object QryListagemtelefone: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Required = True
      Size = 14
    end
    object QryListagememail: TWideStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Required = True
      Size = 70
    end
    object QryListagemdataNascimento: TDateTimeField
      DisplayLabel = 'Data Nascimento'
      FieldName = 'dataNascimento'
      Required = True
    end
  end
end
