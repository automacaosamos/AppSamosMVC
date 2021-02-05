unit UsuariosVO;

interface

uses
  DB,
  System.SysUtils,
  System.Generics.Collections,
  System.Classes;
  type
  TUsuariosBasicaVO = class
  private
    P_USUARIOS_ID           : Integer;
    P_USUARIOS_STATUS       : String;
    P_USUARIOS_TIPO         : String;
    P_USUARIOS_CPFCNPJ      : String;
    P_USUARIOS_RG           : String;
    P_USUARIOS_NASCIMENTO   : TDate;
    P_USUARIOS_CADASTRO     : TDate;
    P_USUARIOS_VALIDADE     : TDate;
    P_USUARIOS_NOME         : String;
    P_USUARIOS_CEP          : String;
    P_USUARIOS_ENDERECO     : String;
    P_USUARIOS_NUMERO       : String;
    P_USUARIOS_BAIRRO       : String;
    P_USUARIOS_ID_CIDADES   : Integer;
    P_USUARIOS_TELEFONE     : String;
    P_USUARIOS_CELULAR      : String;
    P_USUARIOS_EMAIL        : String;
    P_USUARIOS_LOGIN        : String;
    P_USUARIOS_SENHA        : String;
    P_USUARIOS_FUNCAO       : String;
    P_USUARIOS_COMISSAO     : Real;
    P_USUARIOS_PRIVILEGIADO : String;
    P_USUARIOS_ID_EMPRESAS  : Integer;
    P_USUARIOS_NOVASENHA    : String;
    P_USUARIOS_TEMPO        : Integer;
    P_CIDADES_NOME          : String;
    P_CIDADES_ESTADO        : String;
    P_CIDADES_IBGE          : String;
    P_EMPRESAS_NOME         : String;
  public
    property USUARIOS_ID           : Integer read P_USUARIOS_ID           write P_USUARIOS_ID;
    property USUARIOS_STATUS       : String  read P_USUARIOS_STATUS       write P_USUARIOS_STATUS;
    property USUARIOS_TIPO         : String  read P_USUARIOS_TIPO         write P_USUARIOS_TIPO;
    property USUARIOS_CPFCNPJ      : String  read P_USUARIOS_CPFCNPJ      write P_USUARIOS_CPFCNPJ;
    property USUARIOS_RG           : String  read P_USUARIOS_RG           write P_USUARIOS_RG;
    property USUARIOS_NASCIMENTO   : TDate   read P_USUARIOS_NASCIMENTO   write P_USUARIOS_NASCIMENTO;
    property USUARIOS_CADASTRO     : TDate   read P_USUARIOS_CADASTRO     write P_USUARIOS_CADASTRO;
    property USUARIOS_VALIDADE     : TDate   read P_USUARIOS_VALIDADE     write P_USUARIOS_VALIDADE;
    property USUARIOS_NOME         : String  read P_USUARIOS_NOME         write P_USUARIOS_NOME;
    property USUARIOS_CEP          : String  read P_USUARIOS_CEP          write P_USUARIOS_CEP;
    property USUARIOS_ENDERECO     : String  read P_USUARIOS_ENDERECO     write P_USUARIOS_ENDERECO;
    property USUARIOS_NUMERO       : String  read P_USUARIOS_NUMERO       write P_USUARIOS_NUMERO;
    property USUARIOS_BAIRRO       : String  read P_USUARIOS_BAIRRO       write P_USUARIOS_BAIRRO;
    property USUARIOS_ID_CIDADES   : Integer read P_USUARIOS_ID_CIDADES   write P_USUARIOS_ID_CIDADES;
    property USUARIOS_TELEFONE     : String  read P_USUARIOS_TELEFONE     write P_USUARIOS_TELEFONE;
    property USUARIOS_CELULAR      : String  read P_USUARIOS_CELULAR      write P_USUARIOS_CELULAR;
    property USUARIOS_EMAIL        : String  read P_USUARIOS_EMAIL        write P_USUARIOS_EMAIL;
    property USUARIOS_LOGIN        : String  read P_USUARIOS_LOGIN        write P_USUARIOS_LOGIN;
    property USUARIOS_SENHA        : String  read P_USUARIOS_SENHA        write P_USUARIOS_SENHA;
    property USUARIOS_FUNCAO       : String  read P_USUARIOS_FUNCAO       write P_USUARIOS_FUNCAO;
    property USUARIOS_COMISSAO     : Real    read P_USUARIOS_COMISSAO     write P_USUARIOS_COMISSAO;
    property USUARIOS_PRIVILEGIADO : String  read P_USUARIOS_PRIVILEGIADO write P_USUARIOS_PRIVILEGIADO;
    property USUARIOS_ID_EMPRESAS  : Integer read P_USUARIOS_ID_EMPRESAS  write P_USUARIOS_ID_EMPRESAS;
    property USUARIOS_NOVASENHA    : String  read P_USUARIOS_NOVASENHA    write P_USUARIOS_NOVASENHA;
    property USUARIOS_TEMPO        : Integer read P_USUARIOS_TEMPO        write P_USUARIOS_TEMPO;
    property CIDADES_NOME          : String  read P_CIDADES_NOME          write P_CIDADES_NOME;
    property CIDADES_ESTADO        : String  read P_CIDADES_ESTADO        write P_CIDADES_ESTADO;
    property CIDADES_IBGE          : String  read P_CIDADES_IBGE          write P_CIDADES_IBGE;
    property EMPRESAS_NOME         : String  read P_EMPRESAS_NOME         write P_EMPRESAS_NOME;
  end;

