unit frmMainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPortCtl, CPort, System.Types,
  Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    lbStatus: TLabel;
    edtStatus: TEdit;
    ccbComPortList: TComComboBox;
    lbComPortList: TLabel;
    ComPort: TComPort;
    btnLedOn: TButton;
    btnLedOff: TButton;
    lbResponse: TLabel;
    memResponse: TMemo;
    tmrConnect: TTimer;
    procedure tmrConnectTimer(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure btnLedOnClick(Sender: TObject);
    procedure btnLedOffClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ccbComPortListChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnLedOffClick(Sender: TObject);
begin
  // Send string to arduino
  ComPort.WriteStr('0');
end;

procedure TfrmMain.btnLedOnClick(Sender: TObject);
begin
  // Send string to arduino
  ComPort.WriteStr('1');
end;

procedure TfrmMain.ccbComPortListChange(Sender: TObject);
begin
  if IsDebuggerPresent() then
  begin
    // On COM port select, try to connect
    try
      ComPort.Open;
      ComPort.WriteStr('-');
      edtStatus.Text := 'Connected';
    except
      edtStatus.Text := 'Not connected';
      btnLedOn.Enabled := False;
      btnLedOff.Enabled := False;
    end;
  end;
end;

procedure TfrmMain.ComPortRxChar(Sender: TObject; Count: Integer);
var
  LReadedStr: String;
begin
  // Read string from COM port
  ComPort.ReadStr(LReadedStr, Count);
  // If string is not empty
  if Trim(LReadedStr) <> '' then
  begin
    // Check for status and enable buttons
    if Trim(LReadedStr) = 'READY' then
    begin
      btnLedOn.Enabled := True;
      btnLedOff.Enabled := True;
    end;
    // Add string to memo
    memResponse.Lines.Add(LReadedStr);
    // Move memo vertical scroll bar to end
    memResponse.ScrollBy(0, 99999);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Close COM port on exit
  if ComPort.Connected then ComPort.Close;
end;

procedure TfrmMain.tmrConnectTimer(Sender: TObject);
begin
  if not IsDebuggerPresent() then
  begin
    // In non debug mode use timer
    // Try connect to COM port
    if not ComPort.Connected then
    begin
      try
        ComPort.Open;
        ComPort.WriteStr('-');
        edtStatus.Text := 'Connected';
      except
        edtStatus.Text := 'Not connected';
        btnLedOn.Enabled := False;
        btnLedOff.Enabled := False;
      end;
    end;
  end;
end;

end.
