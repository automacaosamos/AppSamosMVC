unit EmpresasVO;

interface

uses
  DB,
  System.SysUtils,
  System.Generics.Collections,
  System.Classes;
  type
  TEmpresasBasicaVO = class
  private
    P_EMPRESAS_ID              : Integer;
    P_EMPRESAS_STATUS          : String;
    P_EMPRESAS_CPFCNPJ         : String;
    P_EMPRESAS_INSCRICAO       : String;
    P_EMPRESAS_MUNICIPAL       : String;
    P_EMPRESAS_CADASTRO        : TDate;
    P_EMPRESAS_NOME            : String;
    P_EMPRESAS_FANTASIA        : String;
    P_EMPRESAS_CEP             : String;
    P_EMPRESAS_ID_CIDADES      : Integer;
    P_EMPRESAS_ENDERECO        : String;
    P_EMPRESAS_NUMERO          : String;
    P_EMPRESAS_BAIRRO          : String;
    P_EMPRESAS_TELEFONE        : String;
    P_EMPRESAS_CELULAR         : String;
    P_EMPRESAS_PAGINA          : String;
    P_EMPRESAS_EMAIL           : String;
    P_EMPRESAS_CERTIFICADO     : String;
    P_EMPRESAS_SENHA           : String;
    P_EMPRESAS_AMBIENTE        : String;
    P_EMPRESAS_SMTP            : String;
    P_EMPRESAS_LOGIN           : String;
    P_EMPRESAS_PASSWORD        : String;
    P_EMPRESAS_AUTENTICA       : String;
    P_EMPRESAS_ID_PORTADORES   : Integer;
    P_EMPRESAS_SIMPLES         : String;
    P_EMPRESAS_ALIQUOTA        : Real;
    P_EMPRESAS_REGIAO12        : String;
    P_EMPRESAS_IMPRESSAO       : String;
    P_EMPRESAS_CAIXA           : String;
    P_EMPRESAS_ANALISACLIENTE  : String;
    P_EMPRESAS_ATRASOCLIENTE   : Integer;
    P_EMPRESAS_CNAE            : String;
    P_CIDADES_NOME             : String;
    P_CIDADES_ESTADO           : String;
    P_CIDADES_IBGE             : String;
    P_PORTADORES_NOME          : String;
  public
    property EMPRESAS_ID              : Integer   read P_EMPRESAS_ID             write P_EMPRESAS_ID;
    property EMPRESAS_STATUS          : String    read P_EMPRESAS_STATUS         write P_EMPRESAS_STATUS;
    property EMPRESAS_CPFCNPJ         : String    read P_EMPRESAS_CPFCNPJ        write P_EMPRESAS_CPFCNPJ;
    property EMPRESAS_INSCRICAO       : String    read P_EMPRESAS_INSCRICAO      write P_EMPRESAS_INSCRICAO;
    property EMPRESAS_MUNICIPAL       : String    read P_EMPRESAS_MUNICIPAL      write P_EMPRESAS_MUNICIPAL;
    property EMPRESAS_CADASTRO        : TDate     read P_EMPRESAS_CADASTRO       write P_EMPRESAS_CADASTRO;
    property EMPRESAS_NOME            : String    read P_EMPRESAS_NOME           write P_EMPRESAS_NOME;
    property EMPRESAS_FANTASIA        : String    read P_EMPRESAS_FANTASIA       write P_EMPRESAS_FANTASIA;
    property EMPRESAS_CEP             : String    read P_EMPRESAS_CEP            write P_EMPRESAS_CEP;
    property EMPRESAS_ID_CIDADES      : Integer   read P_EMPRESAS_ID_CIDADES     write P_EMPRESAS_ID_CIDADES;
    property EMPRESAS_ENDERECO        : String    read P_EMPRESAS_ENDERECO       write P_EMPRESAS_ENDERECO;
    property EMPRESAS_NUMERO          : String    read P_EMPRESAS_NUMERO         write P_EMPRESAS_NUMERO;
    property EMPRESAS_BAIRRO          : String    read P_EMPRESAS_BAIRRO         write P_EMPRESAS_BAIRRO;
    property EMPRESAS_TELEFONE        : String    read P_EMPRESAS_TELEFONE       write P_EMPRESAS_TELEFONE;
    property EMPRESAS_CELULAR         : String    read P_EMPRESAS_CELULAR        write P_EMPRESAS_CELULAR;
    property EMPRESAS_PAGINA          : String    read P_EMPRESAS_PAGINA         write P_EMPRESAS_PAGINA;
    property EMPRESAS_EMAIL           : String    read P_EMPRESAS_EMAIL          write P_EMPRESAS_EMAIL;
    property EMPRESAS_CERTIFICADO     : String    read P_EMPRESAS_CERTIFICADO    write P_EMPRESAS_CERTIFICADO;
    property EMPRESAS_SENHA           : String    read P_EMPRESAS_SENHA          write P_EMPRESAS_SENHA;
    property EMPRESAS_AMBIENTE        : String    read P_EMPRESAS_AMBIENTE       write P_EMPRESAS_AMBIENTE;
    property EMPRESAS_SMTP            : String    read P_EMPRESAS_SMTP           write P_EMPRESAS_SMTP;
    property EMPRESAS_LOGIN           : String    read P_EMPRESAS_LOGIN          write P_EMPRESAS_LOGIN;
    property EMPRESAS_PASSWORD        : String    read P_EMPRESAS_PASSWORD       write P_EMPRESAS_PASSWORD;
    property EMPRESAS_AUTENTICA       : String    read P_EMPRESAS_AUTENTICA      write P_EMPRESAS_AUTENTICA;
    property EMPRESAS_ID_PORTADORES   : Integer   read P_EMPRESAS_ID_PORTADORES  write P_EMPRESAS_ID_PORTADORES;
    property EMPRESAS_SIMPLES         : String    read P_EMPRESAS_SIMPLES        write P_EMPRESAS_SIMPLES;
    property EMPRESAS_ALIQUOTA        : Real      read P_EMPRESAS_ALIQUOTA       write P_EMPRESAS_ALIQUOTA;
    property EMPRESAS_REGIAO12        : String    read P_EMPRESAS_REGIAO12       write P_EMPRESAS_REGIAO12;
    property EMPRESAS_IMPRESSAO       : String    read P_EMPRESAS_IMPRESSAO      write P_EMPRESAS_IMPRESSAO;
    property EMPRESAS_CAIXA           : String    read P_EMPRESAS_CAIXA          write P_EMPRESAS_CAIXA;
    property EMPRESAS_ANALISACLIENTE  : String    read P_EMPRESAS_ANALISACLIENTE write P_EMPRESAS_ANALISACLIENTE;
    property EMPRESAS_ATRASOCLIENTE   : Integer   read P_EMPRESAS_ATRASOCLIENTE  write P_EMPRESAS_ATRASOCLIENTE;
    property EMPRESAS_CNAE            : String    read P_EMPRESAS_CNAE           write P_EMPRESAS_CNAE;
    property CIDADES_NOME             : String    read P_CIDADES_NOME            write P_CIDADES_NOME;
    property CIDADES_ESTADO           : String    read P_CIDADES_ESTADO          write P_CIDADES_ESTADO;
    property CIDADES_IBGE             : String    read P_CIDADES_IBGE            write P_CIDADES_IBGE;
    property PORTADORES_NOME          : String    read P_PORTADORES_NOME         write P_PORTADORES_NOME;
  end;