type
  TUsuariosVO = class
  private
    p_results : TObjectList<TUsuariosBasicaVO>;
    p_total   : Integer;
  public
    property results : TObjectList<TUsuariosBasicaVO> read p_results write p_results;
    property total   : Integer                        read p_total   write p_total;
    class function GetAll(Parametros,Start,Limit:String)                                : TUsuariosVO;
    class function GetByID(Parametros:integer)                                          : TUsuariosVO;
    class function CreateRecord(UsuariosBasicaVO: TUsuariosBasicaVO)                    : TUsuariosVO;
    class function UpdateRecord(Parametros:Integer;UsuariosBasicaVO: TUsuariosBasicaVO) : TUsuariosVO;
    class function DeleteRecord(Parametros:Integer)                                     : TUsuariosVO;
    destructor Destroy; override;
  end;

implementation

uses ConexoesFactory, FuncoesController;

destructor TUsuariosVO.Destroy;
var
  UsuariosBasica : TUsuariosBasicaVO;
begin
  for UsuariosBasica in p_results do
    UsuariosBasica.Free;
  inherited;
end;

procedure ObjectToDataSet(UsuariosBasicaVO:TUsuariosBasicaVO;DataSetUsuarios:TDataSet);
begin
  DataSetUsuarios.FindField('USUARIOS_ID').AsInteger          := UsuariosBasicaVO.USUARIOS_ID;
  DataSetUsuarios.FindField('USUARIOS_STATUS').AsString       := UsuariosBasicaVO.USUARIOS_STATUS;
  DataSetUsuarios.FindField('USUARIOS_TIPO').AsString         := UsuariosBasicaVO.USUARIOS_TIPO;
  DataSetUsuarios.FindField('USUARIOS_CPFCNPJ').AsString      := UsuariosBasicaVO.USUARIOS_CPFCNPJ;
  DataSetUsuarios.FindField('USUARIOS_RG').AsString           := UsuariosBasicaVO.USUARIOS_RG;
  DataSetUsuarios.FindField('USUARIOS_NASCIMENTO').AsDateTime := UsuariosBasicaVO.USUARIOS_NASCIMENTO;
  DataSetUsuarios.FindField('USUARIOS_CADASTRO').AsDateTime   := UsuariosBasicaVO.USUARIOS_CADASTRO;
  DataSetUsuarios.FindField('USUARIOS_VALIDADE').AsDateTime   := UsuariosBasicaVO.USUARIOS_VALIDADE;
  DataSetUsuarios.FindField('USUARIOS_NOME').AsString         := UsuariosBasicaVO.USUARIOS_NOME;
  DataSetUsuarios.FindField('USUARIOS_CEP').AsString          := UsuariosBasicaVO.USUARIOS_CEP;
  DataSetUsuarios.FindField('USUARIOS_ENDERECO').AsString     := UsuariosBasicaVO.USUARIOS_ENDERECO;
  DataSetUsuarios.FindField('USUARIOS_NUMERO').AsString       := UsuariosBasicaVO.USUARIOS_NUMERO;
  DataSetUsuarios.FindField('USUARIOS_BAIRRO').AsString       := UsuariosBasicaVO.USUARIOS_BAIRRO;
  DataSetUsuarios.FindField('USUARIOS_ID_CIDADES').AsInteger  := UsuariosBasicaVO.USUARIOS_ID_CIDADES;
  DataSetUsuarios.FindField('USUARIOS_TELEFONE').AsString     := UsuariosBasicaVO.USUARIOS_TELEFONE;
  DataSetUsuarios.FindField('USUARIOS_CELULAR').AsString      := UsuariosBasicaVO.USUARIOS_CELULAR;
  DataSetUsuarios.FindField('USUARIOS_EMAIL').AsString        := UsuariosBasicaVO.USUARIOS_EMAIL;
  DataSetUsuarios.FindField('USUARIOS_LOGIN').AsString        := UpperCase(UsuariosBasicaVO.USUARIOS_LOGIN);
  DataSetUsuarios.FindField('USUARIOS_SENHA').AsString        := UpperCase(UsuariosBasicaVO.USUARIOS_SENHA);
  DataSetUsuarios.FindField('USUARIOS_FUNCAO').AsString       := UsuariosBasicaVO.USUARIOS_FUNCAO;
  DataSetUsuarios.FindField('USUARIOS_COMISSAO').AsFloat      := UsuariosBasicaVO.USUARIOS_COMISSAO;
  DataSetUsuarios.FindField('USUARIOS_PRIVILEGIADO').AsString := UsuariosBasicaVO.USUARIOS_PRIVILEGIADO;
  DataSetUsuarios.FindField('USUARIOS_ID_EMPRESAS').AsInteger := UsuariosBasicaVO.USUARIOS_ID_EMPRESAS;
  DataSetUsuarios.FindField('USUARIOS_NOVASENHA').AsString    := UsuariosBasicaVO.USUARIOS_NOVASENHA;
  DataSetUsuarios.FindField('USUARIOS_TEMPO').AsInteger       := UsuariosBasicaVO.USUARIOS_TEMPO;
