unit PortadoresController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  System.JSON,
  Rest.JSON,
  PortadoresVO;
type
  [MVCPath('/api')]
  TPortadoresController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/portadoresbuscar')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAll;

    [MVCPath('/portadores/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetByID(parametros: Integer);

    [MVCPath('/portadores')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateRecord;

    [MVCPath('/portadores/($parametros)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateRecord(parametros: Integer);

    [MVCPath('/portadores/($parametros)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteRecord(parametros: Integer);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, FuncoesController;

procedure TPortadoresController.Index;
begin
  Render('{"PortadoresController":"sucesso"}');
end;

procedure TPortadoresController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TPortadoresController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TPortadoresController.GetAll;
begin
  Render(TPortadoresVO.GetAll(Context.Request.Params['parametros'],Context.Request.Params['start'],Context.Request.Params['limit']));
end;

procedure TPortadoresController.GetByID(parametros: Integer);
begin
  Render(TPortadoresVO.GetByID(parametros));
end;

procedure TPortadoresController.CreateRecord;
var
  PortadoresVO       : TPortadoresVO;
  PortadoresBasicaVO : TPortadoresBasicaVO;
begin
  PortadoresBasicaVO := Context.Request.BodyAs<TPortadoresBasicaVO>;
  PortadoresVO       := TPortadoresVO.CreateRecord(PortadoresBasicaVO);
  try
    if PortadoresVO.total > 0 then
      Render(200,PortadoresVO)
    else
      Render(500,PortadoresVO);
  except
    Render(500,PortadoresVO);
  end;

end;

procedure TPortadoresController.UpdateRecord(Parametros:Integer);
var
  PortadoresVO       : TPortadoresVO;
  PortadoresBasicaVO : TPortadoresBasicaVO;
begin
  PortadoresBasicaVO := Context.Request.BodyAs<TPortadoresBasicaVO>;
  PortadoresVO       := TPortadoresVO.UpdateRecord(Parametros,PortadoresBasicaVO);
  try
    if PortadoresVO.total > 0 then
      Render(200,PortadoresVO)
    else
      Render(500,PortadoresVO);
  except
    Render(500,PortadoresVO);
  end;
end;

procedure TPortadoresController.DeleteRecord(Parametros: Integer);
var
  PortadoresVO       : TPortadoresVO;
begin
  PortadoresVO       := TPortadoresVO.DeleteRecord(Parametros);
  try
    if PortadoresVO.total > 0 then
      Render(200,PortadoresVO)
    else
      Render(500,PortadoresVO);
  except
    Render(500,PortadoresVO);
  end;
end;

end.
