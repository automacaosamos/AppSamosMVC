unit UtilsVO;

interface

uses
  DB,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Classes,
  System.Rtti,
  System.JSON,
  MVCFramework.RESTClient;

type
  TUtilsVO = class
  private
//    p_status  : Boolean;
  public
//    property status : Boolean read p_status   write p_status;
    class function GetLogin(Usuario,Senha,IpAcesso:String) : TJSONObject;
    class function GetLogout(Parametros:String)            : TJSONObject;
    class function GetBuscarCep(Parametros:String)         : TJSONObject;
    class function GetValidar(Parametros:String)           : TJSONObject;
    class function GetGeraPDF(Parametros:String)           : TJSONObject;
  end;

implementation

uses ConexoesFactory, FuncoesController, PortadoresVO;

class function TUtilsVO.GetLogin(Usuario,Senha,IpAcesso:String): TJSONObject;
var
  DataSetLogin      : TDataSet;
  DataSetLogs       : TDataSet;
  DataSetPermissoes : TDataSet;
  ConexoesControl   : TConexoesFactory;
  JsonArray         : TJSONArray;
  JsonObject        : TJsonObject;
begin
  Result            := TJSONObject.Create;
  ConexoesControl   := TConexoesFactory.Create;
  try
    DataSetLogin    := ConexoesControl.Abre_tabelas('select USUARIOS_ID           as LOGIN_ID,          ' +
                                                    '       USUARIOS_VALIDADE     as LOGIN_VALIDADE,    ' +
                                                    '       USUARIOS_LOGIN        as LOGIN_NOME,        ' +
                                                    '       USUARIOS_PRIVILEGIADO as LOGIN_PRIVILEGIADO,' +
                                                    '       USUARIOS_ID_EMPRESAS  as LOGIN_ID_EMPRESAS, ' +
                                                    '       USUARIOS_TEMPO        as LOGIN_TEMPO,       ' +
                                                    '       EMPRESAS_FANTASIA     as LOGIN_FANTASIA     ' +
                                                    'from USUARIOS ' +
                                                    'join EMPRESAS on EMPRESAS_ID = USUARIOS_ID_EMPRESAS ' +
                                                    'where USUARIOS_LOGIN = '+ QuotedStr(UpperCase(Usuario)) + ' and USUARIOS_SENHA = ' + QuotedStr(UpperCase(Senha)) + ' ' +
                                                    'order by USUARIOS_ID');
    try
      if not DataSetLogin.IsEmpty then
        begin
          Result.AddPair(TJSONPair.Create('LOGIN_ID'          ,TJSONNumber.Create(DataSetLogin.FindField('LOGIN_ID').AsInteger)));
          Result.AddPair(TJSONPair.Create('LOGIN_VALIDADE'    ,TJSONString.Create(DateToJSON(DataSetLogin.FindField('LOGIN_VALIDADE').AsDateTime))));
          Result.AddPair(TJSONPair.Create('LOGIN_NOME'        ,TJSONString.Create(DataSetLogin.FindField('LOGIN_NOME').AsString)));
          Result.AddPair(TJSONPair.Create('LOGIN_PRIVILEGIADO',TJSONString.Create(DataSetLogin.FindField('LOGIN_PRIVILEGIADO').AsString)));
          Result.AddPair(TJSONPair.Create('LOGIN_ID_EMPRESAS' ,TJSONNumber.Create(DataSetLogin.FindField('LOGIN_ID_EMPRESAS').AsInteger)));
          Result.AddPair(TJSONPair.Create('LOGIN_TEMPO'       ,TJSONNumber.Create(DataSetLogin.FindField('LOGIN_TEMPO').AsInteger)));
          Result.AddPair(TJSONPair.Create('LOGIN_FANTASIA'    ,TJSONString.Create(DataSetLogin.FindField('LOGIN_FANTASIA').AsString)));
          JsonArray := TJSONArray.Create;
          DataSetPermissoes := ConexoesControl.Abre_tabelas('select PERMISSOES_ID_EMPRESAS, EMPRESAS_FANTASIA, PERMISSOES_ITENS from PERMISSOES ' +
                                                            'join EMPRESAS on EMPRESAS_ID = PERMISSOES_ID_EMPRESAS ' +
                                                            'where PERMISSOES_ID_USUARIOS = ' + Valor_Str(DataSetLogin.FindField('LOGIN_ID').AsInteger) + ' ' +
                                                            'order by PERMISSOES_ID_EMPRESAS');
          try
            if DataSetPermissoes.IsEmpty then
              begin
                Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
                Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Usuário sem permissões')));
              end
            else
              begin
                DataSetPermissoes.First;
                while not DataSetPermissoes.eof do
                  begin
                    JsonObject := TJSONObject.Create;
                    JsonObject.AddPair(TJSONPair.Create('PERMISSOES_ID_EMPRESAS',TJSONNumber.Create(DataSetPermissoes.FindField('PERMISSOES_ID_EMPRESAS').AsInteger)));
                    JsonObject.AddPair(TJSONPair.Create('EMPRESAS_FANTASIA'     ,TJSONString.Create(DataSetPermissoes.FindField('EMPRESAS_FANTASIA').AsString)));
                    JsonObject.AddPair(TJSONPair.Create('PERMISSOES_ITENS'      ,TJSONString.Create(DataSetPermissoes.FindField('PERMISSOES_ITENS').AsString)));
                    JsonArray.AddElement(JsonObject);
                    DataSetPermissoes.Next;
                  end;
                DataSetLogs := ConexoesControl.Abre_tabelas('select * from LOGS where LOGS_ID > 0');
                try
                  DataSetLogs.Append;
                  DataSetLogs.FindField('LOGS_ID').AsInteger          := ConexoesControl.Ultimo_ID('LOGS','T');
                  DataSetLogs.FindField('LOGS_STATUS').AsString       := 'T';
                  DataSetLogs.FindField('LOGS_IP').AsString           := IpAcesso;
                  DataSetLogs.FindField('LOGS_ID_USUARIOS').AsInteger := DataSetLogin.FindField('LOGIN_ID').AsInteger;
                  DataSetLogs.FindField('LOGS_DATA').AsDateTime       := Date;
                  DataSetLogs.FindField('LOGS_HORA').AsString         := TimeToStr(Time);
                  DataSetLogs.FindField('LOGS_DATALOGOUT').AsDateTime := StrToDate('30/12/1899');
                  DataSetLogs.FindField('LOGS_HORALOGOUT').AsString   := '';
                  DataSetLogs.Post;
                  Result.AddPair(TJSONPair.Create('LOGIN_ID_LOGS' ,TJSONNumber.Create( DataSetLogs.FindField('LOGS_ID').AsInteger)));
                  Result.AddPair(TJSONPair.Create('LOGIN_EMPRESAS',JsonArray));
                finally
                  FreeAndNil(DataSetLogs);
                end;
              end;
          finally
             FreeAndNil(DataSetPermissoes);
          end;
        end
      else
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Usuário inválido')));
        end;
    finally
        FreeAndNil(DataSetLogin);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;