end;
procedure DataSetToObject(DataSetUsuarios:TDataSet;UsuariosBasicaVO:TUsuariosBasicaVO);
begin
  UsuariosBasicaVO.USUARIOS_ID           := DataSetUsuarios.FindField('USUARIOS_ID').AsInteger;
  UsuariosBasicaVO.USUARIOS_STATUS       := DataSetUsuarios.FindField('USUARIOS_STATUS').AsString;
  UsuariosBasicaVO.USUARIOS_TIPO         := DataSetUsuarios.FindField('USUARIOS_TIPO').AsString;
  UsuariosBasicaVO.USUARIOS_CPFCNPJ      := DataSetUsuarios.FindField('USUARIOS_CPFCNPJ').AsString;
  UsuariosBasicaVO.USUARIOS_RG           := DataSetUsuarios.FindField('USUARIOS_RG').AsString;
  UsuariosBasicaVO.USUARIOS_NASCIMENTO   := DataSetUsuarios.FindField('USUARIOS_NASCIMENTO').AsDateTime;
  UsuariosBasicaVO.USUARIOS_CADASTRO     := DataSetUsuarios.FindField('USUARIOS_CADASTRO').AsDateTime;
  UsuariosBasicaVO.USUARIOS_VALIDADE     := DataSetUsuarios.FindField('USUARIOS_VALIDADE').AsDateTime;
  UsuariosBasicaVO.USUARIOS_NOME         := DataSetUsuarios.FindField('USUARIOS_NOME').AsString;
  UsuariosBasicaVO.USUARIOS_CEP          := DataSetUsuarios.FindField('USUARIOS_CEP').AsString;
  UsuariosBasicaVO.USUARIOS_ENDERECO     := DataSetUsuarios.FindField('USUARIOS_ENDERECO').AsString;
  UsuariosBasicaVO.USUARIOS_NUMERO       := DataSetUsuarios.FindField('USUARIOS_NUMERO').AsString;
  UsuariosBasicaVO.USUARIOS_BAIRRO       := DataSetUsuarios.FindField('USUARIOS_BAIRRO').AsString;
  UsuariosBasicaVO.USUARIOS_ID_CIDADES   := DataSetUsuarios.FindField('USUARIOS_ID_CIDADES').AsInteger;
  UsuariosBasicaVO.USUARIOS_TELEFONE     := DataSetUsuarios.FindField('USUARIOS_TELEFONE').AsString;
  UsuariosBasicaVO.USUARIOS_CELULAR      := DataSetUsuarios.FindField('USUARIOS_CELULAR').AsString;
  UsuariosBasicaVO.USUARIOS_EMAIL        := DataSetUsuarios.FindField('USUARIOS_EMAIL').AsString;
  UsuariosBasicaVO.USUARIOS_LOGIN        := DataSetUsuarios.FindField('USUARIOS_LOGIN').AsString;
  UsuariosBasicaVO.USUARIOS_SENHA        := DataSetUsuarios.FindField('USUARIOS_SENHA').AsString;
  UsuariosBasicaVO.USUARIOS_FUNCAO        := DataSetUsuarios.FindField('USUARIOS_FUNCAO').AsString;
  UsuariosBasicaVO.USUARIOS_COMISSAO     := DataSetUsuarios.FindField('USUARIOS_COMISSAO').AsFloat;
  UsuariosBasicaVO.USUARIOS_PRIVILEGIADO := DataSetUsuarios.FindField('USUARIOS_PRIVILEGIADO').AsString;
  UsuariosBasicaVO.USUARIOS_ID_EMPRESAS  := DataSetUsuarios.FindField('USUARIOS_ID_EMPRESAS').AsInteger;
  UsuariosBasicaVO.USUARIOS_NOVASENHA    := DataSetUsuarios.FindField('USUARIOS_NOVASENHA').AsString;
  UsuariosBasicaVO.USUARIOS_TEMPO        := DataSetUsuarios.FindField('USUARIOS_TEMPO').AsInteger;
  UsuariosBasicaVO.CIDADES_NOME          := DataSetUsuarios.FindField('CIDADES_NOME').AsString;
  UsuariosBasicaVO.CIDADES_ESTADO        := DataSetUsuarios.FindField('CIDADES_ESTADO').AsString;
  UsuariosBasicaVO.CIDADES_IBGE          := DataSetUsuarios.FindField('CIDADES_IBGE').AsString;
  UsuariosBasicaVO.EMPRESAS_NOME         := DataSetUsuarios.FindField('EMPRESAS_NOME').AsString;
