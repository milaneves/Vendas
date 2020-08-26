unit cCadCliente;

interface
uses classes, controls, SysUtils,ExtCtrls, Dialogs, ZAbstractConnection, ZConnection,
ZAbstractRODataset, ZAbstractDataset, ZDataset;

Type
   TCliente = class
   private
    ConexaoDB:TZConnection; //passando a conex�o em tempo de cria��o da classe
    F_ClienteId:integer;
    F_nome:String;
    F_endereco:String;
    F_cidade:String;
    F_bairro:String;
    F_estado:String;
    F_cep:String;
    F_telefone:String;
    F_email:String;
    F_dataNascimento:TDateTime;

   public
     constructor Create(aConexao:TZConnection);
     destructor Destroy; override;
     function Inserir:Boolean;
     function Atualizar:Boolean;
     function Apagar:Boolean;
     function Selecionar(id:integer):Boolean;


   published
     property codigo :integer  read F_ClienteId    write F_ClienteId;
     property nome:string read F_nome write F_nome;
     property endereco:string read F_endereco write F_endereco;
     property cidade:string read F_cidade write F_cidade;
     property bairro:string read F_bairro write F_bairro;
     property estado:string read F_estado write F_estado;
     property cep:string read F_cep write F_cep;
     property telefone:string read F_telefone write F_telefone;
     property email:string read F_email write F_email;
     property dataNascimento:TDateTime read F_dataNascimento write F_dataNascimento;
   end;


implementation

{ TCliente }


constructor TCliente.Create(aConexao: TZConnection);
begin
ConexaoDB:= aConexao;

end;

destructor TCliente.Destroy;
begin
  inherited;
end;

function TCliente.Apagar: Boolean;
var Qry:TZQuery;
begin
 if MessageDlg('Apagar o Registro: '+#13+#13+
               'C�digo: '+IntToStr(F_ClienteId)+ #13+
               'Descri��o: '+F_nome, mtConfirmation, [mbYes, mbNo],0)=mrNo then
               begin
                Result:=false;
                Abort;
              end;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('delete from clientes where clienteId=:clienteId');
   Qry.ParamByName('clienteId').AsInteger:= F_ClienteId;
   try
     Qry.ExecSQL
   except
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;

function TCliente.Atualizar: Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add(' Update clientes '+
                   'set nome = :nome ,'+
                        'endereco = :endereco, '+
                        'cidade = :cidade, '+
                        'bairro = :bairro,  '+
                        'estado = :estado, '+
                        'cep = :cep, '+
                        'telefone = :telefone, '+
                        'email = :email, '+
                        'dataNascimento = :dataNascimento ' +
                   'where  clienteId = :clienteId');
   Qry.ParamByName('clienteId').AsInteger:=Self.F_ClienteId;
   Qry.ParamByName('nome').AsString:=Self.F_nome;
   Qry.ParamByName('endereco').AsString:=Self.F_endereco;
   Qry.ParamByName('cidade').AsString:=Self.F_cidade;
   Qry.ParamByName('bairro').AsString:=Self.F_bairro;
   Qry.ParamByName('estado').AsString:=Self.F_estado;
   Qry.ParamByName('cep').AsString:=Self.F_cep;
   Qry.ParamByName('telefone').AsString:=Self.F_telefone;
   Qry.ParamByName('email').AsString:=Self.F_email;
   Qry.ParamByName('dataNascimento').AsDateTime:=Self.F_dataNascimento;
   try
     Qry.ExecSQL
   except
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;


function TCliente.Inserir: Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('insert into clientes '+
               '            ( nome, '+
               '              endereco, '+
               '              cidade, '+
               '              bairro, '+
               '              estado, '+
               '              cep, '+
               '              telefone, '+
               '              email, '+
               '              dataNascimento) '+
               ' values      (:nome , '+
               '              :endereco , '+
               '              :cidade,    '+
               '              :bairro,    '+
               '              :estado,    '+
               '              :cep,       '+
               '              :telefone,  '+
               '              :email,     '+
               '              :dataNascimento)');

   Qry.ParamByName('nome').AsString:=Self.F_nome;
   Qry.ParamByName('endereco').AsString:=Self.F_endereco;
   Qry.ParamByName('cidade').AsString:=Self.F_cidade;
   Qry.ParamByName('bairro').AsString:=Self.F_bairro;
   Qry.ParamByName('estado').AsString:=Self.F_estado;
   Qry.ParamByName('cep').AsString:=Self.F_cep;
   Qry.ParamByName('telefone').AsString:=Self.F_telefone;
   Qry.ParamByName('email').AsString:=Self.F_email;
   Qry.ParamByName('dataNascimento').AsDateTime:=Self.F_dataNascimento;
   try
     Qry.ExecSQL
   except
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;

function TCliente.Selecionar(id: integer): Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add( 'select ClienteId,'+
                '       nome, '+
                '       endereco, '+
                '       cidade, '+
                '       bairro, '+
                '       estado, '+
                '       cep, '+
                '       telefone, '+
                '       email, '+
                '       dataNascimento '+
                ' From Clientes   '+
                ' Where clienteId =:ClienteId');
   Qry.ParamByName('ClienteId').Value:=id;
   try
     Qry.Open;

     Self.F_clienteId:= Qry.FieldByName('ClienteId').AsInteger;
     Self.F_nome:= Qry.FieldByName('nome').AsString;
     Self.F_endereco:= Qry.FieldByName('endereco').AsString;
     Self.F_cidade:= Qry.FieldByName('cidade').AsString;
     Self.F_bairro:= Qry.FieldByName('bairro').AsString;
     Self.F_estado:= Qry.FieldByName('estado').AsString;
     Self.F_cep:= Qry.FieldByName('cep').AsString;
     Self.F_telefone:= Qry.FieldByName('telefone').AsString;
     Self.F_email:= Qry.FieldByName('email').AsString;
     Self.F_dataNascimento:= Qry.FieldByName('dataNascimento').AsDateTime;
   except
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;

end.
