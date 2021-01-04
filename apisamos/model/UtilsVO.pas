unit UtilsVO;

interface

uses
  DB,
  System.SysUtils,
  System.Generics.Collections,
  System.Classes,
  System.Rtti,
  System.JSON,
  MVCFramework.RESTClient,
  ACBrBase,
  ACBrValidador;
type
  TUtilsVO = class
  private
//    p_status  : Boolean;
  public
//    property status : Boolean read p_status   write p_status;
    class function GetLogin(Usuario,Senha:String)  : TJSONObject;
    class function GetBuscarCep(Parametros:String) : TJSONObject;
    class function GetValidar(Parametros:String)   : TJSONObject;
    class function GetGeraPDF(Parametros:String)   : TJSONObject;
  end;

implementation

uses ConexoesController, FuncoesController, PortadoresVO;

class function TUtilsVO.GetLogin(Usuario,Senha:String): TJSONObject;
var
  DataSetLogin      : TDataSet;
  DataSetPermissoes : TDataSet;
  ConexoesControl   : TConexoesController;
  JsonArray         : TJSONArray;
  JsonObject        : TJsonObject;
begin
  Result            := TJSONObject.Create;
  ConexoesControl   := TConexoesController.Create;
  try
    DataSetLogin    := ConexoesControl.Abre_tabelas('select USUARIOS_ID           as LOGIN_ID,' +
                                                    '       USUARIOS_VALIDADE     as LOGIN_VALIDADE,' +
                                                    '       USUARIOS_LOGIN        as LOGIN_NOME,' +
                                                    '       USUARIOS_PRIVILEGIADO as LOGIN_PRIVILEGIADO,' +
                                                    '       USUARIOS_ID_EMPRESAS  as LOGIN_ID_EMPRESAS,' +
                                                    '       USUARIOS_TEMPO        as LOGIN_TEMPO ' +
                                                    'from USUARIOS ' +
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
          JsonArray := TJSONArray.Create;
          DataSetPermissoes := ConexoesControl.Abre_tabelas('select PERMISSOES_ID_EMPRESAS, EMPRESAS_FANTASIA, PERMISSOES_ITENS from PERMISSOES ' +
                                                            'join EMPRESAS on EMPRESAS_ID = PERMISSOES_ID_EMPRESAS ' +
                                                            'where PERMISSOES_ID_USUARIOS = ' + Valor_Str(DataSetLogin.FindField('LOGIN_ID').AsInteger) + ' ' +
                                                            'order by PERMISSOES_ID_EMPRESAS');
          try
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
          finally
             FreeAndNil(DataSetPermissoes);
          end;
          Result.AddPair(TJSONPair.Create('LOGIN_EMPRESAS'    ,JsonArray));
        end
      else
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Usu�rio inv�lido')));
        end;
      finally
        FreeAndNil(DataSetLogin);
    end;
  finally
    FreeAndNil(ConexoesControl);
  end;

//  gera_log(Result.ToString);

end;

class function TUtilsVO.GetBuscarCep(Parametros:String): TJSONObject;
var
  RestClient      : MVCFramework.RESTClient.TRESTClient;
  RestResponse    : IRESTResponse;
  ResponseString  : String;
  JSonValue       : TJSonValue;
  function Acha_Cidades(varIBGE,varNOME:String):Integer;
  var
    ConexoesControl : TConexoesController;
    DataSetCidades  : TDataSet;
  begin
    try
      ConexoesControl   := TConexoesController.Create;
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
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Cep n�o encontrado')));
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
  ACBrValidador   : TACBrValidador;
  StrParametros   : TStringList;
  ConexoesControl : TConexoesController;
  DataSetRetorno  : TDataSet;
begin
  Result          := TJSONObject.Create;
  ACBrValidador   := TACBrValidador.Create(nil);

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
      ACBrValidador.TipoDocto := TACBrValTipoDocto(iif(StrLen(StrParametros[1])=11,0,1));
      ACBrValidador.Documento := StrParametros[1];
      if ACBrValidador.Validar then
        begin
          if StrParametros[2] = 'T' then
            begin
              try
                ConexoesControl   := TConexoesController.Create;
                DataSetRetorno    := ConexoesControl.Abre_tabelas('select * from '+ StrParametros[3] + ' ' +
                                                                  'where ' + StrParametros[3] + '_CPFCNPJ = ' + QuotedStr(StrParametros[1]) + ' ' +
                                                                  'order by ' + StrParametros[3] + '_CPFCNPJ');
                if not DataSetRetorno.isEmpty then
                  begin
                    Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
                    Result.AddPair(TJSONPair.Create('message',TJSONString.Create('C�digo:' + DataSetRetorno.FindField(StrParametros[3] + '_ID').AsString + ' Nome: ' +  DataSetRetorno.FindField(StrParametros[3] + '_NOME').AsString)));
                  end
                else
                  begin
                    Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(True)));
                    Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Cpf/Cnpj v�lido')));
                  end;
              finally
                FreeAndNil(DataSetRetorno);
                FreeAndNil(ConexoesControl);
              end;
            end
          else
            begin
              Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(True)));
              Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Cpf/Cnpj v�lido')));
            end;
        end
      else
        begin
          Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
          Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Cpf/Cnpj inv�lido')));
        end;
    end
  else
    if StrParametros[0] = 'INSCRICAO' then
      begin
        ACBrValidador.TipoDocto   := TACBrValTipoDocto(3);
        ACBrValidador.Documento   := RemoverEspeciais(StrParametros[1]);
        ACBrValidador.Complemento := StrParametros[2];
        if ACBrValidador.Validar then
          begin
            Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(True)));
            Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Inscri��o v�lida')));
          end
        else
          begin
            Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
            Result.AddPair(TJSONPair.Create('message',TJSONString.Create('Inscri��o inv�lida')));
          end;
      end;

  FreeAndNil(ACBrValidador);
  FreeAndNil(StrParametros);

end;

class function TUtilsVO.GetGeraPDF(Parametros:String): TJSONObject;

begin
  Result           := TJSONObject.Create;

  Result.AddPair(TJSONPair.Create('status',TJSONBool.Create(False)));
  Result.AddPair(TJSONPair.Create('message',TJSONString.Create('PDF gerado com sucesso')));
end;


end.
