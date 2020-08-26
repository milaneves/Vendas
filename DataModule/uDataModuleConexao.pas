unit uDataModuleConexao;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TdtmConexaoPrincipal = class(TDataModule)
    ConexaoDB: TZConnection;
    QryScriptCategorias: TZQuery;
    QryScriptProduto: TZQuery;
    QryScriptVendas: TZQuery;
    QryScriptItensVendas: TZQuery;
    QryScriptClientes: TZQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmConexaoPrincipal: TdtmConexaoPrincipal;

implementation

{$R *.dfm}

end.