//  gera_log(Result.ToString);

end;


class function TUtilsVO.GetLogout(Parametros:String): TJSONObject;
var
  DataSetLogs     : TDataSet;
  ConexoesControl : TConexoesFactory;
begin
  Result          := TJSONObject.Create;
  ConexoesControl := TConexoesFactory.Create;
  try
    DataSetLogs   := ConexoesControl.Abre_tabelas('select * from LOGS where LOGS_ID = ' + Parametros);
    try
      if not DataSetLogs.IsEmpty then
        begin
          DataSetLogs.Edit;
          DataSetLogs.FindField('LOGS_DATALOGOUT').AsDateTime := Date;
          DataSetLogs.FindField('LOGS_HORALOGOUT').AsString   := TimeToStr(Time);
          DataSetLogs.Post;
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(True)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Logout efetuado com sucesso')));
        end
      else
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Não consegui efetuar o logout')));
        end;
    finally
        FreeAndNil(DataSetLogs);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;
end;

class function TUtilsVO.GetBuscarCep(Parametros:String): TJSONObject;
var
  RestClient      : MVCFramework.RESTClient.TRESTClient;
  RestResponse    : IRESTResponse;
  ResponseString  : String;
  JSonValue       : TJSonValue;
  function Acha_Cidades(varIBGE,varNOME:String):Integer;
  var
    ConexoesControl : TConexoesFactory;
    DataSetCidades  : TDataSet;
  begin
    try
      ConexoesControl   := TConexoesFactory.Create;
      DataSetCidades    := ConexoesControl.Abre_tabelas('select * from CIDADES where CIDADES_IBGE = ' + QuotedStr(varIBGE) + ' and ' +
                                                        'CIDADES_NOME like ' + QuotedStr('%' + varNOME + '%') + ' ' +
                                                        'order by CIDADES_IBGE');
      if not DataSetCidades.isEmpty then
        Result := DataSetCidades.FindField('CIDADES_ID').AsInteger
      else
        Result := 1;
    finally
      FreeAndNil(DataSetCidades);
      FreeAndNil(ConexoesControl);
    end;
  end;
