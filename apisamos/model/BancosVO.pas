unit BancosVO;

interface

uses
  DB,
  System.SysUtils,
  System.Generics.Collections,
  System.Classes;
  type
  TBancosBasicaVO = class
  private
    P_BANCOS_ID            : Integer; // INTEGER GENERATED BY DEFAULT AS IDENTITY,
    P_BANCOS_STATUS        : String;  // CHAR(1) NOT NULL,
    P_BANCOS_NOME          : String;  // VARCHAR(50) COLLATE PT_BR,
  public
    property BANCOS_ID     : Integer  read P_BANCOS_ID      write P_BANCOS_ID;
    property BANCOS_STATUS : String   read P_BANCOS_STATUS  write P_BANCOS_STATUS;
    property BANCOS_NOME   : String   read P_BANCOS_NOME    write P_BANCOS_NOME;
  end;

type
  TBancosVO = class
  private
    p_results : TObjectList<TBancosBasicaVO>;
    p_total   : Integer;
  public
    property results : TObjectList<TBancosBasicaVO> read p_results  write p_results;
    property total   : Integer                      read p_total    write p_total;
    class function GetAll(Parametros,Start,Limit:String)                            : TBancosVO;
    class function GetByID(Parametros:integer)                                      : TBancosVO;
    class function CreateRecord(BancosBasicaVO: TBancosBasicaVO)                    : TBancosVO;
    class function UpdateRecord(Parametros:Integer;BancosBasicaVO: TBancosBasicaVO) : TBancosVO;
    class function DeleteRecord(Parametros:Integer)                                 : TBancosVO;
    destructor Destroy; override;
  end;

implementation

uses ConexoesController, FuncoesController;

destructor TBancosVO.Destroy;
var
  BancosBasica : TBancosBasicaVO;
begin
  for BancosBasica in results do
    BancosBasica.Free;
  inherited;
end;

procedure ObjectToDataSet(BancosBasicaVO:TBancosBasicaVO;DataSetBancos:TDataSet);
begin
  DataSetBancos.FindField('BANCOS_ID').AsInteger    := BancosBasicaVO.BANCOS_ID;
  DataSetBancos.FindField('BANCOS_STATUS').AsString := BancosBasicaVO.BANCOS_STATUS;
  DataSetBancos.FindField('BANCOS_NOME').AsString   := BancosBasicaVO.BANCOS_NOME;
end;
procedure DataSetToObject(DataSetBancos:TDataSet;BancosBasicaVO:TBancosBasicaVO);
begin
  BancosBasicaVO.BANCOS_ID     := DataSetBancos.FindField('BANCOS_ID').AsInteger;
  BancosBasicaVO.BANCOS_STATUS := DataSetBancos.FindField('BANCOS_STATUS').AsString;
  BancosBasicaVO.BANCOS_NOME   := DataSetBancos.FindField('BANCOS_NOME').AsString;
end;
class function TBancosVO.GetAll(Parametros,Start,Limit:String): TBancosVO;
var
  ConexoesControl  : TConexoesController;
  DataSetBancos    : TDataSet;
  BancosVO         : TBancosVO;
  BancosBasicaVO   : TBancosBasicaVO;
  SQLAtivo         : String;
  SQLWhere         : String;
  SQLOrder         : String;
  Registros        : Integer;
  Itens            : Integer;
  StrParametros    : TStringList;
begin

  ConexoesControl  := TConexoesController.Create;

  if StrContains(Parametros,'|') then
    StrParametros := Explode(Parametros,'|')
  else
    begin
      StrParametros := TStringList.Create;
      StrParametros.add(Parametros);
    end;

  if StrParametros[0] = 'ULTIMABANCOS' then
    begin
      try
        BancosVO                   := TBancosVO.Create;
        BancosVO.results           := TObjectList<TBancosBasicaVO>.Create;
        BancosVO.Total             := 1;
        BancosBasicaVO             := TBancosBasicaVO.Create;
        BancosBasicaVO.BANCOS_ID := ConexoesControl.Ultimo_ID('BANCOS','F') + 1;
        BancosVO.results.Add(BancosBasicaVO);
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(ConexoesControl);
      end;

      try
        BancosVO                     := TBancosVO.Create;
        BancosVO.results             := TObjectList<TBancosBasicaVO>.Create;
        BancosVO.Total               := 1;
        BancosBasicaVO               := TBancosBasicaVO.Create;
        BancosBasicaVO.BANCOS_ID     := ConexoesControl.Ultimo_ID('BANCOS','F') + 1;
        BancosBasicaVO.BANCOS_STATUS := 'T';
        BancosBasicaVO.BANCOS_NOME   := '';
        BancosVO.results.Add(BancosBasicaVO);
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(ConexoesControl);
      end;

    end
  else
    begin
      SQLWhere := ' where BANCOS_ID > 0 ';

      if StrLeft(StrParametros[0],1) = '.' then
        begin
          SQLWhere := ' where BANCOS_ID = '   + IntToStr(Valor_int(Copy(StrParametros[0],2,6)));
          SQLAtivo := '';
          SQLOrder := ' order by BANCOS_ID';
        end
      else
        begin
          case Valor_Int(StrParametros[1]) of
            0: SQLAtivo := ' and BANCOS_STATUS = ' + QuotedStr('T');
            1: SQLAtivo := ' and BANCOS_STATUS = ' + QuotedStr('F');
            2: SQLAtivo := '';
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLWhere := SQLWhere + ' and BANCOS_NOME starting ' + QuotedStr(StrParametros[0]);
            1: SQLWhere := SQLWhere + ' and BANCOS_ID >= '         + iif(StrEmpty(StrParametros[0]),'0',StrParametros[0]);
            2: SQLWhere := SQLWhere + ' and BANCOS_NOME like '     + QuotedStr('%' + StrParametros[0] + '%');
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLOrder := ' order by BANCOS_NOME';
            1: SQLOrder := ' order by BANCOS_NOME';
            2: SQLOrder := ' order by BANCOS_ID';
          end;
        end;

      Registros := ConexoesControl.TotalRegistros('select count(*) as REGISTROS from BANCOS '+ SQLWhere + SQLAtivo);

      if Registros <= Valor_Int(limit) then
        DataSetBancos := ConexoesControl.Abre_Tabelas('select * from BANCOS ' +
                                                         SQLWhere + SQLAtivo + SQLOrder)
      else
        DataSetBancos := ConexoesControl.Abre_Tabelas('select first ' + limit + ' skip ' + start + ' * from BANCOS ' +
                                                          SqlWhere + SqlAtivo +  SqlOrder);

      BancosVO           := TBancosVO.Create;
      BancosVO.results := TObjectList<TBancosBasicaVO>.Create;
      BancosVO.Total     := Registros;
      try
        DataSetBancos.First;
        while not DataSetBancos.Eof do
          begin
            BancosBasicaVO               := TBancosBasicaVO.Create;
            BancosBasicaVO.BANCOS_ID := DataSetBancos.FindField('BANCOS_ID').AsInteger;
            DataSetToObject(DataSetBancos,BancosBasicaVO);
            BancosVO.results.Add(BancosBasicaVO);
            DataSetBancos.Next;
          end;
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(DataSetBancos);
        FreeAndNil(ConexoesControl);
      end;
    end;

  Result := BancosVO;

