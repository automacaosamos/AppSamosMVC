unit CidadesVO;

interface

uses
  DB,
  System.SysUtils,
  System.Generics.Collections,
  System.Classes;
  type
  TCidadesBasicaVO = class
  private
    P_CIDADES_ID            : Integer;
    P_CIDADES_STATUS        : String;
    P_CIDADES_NOME          : String;
    P_CIDADES_ESTADO        : String;
    P_CIDADES_IBGE          : String;
  public
    property CIDADES_ID     : Integer  read P_CIDADES_ID      write P_CIDADES_ID;
    property CIDADES_STATUS : String   read P_CIDADES_STATUS  write P_CIDADES_STATUS;
    property CIDADES_NOME   : String   read P_CIDADES_NOME    write P_CIDADES_NOME;
    property CIDADES_ESTADO : String   read P_CIDADES_ESTADO  write P_CIDADES_ESTADO;
    property CIDADES_IBGE   : String   read P_CIDADES_IBGE    write P_CIDADES_IBGE;
  end;

type
  TCidadesVO = class
  private
    p_results : TObjectList<TCidadesBasicaVO>;
    p_total   : Integer;
  public
    property results : TObjectList<TCidadesBasicaVO> read p_results  write p_results;
    property total   : Integer                      read p_total    write p_total;
    class function GetAll(Parametros,Start,Limit:String)                            : TCidadesVO;
    class function GetByID(Parametros:integer)                                      : TCidadesVO;
    class function CreateRecord(CidadesBasicaVO: TCidadesBasicaVO)                    : TCidadesVO;
    class function UpdateRecord(Parametros:Integer;CidadesBasicaVO: TCidadesBasicaVO) : TCidadesVO;
    class function DeleteRecord(Parametros:Integer)                                 : TCidadesVO;
    destructor Destroy; override;
  end;

implementation

uses ConexoesController, FuncoesController;

destructor TCidadesVO.Destroy;
var
  CidadesBasica : TCidadesBasicaVO;
begin
  for CidadesBasica in results do
    CidadesBasica.Free;
  inherited;
end;

procedure ObjectToDataSet(CidadesBasicaVO:TCidadesBasicaVO;DataSetCidades:TDataSet);
begin
  DataSetCidades.FindField('CIDADES_ID').AsInteger    := CidadesBasicaVO.CIDADES_ID;
  DataSetCidades.FindField('CIDADES_STATUS').AsString := CidadesBasicaVO.CIDADES_STATUS;
  DataSetCidades.FindField('CIDADES_NOME').AsString   := CidadesBasicaVO.CIDADES_NOME;
  DataSetCidades.FindField('CIDADES_ESTADO').AsString := CidadesBasicaVO.CIDADES_ESTADO;
  DataSetCidades.FindField('CIDADES_IBGE').AsString   := CidadesBasicaVO.CIDADES_IBGE;

end;
procedure DataSetToObject(DataSetCidades:TDataSet;CidadesBasicaVO:TCidadesBasicaVO);
begin
  CidadesBasicaVO.CIDADES_ID     := DataSetCidades.FindField('CIDADES_ID').AsInteger;
  CidadesBasicaVO.CIDADES_STATUS := DataSetCidades.FindField('CIDADES_STATUS').AsString;
  CidadesBasicaVO.CIDADES_NOME   := DataSetCidades.FindField('CIDADES_NOME').AsString;
  CidadesBasicaVO.CIDADES_ESTADO := DataSetCidades.FindField('CIDADES_ESTADO').AsString;
  CidadesBasicaVO.CIDADES_IBGE   := DataSetCidades.FindField('CIDADES_IBGE').AsString;
end;
class function TCidadesVO.GetAll(Parametros,Start,Limit:String): TCidadesVO;
var
  ConexoesControl  : TConexoesController;
  DataSetCidades    : TDataSet;
  CidadesVO         : TCidadesVO;
  CidadesBasicaVO   : TCidadesBasicaVO;
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

  if StrParametros[0] = 'ULTIMACIDADES' then
    begin
      try
        CidadesVO                   := TCidadesVO.Create;
        CidadesVO.results           := TObjectList<TCidadesBasicaVO>.Create;
        CidadesVO.Total             := 1;
        CidadesBasicaVO             := TCidadesBasicaVO.Create;
        CidadesBasicaVO.CIDADES_ID := ConexoesControl.Ultimo_ID('CIDADES','F') + 1;
        CidadesVO.results.Add(CidadesBasicaVO);
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(ConexoesControl);
      end;

      try
        CidadesVO                     := TCidadesVO.Create;
        CidadesVO.results             := TObjectList<TCidadesBasicaVO>.Create;
        CidadesVO.Total               := 1;
        CidadesBasicaVO               := TCidadesBasicaVO.Create;
        CidadesBasicaVO.CIDADES_ID     := ConexoesControl.Ultimo_ID('CIDADES','F') + 1;
        CidadesBasicaVO.CIDADES_STATUS := 'T';
        CidadesBasicaVO.CIDADES_NOME   := '';
        CidadesVO.results.Add(CidadesBasicaVO);
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(ConexoesControl);
      end;

    end
  else
    begin
      SQLWhere := ' where CIDADES_ID > 0 ';

      if StrLeft(StrParametros[0],1) = '.' then
        begin
          SQLWhere := ' where CIDADES_ID = '   + IntToStr(Valor_int(Copy(StrParametros[0],2,6)));
          SQLAtivo := '';
          SQLOrder := ' order by CIDADES_ID';
        end
      else
        begin
          case Valor_Int(StrParametros[1]) of
            0: SQLAtivo := ' and CIDADES_STATUS = ' + QuotedStr('T');
            1: SQLAtivo := ' and CIDADES_STATUS = ' + QuotedStr('F');
            2: SQLAtivo := '';
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLWhere := SQLWhere + ' and CIDADES_NOME starting ' + QuotedStr(StrParametros[0]);
            1: SQLWhere := SQLWhere + ' and CIDADES_ID >= '         + iif(StrEmpty(StrParametros[0]),'0',StrParametros[0]);
            2: SQLWhere := SQLWhere + ' and CIDADES_NOME like '     + QuotedStr('%' + StrParametros[0] + '%');
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLOrder := ' order by CIDADES_NOME';
            1: SQLOrder := ' order by CIDADES_ID';
            2: SQLOrder := ' order by CIDADES_NOME';
          end;
        end;

      Registros := ConexoesControl.TotalRegistros('select count(*) as REGISTROS from CIDADES '+ SQLWhere + SQLAtivo);

      if Registros <= Valor_Int(limit) then
        DataSetCidades := ConexoesControl.Abre_Tabelas('select * from CIDADES ' +
                                                         SQLWhere + SQLAtivo + SQLOrder)
      else
        DataSetCidades := ConexoesControl.Abre_Tabelas('select first ' + limit + ' skip ' + start + ' * from CIDADES ' +
                                                          SqlWhere + SqlAtivo +  SqlOrder);

      CidadesVO           := TCidadesVO.Create;
      CidadesVO.results := TObjectList<TCidadesBasicaVO>.Create;
      CidadesVO.Total     := Registros;
      try
        DataSetCidades.First;
        while not DataSetCidades.Eof do
          begin
            CidadesBasicaVO               := TCidadesBasicaVO.Create;
            CidadesBasicaVO.CIDADES_ID := DataSetCidades.FindField('CIDADES_ID').AsInteger;
            DataSetToObject(DataSetCidades,CidadesBasicaVO);
            CidadesVO.results.Add(CidadesBasicaVO);
            DataSetCidades.Next;
          end;
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(DataSetCidades);
        FreeAndNil(ConexoesControl);
      end;
    end;

  Result := CidadesVO;