begin
  Result          := TJSONObject.Create;
  RestClient      := MVCFramework.RESTClient.TRESTClient.Create('viacep.com.br',80);
  try
    RestResponse  := RestClient.DoGET('/ws/' + Parametros + '/json/',[]);
    try
      ResponseString     := RestResponse.BodyAsString;
      if StrContains(ResponseString,'erro') then
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Cep não encontrado')));
        end
      else
        begin
          JSONValue := TJSONObject.ParseJSONValue(StrAllTrim(ResponseString));
          Result.AddPair(TJSONPair.Create('CEP',TJSONString.Create(RemoverEspeciais(JSONValue.GetValue<string>('cep')))));
          Result.AddPair(TJSONPair.Create('ENDERECO',TJSONString.Create(RemoverEspeciais(JSONValue.GetValue<string>('logradouro')))));
          Result.AddPair(TJSONPair.Create('BAIRRO',TJSONString.Create(RemoverEspeciais(JSONValue.GetValue<string>('bairro')))));
          Result.AddPair(TJSONPair.Create('CIDADE',TJSONString.Create(UpperCase(RemoverEspeciais(JSONValue.GetValue<string>('localidade'))))));
          Result.AddPair(TJSONPair.Create('ESTADO',TJSONString.Create(UpperCase(JSONValue.GetValue<string>('uf')))));
          Result.AddPair(TJSONPair.Create('IBGE',TJSONString.Create(JSONValue.GetValue<string>('ibge'))));
          Result.AddPair(TJSONPair.Create('DDD',TJSONString.Create(RemoverEspeciais(JSONValue.GetValue<string>('ddd')))));
          Result.AddPair(TJSONPair.Create('CODIGO',TJSONNumber.Create(Acha_Cidades(JSONValue.GetValue<string>('ibge'),UpperCase(JSONValue.GetValue<string>('localidade'))))));
        end;
    except
      on e: exception do
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create(e.message)));
          gera_log(e.message);
        end;
    end;
  finally
    FreeAndNil(RestClient);
  end;
end;

class function TUtilsVO.GetValidar(Parametros:String): TJSONObject;
var
  StrParametros   : TStringList;
  ConexoesControl : TConexoesFactory;
  DataSetRetorno  : TDataSet;
  Valido          : Boolean;
begin

  Result          := TJSONObject.Create;

  if StrContains(Parametros,'|') then
    StrParametros := Explode(Parametros,'|')
  else
    begin
      StrParametros := TStringList.Create;
      StrParametros.Add('');
      StrParametros.Add('');
      StrParametros.Add('F');
      StrParametros.Add('');
    end;
  if StrParametros[0] = 'CPFCNPJ' then
    begin
      if StrLen(StrParametros[1])=11 then
        Valido := iif(ValidaCPF(StrParametros[1]),True,False)
      else
        Valido := iif(ValidaCNPJ(StrParametros[1]),True,False);
      if Valido then
        begin
          if StrParametros[2] = 'T' then
            begin
              try
                ConexoesControl   := TConexoesFactory.Create;
                DataSetRetorno    := ConexoesControl.Abre_tabelas('select * from '+ StrParametros[3] + ' ' +
                                                                  'where ' + StrParametros[3] + '_CPFCNPJ = ' + QuotedStr(StrParametros[1]) + ' ' +
                                                                  'order by ' + StrParametros[3] + '_CPFCNPJ');
                if not DataSetRetorno.isEmpty then
                  begin
                    Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
                    Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Código:' + DataSetRetorno.FindField(StrParametros[3] + '_ID').AsString + ' Nome: ' +  DataSetRetorno.FindField(StrParametros[3] + '_NOME').AsString)));
                  end
                else
                  begin
                    Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(True)));
                    Result.AddPair(TJSONPair.Create('message',TJSONString.Create(iif(StrLen(StrParametros[1])=11,'Cpf','Cnpj') + ' válido')));
                  end;
              finally
                FreeAndNil(DataSetRetorno);
                FreeAndNil(ConexoesControl);
              end;
            end
          else
            begin
              Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(True)));
              Result.AddPair(TJSONPair.Create('message',TJSONString.Create(iif(StrLen(StrParametros[1])=11,'Cpf','Cnpj') + ' válido')));
            end;
        end
      else
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(false)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create(iif(StrLen(StrParametros[1])=11,'Cpf','Cnpj') + ' inválido')));
        end;
    end;

  FreeAndNil(StrParametros);

