unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, uDataModuleVenda, uEnum, cProVenda, uDataModuleConexao;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    QryListagemVendaId: TIntegerField;
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdataVenda: TDateTimeField;
    QryListagemtotalVenda: TFloatField;
    edtVendaId: TLabeledEdit;
    combCliente: TDBLookupComboBox;
    lblCliente: TLabel;
    edtDataVenda: TDateTimePicker;
    lblDtVenda: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    lblProduto: TLabel;
    Label1: TLabel;
    lblQuantidade: TLabel;
    lblTotalProduto: TLabel;
    combProduto: TDBLookupComboBox;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionar: TBitBtn;
    btnRemover: TBitBtn;
    Panel4: TPanel;
    lblValorVenda: TLabel;
    edtValorVenda: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure combProdutoExit(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
    dtmVenda:TdtmVenda;
    oVenda:TVenda;
    function Apagar:boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function TotalizarProduto(ValorUnitario, Quantidade: Double): Double;
    procedure LimparComponentesItem;
    procedure LimparCds;
  public
    { Public declarations }

  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}


function TfrmProVenda.Apagar: boolean;
begin
if oVenda.Selecionar(Qrylistagem.FieldByName('vendaId').AsInteger) then
begin
  Result:=oVenda.Apagar;
end;

end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
   if edtVendaId.Text<>EmptyStr then
    oVenda.vendaId:=StrToInt(edtVendaId.Text)
   else
    oVenda.vendaId:= 0;
    oVenda.clienteId:= combCliente.KeyValue;
    oVenda.dataVenda:= edtDataVenda.Date;
    oVenda.totalVenda:= edtValorVenda.Value;

    if EstadoDoCadastro = ecInserir then
    Result:=oVenda.Inserir
    else if EstadoDoCadastro = ecAlterar then
    Result:=oVenda.Atualizar;

end;

procedure TfrmProVenda.btnAdicionarClick(Sender: TObject);
begin
  inherited;
   if combProduto.KeyValue = Null then
   begin
     MessageDlg('Produto � um campo obrigat�rio', mtInformation,[mbOK],0);
     combProduto.SetFocus;
     abort;
   end;

    if edtValor.value <= 0 then
   begin
     MessageDlg('Valor Unit�rio n�o pode ser zero', mtInformation,[mbOK],0);
     edtValor.SetFocus;
     abort;
   end;

    if edtQuantidade.value <= 0 then
   begin
     MessageDlg('quantidade n�o pode ser zero', mtInformation,[mbOK],0);
     combProduto.SetFocus;
     abort;
   end;

   if dtmVenda.cdsItensVenda.Locate('produtoId', combProduto.KeyValue,[])then
   begin
    MessageDlg('Este produto j� foi selecionado', mtInformation,[mbOK],0);
    combProduto.SetFocus;
    abort;
   end;

   edtTotalProduto.Value:= TotalizarProduto(edtValor.Value, edtQuantidade.Value);

   dtmVenda.cdsItensVenda.Append;
   dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString:=combProduto.KeyValue ;
   dtmVenda.cdsItensVenda.FieldByName('nomeproduto').AsString:=dtmVenda.QryProdutos.FieldByName('nome').AsString;
   dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat:=edtQuantidade.Value;
   dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat:=edtValor.Value;
   dtmVenda.cdsItensVenda.FieldByName('ValorTotalProduto').AsFloat:=edtTotalProduto.Value;
   dtmVenda.cdsItensVenda.Post;
   LimparComponentesItem;

   combProduto.SetFocus;

end;
procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
  LimparComponentesItem;

end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  LimparCds;
  LimparComponentesItem;

end;

procedure TfrmProVenda.LimparComponentesItem;
begin
 combProduto.KeyValue  := null;
 edtQuantidade.Value   :=  0 ;
 edtValor.Value        :=  0;
 edtTotalProduto.Value :=  0;
end;

procedure TfrmProVenda.LimparCds;
begin
  while not dtmVenda.cdsItensVenda.Eof do
  dtmVenda.cdsItensVenda.Delete;

end;

procedure TfrmProVenda.combProdutoExit(Sender: TObject);
begin
  inherited;
  edtValor.value:=dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
  edtQuantidade.Value:=1;
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value:= TotalizarProduto(edtValor.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value:= TotalizarProduto(edtValor.Value, edtQuantidade.Value);
end;

function TfrmProVenda.TotalizarProduto(ValorUnitario, Quantidade:Double):Double;
begin
  result := ValorUnitario  * Quantidade;
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
  FreeAndNil(dtmVenda);

end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda:=TdtmVenda.Create(Self);
  oVenda:=TVenda.Create(dtmConexaoPrincipal.ConexaoDB);
  IndiceAtual:='nome';

end;
end.