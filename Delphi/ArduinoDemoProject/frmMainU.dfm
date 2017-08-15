object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ComPortArduino'
  ClientHeight = 305
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbStatus: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object lbComPortList: TLabel
    Left = 8
    Top = 56
    Width = 82
    Height = 13
    Caption = 'Select COM port:'
  end
  object lbResponse: TLabel
    Left = 8
    Top = 152
    Width = 51
    Height = 13
    Caption = 'Response:'
  end
  object edtStatus: TEdit
    Left = 8
    Top = 24
    Width = 233
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = 'Not connected'
  end
  object ccbComPortList: TComComboBox
    Left = 8
    Top = 72
    Width = 233
    Height = 21
    ComPort = ComPort
    ComProperty = cpPort
    AutoApply = True
    Text = ''
    Style = csDropDownList
    ItemIndex = -1
    TabOrder = 1
    OnChange = ccbComPortListChange
  end
  object btnLedOn: TButton
    Left = 8
    Top = 104
    Width = 113
    Height = 41
    Caption = 'Turn Led On'
    Enabled = False
    TabOrder = 2
    OnClick = btnLedOnClick
  end
  object btnLedOff: TButton
    Left = 128
    Top = 104
    Width = 113
    Height = 41
    Caption = 'Turn Led Off'
    Enabled = False
    TabOrder = 3
    OnClick = btnLedOffClick
  end
  object memResponse: TMemo
    Left = 8
    Top = 168
    Width = 233
    Height = 129
    TabOrder = 4
  end
  object ComPort: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    DiscardNull = True
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = True
    OnRxChar = ComPortRxChar
    Left = 144
    Top = 8
  end
  object tmrConnect: TTimer
    OnTimer = tmrConnectTimer
    Left = 200
    Top = 8
  end
end
