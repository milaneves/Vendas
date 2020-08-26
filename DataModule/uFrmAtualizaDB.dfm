object frmAtualizaDB: TfrmAtualizaDB
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmAtualizaDB'
  ClientHeight = 278
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 278
    Align = alClient
    BevelOuter = bvLowered
    BevelWidth = 3
    BorderWidth = 3
    Color = clBackground
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 6
      Top = 6
      Width = 639
      Height = 266
      Align = alClient
      Color = clWhite
      Enabled = False
      ParentBackground = False
      TabOrder = 0
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 256
        Height = 256
        AutoSize = True
      end
      object lblAtualizaBD: TLabel
        Left = 320
        Top = 32
        Width = 252
        Height = 24
        Caption = 'Atualiza'#231#227'o Banco de Dados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object chkConexaoBD: TCheckBox
        Left = 320
        Top = 80
        Width = 209
        Height = 17
        Caption = 'Conex'#227'o com Banco de Dados'
        TabOrder = 0
      end
      object chkCategoria: TCheckBox
        Left = 320
        Top = 103
        Width = 209
        Height = 17
        Caption = 'Categoria'
        TabOrder = 1
      end
      object chkProduto: TCheckBox
        Left = 320
        Top = 126
        Width = 209
        Height = 17
        Caption = 'Produto'
        TabOrder = 2
      end
      object chkVendas: TCheckBox
        Left = 320
        Top = 149
        Width = 209
        Height = 17
        Caption = 'Vendas'
        TabOrder = 3
      end
      object chkItensVendas: TCheckBox
        Left = 320
        Top = 172
        Width = 209
        Height = 17
        Caption = 'Itens Vendas'
        TabOrder = 4
      end
    end
  end
end
