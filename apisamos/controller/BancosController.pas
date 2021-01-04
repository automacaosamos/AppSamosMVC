unit BancosController;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  System.JSON,
  Rest.JSON,
  BancosVO;
type
  [MVCPath('/api')]
  TBancosController = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  public
    [MVCPath('/bancosbuscar')]
    [MVCHTTPMethod([httpGET])]
    procedure GetAll;

    [MVCPath('/bancos/($parametros)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetByID(parametros: Integer);

    [MVCPath('/bancos')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateRecord;

    [MVCPath('/bancos/($parametros)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateRecord(parametros: Integer);

    [MVCPath('/bancos/($parametros)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteRecord(parametros: Integer);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, FuncoesController;

procedure TBancosController.Index;
begin
  Render('{"BancosController":"sucesso"}');
end;

procedure TBancosController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  inherited;
end;

procedure TBancosController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  inherited;
end;

procedure TBancosController.GetAll;
begin
  Render(TBancosVO.GetAll(Context.Request.Params['parametros'],Context.Request.Params['start'],Context.Request.Params['limit']));
end;

procedure TBancosController.GetByID(parametros: Integer);
begin
  Render(TBancosVO.GetByID(parametros));
end;

procedure TBancosController.CreateRecord;
var
  BancosVO       : TBancosVO;
  BancosBasicaVO : TBancosBasicaVO;
begin
  BancosBasicaVO := Context.Request.BodyAs<TBancosBasicaVO>;
  BancosVO       := TBancosVO.CreateRecord(BancosBasicaVO);
  try
    if BancosVO.total > 0 then
      Render(200,BancosVO)
    else
      Render(500,BancosVO);
  except
    Render(500,BancosVO);
  end;

end;

procedure TBancosController.UpdateRecord(Parametros:Integer);
var
  BancosVO       : TBancosVO;
  BancosBasicaVO : TBancosBasicaVO;
begin
  BancosBasicaVO := Context.Request.BodyAs<TBancosBasicaVO>;
  BancosVO       := TBancosVO.UpdateRecord(Parametros,BancosBasicaVO);
  try
    if BancosVO.total > 0 then
      Render(200,BancosVO)
    else
      Render(500,BancosVO);
  except
    Render(500,BancosVO);
  end;
end;

procedure TBancosController.DeleteRecord(Parametros: Integer);
var
  BancosVO       : TBancosVO;
begin
  BancosVO       := TBancosVO.DeleteRecord(Parametros);
  try
    if BancosVO.total > 0 then
      Render(200,BancosVO)
    else
      Render(500,BancosVO);
  except
    Render(500,BancosVO);
  end;
end;

end.
