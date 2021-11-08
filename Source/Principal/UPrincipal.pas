unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.Menus, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Memo, FMX.StdCtrls, FMX.Edit,
  FMX.ScrollBox, FMX.Grid, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl,db,
  IdSSLOpenSSL,IdSMTP,IdMessage,IdText,IdExplicitTLSClientServerBase,
  IdAttachmentFile, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FMX.ListBox;
type
  TfrmPrincipal = class(TForm)
    tbPrincipal: TTabControl;
    tbi1: TTabItem;
    tbi2: TTabItem;
    layPrincipal: TLayout;
    Image1: TImage;
    Layout1: TLayout;
    Layout2: TLayout;
    btnEmails: TButton;
    Image2: TImage;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    Layout3: TLayout;
    btnNovoEmail: TButton;
    Image3: TImage;
    tbi3: TTabItem;
    Rectangle1: TRectangle;
    Label2: TLabel;
    layFechaPadrao: TLayout;
    imgClose: TImage;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Layout4: TLayout;
    Image4: TImage;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Layout5: TLayout;
    Image5: TImage;
    Layout6: TLayout;
    Layout7: TLayout;
    Rectangle4: TRectangle;
    Layout8: TLayout;
    Label4: TLabel;
    edtEmail: TEdit;
    Layout9: TLayout;
    Layout10: TLayout;
    Rectangle5: TRectangle;
    Layout11: TLayout;
    Label5: TLabel;
    Layout12: TLayout;
    chkMapa: TCheckBox;
    chkZootecnico: TCheckBox;
    Layout13: TLayout;
    btnConfirma: TButton;
    Image6: TImage;
    PopupMenu1: TPopupMenu;
    mnuEditar: TMenuItem;
    mnuExcluir: TMenuItem;
    tbiLog: TTabItem;
    mlog: TMemo;
    cbxDirMapa: TComboBox;
    cbxDirZootec: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure btnNovoEmailClick(Sender: TObject);
    procedure btnEmailsClick(Sender: TObject);
    procedure mnuEditarClick(Sender: TObject);
    procedure mnuExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    var
     vParam:integer;
    function  ValidarEMail(aStr: string): Boolean;
    function  VerificaEmailExiste(aEmail:string): Boolean;
    procedure SendEmail;
    procedure ListarArquivos(Tipo:string;Diretorio: string; Sub:Boolean);
    function  TemAtributo(Attr, Val: Integer): Boolean;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses UDmDB;

procedure TfrmPrincipal.btnConfirmaClick(Sender: TObject);
var
 vMapa,vZootec:integer;
begin
 if edtEmail.Text.Length=0 then
 begin
   ShowMessage('Informe o email!!!');
   edtEmail.SetFocus;
   exit;
 end;
 if (chkMapa.IsChecked=false)and(chkZootecnico.IsChecked=false)then
 begin
   ShowMessage('Marque pelo menos uma opção de Relatório!');
   exit;
 end;
 if dmDB.ConfEmails.State=dsInsert then
 begin
   if not VerificaEmailExiste(edtEmail.Text) then
   begin
    ShowMessage('Email já Cadastrado!');
    exit;
   end;
 end;
 if chkMapa.IsChecked then
  vMapa :=1
 else
  vMapa :=0;
 if chkZootecnico.IsChecked then
  vZootec :=1
 else
  vZootec :=0;

 dmDB.ConfEmailsemail.AsString       := edtEmail.Text;
 dmDB.ConfEmailsmapagado.AsInteger   := vMapa;
 dmDB.ConfEmailszootecnico.AsInteger := vZootec;
 try
  dmDB.ConfEmails.ApplyUpdates(-1);
  ShowMessage('Email configurado com suscesso!');
  dmDB.ConfEmails.Close;
  dmDB.ConfEmails.Open;
  tbPrincipal.ActiveTab := tbi2;
 except
  on E: Exception do
    ShowMessage('Erro ao salvar Email:'+E.Message);
 end;
end;

procedure TfrmPrincipal.btnEmailsClick(Sender: TObject);
begin
 dmDB.ConfEmails.Close;
 dmDB.ConfEmails.Open;
 tbPrincipal.ActiveTab := tbi2;
end;