end;

class function TUtilsVO.GetGeraPDF(Parametros:String): TJSONObject;
var
  ConexoesControl : TConexoesFactory;
  DataSetGenerico : TDataSet;
  Itens           : Integer;
  Margins         : TJSONArray;
  Margin          : TJSONArray;
  Widths          : TJSONArray;
  Content         : TJSONArray;
  Border1         : TJSONArray;
  Border2         : TJSONArray;
  Border3         : TJSONArray;
  Body            : TJSONArray;
  BodyItens       : TJSONArray;
  Columns         : TJSONArray;

  TableExample    : TJSONObject;
  TableHeader     : TJSONObject;
  Style           : TJSONObject;
  Table           : TJSONObject;
  ItemPrinter     : TJSONObject;
  Styles          : TJSONObject;
begin

  ConexoesControl := TConexoesFactory.Create;

  DataSetGenerico := ConexoesControl.Abre_Tabelas('select * from USUARIOS ' +
                                                  'join CIDADES on CIDADES_ID = USUARIOS_ID_CIDADES ' +
                                                  'where USUARIOS_ID < 400 order by USUARIOS_ID');

  Result          := TJSONObject.Create;
  Result.AddPair(TJSONPair.Create('pageOrientation',TJSONString.Create('landscape')));
  Result.AddPair(TJSONPair.Create('pageSize',TJSONString.Create('A4')));

  Margins         := TJSONArray.Create;
  Margins.AddElement(TJSONNumber.Create(40));
  Margins.AddElement(TJSONNumber.Create(40));
  Margins.AddElement(TJSONNumber.Create(40));
  Margins.AddElement(TJSONNumber.Create(35));
  Result.AddPair(TJSONPair.Create('pageMargins',Margins));

  Content         := TJSONArray.Create;
  columns         := TJSONArray.Create;

  for Itens := 1  to 7 do
    columns.AddElement(TJSONObject.Create());

  Content.AddElement(TJSONObject.Create(TJSONPair.Create('columns',columns)));

  Widths          := TJSONArray.Create;
  Widths.AddElement(TJSONNumber.Create(30));   // Codigo
  Widths.AddElement(TJSONNumber.Create(200));  // Nome
  Widths.AddElement(TJSONNumber.Create(40));   // Cep
  Widths.AddElement(TJSONNumber.Create(200));  // Endereco
  Widths.AddElement(TJSONNumber.Create(40));   // Numero
  Widths.AddElement(TJSONNumber.Create(160));  // Cidade
  Widths.AddElement(TJSONNumber.Create(30));   // Estado

  Style           := TJSONObject.Create;
  Style.AddPair('style',TJSONString.Create('tableExample'));

  Table           := TJSONObject.Create;
  Table.AddPair('headerRows',TJSONNumber.Create(2));
  Table.AddPair('widths',Widths);

  Body            := TJSONArray.Create;


  border1         := TJSONArray.Create;
  border1.AddElement(TJSONObject(TJSONBool.Create(False)));
  border1.AddElement(TJSONObject(TJSONBool.Create(False)));
  border1.AddElement(TJSONObject(TJSONBool.Create(False)));
  border1.AddElement(TJSONObject(TJSONBool.Create(False)));

  border2         := TJSONArray.Create;
  border2.AddElement(TJSONObject(TJSONBool.Create(False)));
  border2.AddElement(TJSONObject(TJSONBool.Create(False)));
  border2.AddElement(TJSONObject(TJSONBool.Create(False)));
  border2.AddElement(TJSONObject(TJSONBool.Create(False)));

  border3         := TJSONArray.Create;
  border3.AddElement(TJSONObject(TJSONBool.Create(False)));
  border3.AddElement(TJSONObject(TJSONBool.Create(False)));
  border3.AddElement(TJSONObject(TJSONBool.Create(False)));
  border3.AddElement(TJSONObject(TJSONBool.Create(False)));


