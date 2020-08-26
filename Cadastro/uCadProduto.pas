unit uCadProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTelaHeranca, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Buttons, DBCtrls, Grids, DBGrids, StdCtrls, Mask, ExtCtrls, ComCtrls,
   uEnum , uDataModuleConexao ,
  cCadProduto, RxToolEdit, RxCurrEdit;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    QryListagemprodutoId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    QryListagemvalor: TFloatField;
    QryListagemquantidade: TFloatField;
    QryListagemcategoriaID: TIntegerField;
    QryListagemDescricaoCategoria: TWideStringField;
    QryListagemnome: TWideStringField;
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    lblDescricao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    QryCategoria: TZQuery;
    dtsCategoria: TDataSource;
    QryCategoriaCategoriaID: TIntegerField;
    QryCategoriaDescricao: TWideStringField;
    lblCategoria: TLabel;
    combCategoria: TDBLookupComboBox;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    oProduto:TProduto;
    function Apagar:boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

{$region ''}
procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto:=TProduto.Create(dtmConexaoPrincipal.ConexaoDB);
  IndiceAtual:='nome';

end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
   QryCategoria.Open;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QryCategoria.Close;
  if Assigned(oProduto) then
   FreeAndNil(oProduto);
end;

{$endRegion}

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
    if edtProdutoId.text <> EmptyStr then
     oProduto.codigo:=StrToInt(edtProdutoId.Text)
   else
    oProduto.codigo:=0;

    oProduto.nome           :=edtNome.Text;
    oProduto.descricao      :=edtDescricao.Text;
    oProduto.categoriaId    :=combCategoria.KeyValue;
    oProduto.valor          :=edtValor.value;
    oProduto.quantidade     :=edtQuantidade.value;

    if EstadoDoCadastro = ecInserir then
     Result:=oProduto.Inserir
    else if EstadoDoCadastro=ecAlterar then
     Result:=oProduto.Atualizar;
end;

function TfrmCadProduto.Apagar: boolean;
begin
   if oProduto.Selecionar(QryListagem.fieldByName('ProdutoId').AsInteger) then
    begin
      Result:=oProduto.Apagar;
    end;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;


procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if oProduto.Selecionar(QryListagem.fieldByName('ProdutoId').AsInteger) then
    begin
      edtProdutoId.Text            := IntToStr(oProduto.codigo);
      edtNome.Text                 := oProduto.nome;
      edtDescricao.Text            := oProduto.descricao;
      combCategoria.KeyValue       := oProduto.categoriaId;
      edtValor.value               := oProduto.valor;
      edtQuantidade.value          := oProduto.quantidade;
    end
    else
    begin
      btnCancelar.Click;
      Abort;
    end;

    inherited;
end;
End.
