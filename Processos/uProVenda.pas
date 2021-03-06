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
    dbgridItensVenda: TDBGrid;
    Panel3: TPanel;
    lblProduto: TLabel;
    Label1: TLabel;
    lblQuantidade: TLabel;
    lblTotalProduto: TLabel;
    combProduto: TDBLookupComboBox;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    btnRemoverItem: TBitBtn;
    Panel4: TPanel;
    lblValorVenda: TLabel;
    edtValorVenda: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure combProdutoExit(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure dbgridItensVendaDblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    dtmVenda:TdtmVenda;
    oVenda:TVenda;
    function Apagar:boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function TotalizarProduto(ValorUnitario, Quantidade: Double): Double;
    procedure LimparComponentesItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
  public
    { Public declarations }

  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}


function TfrmProVenda.Apagar: boolean;
begin
if oVenda.Selecionar(Qrylistagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then
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
    Result:=oVenda.Inserir(dtmVenda.cdsItensVenda)
    else if EstadoDoCadastro = ecAlterar then
    Result:=oVenda.Atualizar(dtmVenda.cdsItensVenda);

end;

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
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
   edtValorVenda.Value:=TotalizarVenda;

   combProduto.SetFocus;

end;
procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then
   begin
     edtVendaId.Text         :=IntToStr(oVenda.vendaId);
     combCliente.KeyValue    :=oVenda.clienteId;
     edtDataVenda.Date       :=oVenda.dataVenda;
     edtValorVenda.Value     :=oVenda.totalVenda;
   end
   else
   begin
     btnCancelar.Click;
     Abort;
   end;
  inherited;
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

procedure TfrmProVenda.btnRemoverItemClick(Sender: TObject);
begin
  inherited;
  if combProduto.KeyValue = Null then
   begin
    MessageDlg('Selecione o Produto a ser excluido', mtInformation, [mbOK],0);
    dbgridItensVenda.SetFocus;
    abort;
   end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', combProduto.keyValue, []) then
    begin
      dtmVenda.cdsItensVenda.Delete;
      edtValor.Value:=TotalizarVenda;
      LimparComponentesItem;
    end;
end;


procedure TfrmProVenda.combProdutoExit(Sender: TObject);
begin
  inherited;
  if TDBLookupComboBox(Sender).KeyField<>Null then
  begin
    edtValor.value:=dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value:=1;
  end;
end;

procedure TfrmProVenda.dbgridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;

end;

{$Region 'Fun��es e procedimentos'}

procedure TfrmProVenda.LimparComponentesItem;
begin
 combProduto.KeyValue  := null;
 edtQuantidade.Value   :=  0 ;
 edtValor.Value        :=  0;
 edtTotalProduto.Value :=  0;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
  dtmVenda.cdsItensVenda.Delete;

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

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  combProduto.KeyValue         := dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.value          := dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValor.value               := dtmVenda.cdsItensVenda.FieldByName('ValorUnitario').AsFloat;
  edtTotalProduto.value        := dtmVenda.cdsItensVenda.FieldByName('ValorTotalProduto').AsFloat;
end;

function TfrmProVenda.TotalizarVenda:Double;
begin
   result:=0;
   dtmVenda.cdsItensVenda.First;
   while not dtmVenda.cdsItensVenda.Eof do
    begin
     result:=result + dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
     dtmVenda.cdsItensVenda.Next;
    end;
end;
{$endRegion}

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