type
  TEmpresasVO = class
  private
    p_results : TObjectList<TEmpresasBasicaVO>;
    p_total   : Integer;
  public
    property results : TObjectList<TEmpresasBasicaVO> read p_results  write p_results;
    property total   : Integer                        read p_total    write p_total;
    class function GetAll(Parametros,Start,Limit:String)                                : TEmpresasVO;
    class function GetByID(Parametros:integer)                                          : TEmpresasVO;
    class function CreateRecord(EmpresasBasicaVO: TEmpresasBasicaVO)                    : TEmpresasVO;
    class function UpdateRecord(Parametros:Integer;EmpresasBasicaVO: TEmpresasBasicaVO) : TEmpresasVO;
    class function DeleteRecord(Parametros:Integer)                                     : TEmpresasVO;
    destructor Destroy; override;
  end;

implementation

uses ConexoesController, FuncoesController;

destructor TEmpresasVO.Destroy;
var
  EmpresasBasica : TEmpresasBasicaVO;
begin
  for EmpresasBasica in p_results do
    EmpresasBasica.Free;
  inherited;
end;

procedure ObjectToDataSet(EmpresasBasicaVO:TEmpresasBasicaVO;DataSetEmpresas:TDataSet);
begin
  DataSetEmpresas.FindField('EMPRESAS_ID').AsInteger            := EmpresasBasicaVO.EMPRESAS_ID;
  DataSetEmpresas.FindField('EMPRESAS_STATUS').AsString         := EmpresasBasicaVO.EMPRESAS_STATUS;
  DataSetEmpresas.FindField('EMPRESAS_CPFCNPJ').AsString        := EmpresasBasicaVO.EMPRESAS_CPFCNPJ;
  DataSetEmpresas.FindField('EMPRESAS_INSCRICAO').AsString      := EmpresasBasicaVO.EMPRESAS_INSCRICAO;
  DataSetEmpresas.FindField('EMPRESAS_MUNICIPAL').AsString      := EmpresasBasicaVO.EMPRESAS_MUNICIPAL;
  DataSetEmpresas.FindField('EMPRESAS_CADASTRO').AsDateTime     := EmpresasBasicaVO.EMPRESAS_CADASTRO;
  DataSetEmpresas.FindField('EMPRESAS_NOME').AsString           := EmpresasBasicaVO.EMPRESAS_NOME;
  DataSetEmpresas.FindField('EMPRESAS_FANTASIA').AsString       := EmpresasBasicaVO.EMPRESAS_FANTASIA;
  DataSetEmpresas.FindField('EMPRESAS_CEP').AsString            := EmpresasBasicaVO.EMPRESAS_CEP;
  DataSetEmpresas.FindField('EMPRESAS_ID_CIDADES').AsInteger    := EmpresasBasicaVO.EMPRESAS_ID_CIDADES;
  DataSetEmpresas.FindField('EMPRESAS_ENDERECO').AsString       := EmpresasBasicaVO.EMPRESAS_ENDERECO;
  DataSetEmpresas.FindField('EMPRESAS_NUMERO').AsString         := EmpresasBasicaVO.EMPRESAS_NUMERO;
  DataSetEmpresas.FindField('EMPRESAS_BAIRRO').AsString         := EmpresasBasicaVO.EMPRESAS_BAIRRO;
  DataSetEmpresas.FindField('EMPRESAS_TELEFONE').AsString       := EmpresasBasicaVO.EMPRESAS_TELEFONE;
  DataSetEmpresas.FindField('EMPRESAS_CELULAR').AsString        := EmpresasBasicaVO.EMPRESAS_CELULAR;
  DataSetEmpresas.FindField('EMPRESAS_PAGINA').AsString         := EmpresasBasicaVO.EMPRESAS_PAGINA;
  DataSetEmpresas.FindField('EMPRESAS_EMAIL').AsString          := EmpresasBasicaVO.EMPRESAS_EMAIL;
  DataSetEmpresas.FindField('EMPRESAS_CERTIFICADO').AsString    := EmpresasBasicaVO.EMPRESAS_CERTIFICADO;
  DataSetEmpresas.FindField('EMPRESAS_SENHA').AsString          := EmpresasBasicaVO.EMPRESAS_SENHA;
  DataSetEmpresas.FindField('EMPRESAS_AMBIENTE').AsString       := EmpresasBasicaVO.EMPRESAS_AMBIENTE;
  DataSetEmpresas.FindField('EMPRESAS_SMTP').AsString           := EmpresasBasicaVO.EMPRESAS_SMTP;
  DataSetEmpresas.FindField('EMPRESAS_LOGIN').AsString          := EmpresasBasicaVO.EMPRESAS_LOGIN;
  DataSetEmpresas.FindField('EMPRESAS_PASSWORD').AsString       := EmpresasBasicaVO.EMPRESAS_PASSWORD;
  DataSetEmpresas.FindField('EMPRESAS_AUTENTICA').AsString      := EmpresasBasicaVO.EMPRESAS_AUTENTICA;
  DataSetEmpresas.FindField('EMPRESAS_ID_PORTADORES').AsInteger := EmpresasBasicaVO.EMPRESAS_ID_PORTADORES;
  DataSetEmpresas.FindField('EMPRESAS_SIMPLES').AsString        := EmpresasBasicaVO.EMPRESAS_SIMPLES;
  DataSetEmpresas.FindField('EMPRESAS_ALIQUOTA').AsFloat        := EmpresasBasicaVO.EMPRESAS_ALIQUOTA;
  DataSetEmpresas.FindField('EMPRESAS_REGIAO12').AsString       := EmpresasBasicaVO.EMPRESAS_REGIAO12;
  DataSetEmpresas.FindField('EMPRESAS_IMPRESSAO').AsString      := EmpresasBasicaVO.EMPRESAS_IMPRESSAO;
  DataSetEmpresas.FindField('EMPRESAS_CAIXA').AsString          := EmpresasBasicaVO.EMPRESAS_CAIXA;
  DataSetEmpresas.FindField('EMPRESAS_ANALISACLIENTE').AsString := EmpresasBasicaVO.EMPRESAS_ANALISACLIENTE;
  DataSetEmpresas.FindField('EMPRESAS_ATRASOCLIENTE').AsInteger := EmpresasBasicaVO.EMPRESAS_ATRASOCLIENTE;
  DataSetEmpresas.FindField('EMPRESAS_CNAE').AsString           := EmpresasBasicaVO.EMPRESAS_CNAE;
