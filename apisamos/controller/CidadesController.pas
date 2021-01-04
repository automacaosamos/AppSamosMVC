unit CidadesController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  System.JSON,
  Rest.JSON,
  CidadesVO;
type
  [MVCPath('/api')]
  TCidadesController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/cidadesbuscar')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAll;

    [MVCPath('/cidades/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetByID(parametros: Integer);

    [MVCPath('/cidades')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateRecord;

    [MVCPath('/cidades/($parametros)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateRecord(parametros: Integer);

    [MVCPath('/cidades/($parametros)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteRecord(parametros: Integer);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, FuncoesController;

procedure TCidadesController.Index;
begin
  Render('{"CidadesController":"sucesso"}');
end;

procedure TCidadesController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TCidadesController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TCidadesController.GetAll;
begin
  Render(TCidadesVO.GetAll(Context.Request.Params['parametros'],Context.Request.Params['start'],Context.Request.Params['limit']));
end;

procedure TCidadesController.GetByID(parametros: Integer);
begin
  Render(TCidadesVO.GetByID(parametros));
end;

procedure TCidadesController.CreateRecord;
var
  CidadesVO       : TCidadesVO;
  CidadesBasicaVO : TCidadesBasicaVO;
begin
  CidadesBasicaVO := Context.Request.BodyAs<TCidadesBasicaVO>;
  CidadesVO       := TCidadesVO.CreateRecord(CidadesBasicaVO);
  try
    if CidadesVO.total > 0 then
      Render(200,CidadesVO)
    else
      Render(500,CidadesVO);
  except
    Render(500,CidadesVO);
  end;

end;

procedure TCidadesController.UpdateRecord(Parametros:Integer);
var
  CidadesVO       : TCidadesVO;
  CidadesBasicaVO : TCidadesBasicaVO;
begin
  CidadesBasicaVO := Context.Request.BodyAs<TCidadesBasicaVO>;
  CidadesVO       := TCidadesVO.UpdateRecord(Parametros,CidadesBasicaVO);
  try
    if CidadesVO.total > 0 then
      Render(200,CidadesVO)
    else
      Render(500,CidadesVO);
  except
    Render(500,CidadesVO);
  end;
end;

procedure TCidadesController.DeleteRecord(Parametros: Integer);
var
  CidadesVO       : TCidadesVO;
begin
  CidadesVO       := TCidadesVO.DeleteRecord(Parametros);
  try
    if CidadesVO.total > 0 then
      Render(200,CidadesVO)
    else
      Render(500,CidadesVO);
  except
    Render(500,CidadesVO);
  end;
end;

end.
