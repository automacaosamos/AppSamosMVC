program apisamos;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  MVCFramework.Logger,
  MVCFramework.Commons,
  MVCFramework.REPLCommandsHandlerU,
  Web.ReqMulti,
  Web.WebReq,
  Web.WebBroker,
  IdContext,
  IdHTTPWebBrokerBridge,
  WebModule in 'WebModule.pas' {WebModuleSamos: TWebModule},
  ConexoesController in 'controller\ConexoesController.pas',
  FuncoesController in 'controller\FuncoesController.pas',
  EmpresasVO in 'model\EmpresasVO.pas',
  UsuariosVO in 'model\UsuariosVO.pas',
  PortadoresVO in 'model\PortadoresVO.pas',
  CidadesVO in 'model\CidadesVO.pas',
  BancosVO in 'model\BancosVO.pas',
  EmpresasController in 'controller\EmpresasController.pas',
  UsuariosController in 'controller\UsuariosController.pas',
  PortadoresController in 'controller\PortadoresController.pas',
  BancosController in 'controller\BancosController.pas',
  CidadesController in 'controller\CidadesController.pas',
  UtilsController in 'controller\UtilsController.pas',
  UtilsVO in 'model\UtilsVO.pas';

{$R *.res}

procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LCustomHandler: TMVCCustomREPLCommandsHandler;
  LCmd: string;
begin
  Writeln('** Servidor DMVCFramework Server -> versao ' + DMVCFRAMEWORK_VERSION);

  LCmd := 'start';

  if ParamCount >= 1 then
    LCmd := ParamStr(1);

  LCustomHandler := function(const Value: String; const Server: TIdHTTPWebBrokerBridge; out Handled: Boolean): THandleCommandResult
    begin
      Handled := False;
      Result := THandleCommandResult.Unknown;
    end;

  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.OnParseAuthentication := TMVCParseAuthentication.OnParseAuthentication;
    LServer.DefaultPort           := APort;
    LServer.MaxConnections        := 0;
    LServer.ListenQueue           := 200;
    LServer.OnParseAuthentication := TMVCParseAuthentication.OnParseAuthentication;

    WriteLn('tecle "quit" ou "exit" para encerrar o servidor');

    repeat
      if LCmd.IsEmpty then
      begin
        Write('-> ');
        ReadLn(LCmd)
      end;
      try
        case HandleCommand(LCmd.ToLower, LServer, LCustomHandler) of
          THandleCommandResult.Continue:
            begin
              Continue;
            end;
          THandleCommandResult.Break:
            begin
              Break;
            end;
          THandleCommandResult.Unknown:
            begin
              REPLEmit('Unknown command: ' + LCmd);
            end;
        end;
      finally
        LCmd := '';
      end;
    until False;

  finally
    LServer.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  IsMultiThread := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    WebRequestHandlerProc.MaxConnections := 1024;
    RunServer(Valor_Int(Configurar('PORTHTTP=')));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
