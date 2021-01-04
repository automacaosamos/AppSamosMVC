unit AuthenticationProvider;

interface

uses
  System.Classes,
  System.SysUtils,
  MVCFramework,
  System.Generics.Collections,
  MVCFramework.Middleware.Authentication.RoleBasedAuthHandler,
  System.Rtti,
  System.JSON,
  DB;
type
  TAuthenticationProvider = class(TInterfacedObject, IMVCAuthenticationHandler)
  private
//
  public
    procedure OnRequest(const AContext: TWebContext; const AControllerQualifiedClassName, AActionName: string; var AAuthenticationRequired: Boolean);
    procedure OnAuthentication(const AContext: TWebContext; const AUserName, APassword: string; AUserRoles: TList<string>; var AIsValid: Boolean; const ASessionData: TDictionary<string, string>);
    procedure OnAuthorization(const AContext: TWebContext; AUserRoles: TList<string>; const AControllerQualifiedClassName: string; const AActionName: string; var AIsAuthorized: Boolean);
  end;

implementation

uses FuncoesController, ConexoesController;

procedure TAuthenticationProvider.OnAuthentication(const AContext: TWebContext;const AUserName, APassword: string; AUserRoles: TList<string>; var AIsValid: Boolean; const ASessionData: TDictionary<string, string>);
var
  ConexoesControl  : TConexoesController;
  DataSetUsuarios  : TDataSet;
  LGUID            : String;
  LJSON            : String;
  function CriaPermissoes():String;
  var
    JsonArray        : TJSONArray;
    JsonObject       : TJsonObject;
    Itens            : Integer;
    ListaItens       : TStringList;
  begin
    JsonArray  := TJSONArray.Create;

    ListaItens := Explode('TEmpresasController,'   +
                          'TUsuariosController,'   +
                          'TPortadoresController,' +
                          'TBancosController,'     +
                          'TCidadesController,'    +
                          'TPermissoesController',',');

    for Itens := 0 to ListaItens.Count -1 do
      begin
        JsonObject := TJSONObject.Create;
        JsonObject.AddPair(TJSONPair.Create('CONTROLLER',TJSONString.Create(ListaItens[Itens])));
        JsonObject.AddPair(TJSONPair.Create('INCLUIR'   ,TJSONString.Create('S')));
        JsonObject.AddPair(TJSONPair.Create('ALTERAR'   ,TJSONString.Create('S')));
        JsonObject.AddPair(TJSONPair.Create('EXCLUIR'   ,TJSONString.Create('S')));
        JsonObject.AddPair(TJSONPair.Create('LISTAR'    ,TJSONString.Create('S')));
        JsonArray.AddElement(JsonObject);
      end;

    Result := JsonArray.ToString;

    FreeAndNil(JsonArray);

  end;
begin

  ConexoesControl  := TConexoesController.Create;

  DataSetUsuarios  := ConexoesControl.Abre_Tabelas('select * from USUARIOS ' +
                                                   'where USUARIOS_LOGIN = ' + QuotedStr(UpperCase(AUserName)) + ' and ' +
                                                   '      USUARIOS_SENHA = ' + QuotedStr(UpperCase(APassword)));

  AIsValid := iif(DataSetUsuarios.IsEmpty,False,True);

  if AIsValid then
    begin
      LGUID := GeraGUID;
      LJSON := CriaPermissoes();
      GetRedisClient.&SET(LGUID,LJSON, 60 * 60);
      AUserRoles.Add(LGUID);
//      if GetRedisClient.GET(LGUID, LJSON) then
//        WriteLn(LJSON);
    end;

  FreeAndNil(DataSetUsuarios);
  FreeAndNil(ConexoesControl);

end;

procedure TAuthenticationProvider.OnAuthorization(const AContext: TWebContext;AUserRoles: TList<string>; const AControllerQualifiedClassName,AActionName: string; var AIsAuthorized: Boolean);
begin
  AIsAuthorized := True;
end;

procedure TAuthenticationProvider.OnRequest(const AContext: TWebContext; const AControllerQualifiedClassName, AActionName: string; var AAuthenticationRequired: Boolean);
begin
  AAuthenticationRequired := True;
end;

end.