end;

class function TBancosVO.GetByID(Parametros: integer): TBancosVO;
var
  ConexoesControl    : TConexoesController;
  BancosVO       : TBancosVO;
  BancosBasicaVO : TBancosBasicaVO;
  DataSetBancos  : TDataSet;
begin
  ConexoesControl      := TConexoesController.Create;
  DataSetBancos      := ConexoesControl.Abre_tabelas('select * from BANCOS where BANCOS_ID = ' + valor_str(Parametros));
  BancosVO           := TBancosVO.Create;
  BancosVO.results := TObjectList<TBancosBasicaVO>.Create;
  BancosVO.Total     := 0;
  try
    if not DataSetBancos.IsEmpty then
      begin
        BancosVO.Total := 1;
        BancosBasicaVO := TBancosBasicaVO.Create;
        DataSetToObject(DataSetBancos,BancosBasicaVO);
        BancosVO.results.Add(BancosBasicaVO);
      end;
  finally
    FreeAndNil(DataSetBancos);
    FreeAndNil(ConexoesControl);
  end;
  Result := BancosVO;
end;

class function TBancosVO.CreateRecord(BancosBasicaVO: TBancosBasicaVO): TBancosVO;
var
  ConexoesControl   : TConexoesController;
  DataSetBancos : TDataSet;
begin
  ConexoesControl   := TConexoesController.Create;
  DataSetBancos := ConexoesControl.Abre_tabelas('select * from BANCOS where BANCOS_ID = 0 ');
  Result            := TBancosVO.Create;
  Result.results    := TObjectList<TBancosBasicaVO>.Create;
  Result.Total      := 0;
  try
    DataSetBancos.Append;
    BancosBasicaVO.BANCOS_ID := ConexoesControl.Ultimo_ID('BANCOS','T');
    objectToDataSet(BancosBasicaVO,DataSetBancos);
    try
      DataSetBancos.Post;
      Result.Total   := 1;
      Result.results.Add(BancosBasicaVO);
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(DataSetBancos);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TBancosVO.UpdateRecord(Parametros:Integer;BancosBasicaVO: TBancosBasicaVO): TBancosVO;
var
  ConexoesControl  : TConexoesController;
  DataSetBancos  : TDataSet;
begin
  ConexoesControl    := TConexoesController.Create;
  DataSetBancos  := ConexoesControl.Abre_tabelas('select * from BANCOS where BANCOS_ID = ' + valor_str(Parametros));
  Result             := TBancosVO.Create;
  Result.results     := TObjectList<TBancosBasicaVO>.Create;
  Result.Total       := 0;
  try
    if not DataSetBancos.IsEmpty then
      begin
        DataSetBancos.Edit;
        BancosBasicaVO.BANCOS_ID := Parametros;
        objectToDataSet(BancosBasicaVO,DataSetBancos);
        try
          DataSetBancos.Post;
          Result.Total   := 1;
        except
          on e: exception do gera_log(e.message);
        end;
      end;
  finally
    FreeAndNil(DataSetBancos);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TBancosVO.DeleteRecord(Parametros:Integer): TBancosVO;
var
  ConexoesControl  : TConexoesController;
begin
  ConexoesControl  := TConexoesController.Create;
  Result           := TBancosVO.Create;
  Result.results   := TObjectList<TBancosBasicaVO>.Create;
  Result.Total     := 0;
  try
    try
      ConexoesControl.ExecutaScriptSQL('delete from BANCOS where BANCOS_ID = ' + Valor_Str(Parametros));
      Result.Total   := 1;
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;
end;

end.