end;
procedure DataSetToObject(DataSetEmpresas:TDataSet;EmpresasBasicaVO:TEmpresasBasicaVO);
begin
  EmpresasBasicaVO.EMPRESAS_ID             := DataSetEmpresas.FindField('EMPRESAS_ID').AsInteger;
  EmpresasBasicaVO.EMPRESAS_STATUS         := DataSetEmpresas.FindField('EMPRESAS_STATUS').AsString;
  EmpresasBasicaVO.EMPRESAS_CPFCNPJ        := DataSetEmpresas.FindField('EMPRESAS_CPFCNPJ').AsString;
  EmpresasBasicaVO.EMPRESAS_INSCRICAO      := DataSetEmpresas.FindField('EMPRESAS_INSCRICAO').AsString;
  EmpresasBasicaVO.EMPRESAS_MUNICIPAL      := DataSetEmpresas.FindField('EMPRESAS_MUNICIPAL').AsString;
  EmpresasBasicaVO.EMPRESAS_CADASTRO       := DataSetEmpresas.FindField('EMPRESAS_CADASTRO').AsDateTime;
  EmpresasBasicaVO.EMPRESAS_NOME           := DataSetEmpresas.FindField('EMPRESAS_NOME').AsString;
  EmpresasBasicaVO.EMPRESAS_FANTASIA       := DataSetEmpresas.FindField('EMPRESAS_FANTASIA').AsString;
  EmpresasBasicaVO.EMPRESAS_CEP            := DataSetEmpresas.FindField('EMPRESAS_CEP').AsString;
  EmpresasBasicaVO.EMPRESAS_ID_CIDADES     := DataSetEmpresas.FindField('EMPRESAS_ID_CIDADES').AsInteger;
  EmpresasBasicaVO.EMPRESAS_ENDERECO       := DataSetEmpresas.FindField('EMPRESAS_ENDERECO').AsString;
  EmpresasBasicaVO.EMPRESAS_NUMERO         := DataSetEmpresas.FindField('EMPRESAS_NUMERO').AsString;
  EmpresasBasicaVO.EMPRESAS_BAIRRO         := DataSetEmpresas.FindField('EMPRESAS_BAIRRO').AsString;
  EmpresasBasicaVO.EMPRESAS_TELEFONE       := DataSetEmpresas.FindField('EMPRESAS_TELEFONE').AsString;
  EmpresasBasicaVO.EMPRESAS_CELULAR        := DataSetEmpresas.FindField('EMPRESAS_CELULAR').AsString;
  EmpresasBasicaVO.EMPRESAS_PAGINA         := DataSetEmpresas.FindField('EMPRESAS_PAGINA').AsString;
  EmpresasBasicaVO.EMPRESAS_EMAIL          := DataSetEmpresas.FindField('EMPRESAS_EMAIL').AsString;
  EmpresasBasicaVO.EMPRESAS_CERTIFICADO    := DataSetEmpresas.FindField('EMPRESAS_CERTIFICADO').AsString;
  EmpresasBasicaVO.EMPRESAS_SENHA          := DataSetEmpresas.FindField('EMPRESAS_SENHA').AsString;
  EmpresasBasicaVO.EMPRESAS_AMBIENTE       := DataSetEmpresas.FindField('EMPRESAS_AMBIENTE').AsString;
  EmpresasBasicaVO.EMPRESAS_SMTP           := DataSetEmpresas.FindField('EMPRESAS_SMTP').AsString;
  EmpresasBasicaVO.EMPRESAS_LOGIN          := DataSetEmpresas.FindField('EMPRESAS_LOGIN').AsString;
  EmpresasBasicaVO.EMPRESAS_PASSWORD       := DataSetEmpresas.FindField('EMPRESAS_PASSWORD').AsString;
  EmpresasBasicaVO.EMPRESAS_AUTENTICA      := DataSetEmpresas.FindField('EMPRESAS_AUTENTICA').AsString;
  EmpresasBasicaVO.EMPRESAS_ID_PORTADORES  := DataSetEmpresas.FindField('EMPRESAS_ID_PORTADORES').AsInteger;
  EmpresasBasicaVO.EMPRESAS_SIMPLES        := DataSetEmpresas.FindField('EMPRESAS_SIMPLES').AsString;
  EmpresasBasicaVO.EMPRESAS_ALIQUOTA       := DataSetEmpresas.FindField('EMPRESAS_ALIQUOTA').AsFloat;
  EmpresasBasicaVO.EMPRESAS_REGIAO12       := DataSetEmpresas.FindField('EMPRESAS_REGIAO12').AsString;
  EmpresasBasicaVO.EMPRESAS_IMPRESSAO      := DataSetEmpresas.FindField('EMPRESAS_IMPRESSAO').AsString;
  EmpresasBasicaVO.EMPRESAS_CAIXA          := DataSetEmpresas.FindField('EMPRESAS_CAIXA').AsString;
  EmpresasBasicaVO.EMPRESAS_ANALISACLIENTE := DataSetEmpresas.FindField('EMPRESAS_ANALISACLIENTE').AsString;
  EmpresasBasicaVO.EMPRESAS_ATRASOCLIENTE  := DataSetEmpresas.FindField('EMPRESAS_ATRASOCLIENTE').AsInteger;
  EmpresasBasicaVO.EMPRESAS_CNAE           := DataSetEmpresas.FindField('EMPRESAS_CNAE').AsString;
  EmpresasBasicaVO.CIDADES_NOME            := DataSetEmpresas.FindField('CIDADES_NOME').AsString;
  EmpresasBasicaVO.CIDADES_ESTADO          := DataSetEmpresas.FindField('CIDADES_ESTADO').AsString;
  EmpresasBasicaVO.CIDADES_IBGE            := DataSetEmpresas.FindField('CIDADES_IBGE').AsString;
  EmpresasBasicaVO.PORTADORES_NOME         := DataSetEmpresas.FindField('PORTADORES_NOME').AsString;