end;

class function TUsuariosVO.GetAll(Parametros,Start,Limit:String): TUsuariosVO;
var
  ConexoesControl  : TConexoesFactory;
  DataSetUsuarios  : TDataSet;
  UsuariosVO       : TUsuariosVO;
  UsuariosBasicaVO : TUsuariosBasicaVO;
  SQLAtivo         : String;
  SQLWhere         : String;
  SQLOrder         : String;
  Registros        : Integer;
  StrParametros    : TStringList;
begin

  ConexoesControl  := TConexoesFactory.Create;

  if StrContains(Parametros,'|') then
    StrParametros := Explode(Parametros,'|')
  else
    begin
      StrParametros := TStringList.Create;
      StrParametros.add(Parametros);
    end;

  if StrParametros[0] = 'ULTIMAUSUARIOS' then
    begin
      try
        UsuariosVO                             := TUsuariosVO.Create;
        UsuariosVO.results                     := TObjectList<TUsuariosBasicaVO>.Create;
        UsuariosVO.Total                       := 1;
        UsuariosBasicaVO                       := TUsuariosBasicaVO.Create;
        UsuariosBasicaVO.USUARIOS_ID           := ConexoesControl.Ultimo_ID('USUARIOS','F') + 1;
        UsuariosBasicaVO.USUARIOS_STATUS       := 'T';
        UsuariosBasicaVO.USUARIOS_TIPO         := '0';
        UsuariosBasicaVO.USUARIOS_CPFCNPJ      := '';
        UsuariosBasicaVO.USUARIOS_RG           := '';
        UsuariosBasicaVO.USUARIOS_NASCIMENTO   := Date;
        UsuariosBasicaVO.USUARIOS_CADASTRO     := Date;
        UsuariosBasicaVO.USUARIOS_VALIDADE     := Date + 365;
        UsuariosBasicaVO.USUARIOS_NOME         := '';
        UsuariosBasicaVO.USUARIOS_CEP          := '';
        UsuariosBasicaVO.USUARIOS_ENDERECO     := '';
        UsuariosBasicaVO.USUARIOS_NUMERO       := '';
        UsuariosBasicaVO.USUARIOS_BAIRRO       := '';
        UsuariosBasicaVO.USUARIOS_ID_CIDADES   := 0;
        UsuariosBasicaVO.USUARIOS_TELEFONE     := '';
        UsuariosBasicaVO.USUARIOS_CELULAR      := '';
        UsuariosBasicaVO.USUARIOS_EMAIL        := '';
        UsuariosBasicaVO.USUARIOS_LOGIN        := '';
        UsuariosBasicaVO.USUARIOS_SENHA        := '';
        UsuariosBasicaVO.USUARIOS_FUNCAO       := '';
        UsuariosBasicaVO.USUARIOS_COMISSAO     := 0;
        UsuariosBasicaVO.USUARIOS_PRIVILEGIADO := 'F';
        UsuariosBasicaVO.USUARIOS_ID_EMPRESAS  := 1;
        UsuariosBasicaVO.USUARIOS_NOVASENHA    := 'T';
        UsuariosBasicaVO.USUARIOS_TEMPO        := 5;
        UsuariosVO.results.Add(UsuariosBasicaVO);
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(ConexoesControl);
      end;
    end
  else
    begin
      SQLWhere := ' where USUARIOS_ID > 0 ';

      if StrLeft(StrParametros[0],1) = '.' then
        begin
          SQLWhere := ' where USUARIOS_ID = '   + IntToStr(Valor_int(Copy(StrParametros[0],2,6)));
          SQLAtivo := '';
          SQLOrder := ' order by USUARIOS_ID';
        end
      else
        begin
          case Valor_Int(StrParametros[1]) of
            0: SQLAtivo := ' and USUARIOS_STATUS = ' + QuotedStr('T');
            1: SQLAtivo := ' and USUARIOS_STATUS = ' + QuotedStr('F');
            2: SQLAtivo := '';
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLWhere := SQLWhere + ' and USUARIOS_NOME starting ' + QuotedStr(StrParametros[0]);
            1: SQLWhere := SQLWhere + ' and USUARIOS_ID >= '          + iif(StrEmpty(StrParametros[0]),'0',StrParametros[0]);
            2: SQLWhere := SQLWhere + ' and USUARIOS_NOME like '     + QuotedStr('%' + StrParametros[0] + '%');
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLOrder := ' order by USUARIOS_NOME';
            1: SQLOrder := ' order by USUARIOS_ID';
            2: SQLOrder := ' order by USUARIOS_NOME';
          end;
        end;

      Registros := ConexoesControl.TotalRegistros('select count(*) as REGISTROS from USUARIOS '+ SQLWhere + SQLAtivo);

      if Registros <= Valor_Int(limit) then
        DataSetUsuarios := ConexoesControl.Abre_Tabelas('select * from USUARIOS ' +
                                                        'join CIDADES  on CIDADES_ID  = USUARIOS_ID_CIDADES '  +
                                                        'join EMPRESAS on EMPRESAS_ID = USUARIOS_ID_EMPRESAS ' +
                                                         SQLWhere + SQLAtivo + SQLOrder)
      else
        DataSetUsuarios := ConexoesControl.Abre_Tabelas('select first ' + limit + ' skip ' + start + ' * from USUARIOS ' +
                                                        'join CIDADES  on CIDADES_ID  = USUARIOS_ID_CIDADES '  +
                                                        'join EMPRESAS on EMPRESAS_ID = USUARIOS_ID_EMPRESAS ' +
                                                        SqlWhere + SqlAtivo +  SqlOrder);

      UsuariosVO       := TUsuariosVO.Create;
      UsuariosVO.results := TObjectList<TUsuariosBasicaVO>.Create;
      UsuariosVO.Total := Registros;
      try
        DataSetUsuarios.First;
        while not DataSetUsuarios.Eof do
          begin
            UsuariosBasicaVO             := TUsuariosBasicaVO.Create;
            UsuariosBasicaVO.USUARIOS_ID := DataSetUsuarios.FindField('USUARIOS_ID').AsInteger;
            DataSetToObject(DataSetUsuarios,UsuariosBasicaVO);
            UsuariosVO.results.Add(UsuariosBasicaVO);
            DataSetUsuarios.Next;
          end;
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(DataSetUsuarios);
        FreeAndNil(ConexoesControl);
      end;
    end;

  Result := UsuariosVO;

