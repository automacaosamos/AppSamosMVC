unit UtilsController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  WebModuleServices,
  System.JSON,
  Rest.JSON,
  UtilsVO;
type
  [MVCPath('/api')]
  TUtilsController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction (Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/utilslogin')]
    [MVCHTTPMethod([httpPOST])]
    procedure GetLogin;

    [MVCHTTPMethod([httpGET])]
    [MVCPath('/logout/($parametros)')]
    procedure GetLogout(parametros:String);

    [MVCHTTPMethod([httpGET])]
    [MVCPath('/utilsbuscarcep/($parametros)')]

    [MVCHTTPMethod([httpGET])]
    procedure GetBuscarCep(parametros:String);

    [MVCHTTPMethod([httpGET])]
    [MVCPath('/utilsvalidar/($parametros)')]
    procedure GetValidar(parametros:String);

    [MVCHTTPMethod([httpGET])]
    [MVCPath('/utilsgerapdf/($parametros)')]
    procedure GetGeraPDF(parametros:String);

 end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, FuncoesController;

procedure TUtilsController.Index;
begin
  Render('{"UtilsController":"sucesso"}');
end;

procedure TUtilsController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TUtilsController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TUtilsController.GetLogin;
var
  JSonValue : TJSonValue;
begin
  JSONValue := TJSONObject.ParseJSONValue(StrAllTrim(Context.Request.Body));
  Render(TUtilsVO.GetLogin(JSONValue.GetValue<string>('usuario'),JSONValue.GetValue<string>('senha'),JSONValue.GetValue<string>('ipacesso')));
end;

procedure TUtilsController.GetLogout(parametros:String);
begin
  Render(TUtilsVO.GetLogout(parametros));
end;

procedure TUtilsController.GetBuscarCep(parametros:String);
begin
  Render(TUtilsVO.GetBuscarCep(parametros));
end;

procedure TUtilsController.GetValidar(parametros:String);
begin
  Render(TUtilsVO.GetValidar(parametros));
end;

procedure TUtilsController.GetGeraPDF(parametros:String);
begin
  Render(TUtilsVO.GetGeraPDF(parametros));
end;


end.