end;
class function TEmpresasVO.GetAll(Parametros,Start,Limit:String): TEmpresasVO;
var
  ConexoesControl  : TConexoesController;
  DataSetEmpresas  : TDataSet;
  EmpresasVO       : TEmpresasVO;
  EmpresasBasicaVO : TEmpresasBasicaVO;
  SQLAtivo         : String;
  SQLWhere         : String;
  SQLOrder         : String;
  Registros        : Integer;
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

  if StrParametros[0] = 'ULTIMAEMPRESAS' then
    begin
      try
        EmpresasVO                               := TEmpresasVO.Create;
        EmpresasVO.results                       := TObjectList<TEmpresasBasicaVO>.Create;
        EmpresasVO.Total                         := 1;
        EmpresasBasicaVO                         := TEmpresasBasicaVO.Create;
        EmpresasBasicaVO.EMPRESAS_ID             := ConexoesControl.Ultimo_ID('EMPRESAS','F') + 1;
        EmpresasBasicaVO.EMPRESAS_NOME           := '';
        EmpresasBasicaVO.EMPRESAS_STATUS         := 'T';
        EmpresasBasicaVO.EMPRESAS_CADASTRO       := Date;
        EmpresasBasicaVO.EMPRESAS_ID_CIDADES     := 0;
        EmpresasBasicaVO.EMPRESAS_AMBIENTE       := 'H';
        EmpresasBasicaVO.EMPRESAS_AUTENTICA      := 'F';
        EmpresasBasicaVO.EMPRESAS_ID_PORTADORES  := 1;
        EmpresasBasicaVO.EMPRESAS_SIMPLES        := 'T';
        EmpresasBasicaVO.EMPRESAS_ALIQUOTA       := 0;
        EmpresasBasicaVO.EMPRESAS_REGIAO12       := 'PR#SC#MG#RJ#RS';
        EmpresasBasicaVO.EMPRESAS_IMPRESSAO      := '0';
        EmpresasBasicaVO.EMPRESAS_CAIXA          := 'F';
        EmpresasBasicaVO.EMPRESAS_ANALISACLIENTE := 'F';
        EmpresasBasicaVO.EMPRESAS_ATRASOCLIENTE  := 0;
        EmpresasVO.results.Add(EmpresasBasicaVO);
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(ConexoesControl);
      end;
    end
  else
    begin
      SQLWhere := ' where EMPRESAS_ID > 0 ';

      if StrLeft(StrParametros[0],1) = '.' then
        begin
          SQLWhere := ' where EMPRESAS_ID = '   + IntToStr(Valor_int(Copy(StrParametros[0],2,6)));
          SQLAtivo := '';
          SQLOrder := ' order by EMPRESAS_ID';
        end
      else
        begin
          case Valor_Int(StrParametros[1]) of
            0: SQLAtivo := ' and EMPRESAS_STATUS = ' + QuotedStr('T');
            1: SQLAtivo := ' and EMPRESAS_STATUS = ' + QuotedStr('F');
            2: SQLAtivo := '';
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLWhere := SQLWhere + ' and EMPRESAS_NOME starting ' + QuotedStr(StrParametros[0]);
            1: SQLWhere := SQLWhere + ' and EMPRESAS_ID >= '          + iif(StrEmpty(StrParametros[0]),'0',StrParametros[0]);
            2: SQLWhere := SQLWhere + ' and EMPRESAS_NOME like '     + QuotedStr('%' + StrParametros[0] + '%');
          end;
          case Valor_Int(StrParametros[2]) of
            0: SQLOrder := ' order by EMPRESAS_NOME';
            1: SQLOrder := ' order by EMPRESAS_ID';
            2: SQLOrder := ' order by EMPRESAS_NOME';
          end;
        end;

      Registros := ConexoesControl.TotalRegistros('select count(*) as REGISTROS from EMPRESAS '+ SQLWhere + SQLAtivo);

      if Registros <= Valor_Int(limit) then
        DataSetEmpresas := ConexoesControl.Abre_Tabelas('select * from EMPRESAS ' +
                                                        'join CIDADES on CIDADES_ID = EMPRESAS_ID_CIDADES ' +
                                                        'join PORTADORES on PORTADORES_ID = EMPRESAS_ID_PORTADORES ' +
                                                         SQLWhere + SQLAtivo + SQLOrder)
      else
        DataSetEmpresas := ConexoesControl.Abre_Tabelas('select first ' + limit + ' skip ' + start + ' * from EMPRESAS ' +
                                                        'join CIDADES on CIDADES_ID = EMPRESAS_ID_CIDADES ' +
                                                        'join PORTADORES on PORTADORES_ID = EMPRESAS_ID_PORTADORES ' +
                                                        SqlWhere + SqlAtivo +  SqlOrder);

      EmpresasVO           := TEmpresasVO.Create;
      EmpresasVO.results := TObjectList<TEmpresasBasicaVO>.Create;
      EmpresasVO.Total     := Registros;
      try
        DataSetEmpresas.First;
        while not DataSetEmpresas.Eof do
          begin
            EmpresasBasicaVO             := TEmpresasBasicaVO.Create;
            EmpresasBasicaVO.EMPRESAS_ID := DataSetEmpresas.FindField('EMPRESAS_ID').AsInteger;
            DataSetToObject(DataSetEmpresas,EmpresasBasicaVO);
            EmpresasVO.results.Add(EmpresasBasicaVO);
            DataSetEmpresas.Next;
          end;
      finally
        FreeAndNil(StrParametros);
        FreeAndNil(DataSetEmpresas);
        FreeAndNil(ConexoesControl);
      end;
    end;

  Result := EmpresasVO;

