unit UDmDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet,FMX.Dialogs, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,System.IniFiles,FMX.Forms, ppDB,
  ppDBPipe, ppParameter, ppDesignLayer, ppCtrls, ppBands, ppVar,
  Vcl.Imaging.pngimage, ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd,
  ppReport;

type
  TdmDB = class(TDataModule)
    FConFB: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FconDB: TFDConnection;
    PROPRIEDADES: TFDQuery;
    PROPRIEDADESID: TIntegerField;
    PROPRIEDADESNOME: TStringField;
    PROPRIEDADESCIDADE: TStringField;
    PROPRIEDADESUF: TStringField;
    PROPRIEDADESENDERECO: TStringField;
    PROPRIEDADESSTATUS: TIntegerField;
    PROPRIEDADESUSRER_ID: TIntegerField;
    PROPRIEDADESDATA_REG: TSQLTimeStampField;
    PROPRIEDADESPROPRIA: TIntegerField;
    PROPRIEDADESCOD_ESTAB_GTA: TStringField;
    PROPRIEDADESIE: TStringField;
    PROPRIEDADESGUID: TStringField;
    PROPRIEDADESRASTREADA: TIntegerField;
    PROPRIEDADESCOD_ERAS_BND: TStringField;
    PROPRIEDADESCIF: TStringField;
    PROPRIEDADESNIRF: TStringField;
    PROPRIEDADESINCRA: TStringField;
    qryAuxFB: TFDQuery;
    TRelZoo: TFDQuery;
    TRelZooID: TIntegerField;
    TRelZooLOTE: TIntegerField;
    TRelZooCURRAL: TStringField;
    TRelZooQTDE_CAB: TIntegerField;
    TRelZooENTRADA: TDateField;
    TRelZooPESO_ENTRADA: TFMTBCDField;
    TRelZooARROENT: TFMTBCDField;
    TRelZooDIAS_MEDIO: TIntegerField;
    TRelZooPESO_PROJ: TFMTBCDField;
    TRelZooARROPROJ: TFMTBCDField;
    TRelZooGPT: TFMTBCDField;
    TRelZooARROBAPRODMED: TFMTBCDField;
    TRelZooARROBAPRODTOTAL: TFMTBCDField;
    TRelZooGMD: TFMTBCDField;
    TRelZooCONSUMO_MN_GERAL: TFMTBCDField;
    TRelZooCONSUMO_MS_GERAL: TFMTBCDField;
    TRelZooIMS_PV_GERAL: TFMTBCDField;
    TRelZooCONSUMO_MN: TFMTBCDField;
    TRelZooCONSUMO_MS: TFMTBCDField;
    TRelZooIMS_PV: TFMTBCDField;
    TRelZooCONSUMO_MN_1D: TFMTBCDField;
    TRelZooCONSUMO_MS_1D: TFMTBCDField;
    TRelZooIMS_PV_1D: TFMTBCDField;
    TRelZooCONSUMO_MN_5D: TFMTBCDField;
    TRelZooCONSUMO_MS_5D: TFMTBCDField;
    TRelZooIMS_PV_5D: TFMTBCDField;
    TRelZooDATA_BASE_REL: TDateField;
    TRelZooID_PROPRIEDADE: TIntegerField;
    ppRepLoteAtivo: TppReport;
    ppHeaderBand3: TppHeaderBand;
    imgCli: TppImage;
    ppLabel29: TppLabel;
    ppLine8: TppLine;
    ppImage3: TppImage;
    ppShape36: TppShape;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppLabel47: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel50: TppLabel;
    ppLabel56: TppLabel;
    ppLabel57: TppLabel;
    ppLabel58: TppLabel;
    ppLabel59: TppLabel;
    ppLabel24: TppLabel;
    ppLine10: TppLine;
    ppLabel81: TppLabel;
    ppLabel62: TppLabel;
    ppLabel63: TppLabel;
    ppLabel64: TppLabel;
    ppLabel52: TppLabel;
    ppLine11: TppLine;
    ppLabel53: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppLabel44: TppLabel;
    ppLabel61: TppLabel;
    ppLabel70: TppLabel;
    ppLine13: TppLine;
    ppLabel71: TppLabel;
    ppLine14: TppLine;
    ppLabel72: TppLabel;
    ppLabel73: TppLabel;
    ppLabel74: TppLabel;
    ppLine15: TppLine;
    ppLabel75: TppLabel;
    ppLabel76: TppLabel;
    ppLabel78: TppLabel;
    ppLabel51: TppLabel;
    ppLabel60: TppLabel;
    ppLine16: TppLine;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppShape25: TppShape;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText30: TppDBText;
    ppDBText31: TppDBText;
    ppDBText33: TppDBText;
    ppDBText35: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppDBText29: TppDBText;
    ppDBText25: TppDBText;
    ppDBText28: TppDBText;
    ppDBText32: TppDBText;
    ppDBText34: TppDBText;
    ppDBText36: TppDBText;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppDBText41: TppDBText;
    ppDBText46: TppDBText;
    ppFooterBand3: TppFooterBand;
    ppLine9: TppLine;
    ppLabel30: TppLabel;
    ppSystemVariable5: TppSystemVariable;
    ppSystemVariable6: TppSystemVariable;
    ppSummaryBand2: TppSummaryBand;
    ppShape35: TppShape;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppDBCalc33: TppDBCalc;
    ppDBCalc34: TppDBCalc;
    ppDBCalc35: TppDBCalc;
    ppDBCalc36: TppDBCalc;
    ppDBCalc37: TppDBCalc;
    ppLabel39: TppLabel;
    ppDBCalc38: TppDBCalc;
    ppLabel40: TppLabel;
    ppDBCalc39: TppDBCalc;
    ppDBCalc40: TppDBCalc;
    ppDBCalc41: TppDBCalc;
    ppLabel41: TppLabel;
    ppDBCalc42: TppDBCalc;
    ppLabel43: TppLabel;
    ppDBCalc44: TppDBCalc;
    ppDBCalc45: TppDBCalc;
    ppLabel42: TppLabel;
    ppDesignLayers3: TppDesignLayers;
    ppDesignLayer3: TppDesignLayer;
    ppParameterList3: TppParameterList;
    ppDBRelLoteAtivo: TppDBPipeline;
    ppDBRelLoteAtivoppField1: TppField;
    ppDBRelLoteAtivoppField2: TppField;
    ppDBRelLoteAtivoppField3: TppField;
    ppDBRelLoteAtivoppField4: TppField;
    ppDBRelLoteAtivoppField5: TppField;
    ppDBRelLoteAtivoppField6: TppField;
    ppDBRelLoteAtivoppField7: TppField;
    ppDBRelLoteAtivoppField8: TppField;
    ppDBRelLoteAtivoppField9: TppField;
    ppDBRelLoteAtivoppField10: TppField;
    ppDBRelLoteAtivoppField11: TppField;
    ppDBRelLoteAtivoppField12: TppField;
    ppDBRelLoteAtivoppField13: TppField;
    ppDBRelLoteAtivoppField14: TppField;
    ppDBRelLoteAtivoppField15: TppField;
    ppDBRelLoteAtivoppField16: TppField;
    ppDBRelLoteAtivoppField17: TppField;
    ppDBRelLoteAtivoppField18: TppField;
    ppDBRelLoteAtivoppField19: TppField;
    ppDBRelLoteAtivoppField20: TppField;
    ppDBRelLoteAtivoppField21: TppField;
    ppDBRelLoteAtivoppField22: TppField;
    ppDBRelLoteAtivoppField23: TppField;
    ppDBRelLoteAtivoppField24: TppField;
    ppDBRelLoteAtivoppField25: TppField;
    ppDBRelLoteAtivoppField26: TppField;
    ppDBRelLoteAtivoppField27: TppField;
    ppDBRelLoteAtivoppField28: TppField;
    dsRelLoteAtivo: TDataSource;
    ppReportMapaGado: TppReport;
    ppHeaderBand4: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLine7: TppLine;
    ppImage4: TppImage;
    ppImgCli: TppImage;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppDetailBand4: TppDetailBand;
    ppShape9: TppShape;
    ppShape10: TppShape;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppLabel3: TppLabel;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppLabel6: TppLabel;
    ppDBText5: TppDBText;
    ppLine1: TppLine;
    ppLabel7: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel9: TppLabel;
    ppDBText9: TppDBText;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppLabel11: TppLabel;
    ppDBText11: TppDBText;
    ppLabel176: TppLabel;
    ppDBText104: TppDBText;
    ppLabel177: TppLabel;
    ppDBText105: TppDBText;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppFooterBand4: TppFooterBand;
    ppLine2: TppLine;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppShape11: TppShape;
    ppShape12: TppShape;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppDBCalc3: TppDBCalc;
    ppLabel15: TppLabel;
    ppDBCalc4: TppDBCalc;
    ppLabel16: TppLabel;
    ppDBCalc5: TppDBCalc;
    ppLabel17: TppLabel;
    ppDBCalc6: TppDBCalc;
    ppLabel18: TppLabel;
    ppDBCalc7: TppDBCalc;
    ppLabel19: TppLabel;
    ppDBCalc8: TppDBCalc;
    ppLabel20: TppLabel;
    ppDBCalc9: TppDBCalc;
    ppLabel21: TppLabel;
    ppDBCalc10: TppDBCalc;
    ppLabel22: TppLabel;
    ppDBCalc11: TppDBCalc;
    ppLabel23: TppLabel;
    ppDBCalc12: TppDBCalc;
    ppLabel25: TppLabel;
    ppDBCalc13: TppDBCalc;
    ppLabel26: TppLabel;
    ppDBCalc14: TppDBCalc;
    ppLabel178: TppLabel;
    ppDBCalc56: TppDBCalc;
    ppLabel179: TppLabel;
    ppDBCalc57: TppDBCalc;
    ppDesignLayers4: TppDesignLayers;
    ppDesignLayer4: TppDesignLayer;
    ppParameterList4: TppParameterList;
    ppDBMapaGado: TppDBPipeline;
    dsMapaGado: TDataSource;
    qryMapaGado: TFDQuery;
    qryMapaGadoPASTO: TStringField;
    qryMapaGadoQTDCAB: TIntegerField;
    qryMapaGadoPESO_ESTIMADO: TFMTBCDField;
    qryMapaGadoDIAS: TLargeintField;
    qryMapaGadoUA: TFMTBCDField;
    qryMapaGadoAREA_HECTARES: TFMTBCDField;
    qryMapaGadoUAH: TFMTBCDField;
    qryMapaGadoGMD: TFMTBCDField;
    qryMapaGadoTOTALARROBA: TFMTBCDField;
    qryMapaGadoMACHOS: TIntegerField;
    qryMapaGadoFEMEAS: TIntegerField;
    qryMapaGadoPESO_ENTRADA: TFMTBCDField;
    qryMapaGadoULTIMO_PESO: TFMTBCDField;
    ConfEmails: TFDQuery;
    ConfEmailsid: TFDAutoIncField;
    ConfEmailsemail: TStringField;
    ConfEmailsstatus: TIntegerField;
    ConfEmailsdatareg: TDateTimeField;
    qryAux: TFDQuery;
    ConfEmailszootecnico: TIntegerField;
    ConfEmailsmapagado: TIntegerField;
    ConfEmailsMapa_Str: TWideStringField;
    ConfEmailszootec_Str: TWideStringField;
    procedure FconDBBeforeConnect(Sender: TObject);
    procedure ConfEmailsReconcileError(DataSet: TFDDataSet; E: EFDException;
      UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
  private
    { Private declarations }
  public
    var
     pathDB:string;
     procedure ConectaBDFB;
     function  LerIni(Diretorio,Chave1, Chave2, ValorPadrao: String): String;
     procedure GeraMapaGado;
     procedure GeraZootec;
  end;

var
  dmDB: TdmDB;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses UPrincipal;

{$R *.dfm}

procedure TdmDB.ConectaBDFB;
var
  Arquivo,vPathBD,vNomeBase: String;
  vVendorLib:string;
begin
  FConFB.Connected := false;
  Arquivo := ExtractFilePath(ParamStr(0))+'fieldconf.ini';
  if not FileExists(Arquivo) then
  begin
    frmPrincipal.mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' :Erro ao Conectar no banco:'+
    'Arquivo fieldconf.ini não localizado no seguinte diretorio:'+#13+Arquivo);
    frmPrincipal.mlog.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'logsSendReport\Log_'+
    FormatDateTime('dd_mm_yyyy_hh_mm',now)+'.txt');
    Application.Terminate;
  end
  else
  begin
    vVendorLib :=ExtractFilePath(ParamStr(0))+'fbclient_32.dll';
    FDPhysFBDriverLink1.VendorLib := vVendorLib;
    try
      with FConFB do
        begin
          vPathBD                    := LerIni(Arquivo,'FIREBIRD','dbRede','');
          vNomeBase                  := LerIni(Arquivo,'FIREBIRD','NomeBase','');
          Params.Clear;
          Params.Values['DriverID']  :='FB';
          Params.Values['Server']    :=LerIni(Arquivo,'FIREBIRD','Server','');
          Params.Values['Database']  :=LerIni(Arquivo,'FIREBIRD','Database','');
          Params.Values['User_name'] :=LerIni(Arquivo,'FIREBIRD','User','');
          Params.Values['Password']  :=LerIni(Arquivo,'FIREBIRD','Password','');
          Params.Values['Port']      :=LerIni(Arquivo,'FIREBIRD','Port','');
          Connected := True;
          frmPrincipal.mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' Conectado com Sucesso!');
        end;
    except
     on E: Exception do
      frmPrincipal.mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' :Erro ao Conectar no banco:'+
      'Ocorreu uma Falha na configuração no Banco Firebird:'+e.Message);
    end;
  end;
