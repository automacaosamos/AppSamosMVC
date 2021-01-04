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
  WebModuleServices in 'services\WebModuleServices.pas' {WebModuleServices: TWebModule},
  AuthenticationProvider in 'providers\AuthenticationProvider.pas',
  BancosController in 'controllers\BancosController.pas',
  CidadesController in 'controllers\CidadesController.pas',
  ConexoesController in 'controllers\ConexoesController.pas',
  Controller.Customer in 'controllers\Controller.Customer.pas',
  EmpresasController in 'controllers\EmpresasController.pas',
  FuncoesController in 'controllers\FuncoesController.pas',
  PortadoresController in 'controllers\PortadoresController.pas',
  UsuariosController in 'controllers\UsuariosController.pas',
  UtilsController in 'controllers\UtilsController.pas',
  BancosVO in 'model\BancosVO.pas',
  CidadesVO in 'model\CidadesVO.pas',
  EmpresasVO in 'model\EmpresasVO.pas',
  PortadoresVO in 'model\PortadoresVO.pas',
  UsuariosVO in 'model\UsuariosVO.pas',
  UtilsVO in 'model\UtilsVO.pas';

{$R *.res}


procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LCustomHandler: TMVCCustomREPLCommandsHandler;
  LCmd: string;
begin
  Writeln('** Samos Server ** build ' + DMVCFRAMEWORK_VERSION);
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
    LServer.DefaultPort := APort;
    { more info about MaxConnections
      http://www.indyproject.org/docsite/html/frames.html?frmname=topic&frmfile=TIdCustomTCPServer_MaxConnections.html }
    LServer.MaxConnections := 0;
    { more info about ListenQueue
      http://www.indyproject.org/docsite/html/frames.html?frmname=topic&frmfile=TIdCustomTCPServer_ListenQueue.html }
    LServer.ListenQueue := 200;
    {required if you use JWT middleware }
    LServer.OnParseAuthentication := TMVCParseAuthentication.OnParseAuthentication;

    WriteLn('Digite: "quit" or "exit" para finalizar o servidor');

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
      WebRequestHandler.WebModuleClass   := WebModuleClass;
    WebRequestHandlerProc.MaxConnections := 1024;
    RunServer(Valor_Int(Configurar('PORTHTTP=')));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
