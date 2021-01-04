unit WebModuleServices;

interface

uses 
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  MVCFramework.Middleware.CORS,
  MVCFramework;

type
  TWebModuleServices = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FMVC: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModuleServices;

const
  SECRET_KEY     = 'O#rato#roeu#a#roupa#do#rei#de#roma';
  LOGIN_ENDPOINT = '/login';

implementation

{$R *.dfm}

uses 
  System.IOUtils,
  System.DateUtils,
  MVCFramework.Commons,
  MVCFramework.Middleware.StaticFiles,
  MVCFramework.Middleware.Compression,
  MVCFramework.JWT,
  MVCFramework.Middleware.JWT,
  AuthenticationProvider,
  EmpresasController,
  UsuariosController,
  PortadoresController,
  BancosController,
  CidadesController,
  UtilsController;

procedure TWebModuleServices.WebModuleCreate(Sender: TObject);
var
  LClaims: TJWTClaimsSetup;
begin
  FMVC := TMVCEngine.Create(Self,
  procedure(Config: TMVCConfig)
  begin
    // session timeout (0 means session cookie)
    Config[TMVCConfigKey.SessionTimeout]           := '-1';
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
    // Max request size in bytes
    Config[TMVCConfigKey.MaxRequestSize]           := IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE);
  end);

  FMVC.AddController(TEmpresasController);
  FMVC.AddController(TUsuariosController);
  FMVC.AddController(TPortadoresController);
  FMVC.AddController(TBancosController);
  FMVC.AddController(TCidadesController);
  FMVC.AddController(TUtilsController);
//  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);
  FMVC.AddMiddleware(TCORSMiddleware.Create('*',true,'GET, POST, PUT, DELETE, OPTIONS','Content-Type, Accept, jwtusername, jwtpassword, authentication, authorization, x-requested-with, cache-control'));

  LClaims :=
    procedure (const JWT: TJWT)
    begin
      JWT.Claims.Issuer           := 'Sample API';
      JWT.Claims.ExpirationTime   := Now + (OneMinute * 60);
      JWT.Claims.NotBefore        := Now;
      JWT.Claims.IssuedAt         := Now;
      JWT.CustomClaims['nome']    := 'Empresa Modelo Ltda';
      JWT.CustomClaims['cliente'] := '001';
      JWT.CustomClaims['cnpj']    := '99.999.999/0001-91';
    end;

  FMVC.AddMiddleware(TMVCJWTAuthenticationMiddleware.Create(TAuthenticationProvider.Create,SECRET_KEY,LOGIN_ENDPOINT,LClaims,[TJWTCheckableClaim.ExpirationTime, TJWTCheckableClaim.NotBefore, TJWTCheckableClaim.IssuedAt],15));
  // Required to enable serving of static files
  // Remove the following middleware declaration if you don't
  // serve static files from this dmvcframework service.
  FMVC.AddMiddleware(TMVCStaticFilesMiddleware.Create('/static',TPath.Combine(ExtractFilePath(GetModuleName(HInstance)), 'www')));
  // To enable compression (deflate, gzip) just add this middleware as the last one
  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);
end;

procedure TWebModuleServices.WebModuleDestroy(Sender: TObject);
begin
  FMVC.Free;
end;

end.
