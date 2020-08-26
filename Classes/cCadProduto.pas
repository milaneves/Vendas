unit cCadProduto;

interface
uses classes, controls, SysUtils,ExtCtrls, Dialogs, ZAbstractConnection, ZConnection,
ZAbstractRODataset, ZAbstractDataset, ZDataset;


Type
   TProduto= class
   private
    ConexaoDB:TZConnection; //passando a conexão em tempo de criação da classe
    F_produtoId:integer;
    F_nome:String;
    F_descricao:String;
    F_valor:Double;
    F_quantidade:Double;
    F_categoriaID:integer;

   public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:integer):Boolean;
   published
     property codigo      :integer  read F_produtoId    write F_produtoId;
     property nome        :string   read F_nome         write F_nome;
     property descricao   :string   read F_descricao    write F_descricao;
     property valor       :Double   read F_valor        write F_valor;
     property quantidade  :Double   read F_quantidade   write F_quantidade;
     property categoriaID :integer   read F_categoriaID  write F_categoriaID;
   end;



implementation

{ TProduto }

{$Region Construtor e destructor'}
constructor TProduto.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;
{$endRegion}

function TProduto.Apagar: Boolean;
var Qry:TZQuery;
begin
 if MessageDlg('Apagar o Registro: '+#13+#13+
               'Código: '+IntToStr(F_produtoId)+ #13+
               'Descrição: '+F_nome, mtConfirmation, [mbYes, mbNo],0)=mrNo then
               begin
                Result:=false;
                Abort;
              end;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('delete from produtos where produtoId=:produtoId');
   Qry.ParamByName('produtoId').AsInteger:= F_produtoId;
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
function TProduto.Atualizar: Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add(' Update produtos '+
                   'set nome = :nome ,'+
                        'descricao    =:descricao, '+
                        'valor       =:valor, '+
                        'quantidade  =:quantidade,  '+
                        'categoriaID =:categoriaID '+
                   'where  produtoId =:produtoId');
   Qry.ParamByName('produtoId').AsInteger:=Self.F_produtoId;
   Qry.ParamByName('nome').AsString:=Self.F_nome;
   Qry.ParamByName('descricao').AsString:=Self.F_descricao;
   Qry.ParamByName('valor').AsFloat:=Self.F_valor;
   Qry.ParamByName('quantidade').AsFloat:=Self.F_quantidade;
   Qry.ParamByName('categoriaID').AsInteger:=Self.F_categoriaID;

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



function TProduto.Inserir: Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('insert into produtos '+
               '            ( nome, '+
               '              descricao, '+
               '              valor, '+
               '              quantidade, '+
               '              categoriaID) '+
               ' values      (:nome , '+
               '              :descricao , '+
               '              :valor,    '+
               '              :quantidade,    '+
               '              :categoriaID)');

   Qry.ParamByName('nome').AsString:=Self.F_nome;
   Qry.ParamByName('descricao').AsString:=Self.F_descricao;
   Qry.ParamByName('valor').AsFloat:=Self.F_valor;
   Qry.ParamByName('quantidade').AsFloat:=Self.F_quantidade;
   Qry.ParamByName('categoriaID').AsInteger:=Self.F_categoriaID;
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
function TProduto.Selecionar(id: integer): Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add( 'select produtoId,'+
                '       nome, '+
                '       descricao, '+
                '       valor, '+
                '       quantidade, '+
                '       categoriaID '+
                ' From produtos   '+
                ' Where produtoId =:produtoId');
   Qry.ParamByName('produtoId').Value:=id;
   try
     Qry.Open;

     Self.F_produtoId:= Qry.FieldByName('produtoId').AsInteger;
     Self.F_nome:= Qry.FieldByName('nome').AsString;
     Self.F_descricao:= Qry.FieldByName('descricao').AsString;
     Self.F_valor:= Qry.FieldByName('valor').AsFloat;
     Self.F_quantidade:= Qry.FieldByName('quantidade').AsFloat;
     Self.F_categoriaID:= Qry.FieldByName('categoriaID').AsInteger;
   except
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;
end.