end;

class function TCidadesVO.GetByID(Parametros: integer): TCidadesVO;
var
  ConexoesControl    : TConexoesController;
  CidadesVO       : TCidadesVO;
  CidadesBasicaVO : TCidadesBasicaVO;
  DataSetCidades  : TDataSet;
begin
  ConexoesControl      := TConexoesController.Create;
  DataSetCidades      := ConexoesControl.Abre_tabelas('select * from CIDADES where CIDADES_ID = ' + valor_str(Parametros));
  CidadesVO           := TCidadesVO.Create;
  CidadesVO.results := TObjectList<TCidadesBasicaVO>.Create;
  CidadesVO.Total     := 0;
  try
    if not DataSetCidades.IsEmpty then
      begin
        CidadesVO.Total := 1;
        CidadesBasicaVO := TCidadesBasicaVO.Create;
        DataSetToObject(DataSetCidades,CidadesBasicaVO);
        CidadesVO.results.Add(CidadesBasicaVO);
      end;
  finally
    FreeAndNil(DataSetCidades);
    FreeAndNil(ConexoesControl);
  end;
  Result := CidadesVO;
end;

class function TCidadesVO.CreateRecord(CidadesBasicaVO: TCidadesBasicaVO): TCidadesVO;
var
  ConexoesControl   : TConexoesController;
  DataSetCidades : TDataSet;
begin
  ConexoesControl   := TConexoesController.Create;
  DataSetCidades := ConexoesControl.Abre_tabelas('select * from CIDADES where CIDADES_ID = 0 ');
  Result            := TCidadesVO.Create;
  Result.results    := TObjectList<TCidadesBasicaVO>.Create;
  Result.Total      := 0;
  try
    DataSetCidades.Append;
    CidadesBasicaVO.CIDADES_ID := ConexoesControl.Ultimo_ID('CIDADES','T');
    objectToDataSet(CidadesBasicaVO,DataSetCidades);
    try
      DataSetCidades.Post;
      Result.Total   := 1;
      Result.results.Add(CidadesBasicaVO);
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(DataSetCidades);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TCidadesVO.UpdateRecord(Parametros:Integer;CidadesBasicaVO: TCidadesBasicaVO): TCidadesVO;
var
  ConexoesControl  : TConexoesController;
  DataSetCidades  : TDataSet;
begin
  ConexoesControl    := TConexoesController.Create;
  DataSetCidades  := ConexoesControl.Abre_tabelas('select * from CIDADES where CIDADES_ID = ' + valor_str(Parametros));
  Result             := TCidadesVO.Create;
  Result.results     := TObjectList<TCidadesBasicaVO>.Create;
  Result.Total       := 0;
  try
    if not DataSetCidades.IsEmpty then
      begin
        DataSetCidades.Edit;
        CidadesBasicaVO.CIDADES_ID := Parametros;
        objectToDataSet(CidadesBasicaVO,DataSetCidades);
        try
          DataSetCidades.Post;
          Result.Total   := 1;
        except
          on e: exception do gera_log(e.message);
        end;
      end;
  finally
    FreeAndNil(DataSetCidades);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TCidadesVO.DeleteRecord(Parametros:Integer): TCidadesVO;
var
  ConexoesControl  : TConexoesController;
begin
  ConexoesControl  := TConexoesController.Create;
  Result           := TCidadesVO.Create;
  Result.results   := TObjectList<TCidadesBasicaVO>.Create;
  Result.Total     := 0;
  try
    try
      ConexoesControl.ExecutaScriptSQL('delete from CIDADES where CIDADES_ID = ' + Valor_Str(Parametros));
      Result.Total   := 1;
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;
end;

end.