end;

class function TEmpresasVO.GetByID(Parametros: integer): TEmpresasVO;
var
  ConexoesControl  : TConexoesController;
  EmpresasVO       : TEmpresasVO;
  EmpresasBasicaVO : TEmpresasBasicaVO;
  DataSetEmpresas  : TDataSet;
begin
  ConexoesControl    := TConexoesController.Create;
  DataSetEmpresas    := ConexoesControl.Abre_tabelas('select * from EMPRESAS where EMPRESAS_ID = ' + valor_str(Parametros));
  EmpresasVO         := TEmpresasVO.Create;
  EmpresasVO.results := TObjectList<TEmpresasBasicaVO>.Create;
  EmpresasVO.Total   := 0;
  try
    if not DataSetEmpresas.IsEmpty then
      begin
        EmpresasVO.Total   := 1;
        EmpresasBasicaVO   := TEmpresasBasicaVO.Create;
        DataSetToObject(DataSetEmpresas,EmpresasBasicaVO);
        EmpresasVO.results.Add(EmpresasBasicaVO);
      end;
  finally
    FreeAndNil(DataSetEmpresas);
    FreeAndNil(ConexoesControl);
  end;
  Result := EmpresasVO;
end;

class function TEmpresasVO.CreateRecord(EmpresasBasicaVO: TEmpresasBasicaVO): TEmpresasVO;
var
  ConexoesControl  : TConexoesController;
  DataSetEmpresas  : TDataSet;
