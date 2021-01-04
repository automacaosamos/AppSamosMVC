unit EmpresasController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  System.JSON,
  Rest.JSON,
  EmpresasVO;
type
  [MVCPath('/api')]
  TEmpresasController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/empresasbuscar')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAll;

    [MVCPath('/empresas/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetByID(parametros: Integer);

    [MVCPath('/empresas')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateRecord;

    [MVCPath('/empresas/($parametros)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateRecord(parametros: Integer);

    [MVCPath('/empresas/($parametros)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteRecord(parametros: Integer);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, FuncoesController;

procedure TEmpresasController.Index;
begin
  Render('{"EmpresasController":"sucesso"}');
end;

procedure TEmpresasController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TEmpresasController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TEmpresasController.GetAll;
begin
  Render(TEmpresasVO.GetAll(Context.Request.Params['parametros'],Context.Request.Params['start'],Context.Request.Params['limit']));
end;

procedure TEmpresasController.GetByID(parametros: Integer);
begin
  Render(TEmpresasVO.GetByID(parametros));
end;

procedure TEmpresasController.CreateRecord;
var
  EmpresasVO       : TEmpresasVO;
  EmpresasBasicaVO : TEmpresasBasicaVO;
begin
  EmpresasBasicaVO := Context.Request.BodyAs<TEmpresasBasicaVO>;
  EmpresasVO       := TEmpresasVO.CreateRecord(EmpresasBasicaVO);
  try
    if EmpresasVO.total > 0 then
      Render(200,EmpresasVO)
    else
      Render(500,EmpresasVO);
  except
    Render(500,EmpresasVO);
  end;

end;

procedure TEmpresasController.UpdateRecord(Parametros:Integer);
var
  EmpresasVO       : TEmpresasVO;
  EmpresasBasicaVO : TEmpresasBasicaVO;
begin
  EmpresasBasicaVO := Context.Request.BodyAs<TEmpresasBasicaVO>;
  EmpresasVO       := TEmpresasVO.UpdateRecord(Parametros,EmpresasBasicaVO);
  try
    if EmpresasVO.total > 0 then
      Render(200,EmpresasVO)
    else
      Render(500,EmpresasVO);
  except
    Render(500,EmpresasVO);
  end;
end;

procedure TEmpresasController.DeleteRecord(Parametros: Integer);
var
  EmpresasVO       : TEmpresasVO;
begin
  EmpresasVO       := TEmpresasVO.DeleteRecord(Parametros);
  try
    if EmpresasVO.total > 0 then
      Render(200,EmpresasVO)
    else
      Render(500,EmpresasVO);
  except
    Render(500,EmpresasVO);
  end;
end;

end.
