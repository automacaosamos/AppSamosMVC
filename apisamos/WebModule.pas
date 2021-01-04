unit WebModule;

interface

uses 
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  MVCFramework,
  MVCFramework.Middleware.CORS;
type
  TWebModuleSamos = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FMVC: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModuleSamos;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  MVCFramework.Commons,
  MVCFramework.Middleware.StaticFiles,
  MVCFramework.Middleware.Compression,
  EmpresasController,
  UsuariosController,
  PortadoresController,
  BancosController,
  CidadesController,
  UtilsController;

procedure TWebModuleSamos.WebModuleCreate(Sender: TObject);
begin
  FMVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      // session timeout (0 means session cookie)
      Config[TMVCConfigKey.SessionTimeout]           := '0';
      //default content-type
      Config[TMVCConfigKey.DefaultContentType]       := TMVCConstants.DEFAULT_CONTENT_TYPE;
      //default content charset
      Config[TMVCConfigKey.DefaultContentCharset]    := TMVCConstants.DEFAULT_CONTENT_CHARSET;
      //unhandled actions are permitted?
      Config[TMVCConfigKey.AllowUnhandledAction]     := 'false';
      //enables or not system controllers loading (available only from localhost requests)
      Config[TMVCConfigKey.LoadSystemControllers]    := 'true';
      //default view file extension
      Config[TMVCConfigKey.DefaultViewFileExtension] := 'html';
      //view path
      Config[TMVCConfigKey.ViewPath]                 := 'templates';
      //Max Record Count for automatic Entities CRUD
      Config[TMVCConfigKey.MaxEntitiesRecordCount]   := '20';
      //Enable Server Signature in response
      Config[TMVCConfigKey.ExposeServerSignature]    := 'true';
      //Enable X-Powered-By Header in response
      Config[TMVCConfigKey.ExposeXPoweredBy]         := 'true';
      // Max request size in bytes
      Config[TMVCConfigKey.MaxRequestSize]           := IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE);
    end);
  FMVC.AddController(TEmpresasController);
  FMVC.AddController(TUsuariosController);
  FMVC.AddController(TPortadoresController);
  FMVC.AddController(TBancosController);
  FMVC.AddController(TCidadesController);
  FMVC.AddController(TUtilsController);
  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);
  FMVC.AddMiddleware(TCORSMiddleware.Create('*',true,'GET, POST, PUT, DELETE, OPTIONS','Content-Type, Accept, jwtusername, jwtpassword, authentication, authorization, x-requested-with, cache-control'));
end;

procedure TWebModuleSamos.WebModuleDestroy(Sender: TObject);
begin
  FMVC.Free;
end;

end.
