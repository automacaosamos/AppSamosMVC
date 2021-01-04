unit UsuariosController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  System.JSON,
  Rest.JSON,
  UsuariosVO;
type
  [MVCPath('/api')]
  TUsuariosController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/usuariosbuscar')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAll;

    [MVCPath('/usuarios/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetByID(parametros: Integer);

    [MVCPath('/usuarios')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateRecord;

    [MVCPath('/usuarios/($parametros)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateRecord(parametros: Integer);

    [MVCPath('/usuarios/($parametros)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteRecord(parametros: Integer);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, FuncoesController;

procedure TUsuariosController.Index;
begin
  Render('{"UsuariosController":"sucesso"}');
end;

procedure TUsuariosController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TUsuariosController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TUsuariosController.GetAll;
begin
  Render(TUsuariosVO.GetAll(Context.Request.Params['parametros'],Context.Request.Params['start'],Context.Request.Params['limit']));
end;

procedure TUsuariosController.GetByID(parametros: Integer);
begin
  Render(TUsuariosVO.GetByID(parametros));
end;

procedure TUsuariosController.CreateRecord;
var
  UsuariosVO       : TUsuariosVO;
  UsuariosBasicaVO : TUsuariosBasicaVO;
begin
  UsuariosBasicaVO := Context.Request.BodyAs<TUsuariosBasicaVO>;
  UsuariosVO       := TUsuariosVO.CreateRecord(UsuariosBasicaVO);
  try
    if UsuariosVO.Total > 0 then
      Render(200,UsuariosVO)
    else
      Render(500,UsuariosVO);
  except
    Render(500,UsuariosVO);
  end;

end;

procedure TUsuariosController.UpdateRecord(Parametros:Integer);
var
  UsuariosVO       : TUsuariosVO;
  UsuariosBasicaVO : TUsuariosBasicaVO;
begin
  UsuariosBasicaVO := Context.Request.BodyAs<TUsuariosBasicaVO>;
  UsuariosVO       := TUsuariosVO.UpdateRecord(Parametros,UsuariosBasicaVO);
  try
    if UsuariosVO.Total > 0 then
      Render(200,UsuariosVO)
    else
      Render(500,UsuariosVO);
  except
    Render(500,UsuariosVO);
  end;
end;

procedure TUsuariosController.DeleteRecord(Parametros: Integer);
var
  UsuariosVO       : TUsuariosVO;
begin
  UsuariosVO       := TUsuariosVO.DeleteRecord(Parametros);
  try
    if UsuariosVO.Total > 0 then
      Render(200,UsuariosVO)
    else
      Render(500,UsuariosVO);
  except
    Render(500,UsuariosVO);
  end;
end;

end.
