program FieldReports;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'Principal\UPrincipal.pas' {frmPrincipal},
  UDmDB in 'UDmDB.pas' {dmDB: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmDB, dmDB);
  Application.Run;
end.
