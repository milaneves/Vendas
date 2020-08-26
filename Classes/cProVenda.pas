unit cProVenda;

interface
uses classes, controls, SysUtils,ExtCtrls, Dialogs, ZAbstractConnection, ZConnection,
ZAbstractRODataset, ZAbstractDataset, ZDataset;

Type
   TVenda = class
   private
    ConexaoDB:TZConnection; //passando a conex�o em tempo de cria��o da classe
    F_VendaId:integer;
    F_ClienteId:integer;
    F_dataVenda:TDateTime;
    F_totalVenda:Double;

    public
     constructor Create(aConexao:TZConnection);
     destructor Destroy; override;
     function Inserir:Boolean;
     function Atualizar:Boolean;
     function Apagar:Boolean;
     function Selecionar(id:integer):Boolean;

    published
     property vendaId   :integer    read F_VendaId      write F_VendaId;
     property clienteId :integer     read F_ClienteId    write F_ClienteId;
     property dataVenda :TDateTime   read F_dataVenda    write F_dataVenda;
     property totalVenda:Double      read F_totalVenda   write F_totalVenda;
   end;

implementation

{ TVenda }

constructor TVenda.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;

end;

destructor TVenda.Destroy;
begin

  inherited;
end;


function TVenda.Apagar: Boolean;
var Qry:TZQuery;
begin
 if MessageDlg('Apagar o Registro: '+#13+#13+
               'Venda Nr: '+IntToStr(vendaId), mtConfirmation, [mbYes, mbNo],0)=mrNo then
               begin
                Result:=false;
                Abort;
              end;
 try
   Result:=true;
   ConexaoDB.StartTransaction;
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('DELETE FROM VENDASITENS where vendaId=:vendaId');
   Qry.ParamByName('vendaId').AsInteger:= vendaId;
   try
     Qry.ExecSQL;

     Qry.SQL.Clear;
     Qry.SQL.Add('DELETE FROM VENDAS where vendaId=:vendaId');
     Qry.ParamByName('vendaId').AsInteger:= vendaId;
     Qry.ExecSQL;
     ConexaoDB.Commit;
   except
     ConexaoDB.Rollback;
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;

function TVenda.Atualizar: Boolean;
var Qry:TZQuery;

begin
 result:=true;
 try

   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add(' Update vendas '+
                   'set  clienteId    =:clienteId ,'+
                        'dataVenda    =:dataVenda, '+
                        'totalVenda   =:totalVenda ' +
                   'where  clienteId  =:clienteId');
   Qry.ParamByName('VendaId').AsInteger:=Self.F_vendaId;
   Qry.ParamByName('clienteId').AsInteger:=Self.F_clienteId;
   Qry.ParamByName('dataVenda').AsDateTime:=Self.F_dataVenda;
   Qry.ParamByName('totalVenda').AsFloat:=Self.F_totalVenda;

   try
     Qry.ExecSQL;


   except
     ConexaoDB.Rollback;
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;

end;


function TVenda.Inserir: Boolean;
var Qry:TZQuery;
  IdVendaGerado:Integer;
begin


 try
   result:=true;
   ConexaoDB.StartTransaction;
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('INSERT INTO VENDAS (clienteId, dataVenda, totalVenda )  '+
               '   VALUES (:clienteId ,:dataVenda, :totalVenda )' );

   Qry.ParamByName('clienteId').AsInteger :=self.F_clienteId;
   Qry.ParamByName('dataVenda').AsDateTime :=self.F_dataVenda;
   Qry.ParamByName('totalVenda').AsFloat :=self.F_totalVenda;

   try
    Qry.ExecSQL;
  //Recupera o ID gerado do Insert
     Qry.SQL.Clear;
     Qry.SQL.Add(' SELECT SCOPE_IDENTITY() AS ID ');
     Qry.Open;

     //Id da tabela pai - VENDA
     IdVendaGerado := Qry.FieldByName('ID').AsInteger;
     ConexaoDB.Commit;

   except
     ConexaoDB.Rollback;
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;


end;

function TVenda.Selecionar(id: integer): Boolean;
var Qry:TZQuery;
begin
 result:=true;
 try
   Qry:= TZQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add( 'select vendaId,'+
                '       clienteId, '+
                '       dataVenda, '+
                '       totalVenda'+
                ' From vendas   '+
                ' Where vendaId =:vendaId');
   Qry.ParamByName('vendaId').Value:=id;
   try
     Qry.Open;

     Self.F_vendaId  := Qry.FieldByName('vendaId').AsInteger;
     Self.F_clienteId:= Qry.FieldByName('ClienteId').AsInteger;
     Self.F_dataVenda:= Qry.FieldByName('dataVenda').AsDateTime;
     Self.F_totalVenda:= Qry.FieldByName('totalVenda').AsFloat;

   except
     result:=false;
   end;
 finally
    if Assigned(Qry)then
    FreeAndNil(Qry);
  end;
end;

end.