procedure TfrmPrincipal.btnNovoEmailClick(Sender: TObject);
begin
 edtEmail.Text :='';
 chkMapa.IsChecked       := false;
 chkZootecnico.IsChecked := false;
 dmDB.ConfEmails.Close;
 dmDB.ConfEmails.Open;
 dmDB.ConfEmails.Insert;
 tbPrincipal.ActiveTab := tbi3;
end;

procedure TfrmPrincipal.edtEmailExit(Sender: TObject);
begin
 if edtEmail.Text.Length>0 then
  if not ValidarEMail(edtEmail.Text) then
  begin
    ShowMessage('Email invalido!!');
    edtEmail.SelectAll;
    edtEmail.SetFocus;
  end;
end;

function TfrmPrincipal.ValidarEMail(aStr: string): Boolean;
begin
 aStr := Trim(UpperCase(aStr));
 if Pos('@', aStr) > 1 then
 begin
   Delete(aStr, 1, pos('@', aStr));
   Result := (Length(aStr) > 0) and (Pos('.', aStr) > 2);
 end
 else
   Result := False;
end;

function TfrmPrincipal.VerificaEmailExiste(aEmail: string): Boolean;
begin
 with dmDB.qryAux,dmDB.qryAux.sql do
 begin
   Clear;
   Add('select * from sends where status=1 and email='+aEmail.QuotedString);
   Open;
   Result := dmDB.qryAux.IsEmpty;
 end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
 if not DirectoryExists(ExtractFilePath(ParamStr(0))+'logsSendReport') then
  CreateDir(ExtractFilePath(ParamStr(0))+'logsSendReport');

 if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Reports') then
  CreateDir(ExtractFilePath(ParamStr(0))+'Reports');

 if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)) then
  CreateDir(ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now));

 if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)+'\MAPA') then
  CreateDir(ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)+'\MAPA');

 if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)+'\ZOOTEC') then
  CreateDir(ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)+'\ZOOTEC');

 vParam := ParamCount;
 if vParam=0 then
 begin
  tbPrincipal.TabPosition := TTabPosition.None;
  tbPrincipal.ActiveTab   := tbi1;
 end
 else
 begin
  tbPrincipal.TabPosition := TTabPosition.None;
  tbPrincipal.ActiveTab   := tbiLog;
  mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Conectando ao Banco de Dados');
  dmDB.ConectaBDFB;
  mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Gerando Mapa do Gado');
  dmDB.GeraMapaGado;
  mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Gerando Zootecnico');
  dmDB.GeraZootec;
  mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Enviando E-mail');
  SendEmail;
  mlog.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'logsSendReport\Log_'+
   FormatDateTime('dd_mm_yyyy_hh_mm',now)+'.txt');
  Application.Terminate;
 end;
end;

procedure TfrmPrincipal.Image4Click(Sender: TObject);
begin
 tbPrincipal.ActiveTab := tbi1;
end;

procedure TfrmPrincipal.Image5Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TfrmPrincipal.imgCloseClick(Sender: TObject);
begin
 dmDB.ConfEmails.Close;
 dmDB.ConfEmails.Open;
 tbPrincipal.ActiveTab := tbi2;
end;