end;

function TdmDB.LerIni(Diretorio,Chave1, Chave2, ValorPadrao: String): String;
var
 FileIni: TIniFile;
begin
  result := ValorPadrao;
  try
    FileIni := TIniFile.Create(Diretorio);
    if FileExists(Diretorio) then
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;
end;

procedure TdmDB.ConfEmailsReconcileError(DataSet: TFDDataSet; E: EFDException;
  UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
begin
  ShowMessage(E.Message);
end;

procedure TdmDB.FconDBBeforeConnect(Sender: TObject);
begin
 pathDB :=ExtractFilePath(ParamStr(0))+'dbSqlite\SendReport.db';
 FconDB.Params.DriverID :='SQLite';
 FconDB.Params.Values['Database'] :=pathDB;
end;

procedure TdmDB.GeraZootec;
begin
  PROPRIEDADES.Close;
  PROPRIEDADES.Open;
  while not PROPRIEDADES.eof do
  begin
   with qryAuxFB,qryAuxFB.SQL DO
   begin
     Clear;
     Add('insert into REL_ZOO_CONF');
     Add('SELECT');
     Add('NULL,');
     Add('LOTE,');
     Add('CURRAL,');
     Add('QTDE_CAB,');
     Add('ENTRADA,');
     Add('PESO_ENTRADA,');
     Add('ARROENT,');
     Add('DIAS_MEDIO,');
     Add('PESO_PROJ,');
     Add('ARROPROJ,');
     Add('GPT,');
     Add('ARROBAPRODMED,');
     Add('ARROBAPRODTOTAL,');
     Add('GMD,');
     Add('CONSUMO_MN_GERAL,');
     Add('CONSUMO_MS_GERAL,');
     Add('IMS_PV_GERAL,');
     Add('CONSUMO_MN,');
     Add('CONSUMO_MS,');
     Add('IMS_PV,');
     Add('CONSUMO_MN_1D,');
     Add('CONSUMO_MS_1D,');
     Add('IMS_PV_1D,');
     Add('CONSUMO_MN_5D,');
     Add('CONSUMO_MS_5D,');
     Add('IMS_PV_5D,');
     Add(':vData,');
     Add(':vIdProp');
     Add('from RELATORIO_ZOOTEC(:vIdProp,:vData)');
     ParamByName('vIDProp').AsString := PROPRIEDADESID.AsString;
     ParamByName('vData').AsDate     := date;
     ExecSQL;
   end;

   with TRelZoo,TRelZoo.SQL do
   begin
     Clear;
     Add('SELECT * from REL_ZOO_CONF');
     Add('WHERE ID_PROPRIEDADE=:vIdProp');
     Add('AND DATA_BASE_REL=:vData');
     ParamByName('vIDProp').AsString := PROPRIEDADESID.AsString;
     ParamByName('vData').AsDate   := date;
     Open;
     if not TRelZoo.IsEmpty then
     begin
      ppRepLoteAtivo.ShowPrintDialog := false;
      ppRepLoteAtivo.DeviceType      := 'PDF';
      ppRepLoteAtivo.TextFileName    := ExtractFilePath(ParamStr(0))+'Reports\'+
      FormatDateTime('dd_mm_yyyy',now)+'\ZOOTEC\'+
      PROPRIEDADESNOME.AsString+'_Zootecnico_'+FormatDateTime('dd_mm_yyyy',now)+'.PDF';
      ppRepLoteAtivo.Print;
     end;
   end;
   PROPRIEDADES.Next;
  end;
end;

procedure TdmDB.GeraMapaGado;
begin
 PROPRIEDADES.Close;
 PROPRIEDADES.Open;
 while not PROPRIEDADES.eof do
 begin
   with qryMapaGado,qryMapaGado.SQL do
   begin
     Clear;
     Add('SELECT');
     Add('Pasto ,');
     Add('QtdCab  ,');
     Add('peso_estimado,');
     Add('dias,');
     Add('UA,');
     Add('peso_entrada,');
     Add('ultimo_peso,');
     Add('area_hectares,');
     Add('CASE');
     Add(' WHEN (UA>0 AND area_hectares>0) then');
     Add('   (UA/area_hectares)');
     Add('  else');
     Add('   0');
     Add('end UAH,');
     Add('gpt/dias gmd,');
     Add('totalArroba,');
     Add('(SELECT COUNT(*) Machos FROM ANIMAL a');
     Add('JOIN CATEGORIAS ca ON CA.ID=A.ID_CATEGORIA');
     Add('JOIN CURRAIS c ON c.ID=a.ID_LOCAL');
     Add('WHERE A.STATUS=1 AND a.ID_PROPRIEDADE=:id_propriedade AND CA.SEXO=''M'' AND c.CODIGO=Pasto)Machos,');
     Add('(SELECT COUNT(*) Femeas FROM ANIMAL a');
     Add('JOIN CATEGORIAS ca ON CA.ID=A.ID_CATEGORIA');
     Add('JOIN CURRAIS c ON c.ID=a.ID_LOCAL');
     Add('WHERE A.STATUS=1 AND a.ID_PROPRIEDADE=:id_propriedade AND CA.SEXO=''F'' AND c.CODIGO=Pasto)Femeas');
     Add('FROM');
     Add('(select');
     Add(' Pasto,');
     Add(' SUM(peso) UA,');
     Add(' AVG(area_hectares)area_hectares,');
     Add(' COUNT(*) QtdCab,');
     Add('AVG(peso_estimado) peso_estimado,');
     Add(' avg(dias)+1dias,');
     Add(' avg(gpt)gpt,');
     Add(' sum(arroba) totalArroba,');
     Add('avg(peso_entrada)peso_entrada,');
     Add('avg(ultimo_peso)ultimo_peso');
     Add('from');
     Add('(');
     Add('select c.codigo Pasto,');
     Add('a.peso_estimado,');
     Add('(a.peso_estimado/450)peso,');
     Add('C.area_hectares,');
     Add('datediff(day from a.data_proc to current_timestamp) dias,');
     Add('(a.peso_estimado-a.peso_entrada) gpt,');
     Add('((peso_estimado/2)/15) arroba,');
     Add('a.peso_entrada,');
     Add('a.ultimo_peso');
     Add('from animal a');
     Add('join currais c on c.id=a.id_local');
     Add('where a.status=1 and a.id_propriedade=:id_propriedade)');
     Add('GROUP BY Pasto)');
     ParamByName('id_propriedade').AsString := PROPRIEDADESID.AsString;
     Open;
     if not IsEmpty then
     begin
      ppReportMapaGado.ShowPrintDialog := false;
      ppReportMapaGado.DeviceType      := 'PDF';
      ppReportMapaGado.TextFileName    := ExtractFilePath(ParamStr(0))+'Reports\'+
      FormatDateTime('dd_mm_yyyy',now)+'\MAPA\'+
      PROPRIEDADESNOME.AsString+'_Mapa_do_Gado_'+FormatDateTime('dd_mm_yyyy',now)+'.PDF';
      ppReportMapaGado.Print;
     end;
   end;
   PROPRIEDADES.Next;
 end;
end;


end.