// Titulo
  BodyItens       := TJSONArray.Create;
  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('EMPRESA B'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('fontSize' ,TJSONNumber.Create(15));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  ItemPrinter.AddPair('colSpan',TJSONNumber.Create(2));
  ItemPrinter.AddPair('border',border1);
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('RELAÇÃO DE USUÁRIOS'+#32));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('fontSize' ,TJSONNumber.Create(20));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('center'));
  ItemPrinter.AddPair('colSpan',TJSONNumber.Create(3));
  ItemPrinter.AddPair('border',border2);
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create(DateToStr(Date) + ' ' + StrLeft(TimeToStr(Time),5)));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('fontSize' ,TJSONNumber.Create(15));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('right'));
  ItemPrinter.AddPair('colSpan'  ,TJSONNumber.Create(2));
  ItemPrinter.AddPair('border',border3);
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  BodyItens.AddElement(ItemPrinter);

  Body.AddElement(BodyItens);

// Cabeçalho
  BodyItens       := TJSONArray.Create;
  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Código'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('right'));
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Nome'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Cep'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Endereço'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Número'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Cidade'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  BodyItens.AddElement(ItemPrinter);

  ItemPrinter := TJSONObject.Create;
  ItemPrinter.AddPair('text'     ,TJSONString.Create('Estado'));
  ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
  ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
  ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
  BodyItens.AddElement(ItemPrinter);
  Body.AddElement(BodyItens);

// Itens

  DataSetGenerico.First;
  while not DataSetGenerico.eof  do
    begin
      BodyItens   := TJSONArray.Create;

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONNumber.Create(DataSetGenerico.FindField('USUARIOS_ID').AsInteger));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('right'));
      BodyItens.AddElement(ItemPrinter);

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONString.Create(DataSetGenerico.FindField('USUARIOS_NOME').AsString));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
      BodyItens.AddElement(ItemPrinter);

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONString.Create(DataSetGenerico.FindField('USUARIOS_CEP').AsString));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
      BodyItens.AddElement(ItemPrinter);

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONString.Create(DataSetGenerico.FindField('USUARIOS_ENDERECO').AsString));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
      BodyItens.AddElement(ItemPrinter);

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONString.Create(DataSetGenerico.FindField('USUARIOS_NUMERO').AsString));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
      BodyItens.AddElement(ItemPrinter);

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONString.Create(DataSetGenerico.FindField('CIDADES_NOME').AsString));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
      BodyItens.AddElement(ItemPrinter);

      ItemPrinter := TJSONObject.Create;
      ItemPrinter.AddPair('text'     ,TJSONString.Create(DataSetGenerico.FindField('CIDADES_ESTADO').AsString));
      ItemPrinter.AddPair('style'    ,TJSONString.Create('tableHeader'));
      ItemPrinter.AddPair('fillColor',TJSONString.Create(iif((DataSetGenerico.recno mod 2)=0,'#dedede','#ffffff')));
      ItemPrinter.AddPair('bold'     ,TJSONBool.Create(false));
      ItemPrinter.AddPair('alignment',TJSONString.Create('left'));
      BodyItens.AddElement(ItemPrinter);

      Body.AddElement(BodyItens);

      DataSetGenerico.Next;
    end;

  Table.AddPair('body',Body);

  Style.AddPair('table',Table);

  Content.AddElement(Style);

  Result.AddPair(TJSONPair.Create('content',Content));

  Styles          := TJSONObject.Create;

  Margin          := TJSONArray.Create;
  Margin.AddElement(TJSONNumber.Create(0));
  Margin.AddElement(TJSONNumber.Create(0));
  Margin.AddElement(TJSONNumber.Create(0));
  Margin.AddElement(TJSONNumber.Create(5));

  TableExample    := TJSONObject.Create;
  TableExample.AddPair('fontSize',TJSONNumber.Create(8));
  TableExample.AddPair('margin',Margin);

  TableHeader     := TJSONObject.Create;
  TableHeader.AddPair('fontSize',TJSONNumber.Create(8));
  TableHeader.AddPair('color',TJSONString.Create('black'));

  Styles.AddPair('tableExample',TableExample);
  Styles.AddPair('tableHeader',TableHeader);

  Result.AddPair(TJSONPair.Create('styles',Styles));

end;


end.