end;

class function TUsuariosVO.GetByID(Parametros: integer): TUsuariosVO;
var
  ConexoesControl  : TConexoesFactory;
  UsuariosVO       : TUsuariosVO;
  UsuariosBasicaVO : TUsuariosBasicaVO;
  DataSetUsuarios  : TDataSet;
begin
  ConexoesControl    := TConexoesFactory.Create;
  DataSetUsuarios    := ConexoesControl.Abre_tabelas('select * from USUARIOS where USUARIOS_ID = ' + valor_str(Parametros));
  UsuariosVO         := TUsuariosVO.Create;
  UsuariosVO.results := TObjectList<TUsuariosBasicaVO>.Create;
  UsuariosVO.Total   := 0;
  try
    if not DataSetUsuarios.IsEmpty then
      begin
        UsuariosVO.Total   := 1;
        UsuariosBasicaVO   := TUsuariosBasicaVO.Create;
        DataSetToObject(DataSetUsuarios,UsuariosBasicaVO);
        UsuariosVO.results.Add(UsuariosBasicaVO);
      end;
  finally
    FreeAndNil(DataSetUsuarios);
    FreeAndNil(ConexoesControl);
  end;
  Result := UsuariosVO;
end;

class function TUsuariosVO.CreateRecord(UsuariosBasicaVO: TUsuariosBasicaVO): TUsuariosVO;
var
  ConexoesControl  : TConexoesFactory;
  DataSetUsuarios  : TDataSet;