begin
  ConexoesControl := TConexoesController.Create;
  DataSetEmpresas := ConexoesControl.Abre_tabelas('select * from EMPRESAS where EMPRESAS_ID = 0 ');
  Result          := TEmpresasVO.Create;
  Result.results  := TObjectList<TEmpresasBasicaVO>.Create;
  Result.Total    := 0;
  try
    DataSetEmpresas.Append;
    EmpresasBasicaVO.EMPRESAS_ID := ConexoesControl.Ultimo_ID('EMPRESAS','T');
    objectToDataSet(EmpresasBasicaVO,DataSetEmpresas);
    try
      DataSetEmpresas.Post;
      Result.Total   := 1;
      Result.results.Add(EmpresasBasicaVO);
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(DataSetEmpresas);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TEmpresasVO.UpdateRecord(Parametros:Integer;EmpresasBasicaVO: TEmpresasBasicaVO): TEmpresasVO;
var
  ConexoesControl  : TConexoesController;
  DataSetEmpresas  : TDataSet;
begin
  ConexoesControl  := TConexoesController.Create;
  DataSetEmpresas  := ConexoesControl.Abre_tabelas('select * from EMPRESAS where EMPRESAS_ID = ' + valor_str(Parametros));
  Result           := TEmpresasVO.Create;
  Result.results := TObjectList<TEmpresasBasicaVO>.Create;
  Result.Total     := 0;
  try
    if not DataSetEmpresas.IsEmpty then
      begin
        DataSetEmpresas.Edit;
        EmpresasBasicaVO.EMPRESAS_ID := Parametros;
        objectToDataSet(EmpresasBasicaVO,DataSetEmpresas);
        try
          DataSetEmpresas.Post;
          Result.Total   := 1;
        except
          on e: exception do gera_log(e.message);
        end;
      end;
  finally
    FreeAndNil(DataSetEmpresas);
    FreeAndNil(ConexoesControl);
  end;
end;

class function TEmpresasVO.DeleteRecord(Parametros:Integer): TEmpresasVO;
var
  ConexoesControl  : TConexoesController;
begin
  ConexoesControl  := TConexoesController.Create;
  Result           := TEmpresasVO.Create;
  Result.results   := TObjectList<TEmpresasBasicaVO>.Create;
  Result.Total     := 0;
  try
    try
      ConexoesControl.ExecutaScriptSQL('delete from EMPRESAS where EMPRESAS_ID = ' + Valor_Str(Parametros));
      Result.Total   := 1;
    except
      on e: exception do gera_log(e.message);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;
end;

end.
