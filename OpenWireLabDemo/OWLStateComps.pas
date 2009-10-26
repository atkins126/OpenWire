// OpenWire demo components.
// The package is not designed for a real usage, but to demonstrate the power of OpenWire,
// however the components are fully implemented and can be used in a real application.

unit OWLStateComps;

{$IFDEF FPC}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses Classes, ComCtrls, OWStdTypes, OWPins;

type
  TOWLTrackBar = class( TTrackBar )
  protected // OpenWire support
    FPositionPin : TOWIntegerStatePin;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  protected
{$IFDEF FPC}
    procedure EditingDone; override;
{$ELSE}
    procedure Changed; override;
{$ENDIF}

  protected
    procedure OnIntegerChangeEvent( Sender : TOWPin; AValue : Integer );

  published // OpenWire support
    property PositionPin : TOWIntegerStatePin read FPositionPin write FPositionPin;

  end;

type
  TOWLProgressBar = class( TProgressBar )
  protected // OpenWire support
    FPositionPin : TOWFloatIntStatePin;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  protected
    procedure FloatChangeEvent( Sender : TOWPin; AValue : Single );
    
  published // OpenWire support
    property PositionPin : TOWFloatIntStatePin read FPositionPin write FPositionPin;

  end;

procedure Register;

implementation

constructor TOWLTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  FPositionPin := TOWIntegerStatePin.Create( Self, OnIntegerChangeEvent );
  
end;

destructor  TOWLTrackBar.Destroy;
begin
  FPositionPin.Free();
  inherited;
end;

procedure TOWLTrackBar.OnIntegerChangeEvent( Sender : TOWPin; AValue : Integer );
begin
  Position := AValue;
end;

{$IFDEF FPC}
procedure TOWLTrackBar.EditingDone;
{$ELSE}
procedure TOWLTrackBar.Changed;
{$ENDIF}
begin
  inherited;
  FPositionPin.Value := Position;
end;

constructor TOWLProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  FPositionPin := TOWFloatIntStatePin.Create( Self, FloatChangeEvent );

end;

destructor  TOWLProgressBar.Destroy;
begin
  FPositionPin.Free();
  inherited;
end;

procedure TOWLProgressBar.FloatChangeEvent( Sender : TOWPin; AValue : Single );
begin
  Position := Round( AValue );
end;

procedure Register;
begin
  RegisterComponents('OpenWire', [TOWLTrackBar]);
  RegisterComponents('OpenWire', [TOWLProgressBar]);
end;

end.
