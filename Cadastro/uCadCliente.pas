unit uCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTelaHeranca, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Buttons, DBCtrls, Grids, DBGrids, StdCtrls, Mask, ExtCtrls, ComCtrls,
  uEnum, cCadCliente, uDataModuleConexao;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    lblCEP: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtTelefone: TMaskEdit;
    lblTelefone: TLabel;
    edtEmail: TLabeledEdit;
    edtDtNascimento: TDateTimePicker;
    lblDtNascimento: TLabel;
    edtEstado: TLabeledEdit;
    QryListagemClienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemendereco: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemestado: TWideStringField;
    QryListagemcep: TWideStringField;
    QryListagemtelefone: TWideStringField;
    QryListagememail: TWideStringField;
    QryListagemdataNascimento: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);

  private
    { Private declarations }
    oCliente: TCliente;
    function Apagar:boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

{ TfrmCadCliente }

function TfrmCadCliente.Apagar: boolean;
begin
   if oCliente.Selecionar(QryListagem.fieldByName('clienteId').AsInteger) then
    begin
      Result:=oCliente.Apagar;
    end;

end;

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
   if oCliente.Selecionar(QryListagem.fieldByName('clienteId').AsInteger) then
   begin

    edtClienteId.Text     := IntToStr(oCliente.codigo);
    edtNome.Text          := oCliente.nome;
    edtCep.Text           := oCliente.cep;
    edtEndereco.Text      := oCliente.endereco;
    edtCidade.Text        := oCliente.cidade;
    edtBairro.Text        := oCliente.bairro;
    edtEstado.Text        := oCliente.estado;
    edtTelefone.Text      := oCliente.telefone;
    edtEmail.text         := oCliente.email;
    edtDtNascimento.Date  := oCliente.dataNascimento;
   end
   else
   begin
     btnCancelar.Click;
     Abort;
   end;

 inherited;

end;



Procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
   edtNome.SetFocus;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 inherited;
  //verifica se a vari�vel foi instanciada para limpar da mem�ria
  if Assigned(oCliente) then
   FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente:=TCliente.Create(dtmConexaoPrincipal.ConexaoDB);
  IndiceAtual:='nome';
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
    if edtClienteId.text <> EmptyStr then
       oCliente.codigo:=StrToInt(edtClienteId.Text)
    else
      oCliente.codigo:=0;

    oCliente.nome           :=edtNome.Text;
    oCliente.cep            :=edtCep.Text;
    oCliente.endereco       :=edtEndereco.Text;
    oCliente.bairro         :=edtBairro.Text;
    oCliente.estado         :=edtEstado.Text;
    oCliente.cidade         :=edtCidade.Text;
    oCliente.telefone       :=edtTelefone.Text;
    oCliente.email          :=edtEmail.text;
    oCliente.dataNascimento :=edtDtNascimento.Date;

    if EstadoDoCadastro = ecInserir then
     Result:=oCliente.Inserir
    else if EstadoDoCadastro=ecAlterar then
     Result:=oCliente.Atualizar;

end;

End.
