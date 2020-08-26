unit uCadCategoria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTelaHeranca, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBCtrls, Grids, DBGrids, StdCtrls, Mask, ExtCtrls, ComCtrls, Buttons, cCadCategoria,
  uEnum, uDataModuleConexao;
type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    QryListagemCategoriaID: TIntegerField;
    QryListagemDescricao: TWideStringField;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
  private
    { Private declarations }
    oCategoria:TCategoria;
  public
    { Public declarations }
    function Apagar:Boolean;override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean;override;

  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}
{$Region 'override'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  if oCategoria.Selecionar(QryListagem.FieldBYName('categoriaId').AsInteger) then
  begin
    Result:=oCategoria.Apagar;
  end;

end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin

 if edtCategoriaId.Text<>EmptyStr then
    oCategoria.codigo:= StrToInt(edtCategoriaId.Text)
  else
   oCategoria.codigo:=0;

   oCategoria.descricao:=edtDescricao.Text;


 if ( EstadoDoCadastro = EcInserir) then
   Result:=oCategoria.Inserir
 else if ( EstadoDoCadastro = ecAlterar) then
   Result:=oCategoria.Atualizar;

end;
procedure TfrmCadCategoria.mskPesquisarChange(Sender: TObject);
begin
  inherited;

end;

{$endRegion}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
   if oCategoria.Selecionar(QryListagem.FieldBYName('categoriaId').AsInteger) then
    begin
      edtCategoriaId.Text:=IntToStr(oCategoria.codigo);
      edtDescricao.Text:= oCategoria.descricao;
    end
    else
    begin
      btnCancelar.Click;
      Abort;
    end;


  inherited;

end;

Procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //verifica se a vari�vel foi instanciada para limpar da mem�ria
  if Assigned(oCategoria) then
   FreeAndNil(oCategoria);


end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria:=TCategoria.Create(dtmConexaoPrincipal.ConexaoDB);
  IndiceAtual:= 'Descricao';

end;



end.
