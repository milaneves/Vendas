unit uFrmAtualizaDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  ExtCtrls;

type
  TfrmAtualizaDB = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    lblAtualizaBD: TLabel;
    chkConexaoBD: TCheckBox;
    chkCategoria: TCheckBox;
    chkProduto: TCheckBox;
    chkVendas: TCheckBox;
    chkItensVendas: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtualizaDB: TfrmAtualizaDB;

implementation

{$R *.dfm}

end.