procedure TfrmPrincipal.ListarArquivos(Tipo, Diretorio: string; Sub: Boolean);
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin
 if TIPO='MAPA' then
  cbxDirMapa.Items.Clear;
 if TIPO='ZOOTEC' then
  cbxDirZootec.Items.Clear;
 Ret := FindFirst(Diretorio+'\*.*', faAnyFile, F);
 try
   while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
       if (F.Name <> '.') And (F.Name <> '..') then
        if Sub = True then
        begin
         TempNome := Diretorio+'\' + F.Name;
         ListarArquivos(Tipo,TempNome, True);
        end;
      end
      else
      begin
       if TIPO='MAPA' then
        cbxDirMapa.Items.Add(Diretorio+'\'+F.Name);
       if TIPO='ZOOTEC' then
        cbxDirZootec.Items.Add(Diretorio+'\'+F.Name);
      end;
      Ret := FindNext(F);
    end;
  finally
  begin
    FindClose(F);
  end;
 end;
end;


procedure TfrmPrincipal.mnuEditarClick(Sender: TObject);
begin
 dmDB.ConfEmails.Edit;
 edtEmail.Text           := dmDB.ConfEmailsemail.AsString;
 chkMapa.IsChecked       := dmDB.ConfEmailsmapagado.AsInteger   =1;
 chkZootecnico.IsChecked := dmDB.ConfEmailszootecnico.AsInteger =1;
 tbPrincipal.ActiveTab   := tbi3;
end;

procedure TfrmPrincipal.mnuExcluirClick(Sender: TObject);
begin
   MessageDlg('Deseja Realmente Deletar esse Registro?', System.UITypes.TMsgDlgType.mtInformation,
   [System.UITypes.TMsgDlgBtn.mbYes,
   System.UITypes.TMsgDlgBtn.mbNo
   ], 0,
   procedure(const AResult: System.UITypes.TModalResult)
   begin
    case AResult of
     mrYES:
     begin
       try
        dmDB.ConfEmails.Delete;
        dmDB.ConfEmails.ApplyUpdates(-1);
        ShowMessage('Registro deletado com sucesso!');
        dmDB.ConfEmails.Close;
        dmDB.ConfEmails.Open;
       except
        on E: Exception do
         ShowMessage('Erro ao Deletar Email:'+E.Message);
       end;
     end;
     mrNo:
    end;
   end);
end;

procedure TfrmPrincipal.SendEmail;
var
 IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
 IdSMTP: TIdSMTP;
 IdMessage: TIdMessage;
 IdText: TIdText;
 sAnexo,sAnexo2: string;
 StrAux  : TStringWriter;
 vEmailCliente,vEmailUsuario:string;
 x:integer;
begin
 ListarArquivos('MAPA',ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)+'\MAPA',true);
 ListarArquivos('ZOOTEC',ExtractFilePath(ParamStr(0))+'Reports\'+FormatDateTime('dd_mm_yyyy',now)+'\ZOOTEC',true);
 if(cbxDirMapa.Items.Count=0) and (cbxDirZootec.Items.Count=0) then
  Exit
 else
   dmDB.ConfEmails.Close;
   dmDB.ConfEmails.Open;
   dmDB.ConfEmails.First;
   while not dmDB.ConfEmails.Eof do
   begin
     IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
     IdSMTP := TIdSMTP.Create(Self);
     IdMessage := TIdMessage.Create(Self);
     try
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;
      IdSMTP.IOHandler := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS := utUseImplicitTLS;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Port := 465;
      IdSMTP.Host := 'smtp.gmail.com';
      IdSMTP.Username := 'relatoriosfield@gmail.com';
      IdSMTP.Password := '#field2021';
      IdMessage.From.Address := dmDB.ConfEmailsemail.AsString;
      IdMessage.From.Name := 'Relatórios FieldPec';
      IdMessage.Recipients.Add.Text := dmDB.ConfEmailsemail.AsString;
      IdMessage.Subject := 'Relatórios FieldPec';
      IdMessage.Encoding := meMIME;
      IdText := TIdText.Create(IdMessage.MessageParts);
      IdText.Body.Add('Relatórios FieldPec');
      IdText.ContentType := 'text/plain; charset=iso-8859-1';
      if dmDB.ConfEmailsmapagado.AsInteger=1 then
      begin
        for x := 0 to cbxDirMapa.Items.Count-1 do
          TIdAttachmentFile.Create(IdMessage.MessageParts, TFileName(cbxDirMapa.Items[x]));
      end;
      if dmDB.ConfEmailszootecnico.AsInteger=1 then
      begin
        for x := 0 to cbxDirZootec.Items.Count-1 do
          TIdAttachmentFile.Create(IdMessage.MessageParts, TFileName(cbxDirZootec.Items[x]));
      end;

      try
        IdSMTP.Connect;
        IdSMTP.Authenticate;
      except
      on E:Exception do
      begin
       mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Erro ao Enviar Email '+e.Message);
      end;
      end;
      try
        IdSMTP.Send(IdMessage);
        mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Emial enviado para :'+dmDB.ConfEmailsemail.AsString);
       except
       On E:Exception do
       begin
         mlog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss',now)+' : Erro ao Enviar Email '+e.Message);
       end;
      end;
      finally
       IdSMTP.Disconnect;
       UnLoadOpenSSLLibrary;
       FreeAndNil(IdMessage);
       FreeAndNil(IdSSLIOHandlerSocket);
       FreeAndNil(IdSMTP);
     end;
     dmDB.ConfEmails.Next;
   end;
end;

function TfrmPrincipal.TemAtributo(Attr, Val: Integer): Boolean;
begin
 Result := Attr and Val = Val;
end;

end.