begin
  ConexoesControl  := TConexoesFactory.Create;
  DataSetUsuarios  := ConexoesControl.Abre_tabelas('select * from USUARIOS where USUARIOS_ID = 0 ');
  Result           := TUsuariosVO.Create;
  Result.results   := TObjectList<TUsuariosBasicaVO>.Create;
  Result.Total     := 0;
  try
    DataSetUsuarios.Append;
    UsuariosBasicaVO.USUARIOS_ID := ConexoesControl.Ultimo_ID('USUARIOS','T');
    objectToDataSet(UsuariosBasicaVO,DataSetUsuarios);
    try
      DataSetUsuarios.Post;
      Result.Total   := 1;
      Result.results.Add(UsuariosBasicaVO);
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(DataSetUsuarios);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TUsuariosVO.UpdateRecord(Parametros:Integer;UsuariosBasicaVO: TUsuariosBasicaVO): TUsuariosVO;
var
  ConexoesControl  : TConexoesFactory;
  DataSetUsuarios  : TDataSet;
begin
  ConexoesControl  := TConexoesFactory.Create;
  DataSetUsuarios  := ConexoesControl.Abre_tabelas('select * from USUARIOS where USUARIOS_ID = ' + valor_str(Parametros));
  Result           := TUsuariosVO.Create;
  Result.results   := TObjectList<TUsuariosBasicaVO>.Create;
  Result.Total     := 0;
  try
    if not DataSetUsuarios.IsEmpty then
      begin
        DataSetUsuarios.Edit;
        UsuariosBasicaVO.USUARIOS_ID := Parametros;
        objectToDataSet(UsuariosBasicaVO,DataSetUsuarios);
        try
          DataSetUsuarios.Post;
          Result.Total   := 1;
        except
          on e: exception do gera_log(e.message);
        end;
      end;
  finally
    FreeAndNil(DataSetUsuarios);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TUsuariosVO.DeleteRecord(Parametros:Integer): TUsuariosVO;
var
  ConexoesControl  : TConexoesFactory;
begin
  ConexoesControl  := TConexoesFactory.Create;
  Result           := TUsuariosVO.Create;
  Result.results   := TObjectList<TUsuariosBasicaVO>.Create;
  Result.Total     := 0;
  try
    try
      ConexoesControl.ExecutaScriptSQL('delete from USUARIOS where USUARIOS_ID = ' + Valor_Str(Parametros));
      Result.Total   := 1;
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;
end;

end.
