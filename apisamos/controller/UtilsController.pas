unit UtilsController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  WebModule,
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
    [MVCPath('/utilsbuscarcep/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetBuscarCep(parametros:String);
    [MVCPath('/utilsvalidar/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetValidar(parametros:String);
    [MVCPath('/utilsgerapdf/($parametros)')]
    [MVCHTTPMethod([httpGET])]
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
  Render(TUtilsVO.GetLogin(JSONValue.GetValue<string>('usuario'),JSONValue.GetValue<string>('senha')));
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

