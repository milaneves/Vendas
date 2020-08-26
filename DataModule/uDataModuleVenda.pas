unit uDataModuleVenda;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TdtmVenda = class(TDataModule)
    QryClientes: TZQuery;
    QryProdutos: TZQuery;
    QryClientesClienteId: TIntegerField;
    QryClientesnome: TWideStringField;
    QryProdutosprodutoId: TIntegerField;
    QryProdutosnome: TWideStringField;
    QryProdutosvalor: TFloatField;
    QryProdutosquantidade: TFloatField;
    cdsItensVenda: TClientDataSet;
    dtsCliente: TDataSource;
    dtsProdutos: TDataSource;
    dtsItensVenda: TDataSource;
    cdsItensVendaProdutoId: TIntegerField;
    cdsItensVendaNomeProduto: TStringField;
    cdsItensVendaQuantidade: TFloatField;
    cdsItensVendaValorUnitario: TFloatField;
    cdsItensVendaValorTotalProduto: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmVenda: TdtmVenda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDataModuleConexao;

{$R *.dfm}

procedure TdtmVenda.DataModuleCreate(Sender: TObject);
begin
  cdsItensVenda.CreateDataSet;
  QryProdutos.Open;
  QryClientes.Open;
end;

procedure TdtmVenda.DataModuleDestroy(Sender: TObject);
begin
  cdsItensVenda.Close;
  QryProdutos.Close;
  QryClientes.Close;
end;

end.
