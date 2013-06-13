unit OpenWirePinEditors;

{$IFDEF FPC}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

{$IFDEF VER140} // Delphi 6.0
{$DEFINE D6}
{$ENDIF}

{$IFDEF VER150} // Delphi 7.0
{$DEFINE D6}
{$DEFINE D7}
{$ENDIF}

{$IFDEF VER170} // Delphi 9.0
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER180} // Delphi 10.0
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER190} // Delphi 11.0
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER200} // Delphi 12.0
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER210} // Delphi 14.0
{$DEFINE D14Up}
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER220} // Delphi 15.0
{$DEFINE D14Up}
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER230} // Delphi 16.0
{$DEFINE D14Up}
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER240} // Delphi 17.0
{$DEFINE D14Up}
{$DEFINE D17Up}
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFDEF VER250} // Delphi 18.0
{$DEFINE D17Up}
{$DEFINE D14Up}
{$DEFINE D6}
{$DEFINE D7}
{$DEFINE D9}
{$DEFINE BDS2005_OR_HIGHER}
{$ENDIF}

{$IFNDEF FPC}
{$IFDEF D6}
{$DEFINE I_PROP_EDITOR}
{$ENDIF}
{$ENDIF}

{$IFNDEF FPC}
{$IFNDEF D6}

{$DEFINE D5}

{$ENDIF}
{$ENDIF}

uses
{$IFDEF FPC}
  LCLIntf, LMessages, LResources, PropEdits,
{$ELSE}
  Windows,

  {$IFDEF D6}
    DesignEditors,
    DesignIntf,
    TypInfo,
    OWClassProperty,
  {$ELSE}
    dsgnintf,
  {$ENDIF}

{$ENDIF}
  Messages, SysUtils, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Contnrs, OWPins, Vcl.ExtCtrls,
  OWDesignTypes;

{$IFDEF D6}
type IADesigner = IDesigner;
type TAGetPropProc = TGetPropProc;
{$ELSE}
  {$IFDEF FPC}
    type IADesigner = TIDesigner;
  {$ELSE}
    type IADesigner = IFormDesigner;
  {$ENDIF}
type TAGetPropProc = TGetPropEditProc;
{$ENDIF}

{$IFDEF FPC}
  type TOWPropNameString = ShortString;
  type TOWPropertyDesigner = TPropertyEditorHook;
{$ELSE}
  type TOWPropNameString = String;
  type TOWPropertyDesigner = IADesigner;
{$ENDIF}

//type TOWEPinType = ( ptSource, ptSink );

type
//---------------------------------------------------------------------------
  TOWEItemEntry = class
    protected
      FPin                   : TOWBasicPin;
      FConnectedToPin        : TOWBasicPin;
      FConnectedAfterPin     : TOWBasicPin;
      FItem                  : TListItem;

    protected
      procedure SetConnectedToPin( Value : TOWBasicPin );
      procedure SetConnectedAfterPin( Value : TOWBasicPin );
      
    public
      procedure Populate();

    public
      IsDispatcher    : Boolean;
      StateIndex      : Integer;

      PinConnectIdent : String;
      PinConnectName  : String;

    public
      constructor Create( AItem : TListItem; APin : TOWBasicPin );
      
    public
      property ConnectedToPin     : TOWBasicPin read FConnectedToPin    write SetConnectedToPin;
      property ConnectedAfterPin  : TOWBasicPin read FConnectedAfterPin write SetConnectedAfterPin;
      
  end;


type
  TOWPinEditorForm = class(TForm)
    ImageList1: TImageList;
    SourcesImageList: TImageList;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ListView: TListView;
    Panel4: TPanel;
    FormsComboBox: TComboBox;
    Label1: TLabel;
    Panel5: TPanel;
    LinksCountLabel: TLabel;
    StaticLabel: TLabel;
    SinksImageList: TImageList;
    AboutPanel: TPanel;
    Image1: TImage;
    AllPinsCheckBox: TCheckBox;
    LinkAllButton: TBitBtn;
    UnlinkAllButton: TBitBtn;
    RestoreButton: TBitBtn;
    OkButton: TBitBtn;
    CancelButton: TBitBtn;
    AfterPinButton: TBitBtn;
    procedure LinkAllButtonClick(Sender: TObject);
    procedure UnlinkAllButtonClick(Sender: TObject);
    procedure RestoreButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCreate(Sender: TObject);
    procedure ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormsComboBoxChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListViewKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewDeletion(Sender: TObject; Item: TListItem);
    procedure AfterPinButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLinksCount();
    procedure PopulateAll();
    procedure PopulateAllEntries();
    procedure PopulateForm( ARootComponent : TComponent );

    procedure PopulateSingleForm( CurrentRoot : TComponent; ARootComponent : TComponent; OnlyConnected : Boolean; FullPath : Boolean; FilterPins : Boolean );
    procedure PopulateSingleFormEntries( CurrentRoot : TComponent; ARootComponent : TComponent; FullPath : Boolean; FilterPins : Boolean );

    procedure PopulateSingleFormInt( CurrentRoot : TComponent; ARootComponent : TComponent; OnlyConnected : Boolean; FullPath : Boolean; FilterPins : Boolean );

    procedure FillFormsInfo();
    function  RootFromName( RootName : String ) : TComponent;
    
    function  EntryFromPin( Pin : TOWBasicPin ) : TOWEPinEntry;
    function  EntryFromDispatcher( Dispatcher : TOWBasicStateDispatcher ) : TOWEPinEntry;
    procedure ChangeState( Item : TListItem );

  private
    Designer      : TOWPropertyDesigner;
    FSourcePin    : TOWSourcePin;
    FSinkPin      : TOWSinkPin;
    FMultiSinkPin : TOWMultiSinkPin;
    FPin          : TOWPin;
    Root          : TComponent;
    PinsList      : TOWEPinsList;
    ListUpdating  : Boolean;

  private
    procedure OWMUpdate(var Message: TMessage); message OWM_UPDATE;
    procedure OWMUpdateInspector(var Message: TMessage); message OWMSG_UPDATE_INSPECTOR;
    procedure OWMUpdateModifiedInspector(var Message: TMessage); message OWMSG_UPDATE_MODIFIED_INSPECTOR;

  public
    function ExecuteForSource( ADesigner : TOWPropertyDesigner; ASourcePin : TOWSourcePin ): Integer;
    function ExecuteForSink( ADesigner : TOWPropertyDesigner; ASinkPin : TOWSinkPin ): Integer;
    function ExecuteForEventSink( ADesigner : TOWPropertyDesigner; AMultiSinkPin : TOWMultiSinkPin ): Integer;

  private
    FColumnToSort : Integer;
    FDirection    : Boolean;
    FAllSelected  : Boolean;

  public
    function  GetListItems() : TListItems;
    procedure ClearData();

  public
    property Items : TListItems read GetListItems;
    
  end;

type
  TOWBasicPropertyEditor = class(TPropertyEditor)
  protected
    function GetIntDesigner() : TOWPropertyDesigner;

  end;
//---------------------------------------------------------------------------
  TOWBasicPinPropertyEditor = class(TOWBasicPropertyEditor)
  protected
    function  GetPin() : TOWPin;

  public
    function  GetValue() : String; override;
    procedure SetValue(const Value: String); override;
{$IFDEF D7}
    function  GetIsDefault() : Boolean; override;
{$ENDIF}

  end;
//---------------------------------------------------------------------------
  TOWPinListPropertyEditor = class(TOWBasicPropertyEditor)
  public
    function  GetAttributes(): TPropertyAttributes; override;
    function  GetValue(): String; override;
    procedure GetProperties(Proc: TAGetPropProc); override;

  public
    procedure CheckRefresh();
    
  end;
//---------------------------------------------------------------------------
  TOWPinListOwnerPropertyEditor = class(TOWPinListPropertyEditor)
  public
    function  GetAttributes(): TPropertyAttributes; override;
    function  GetValue(): String; override;
    procedure SetValue(const Value: String); override;

  end;
//---------------------------------------------------------------------------
  TOWSourcePinPropertyEditor = class(TOWBasicPinPropertyEditor)
  public
    function  GetAttributes() : TPropertyAttributes; override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
  TOWStatePinPropertyEditor = class(TOWBasicPinPropertyEditor)
  public
    function  GetAttributes() : TPropertyAttributes; override;
    procedure Edit() ; override;

  end;
//---------------------------------------------------------------------------
  TOWBasicPinListPropertyEditor =
{$IFDEF I_PROP_EDITOR}
    class(TOWClassPropertyEditor)
  protected
    function  GetEditValue(out Value: String): Boolean; override;

{$ELSE}
    class(TPropertyEditor)
  protected
  {$IFNDEF FPC}
    FDesigner       : IDesigner;
  {$ENDIF}

{$ENDIF}
  protected
    FName           : String;
    FPin            : TOWBasicPin;
    FPinListEditor  : TOWPinListPropertyEditor;

  protected
    function GetIntDesigner() : TOWPropertyDesigner;

  public
    function  GetName() : TOWPropNameString; override;

    procedure SetValue(const Value: String); override;
    function  GetValue() : String; override;

  public
    function  GetPin() : TOWBasicPin;

  public
    constructor CreateEx( ADesigner : TOWPropertyDesigner; APin : TOWBasicPin; AName : String; PinListEditor : TOWPinListPropertyEditor );
    destructor  Destroy; override;
    
  end;
//---------------------------------------------------------------------------
  TOWSinkPinPropertyEditor = class(TOWBasicPinPropertyEditor)
  public
    function  GetAttributes() : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
  TOWMultiSinkPinPropertyEditor = class(TOWBasicPinPropertyEditor)
  public
    function  GetAttributes() : TPropertyAttributes; override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
  TOWSourcePinListPropertyEditor = class(TOWBasicPinListPropertyEditor)
  public
{$IFDEF D6}
    function  GetPropType() : PTypeInfo; override;
{$ENDIF}
    function  GetAttributes() : TPropertyAttributes; override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
  TOWSinkPinListPropertyEditor = class( TOWBasicPinListPropertyEditor )
  public
{$IFDEF D6}
    function  GetPropType() : PTypeInfo; override;
{$ENDIF}
    function  GetAttributes() : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
  TOWMultiSinkPinListPropertyEditor = class(TOWBasicPinListPropertyEditor)
  public
{$IFDEF D6}
    function  GetPropType() : PTypeInfo; override;
{$ENDIF}
    function  GetAttributes() : TPropertyAttributes; override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
  TOWStatePinListPropertyEditor = class(TOWBasicPinListPropertyEditor)
  public
{$IFDEF D6}
    function  GetPropType() : PTypeInfo; override;
{$ENDIF}
    function  GetAttributes() : TPropertyAttributes; override;
    procedure Edit(); override;

  end;
//---------------------------------------------------------------------------
function  OWGetPinValue( APin : TOWBasicPin; ADesigner : TOWPropertyDesigner ) : String;
function  OWSetPinValue( Root : TComponent; APin : TOWBasicPin; const Value: String ) : Boolean;
function  OWSourcePinEdit( Designer : TOWPropertyDesigner; SourcePin : TOWSourcePin ) : Boolean;
function  OWSinkPinEdit( Designer : TOWPropertyDesigner; SinkPin : TOWSinkPin ) : Boolean;
function  OWMultiSinkPinEdit( Designer : TOWPropertyDesigner; MultiSinkPin : TOWMultiSinkPin ) : Boolean;
procedure OWGetSinkPinValues( SinkPin : TOWSinkPin; Proc: TGetStrProc );
//---------------------------------------------------------------------------
procedure Register;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{$IFDEF FPC}
  uses Math, OWAboutFormUnit, OWStateEditors, OWAfterPinSelectFormUnit;
  type TADesignerSelectionList = TPersistentSelectionList;

{$ELSE}
  {$IFDEF D6}
{$WARN UNIT_DEPRECATED OFF}
    uses OWStateEditors, OWDesignSelectionsList, OWAboutFormUnit, Math, ToolsAPI, ToolIntf, ExptIntf,
{$WARN UNIT_DEPRECATED ON}
    {$IFDEF D17Up}
    System.UITypes,
    {$ELSE}
    {$ENDIF}
    OWAfterPinSelectFormUnit;
    type TADesignerSelectionList = TOWDesignerSelectionList;
  {$ELSE}
    uses ToolsAPI, ToolIntf, ExptIntf, ActiveX, OWAboutFormUnit, Math,
    OWStateEditors, OWAfterPinSelectFormUnit;
    type TADesignerSelectionList = TDesignerSelectionList;
  {$ENDIF}
{$ENDIF}

{$IFDEF BCB}
const
  SEPARATOR = '->';
{$ELSE}
const
  SEPARATOR = '.';
{$ENDIF}

{$IFDEF VER170} // Delphi 9.0
  {$R OpenWireResources2005.res}
{$ELSE}
  {$IFDEF VER180} // Delphi 10.0
    {$IFNDEF VER185} // Delphi 10.0
      {$R OpenWireResources2006.res}

    {$ELSE} // Delphi 11
      {$R OpenWireResources2007.res}

    {$ENDIF}

  {$ELSE} // Delphi 11 up
    {$IFDEF D14Up} // Delphi 14 and up
      {$R OpenWireResources2006.res}

    {$ELSE} // Delphi 14 and up
      {$R OpenWireResources2007.res}

    {$ENDIF}
  {$ENDIF}
{$ENDIF}

var GOWPinEditorForm : TOWPinEditorForm;

type TOWExposedPin = class(TOWBasicPin);
type TOWExposedSinkPin = class(TOWSinkPin);
type TOWExposedSourcePin = class(TOWSourcePin);
type TOWExposedPinList = class( TOWPinList );
//---------------------------------------------------------------------------
procedure GetSinkPinValueList( SinkPin : TOWSinkPin; List : TStrings );
begin
  if( SinkPin = NIL ) then
    Exit;

  OWGetPinsValueList( List, SinkPin, '.', [] );
end;
//---------------------------------------------------------------------------
procedure OWGetSinkPinValues( SinkPin : TOWSinkPin; Proc: TGetStrProc );
var
  Values : TStringList;
  I      : Integer;

begin
  Values := TStringList.Create;
  try
    GetSinkPinValueList( SinkPin, Values);
    Proc(GOWDISCONNECTED);
    for I := 0 to Values.Count - 1 do
      Proc(Values.Strings [i]);

    for I := 0 to OWGetDispatcherCount() - 1 do
      begin
      if( SinkPin.CanConnectToState( OWGetDispatcher( I ) ) ) then
        Proc( OWGetDispatcher( I ).Name );
        
      end;

  except
  end;
  Values.Free;

end;
//---------------------------------------------------------------------------
function OWGetPinValue( APin : TOWBasicPin; ADesigner : TOWPropertyDesigner ) : String;
begin
  try
    if( APin = NIL ) then
      begin
      Result := 'Refreshing ...';
      OWResetObjectInspector( ADesigner );
      end

    else
      Result := TOWExposedPin( APin ).GetEditorString();

  except
    Result := '(Error)';

  end;

end;
//---------------------------------------------------------------------------
function OWSetPinValue( Root : TComponent; APin : TOWBasicPin; const Value: String ) : Boolean;
begin
  Result := False;
  if( APin = NIL ) then
    Exit;

  Result := TOWExposedPin( APin ).SetEditorString( Root, Value );
end;
//---------------------------------------------------------------------------
function LinkToDisplayString( ARootComponent : TComponent; LinkStr : String; FullPath : Boolean; OwnRoot : Boolean; var PinStr : String ) : String;
var
  StrFull : String;
  Str     : String;
  iPos    : Integer;

begin
  if( not OwnRoot ) then
    begin
    iPos := Pos( '.', LinkStr );
    StrFull := LinkStr;
    Delete( StrFull, 1, iPos );
    end

  else
    StrFull := LinkStr;

  iPos := Pos( '.', StrFull );
  Str := StrFull;
  Delete( Str, 1, iPos );
  PinStr := Str;
  Str := StrFull;
  iPos := Pos( '.', Str );
  Delete( Str, iPos, 10000 );
  if( FullPath ) then
    if( ARootComponent <> NIL ) then
      Str := ARootComponent.Name + '.' + Str;

  Result := Str;
end;
//---------------------------------------------------------------------------
function OWGetPinValueEx( APin : TOWBasicPin; ADesigner : TOWPropertyDesigner; ACurrentRoot : TComponent ) : String;
var
  OwnRoot1      : Boolean;
  FullSinkPath  : Boolean;
  Str           : String;
  PinStr        : String;

begin
  if( not APin.IsConnected() ) then
    begin
    Result := '';
    Exit;
    end;

  Result := OWGetPinValue( APin, ADesigner );
  if( TOWExposedPin( APin ).GetConnectedPinCount() = 1 ) then
    begin
    OwnRoot1 := ( OWGetMainOwnerComponent( TOWExposedPin( APin ).GetConnectedPin( 0 ).Owner ) = OWGetMainOwnerComponent( APin.Owner ));
    FullSinkPath := ( OWGetMainOwnerComponent( TOWExposedPin( APin ).GetConnectedPin( 0 ).Owner ) <> ACurrentRoot );

    Str := LinkToDisplayString( OWGetMainOwnerComponent( TOWExposedPin( APin ).GetConnectedPin( 0 ).Owner ), Result, FullSinkPath, OwnRoot1, PinStr );
    Result := Str + '.' + PinStr;
    end;

end;
//---------------------------------------------------------------------------
function OWSinkPinEdit( Designer : TOWPropertyDesigner; SinkPin : TOWSinkPin ) : Boolean;
var
  I             : Integer;
  OtherPin      : TOWBasicPin;
  AfterPin      : TOWBasicPin;
  Dispatcher    : TOWStateDispatcher;
  SourceRoot    : TComponent;
  SourceChanged : Boolean;
  PinIdent      : String;

begin
  Result := False;
  if( SinkPin = NIL ) then
    Exit;

  try
    if( GOWPinEditorForm.ExecuteForSink( Designer, SinkPin ) = mrOk ) then
      begin
      for I := 0 to GOWPinEditorForm.Items.Count - 1 do
        begin
        Dispatcher := NIL;

        SourceChanged := False;
//        if( GOWPinEditorForm.Items [ I ].SubItems.Objects[ 0 ] is TOWPin ) then
          OtherPin := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ).ConnectedToPin; // TOWPin( GOWPinEditorForm.Items[ I ].SubItems.Objects[ 0 ] );

//        else if( GOWPinEditorForm.Items [ I ].SubItems.Objects[ 0 ] is TOWStateDispatcher ) then
//          Dispatcher := TOWStateDispatcher( GOWPinEditorForm.Items [ I ].SubItems.Objects[ 0 ] );

//        PinIdent := GOWPinEditorForm.Items[ I ].SubItems.Strings[ 4 ];
        PinIdent := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ).PinConnectIdent;
        if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
          begin
          if( Dispatcher <> NIL ) then
            begin
            if( not Dispatcher.IsConnectedTo( SinkPin )) then
              SourceChanged := True;

            end

          else if( OtherPin = NIL ) then
            begin
            if( not TOWExposedSinkPin( SinkPin ).IsConnectedToPinName( PinIdent )) then
              SourceChanged := True;

            end

          else
            begin
            if( SinkPin.SourcePin <> OtherPin ) then
              SourceChanged := True;

            end;
          end

        else
          begin
          if( Dispatcher <> NIL ) then
            begin
            if( Dispatcher.IsConnectedTo( SinkPin )) then
              SourceChanged := True;

            end

          else if( OtherPin = NIL ) then
            if( TOWExposedSinkPin( SinkPin ).IsConnectedToPinName( PinIdent )) then
              SourceChanged := True
              
          else
            begin
            if( SinkPin.SourcePin = OtherPin ) then
              SourceChanged := True;
              
            end;
          end;

        if( SourceChanged ) then
          begin
          { TODO : Modify the forms connected trough the Dispatcher }

{$IFDEF FPC}
          Designer.Modified( SinkPin );
{$ELSE}
          Designer.Modified();
{$ENDIF}
          if( OtherPin <> NIL ) then
            begin
            if( OtherPin is TOWPin ) then
              begin 
              SourceRoot := OWGetMainDesignOwner( TOWPin( OtherPin ).Owner );
              if( SourceRoot is TCustomForm ) then
                if( Assigned( TCustomForm( SourceRoot ).Designer )) then
                  TCustomForm( SourceRoot ).Designer.Modified();

              end;

            end;

          Break;
          end;

        end;

      SinkPin.Disconnect();
      for I := 0 to GOWPinEditorForm.Items.Count - 1 do
        begin
        Dispatcher := NIL;

        OtherPin := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ).ConnectedToPin;
        AfterPin := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ).ConnectedAfterPin;

        if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
          begin
          if( Dispatcher <> NIL ) then
            SinkPin.ConnectToStateAfter( Dispatcher, AfterPin )

          else
            begin
            if( OtherPin is TOWStatePin ) then
              begin
              if( TOWExposedPin( SinkPin ).FDispatcher <> NIL ) then
                OtherPin.ConnectToStateAfter( TOWExposedPin( SinkPin ).FDispatcher, AfterPin )

              else if( TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ).IsDispatcher ) then
                SinkPin.ConnectByStateAfter( OtherPin, AfterPin )
                
              else
                SinkPin.ConnectAfter( OtherPin, AfterPin );

              end

            else
              SinkPin.ConnectAfter( OtherPin, AfterPin );

            end;
            
          end;

        if( OtherPin <> NIL ) then
          TOWExposedPin( OtherPin ).SetInEditor( False );

        end;

      Result := True;
      end;

  finally
    GOWPinEditorForm.ClearData();
  end;

end;
//---------------------------------------------------------------------------
function OWMultiSinkPinEdit( Designer : TOWPropertyDesigner; MultiSinkPin : TOWMultiSinkPin ) : Boolean;
var
  I             : Integer;
  OtherPin      : TOWBasicPin;
  AfterPin      : TOWBasicPin;
  Dispatcher    : TOWStateDispatcher;
  SourceRoot    : TComponent;
  SourceChanged : Boolean;
  PinIdent      : String;
  AEntry        : TOWEItemEntry;

begin
  Result := False;
  if( MultiSinkPin = NIL ) then
    Exit;

  try
    if( GOWPinEditorForm.ExecuteForEventSink( Designer, MultiSinkPin ) = mrOk ) then
      begin
      for I := 0 to GOWPinEditorForm.Items.Count - 1 do
        begin
        Dispatcher := NIL;

        SourceChanged := False;
        AEntry := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ); 
        OtherPin := AEntry.ConnectedToPin;

        PinIdent := AEntry.PinConnectIdent;
        if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
          begin
          if( Dispatcher <> NIL ) then
            begin
            if( not Dispatcher.IsConnectedTo( MultiSinkPin )) then
              SourceChanged := True;

            end

          else if( OtherPin = NIL ) then
            begin
            if( not TOWExposedSinkPin( MultiSinkPin ).IsConnectedToPinName( PinIdent )) then
              SourceChanged := True;

            end

          else
            begin
            if( not MultiSinkPin.IsConnectedTo( OtherPin )) then
              SourceChanged := True;

            end;
          end

        else
          begin
          if( Dispatcher <> NIL ) then
            begin
            if( Dispatcher.IsConnectedTo( MultiSinkPin )) then
              SourceChanged := True;

            end

          else if( OtherPin = NIL ) then
            if( TOWExposedSinkPin( MultiSinkPin ).IsConnectedToPinName( PinIdent )) then
              SourceChanged := True
              
          else
            begin
            if( MultiSinkPin.IsConnectedTo( OtherPin )) then
              SourceChanged := True;
              
            end;
          end;

        if( SourceChanged ) then
          begin
          { TODO : Modify the forms connected trough the Dispatcher }

{$IFDEF FPC}
          Designer.Modified( MultiSinkPin );
{$ELSE}
          Designer.Modified();
{$ENDIF}
          if( OtherPin <> NIL ) then
            begin
            if( OtherPin is TOWPin ) then
              begin 
              SourceRoot := OWGetMainDesignOwner( TOWPin( OtherPin ).Owner );
              if( SourceRoot is TCustomForm ) then
                if( Assigned( TCustomForm( SourceRoot ).Designer )) then
                  TCustomForm( SourceRoot ).Designer.Modified();

              end;

            end;

          Break;
          end;

        end;

      MultiSinkPin.Disconnect();
      for I := 0 to GOWPinEditorForm.Items.Count - 1 do
        begin
        Dispatcher := NIL;

        AEntry := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data );
        OtherPin := AEntry.ConnectedToPin;
        AfterPin := AEntry.ConnectedAfterPin;

        if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
          begin
          if( Dispatcher <> NIL ) then
            MultiSinkPin.ConnectToStateAfter( Dispatcher, AfterPin )

          else
            begin
            if( OtherPin is TOWStatePin ) then
              begin
              if( TOWExposedPin( MultiSinkPin ).FDispatcher <> NIL ) then
                OtherPin.ConnectToStateAfter( TOWExposedPin( MultiSinkPin ).FDispatcher, AfterPin )

              else if( AEntry.IsDispatcher ) then
                MultiSinkPin.ConnectByStateAfter( OtherPin, AfterPin )
                
              else
                MultiSinkPin.ConnectAfter( OtherPin, AfterPin );

              end

            else
              MultiSinkPin.ConnectAfter( OtherPin, AfterPin );

            end;
            
          end;

        if( OtherPin <> NIL ) then
          TOWExposedPin( OtherPin ).SetInEditor( False );

        end;

      Result := True;
      end;

  finally
    GOWPinEditorForm.ClearData();
  end;

end;
//---------------------------------------------------------------------------
function OWSourcePinEdit( Designer : TOWPropertyDesigner; SourcePin : TOWSourcePin ) : Boolean;
var
  I             : Integer;
//  SinkPin       : TOWSinkPin;
  OtherPin      : TOWBasicPin;
  AfterPin      : TOWBasicPin;
  SinkRoot      : TComponent;
  SinkChanged   : Boolean;
  PinIdent      : String;
  AEntry        : TOWEItemEntry;

begin
  Result := False;

  if( SourcePin = NIL ) then
    Exit;

  try
    if( GOWPinEditorForm.ExecuteForSource( Designer, SourcePin ) = mrOk ) then
      begin
      for I := 0 to GOWPinEditorForm.Items.Count - 1 do
        begin
        SinkChanged := False;
        AEntry := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data );
        if( not( AEntry.ConnectedToPin is TOWPin )) then
          Continue;

        OtherPin := AEntry.ConnectedToPin;
//        AfterPin := AEntry.ConnectedAfterPin;
        if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
          begin
          if( OtherPin = NIL ) then
            begin
//            PinIdent := GOWPinEditorForm.Items[ I ].SubItems.Strings[ 4 ];
            PinIdent := AEntry.PinConnectIdent;
            if( not TOWExposedSourcePin( SourcePin ).IsConnectedToPinName( PinIdent )) then
              SinkChanged := True;
              
            end
              
          else
            begin
            if( not SourcePin.IsConnectedTo( OtherPin )) then
              SinkChanged := True;
              
            end;
          end

        else
          begin
          if( SourcePin.IsConnectedTo( OtherPin )) then
            SinkChanged := True;
            
          end;

        if( SinkChanged ) then
          begin
          if( OtherPin <> NIL ) then
            begin
            if( OtherPin is TOWPin ) then
              begin 
              SinkRoot := OWGetMainDesignOwner( TOWPin( OtherPin ).Owner );
              if( SinkRoot is TCustomForm ) then
                if( Assigned( TCustomForm( SinkRoot ).Designer )) then
                  TCustomForm( SinkRoot ).Designer.Modified();

              end;
            end;
          end;
        end;

      SourcePin.Disconnect();
      TOWExposedSourcePin( SourcePin ).SetInEditor( True );
      for I := 0 to GOWPinEditorForm.Items.Count - 1 do
        begin
        AEntry := TOWEItemEntry( GOWPinEditorForm.Items[ I ].Data ); 
        OtherPin := AEntry.ConnectedToPin;
        AfterPin := AEntry.ConnectedAfterPin;
        if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
          begin

          if( OtherPin <> NIL ) then
            SourcePin.ConnectAfter( OtherPin, AfterPin );

          end;

        if( OtherPin <> NIL ) then
          TOWExposedPin( OtherPin ).SetInEditor( False );
          
        end;

      Result := True;
      end;
      TOWExposedSourcePin( SourcePin ).SetInEditor( False );

  finally
    GOWPinEditorForm.ClearData();
  end;

end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TOWSourcePinPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
procedure TOWSourcePinPropertyEditor.Edit();
var
  SourcePin : TOWSourcePin;

begin
  OWRequestRefreshEx( GetIntDesigner() );
  SourcePin := TOWSourcePin( GetPin());
  if( OWSourcePinEdit( GetIntDesigner(), SourcePin )) then
    Modified();

end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TOWStatePinPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
procedure TOWStatePinPropertyEditor.Edit();
var
  StatePin : TOWStatePin;

begin
  OWRequestRefreshEx( GetIntDesigner() );
  StatePin := TOWStatePin( GetPin() );
  if( OWStatePinEdit( GetIntDesigner(), StatePin )) then
    Modified();

end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
constructor TOWBasicPinListPropertyEditor.CreateEx( ADesigner : TOWPropertyDesigner; APin : TOWBasicPin; AName : String; PinListEditor : TOWPinListPropertyEditor );
begin
  inherited Create( ADesigner, 1 );
{$IFNDEF FPC}
  FDesigner := ADesigner;
{$ENDIF}
  FPin  := APin;
  FName := AName;
  FPinListEditor := PinListEditor;
  TOWExposedPin( FPin ).CurrentEditorPtr := @FPin;
end;
//---------------------------------------------------------------------------
destructor TOWBasicPinListPropertyEditor.Destroy();
begin
  if( FPin <> NIL )then
    TOWExposedPin( FPin ).CurrentEditorPtr := NIL;
    
  inherited;
end;
//---------------------------------------------------------------------------
{$IFDEF D6}
function TOWBasicPinListPropertyEditor.GetEditValue(out Value: String): Boolean;
begin
  Value := GetValue();
  Result := True;
end;
{$ENDIF}
//---------------------------------------------------------------------------
function  TOWBasicPinListPropertyEditor.GetName() : TOWPropNameString;
begin
  Result := FName;
end;
//---------------------------------------------------------------------------
function  TOWBasicPinListPropertyEditor.GetIntDesigner() : TOWPropertyDesigner;
begin
{$IFDEF FPC}
  Result := PropertyHook;
{$ELSE}
  Result := Designer;
{$ENDIF}
end;
//---------------------------------------------------------------------------
procedure TOWBasicPinListPropertyEditor.SetValue(const Value: String);
var
  APin : TOWBasicPin;

begin
  APin := GetPin();
  if( OWSetPinValue( NIL, APin, Value )) then
    Modified();

end;
//---------------------------------------------------------------------------
function TOWBasicPinListPropertyEditor.GetValue() : String;
var
  APin : TOWBasicPin;

begin
  APin := GetPin();
  OWRequestRefreshEx( GetIntDesigner() );
  Result := OWGetPinValue( APin, GetIntDesigner() );
  FPinListEditor.CheckRefresh();
end;
//---------------------------------------------------------------------------
function TOWBasicPinListPropertyEditor.GetPin() : TOWBasicPin;
begin
  Result := FPin;
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TOWSourcePinListPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
{$IFDEF D6}
function TOWSourcePinListPropertyEditor.GetPropType() : PTypeInfo;
begin
  Result := TypeInfo( TOWSourcePin );
end;
{$ENDIF}
//---------------------------------------------------------------------------
procedure TOWSourcePinListPropertyEditor.Edit();
var
  SourcePin : TOWSourcePin;

begin
  SourcePin := TOWSourcePin( GetPin() );
  if( OWSourcePinEdit( GetIntDesigner(), SourcePin )) then
    Modified();
    
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
procedure TOWSinkPinPropertyEditor.Edit();
var
  SinkPin : TOWSinkPin;

begin
  OWRequestRefreshEx( GetIntDesigner() );
  SinkPin := TOWSinkPin( GetPin() );
  if( OWSinkPinEdit( GetIntDesigner(), SinkPin )) then
    Modified();

end;
//---------------------------------------------------------------------------
function TOWSinkPinPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [ paValueList, paSortList, paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
procedure TOWSinkPinPropertyEditor.GetValues(Proc: TGetStrProc);
var
  SinkPin : TOWSinkPin;

begin
  SinkPin := TOWSinkPin( GetPin() );
  OWGetSinkPinValues( SinkPin, Proc );
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TOWMultiSinkPinPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
procedure TOWMultiSinkPinPropertyEditor.Edit();
var
  MultiSinkPin : TOWMultiSinkPin;

begin
  OWRequestRefreshEx( GetIntDesigner() );
  MultiSinkPin := TOWMultiSinkPin( GetPin() );
  if( OWMultiSinkPinEdit( GetIntDesigner(), MultiSinkPin )) then
    Modified();
    
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
{$IFDEF D6}
function TOWSinkPinListPropertyEditor.GetPropType: PTypeInfo;
begin
  Result := TypeInfo( TOWSinkPin );
end;
{$ENDIF}
//---------------------------------------------------------------------------
procedure TOWSinkPinListPropertyEditor.Edit();
var
  SinkPin : TOWSinkPin;

begin
  SinkPin := TOWSinkPin( GetPin() );
  OWRequestRefreshEx( GetIntDesigner() );
  if( OWSinkPinEdit( GetIntDesigner(), SinkPin )) then
    Modified();

end;
//---------------------------------------------------------------------------
function TOWSinkPinListPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paValueList, paSortList, paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
procedure TOWSinkPinListPropertyEditor.GetValues(Proc: TGetStrProc);
var
  SinkPin : TOWSinkPin;

begin
  SinkPin := TOWSinkPin( GetPin() );
  OWGetSinkPinValues( SinkPin, Proc );
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
{$IFDEF D6}
function TOWMultiSinkPinListPropertyEditor.GetPropType: PTypeInfo;
begin
  Result := TypeInfo( TOWMultiSinkPin );
end;
{$ENDIF}
//---------------------------------------------------------------------------
procedure TOWMultiSinkPinListPropertyEditor.Edit();
var
  SinkPin : TOWMultiSinkPin;

begin
  OWRequestRefreshEx( GetIntDesigner() );
  SinkPin := TOWMultiSinkPin( GetPin() );
  if( OWMultiSinkPinEdit( GetIntDesigner(), SinkPin )) then
    Modified();
    
end;
//---------------------------------------------------------------------------
function TOWMultiSinkPinListPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
{$IFDEF D6}
function TOWStatePinListPropertyEditor.GetPropType: PTypeInfo;
begin
  Result := TypeInfo( TOWStatePin );
end;
{$ENDIF}
//---------------------------------------------------------------------------
procedure TOWStatePinListPropertyEditor.Edit();
var
  StatePin : TOWStatePin;

begin
  OWRequestRefreshEx( GetIntDesigner() );
  StatePin := TOWStatePin( GetPin() );
  if( OWStatePinEdit( GetIntDesigner(), StatePin )) then
    Modified();

end;
//---------------------------------------------------------------------------
function TOWStatePinListPropertyEditor.GetAttributes() : TPropertyAttributes;
begin
  Result := [ paDialog ];
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
{$IFNDEF FPC}
{$IFNDEF D6}
type TOWInputPinsCategory = class( TPropertyCategory )
  class function Name() : String; override;
  class function Description() : String; override;
end;
//---------------------------------------------------------------------------
class function TOWInputPinsCategory.Name() : String;
begin
  Result := 'Input Pins';
end;
//---------------------------------------------------------------------------
class function TOWInputPinsCategory.Description() : String;
begin
  Result := 'OpenWire Input Pins';
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
type TOWOutputPinsCategory = class( TPropertyCategory )
  class function Name() : String; override;
  class function Description() : String; override;
end;
//---------------------------------------------------------------------------
class function TOWOutputPinsCategory.Name() : String;
begin
  Result := 'Output Pins';
end;
//---------------------------------------------------------------------------
class function TOWOutputPinsCategory.Description() : String;
begin
  Result := 'OpenWire Output Pins';
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
type TOWStatePinsCategory = class( TPropertyCategory )
  class function Name() : String; override;
  class function Description() : String; override;
end;
//---------------------------------------------------------------------------
class function TOWStatePinsCategory.Name() : String;
begin
  Result := 'State Pins';
end;
//---------------------------------------------------------------------------
class function TOWStatePinsCategory.Description() : String;
begin
  Result := 'OpenWire State Pins';
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
type TOWPinListCategory = class( TPropertyCategory )
  class function Name() : String; override;
  class function Description() : String; override;
end;
//---------------------------------------------------------------------------
class function TOWPinListCategory.Name() : String;
begin
  Result := 'Pin Lists';
end;
//---------------------------------------------------------------------------
class function TOWPinListCategory.Description() : String;
begin
  Result := 'OpenWire Lists of Pins';
end;
{$ENDIF}
//---------------------------------------------------------------------------
{$IFDEF D9} // Delphi 9.0
var
  LogoBitmap : TBitmap = NIL;
{$ENDIF}
{$ENDIF}

procedure TOWPinEditorForm.LinkAllButtonClick(Sender: TObject);
var
  I : Integer;
begin
  for I := 0 to ListView.Items.Count - 1 do
//    ListView.Items [ I ].Checked := True;
    ListView.Items[ I ].StateIndex := ( ( TOWEItemEntry( ListView.Items[ I ].Data ).StateIndex ) or 1 );

end;

procedure TOWPinEditorForm.UnlinkAllButtonClick(Sender: TObject);
var
  I : Integer;
begin
  for I := 0 to ListView.Items.Count - 1 do
    ListView.Items[ I ].StateIndex := ( ( TOWEItemEntry( ListView.Items[ I ].Data ).StateIndex ) and 2 );
//    ListView.Items [ I ].Checked := False;

end;

procedure TOWPinEditorForm.RestoreButtonClick(Sender: TObject);
var
  I : Integer;
begin
  for I := 0 to ListView.Items.Count - 1 do
    ListView.Items[ I ].StateIndex := TImageIndex( TOWEItemEntry( ListView.Items[ I ].Data ).StateIndex );
    
end;

procedure TOWPinEditorForm.FormShow(Sender: TObject);
begin
  FillFormsInfo();
  UpdateLinksCount();
end;

procedure TOWPinEditorForm.FillFormsInfo();
var
  FormNames     : TOWModulesColection;
  I             : Integer;

{$IFDEF BDS2005_OR_HIGHER}
  CurProject    : IOTAProject;
  ModuleInfo    : IOTAModuleInfo;

{$ENDIF}

begin
  FormNames := TOWModulesColection.Create();

{$IFNDEF FPC}
{$IFNDEF BDS2005_OR_HIGHER}
  Designer.GetProjectModules( FormNames.GetModules );

{$ELSE}
  // Workaround for BDS 2005 and 2006 bug.
  CurProject := GetActiveProject();

  if( CurProject <> NIL ) then
    for I := 0 to CurProject.GetModuleCount() - 1 do
      begin
      ModuleInfo := CurProject.GetModule( I );

      FormNames.GetModules( ModuleInfo.FileName, ModuleInfo.Name, ModuleInfo.FormName, ModuleInfo.DesignClass, NIL );
      end;    

{$ENDIF}
{$ENDIF}

  FormsComboBox.Items.Clear();
  if( FormNames.Count = 0 ) then
    FormNames.Add( Root.Name );

  for I := 0 to FormNames.Count - 1 do
    begin
    if( OWCanAccessRootFromName( Designer, FormNames.Strings[ I ] ) ) then
      begin
      if( FormNames.Strings[ I ] = Root.Name ) then
        begin
        FormsComboBox.Items.Add( FormNames.Strings[ I ] + '  (Current)' );
        FormsComboBox.ItemIndex := FormsComboBox.Items.Count - 1;
        end

      else
        FormsComboBox.Items.Add( FormNames.Strings[ I ] );
        
      end;
    end;

  if( FormNames.Count > 1 ) then
    FormsComboBox.Items.Add( 'All forms' );

  PopulateAllEntries();
  if( FAllSelected ) then
    FormsComboBox.ItemIndex := FormsComboBox.Items.Count - 1;

  FormsComboBoxChange( Self );

  FormNames.Free();
end;

procedure TOWPinEditorForm.PopulateAllEntries();
var
  I             : Integer;             
  CurrentRoot   : TComponent;
  
begin
  PinsList.Clear();  
  for I := 0 to Max( FormsComboBox.Items.Count - 2, 0 ) do
    begin
    CurrentRoot := RootFromName( FormsComboBox.Items.Strings[ I ] );
    PopulateSingleFormEntries( NIL, CurrentRoot, True, not AllPinsCheckBox.Checked );
    end;

  RootFromName( Root.Name );
end;

procedure TOWPinEditorForm.PopulateAll();
var
  I             : Integer;             
  CurrentRoot   : TComponent;
  
begin
  ClearData();
  for I := 0 to FormsComboBox.Items.Count - 2 do
    begin
    CurrentRoot := RootFromName( FormsComboBox.Items.Strings[ I ] );
    PopulateSingleForm( NIL, CurrentRoot, False, True, not AllPinsCheckBox.Checked );
    end;

  RootFromName( Root.Name );
end;

procedure TOWPinEditorForm.PopulateForm( ARootComponent : TComponent );
var
  I           : Integer;
  CurrentRoot : TComponent;

begin
  ClearData();
  PopulateSingleForm( ARootComponent, ARootComponent, False, False, not AllPinsCheckBox.Checked );

  for I := 0 to FormsComboBox.Items.Count - 2 do
    begin
    CurrentRoot := RootFromName( FormsComboBox.Items.Strings[ I ] );
    if( ARootComponent <> CurrentRoot ) then
      PopulateSingleForm( ARootComponent, CurrentRoot, True, True, not AllPinsCheckBox.Checked );

    end;

end;

procedure TOWPinEditorForm.PopulateSingleFormEntries( CurrentRoot : TComponent; ARootComponent : TComponent; FullPath : Boolean; FilterPins : Boolean );
var
  Values        : TStringList;
  I             : Integer;
  OtherPin      : TOWPin;
  Entry         : TOWEPinEntry;
  iPos          : Integer;
  Str           : String;
  OwnRoot       : Boolean;
  OwnDataModule : Boolean;
  LinkName      : String;
  PinStr        : String;
  Dispatcher    : TOWBasicStateDispatcher;

begin
  Values := TStringList.Create;
  try
    OwnRoot := ( ARootComponent = OWGetMainOwnerComponent( FPin.Owner ));
    OwnDataModule := False;

    if( not OwnRoot ) then
      OwnDataModule := ( ARootComponent.Name = OWGetMainOwnerComponent( FPin.Owner ).Name );

    for I := 0 to OWGetDispatcherCount() - 1 do
      begin
      Dispatcher := OWGetDispatcher( I );
      if( not FPin.CanConnectToState( Dispatcher )) then
        Continue;

      Entry := TOWEPinEntry.Create();
      PinsList.Add( Entry );
      Entry.Dispatcher := Dispatcher;
      Entry.PinName := Dispatcher.Name;
      Entry.Checked := FPin.IsConnectedToState( Dispatcher );
      end;

    OWGetPinValueList( ARootComponent, FPin, Values, FilterPins );
    for I := 0 to Values.Count - 1 do
      begin
      OtherPin := TOWPin( Values.Objects[ I ] );

      if( FSourcePin <> NIL ) then
        begin
        if( ( not ( OtherPin is TOWSinkPin )) and ( not ( OtherPin is TOWStatePin )) ) then
          Continue;

        end
        
      else
        if( ( not ( OtherPin is TOWSourcePin )) and ( not ( OtherPin is TOWStatePin )) ) then
          Continue;

      if( OtherPin is TOWStatePin ) then
        if( OtherPin.IsConnected() ) then
          Continue; // Those pins are represented by the Dispatchers.

      Entry := TOWEPinEntry.Create();
      PinsList.Add( Entry );

      Str := LinkToDisplayString( ARootComponent, Values.Strings[ I ], FullPath, OwnRoot, PinStr );
      Entry.PinName := PinStr;

      Entry.OwnerName := Str; 
      Entry.Pin := OtherPin;
      if( not FPin.CanConnectTo( OtherPin )) then
        begin
        Entry.SavedChecked := False;
        Entry.Checked := False;
        end

      else
        begin
        LinkName := Values.Strings[ I ];
        if( OwnDataModule ) then
          begin
          iPos := Pos( '.', LinkName );
          Delete( LinkName, 1, iPos );
          end;

        Entry.SavedChecked := FPin.IsLinkedTo( LinkName );
        Entry.Checked := Entry.SavedChecked;
        end;
      end;

  finally
    Values.Free;

  end;

end;

procedure TOWPinEditorForm.PopulateSingleForm( CurrentRoot : TComponent; ARootComponent : TComponent; OnlyConnected : Boolean; FullPath : Boolean; FilterPins : Boolean );
begin
  ListUpdating := True;
  PopulateSingleFormInt( CurrentRoot, ARootComponent, OnlyConnected, FullPath, FilterPins ); 
  ListUpdating := False;
end;

function GetLinkType( APin : TOWBasicPin ) : String;
var
  ASinkPin : TOWBasicSinkPin;

begin
  if( APin is TOWBasicSinkPin ) then
    ASinkPin := TOWBasicSinkPin( APin )

  else
    begin
    Result := 'Unknown';
    Exit;
    end;

//  if( IsEqualGUID( ASinkPin.DownStreamID, ASinkPin.UpStreamID )) then
  if( ASinkPin.DownStreamLinkName = ASinkPin.UpStreamLinkName ) then
    begin
    if( ASinkPin.DownStreamLinkName <> '' ) then
      Result := 'Bi-directional ( ' + ASinkPin.DownStreamLinkName + ' )';

    end

  else
    begin
    if( ASinkPin.DownStreamLinkName <> '' ) then
      Result := 'Downstream ( ' + ASinkPin.DownStreamLinkName + ' )    ';

    if( ASinkPin.UpStreamLinkName <> '' ) then
      Result := Result + 'Upstream ( ' + ASinkPin.UpStreamLinkName + ' )';

    end;
    
end;

function TOWPinEditorForm.EntryFromPin( Pin : TOWBasicPin ) : TOWEPinEntry;
var
  I : Integer;
  
begin
  Result := NIL;
  for I := 0 to PinsList.Count - 1 do
    if( PinsList.Items[ I ].Pin = Pin ) then
      begin
      Result := PinsList.Items[ I ];
      Break;
      end;
    

end;

function TOWPinEditorForm.EntryFromDispatcher( Dispatcher : TOWBasicStateDispatcher ) : TOWEPinEntry;
var
  I : Integer;

begin
  Result := NIL;
  for I := 0 to PinsList.Count - 1 do
    if( PinsList.Items[ I ].Dispatcher = Dispatcher ) then
      begin
      Result := PinsList.Items[ I ];
      Break;
      end;


end;

procedure TOWPinEditorForm.PopulateSingleFormInt( CurrentRoot : TComponent; ARootComponent : TComponent; OnlyConnected : Boolean; FullPath : Boolean; FilterPins : Boolean );
var
  Values        : TStringList;
  I             : Integer;
  J             : Integer;
  AOtherPin     : TOWBasicPin;
  ASinkPin      : TOWSinkPin;
  Item          : TListItem;
  iPos          : Integer;
  Str           : String;
  LinkedTo      : String;
  LinkType      : String;
  NotifyAfter   : String;
  NotifyAfter1  : String;
  OwnRoot       : Boolean;
  OwnDataModule : Boolean;
  LinkName      : String;
  PinStr        : String;
  Dispatcher    : TOWBasicStateDispatcher;

  Entry         : TOWEPinEntry;
  Linked        : Boolean;

  ItemDataEntry : TOWEItemEntry;

begin
  Items.BeginUpdate();
  Values := TStringList.Create;
  try
    if( ARootComponent = NIL ) then
      ARootComponent := OWGetMainOwnerComponent( FPin.Owner );

    OwnRoot := ( ARootComponent = OWGetMainOwnerComponent( FPin.Owner ));
    OwnDataModule := False;

    if( not OwnRoot ) then
      OwnDataModule := ( ARootComponent.Name = OWGetMainOwnerComponent( FPin.Owner ).Name );

    for I := 0 to OWGetDispatcherCount() - 1 do
      begin
      Dispatcher := OWGetDispatcher( I );
      if( not FPin.CanConnectToState( Dispatcher )) then
        Continue;

      Entry := EntryFromDispatcher( Dispatcher );
      Item := Items.Add();
      

      Item.ImageIndex := -1;
      Item.Caption := Dispatcher.Name;

      ItemDataEntry := TOWEItemEntry.Create( Item, FPin );
      ItemDataEntry.IsDispatcher := True;
      Item.Data := ItemDataEntry;

      Item.SubItems.Add( Str );
      
      if( Dispatcher.Pins[ 0 ] = FPin ) then
        ItemDataEntry.ConnectedToPin := Dispatcher.Pins[ 1 ]
        
      else
        ItemDataEntry.ConnectedToPin := Dispatcher.Pins[ 0 ];

      Item.StateIndex := Ord( Entry.Checked );

      if( Dispatcher.PinCount = 2 ) then
        begin
        if( Dispatcher.Pins[ 0 ] = FPin ) then
          Item.SubItems.Add( Dispatcher.Pins[ 1 ].GetFullName( True ))

        else
          Item.SubItems.Add( Dispatcher.Pins[ 0 ].GetFullName( True ));

        end

      else
        Item.SubItems.Add( IntToStr( Dispatcher.PinCount - 1 ) + ' Pins' );

      if( FSourcePin = NIL ) then
        LinkType := GetLinkType( FPin )

      else
        begin
        if( Dispatcher.PinCount = 0 ) then
          LinkType := 'Unknown'
        
        else
          begin
          LinkType := FSourcePin.GetConnectionName( Dispatcher.Pins[ 0 ] );
          for J := 1 to Dispatcher.PinCount - 1 do
            begin
            if( FSourcePin <> Dispatcher[ J ] ) then 
              if( LinkType <> FSourcePin.GetConnectionName( Dispatcher[ J ] )) then
                begin
                LinkType := 'Multiple types';
                Break;
                end;
            
            end;          
          end;
        end;

      Item.SubItems.Add( Dispatcher.GetAfterPinDisplayName( FPin ));
      Item.SubItems.Add( LinkType );
      Item.SubItems.Add( Dispatcher.Name );
      end;

    OWGetPinValueList( ARootComponent, FPin, Values, FilterPins );
    for I := 0 to Values.Count - 1 do
      begin
      AOtherPin := TOWBasicPin( Values.Objects[ I ] );
      if( not ( AOtherPin is TOWStatePin ) ) then 
        if( FSourcePin = NIL ) then
          begin
          if( not ( AOtherPin is TOWSourcePin ) ) then
            Continue;

          end

        else
          begin
          if( not ( AOtherPin is TOWBasicSinkPin ) ) then
            Continue;
          
          end;

      if( AOtherPin is TOWStatePin ) then
        if( AOtherPin.IsConnected() ) then
          Continue; // Those pins are represented by the Dispatchers.

{
      if( OtherPin is TOWSourcePin ) then
        ASourcePin := TOWSourcePin( OtherPin )

      else
        ASourcePin := NIL;
}
      Entry := EntryFromPin( AOtherPin );
      if( OnlyConnected ) then
        begin
        if( Entry <> NIL ) then
          begin
          if( not Entry.Checked ) then
            Continue;
        
          end

        else
          if( not FMultiSinkPin.IsLinkedTo( Values.Strings[ I ] ) ) then
            Continue;

        end;

      Item := Items.Add();
      ItemDataEntry := TOWEItemEntry.Create( Item, AOtherPin ); //FPin );
      Item.Data := ItemDataEntry;

      if( AOtherPin.GetRoot() <> FPin.GetRoot() ) then
        Item.ImageIndex := 3

      else
        Item.ImageIndex := -1;

      Str := LinkToDisplayString( ARootComponent, Values.Strings [ I ], FullPath, OwnRoot, PinStr );
      Item.Caption := PinStr;

//      Item.SubItems.AddObject( Str, Values.Objects [ I ] );
      Item.SubItems.Add( Str );
      ItemDataEntry.ConnectedToPin := TOWBasicPin( Values.Objects [ I ] );
      if( FSourcePin = NIL ) then
        begin
        if( AOtherPin is TOWSourcePin ) then
          begin
          if( FPin.IsConnectedTo( AOtherPin )) then
            for J := 0 to AOtherPin.ConnectedPinCount - 1 do
              if( FPin = AOtherPin.ConnectedPin[ J ] ) then
                begin
                ItemDataEntry.ConnectedAfterPin := TOWBasicSinkPin( AOtherPin ).AfterPins[ J ];
                Break;
                end;

          end;
        end

      else
        begin
        if( AOtherPin is TOWBasicSinkPin ) then
          begin
          if( AOtherPin.IsConnectedTo( FPin )) then
            for J := 0 to FPin.ConnectedPinCount - 1 do
              if( AOtherPin = FPin.ConnectedPin[ J ] ) then
                begin
                ItemDataEntry.ConnectedAfterPin := TOWBasicSinkPin( FPin ).AfterPins[ J ];
                Break;
                end;
              
          end;
        end;

      if( not FPin.CanConnectTo( AOtherPin )) then
        begin
        Item.StateIndex := -1;
        ItemDataEntry.StateIndex := -1;
//        Item.Data := Pointer( -1 );
        end

      else
        begin
//        Item.Checked := ASourcePin.IsLinkedTo( FPin );
        LinkName := Values.Strings[ I ];
        if( OwnDataModule ) then
          begin
          iPos := Pos( '.', LinkName );
          Delete( LinkName, 1, iPos );
          end;

        Linked := TOWExposedPin( FPin ).IsLinkedTo( LinkName );

        if( Entry <> NIL ) then
          Item.StateIndex := Ord( Entry.Checked )

        else
          Item.StateIndex := Ord( Linked );

        if( AOtherPin is TOWMultiSinkPin ) then
          Item.StateIndex := Item.StateIndex or 2

        else if( AOtherPin is TOWStatePin ) then
          Item.StateIndex := Item.StateIndex or 4;

        ItemDataEntry.StateIndex := Item.StateIndex; 
//        Item.Data := Pointer( Item.StateIndex );
//        Item.StateIndex := Ord( Item.Checked );
        end;

      LinkType := '';
      NotifyAfter := '';
      LinkedTo := OWGetPinValueEx( AOtherPin, Designer, CurrentRoot );
      if( FSourcePin = NIL ) then
        begin
        NotifyAfter := AOtherPin.GetAfterPinDisplayName( FPin );
        if( AOtherPin.ConnectedPinCount > 0 ) then
          LinkType := GetLinkType( AOtherPin.ConnectedPin[ 0 ] );

        end

      else
        begin
        if( AOtherPin is TOWBasicSinkPin ) then
          begin
          if( AOtherPin.ConnectedPinCount = 1 ) then
            NotifyAfter := TOWSourcePin( AOtherPin.ConnectedPin[ 0 ] ).GetAfterPinDisplayName( TOWBasicSinkPin( AOtherPin ));
          
          if( AOtherPin is TOWSinkPin ) then
            begin
            ASinkPin := TOWSinkPin( AOtherPin );
            if( ASinkPin.SourcePin <> NIL ) then
              begin
              LinkType := GetLinkType( ASinkPin );
              NotifyAfter := TOWSourcePin( ASinkPin.SourcePin ).GetAfterPinDisplayName( ASinkPin );
              end;
            end

          else
            begin
            if( AOtherPin.ConnectedPinCount > 0 ) then
              begin
              LinkType := GetLinkType( AOtherPin );
              for J := 0 to AOtherPin.ConnectedPinCount - 1 do
                begin
                NotifyAfter1 := TOWSourcePin( AOtherPin.ConnectedPin[ J ] ).GetAfterPinDisplayName( TOWBasicSinkPin( AOtherPin ));
                if( NotifyAfter1 <> '' ) then
                  begin
                  if( NotifyAfter = '' ) then
                    NotifyAfter := '(' + NotifyAfter1

                  else
                    NotifyAfter := NotifyAfter + ', ' + NotifyAfter1;
                     
                  end;
                    
                end;

              if( NotifyAfter <> '' ) then
                NotifyAfter := NotifyAfter + ')';
                
              end;
            
            end;
          end;
        end;

      Item.SubItems.Add( LinkedTo );
      Item.SubItems.Add( NotifyAfter );
      Item.SubItems.Add( LinkType );
      Item.SubItems.Add( Values.Strings[ I ] );
      end;

    for I := 0 to FPin.ConnectedPinCount - 1 do
      begin
      if( FPin.ConnectedPin[ I ].GetRoot() = NIL ) then
        begin
        Item := Items.Add();

        ItemDataEntry := TOWEItemEntry.Create( Item, FPin );
        Item.Data := ItemDataEntry;

        ItemDataEntry.ConnectedToPin := FPin.ConnectedPin[ I ];

        Item.ImageIndex := 2;
        Item.StateIndex := 1;
        ItemDataEntry.StateIndex := Item.StateIndex;

        Item.Caption := FPin.ConnectedPin[ I ].GetName();
        Item.SubItems.Add( FPin.ConnectedPin[ I ].GetOwnerName() );
        Item.SubItems.Add( FPin.GetFullName( False ) );
        end;        
      end;
      
  finally
    Values.Free;
    for I := 0 to Items.Count - 1 do
      begin
      if( GOWPinEditorForm.Items [ I ].StateIndex and 1 > 0 ) then
        begin
        AOtherPin := TOWEItemEntry( Items[ I ].Data ).ConnectedToPin;
        TOWExposedPin( AOtherPin ).SetInEditor( True );
        end;
      end;

    Items.EndUpdate();

  end;

end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.OWMUpdateInspector(var Message: TMessage);
var
  List      : TADesignerSelectionList;
  Designer  : IADesigner;

begin
  GOWInRefresh := False;
{$IFNDEF FPC}
  Designer := IADesigner( Message.WParam );
  List := TADesignerSelectionList.Create();
  Designer.GetSelections( List );
  Designer.NoSelection();
  Designer.SetSelections( List );
  List.Free();
{$ENDIF}
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.OWMUpdateModifiedInspector(var Message: TMessage);
var
  Designer  : IADesigner;

begin
  OWMUpdateInspector( Message );
{$IFNDEF FPC}
  Designer := IADesigner( Message.WParam );
  Designer.Modified();
{$ENDIF}
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.OWMUpdate(var Message: TMessage);
begin
  OWLinkAwaitsLinkingAllForms();
end;
//---------------------------------------------------------------------------
function TOWPinEditorForm.ExecuteForSource( ADesigner : TOWPropertyDesigner; ASourcePin : TOWSourcePin ): Integer;
begin
  Designer := ADesigner;
  FPin := ASourcePin;
  FSourcePin := ASourcePin;
  FSinkPin := NIL;
  FMultiSinkPin := NIL;
  
{$IFDEF FPC}
  Root := OWGetMainDesignOwner( ASourcePin.Owner );
{$ELSE}
  Root := ADesigner.GetRoot();
{$ENDIF}

  LinkAllButton.Visible := True;
  UnlinkAllButton.Visible := True;

  ListView.Columns[0].Caption := 'Sink pin';
  ListView.Columns[2].Caption := 'Connected to';
  Caption := 'Connections - Source Pin : ' + OWValueToString( FSourcePin, '.', False, False );

  ListView.StateImages := SourcesImageList; 
  OWLinkAwaitsLinkingAllForms();
  Result := ShowModal();
end;
//---------------------------------------------------------------------------
function  TOWPinEditorForm.ExecuteForSink( ADesigner : TOWPropertyDesigner; ASinkPin : TOWSinkPin ): Integer;
begin
  Designer := ADesigner;
  FPin := ASinkPin;
  FSinkPin := ASinkPin;
  FSourcePin := NIL;
  FMultiSinkPin := NIL;

{$IFDEF FPC}
  Root := OWGetMainDesignOwner( ASinkPin.Owner );
{$ELSE}
  Root := ADesigner.GetRoot();
{$ENDIF}

  LinkAllButton.Visible := False;
  UnlinkAllButton.Visible := False;

  ListView.Columns[0].Caption := 'Source pin';
  ListView.Columns[2].Caption := 'Connections';
  Caption := 'Connections - Sink Pin : ' + OWValueToString( FSinkPin, '.', False, False );

  ListView.StateImages := SinksImageList;
  OWLinkAwaitsLinkingAllForms();
  Result := ShowModal();
end;
//---------------------------------------------------------------------------
function TOWPinEditorForm.ExecuteForEventSink( ADesigner : TOWPropertyDesigner; AMultiSinkPin : TOWMultiSinkPin ): Integer;
begin
  Designer := ADesigner;
  FPin := AMultiSinkPin;
  FMultiSinkPin := AMultiSinkPin;
  FSinkPin := NIL;
  FSourcePin := NIL;

{$IFDEF FPC}
  Root := OWGetMainDesignOwner( AMultiSinkPin.Owner );
{$ELSE}
  Root := ADesigner.GetRoot();
{$ENDIF}

  LinkAllButton.Visible := True;
  UnlinkAllButton.Visible := True;

  ListView.Columns[0].Caption := 'Source pin';
  ListView.Columns[2].Caption := 'Connections';
  Caption := 'Connections - Event Sink Pin : ' + OWValueToString( FSinkPin, '.', False, False );

  ListView.StateImages := SourcesImageList;
  OWLinkAwaitsLinkingAllForms();
  Result := ShowModal();
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.UpdateLinksCount();
var
  Counter  : Integer;
  I        : Integer;
  AEnabled : Boolean;
begin
  Counter := 0;
  for I := 0 to ListView.Items.Count - 1 do
    if( ( ListView.Items[ i ].ImageIndex and 1 ) > 0 ) then
      Inc( Counter );

  LinksCountLabel.Caption := IntToStr( Counter );
  AEnabled := ((( FSinkPin <> NIL ) or ( FMultiSinkPin <> NIL )) and ( ListView.ItemFocused <> NIL ) and ( ListView.ItemFocused.Checked ) );
  if( AEnabled ) then
  if( not( TOWEItemEntry( ListView.ItemFocused.Data ).ConnectedToPin is TOWSourcePin )) then
    if( TOWEItemEntry( ListView.ItemFocused.Data ).ConnectedToPin.ConnectedDispatcherCount = 0 ) then
      AEnabled := False;

  AfterPinButton.Enabled := AEnabled;
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.ClearData();
begin
  ListView.Items.Clear();
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.ListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);

begin
  if( ListUpdating ) then
    Exit;

  UpdateLinksCount();
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.ListViewColumnClick(Sender: TObject; Column: TListColumn);
begin
  ListView.Columns[ FColumnToSort ].ImageIndex := -1;

  if( FColumnToSort = Column.Index ) then
    FDirection := not FDirection

  else
    begin
    FDirection := True;
    FColumnToSort := Column.Index;
    end;

{$IFNDEF FPC}
  TCustomListView(Sender).AlphaSort();
{$ENDIF}

  ListView.Columns[ FColumnToSort].ImageIndex := Integer( not FDirection );
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.FormCreate(Sender: TObject);
begin
  PinsList      := TOWEPinsList.Create( True );
  FColumnToSort := 0;
  FDirection    := True;
  FAllSelected  := False;
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.FormDestroy(Sender: TObject);
begin
  PinsList.Free();
  GOWPinEditorForm := NIL;
end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.ListViewCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  DirMultiply : Integer;
  ix          : Integer;

begin
  if( FDirection ) then
    DirMultiply :=  1

  else
    DirMultiply := -1;

  if( FColumnToSort = 0 ) then
    Compare := DirMultiply * CompareText( Item1.Caption, Item2.Caption )

  else
    begin
    ix := FColumnToSort - 1;
    Compare := DirMultiply * CompareText( Item1.SubItems.Strings[ix], Item2.SubItems.Strings[ix] );
    end

end;

function TOWPinEditorForm.GetListItems() : TListItems;
begin
  Result := ListView.Items;
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function  TOWBasicPropertyEditor.GetIntDesigner() : TOWPropertyDesigner;
begin
{$IFDEF FPC}
  Result := PropertyHook;
{$ELSE}
  Result := Designer;
{$ENDIF}
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TOWBasicPinPropertyEditor.GetPin() : TOWPin;
begin
  Result := TOWPin( GetOrdValue());
end;
//---------------------------------------------------------------------------
procedure TOWBasicPinPropertyEditor.SetValue(const Value: String);
var
  APin  : TOWPin;

begin
  inherited SetValue( Value );

  APin := GetPin();
  if( OWSetPinValue( NIL, APin, Value )) then
    Modified();

end;
//---------------------------------------------------------------------------
function TOWBasicPinPropertyEditor.GetValue(): String;
var
  APin  : TOWPin;

begin
  APin := GetPin();
  OWRequestRefreshEx( GetIntDesigner() );
  Result := OWGetPinValue( APin, GetIntDesigner() );
end;
//---------------------------------------------------------------------------
{$IFDEF D7}
function TOWBasicPinPropertyEditor.GetIsDefault() : Boolean;
begin
  Result := not GetPin().IsConnected();
end;
{$ENDIF}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function  TOWPinListPropertyEditor.GetAttributes(): TPropertyAttributes;
begin
  Result := [ paSubProperties, paReadOnly, paVolatileSubProperties ]; //, paAutoUpdate ];
  
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
procedure TOWPinListPropertyEditor.CheckRefresh();
var
  ACollection : TOWPinList;
  
begin
  ACollection := TOWPinList( GetOrdValue() );
  if( TOWExposedPinList( ACollection ).LastIndicatedCount <> ACollection.Count ) then
    begin
    TOWExposedPinList( ACollection ).LastIndicatedCount := ACollection.Count;
    OWResetObjectInspector( GetIntDesigner() );
    end;
    
end;
//---------------------------------------------------------------------------
function TOWPinListPropertyEditor.GetValue(): String;
var
  ACollection : TOWPinList;
  
begin
  OWRequestRefreshEx( GetIntDesigner() );

  ACollection := TOWPinList( GetOrdValue() );
  if( TOWExposedPinList( ACollection ).LastIndicatedCount <> ACollection.Count ) then
    begin
    TOWExposedPinList( ACollection ).LastIndicatedCount := ACollection.Count;
    OWResetObjectInspector( GetIntDesigner() );
    end;

  if( ACollection.Count = 0 ) then
    begin
    Result := '(Empty)';
    Exit;
    end;

  if( ACollection.Count = 1 ) then
    begin
    Result := '1 Pin';
    Exit;
    end;

  Result := IntToStr( ACollection.Count ) + ' Pins';
end;
//---------------------------------------------------------------------------
procedure TOWPinListPropertyEditor.GetProperties(Proc: TAGetPropProc);
var
  ACollection : TOWPinList;
  I           : Integer;
  Pin         : TOWBasicPin;

begin
  ACollection := TOWPinList( GetOrdValue() );

  TOWExposedPinList( ACollection ).LastIndicatedCount := ACollection.Count;
  for I := 0 to ACollection.Count - 1 do
    begin
    try
      Pin := ACollection.Pins[ I ];
      if( Pin is TOWSourcePin ) then
        Proc( TOWSourcePinListPropertyEditor.CreateEx( GetIntDesigner(), TOWSourcePin( Pin ), ACollection.Names[ I ], Self ))

      else if( Pin is TOWSinkPin ) then
        Proc( TOWSinkPinListPropertyEditor.CreateEx( GetIntDesigner(), TOWSinkPin( Pin ), ACollection.Names[ I ], Self ))

      else if( Pin is TOWMultiSinkPin ) then
        Proc( TOWMultiSinkPinListPropertyEditor.CreateEx( GetIntDesigner(), TOWSinkPin( Pin ), ACollection.Names[ I ], Self ))

      else if( Pin is TOWStatePin ) then
        Proc( TOWStatePinListPropertyEditor.CreateEx( GetIntDesigner(), TOWSinkPin( Pin ), ACollection.Names[ I ], Self ))

    finally
      end;

    end;


end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function  TOWPinListOwnerPropertyEditor.GetAttributes(): TPropertyAttributes;
begin
  Result := [ paSubProperties, paVolatileSubProperties ]; //, paAutoUpdate ];
  
  OWRequestDesignerRefresh();
end;
//---------------------------------------------------------------------------
function  TOWPinListOwnerPropertyEditor.GetValue(): String;
var
  Collection : TOWPinList;

begin
  OWRequestRefreshEx( GetIntDesigner() );
//  OWLinkAwaitsLinking( Designer.Form );
  Collection := TOWPinList( GetOrdValue() );
  Result := IntToStr( Collection.Count );
end;
//---------------------------------------------------------------------------
procedure TOWPinListOwnerPropertyEditor.SetValue(const Value: String);
var
  ACollection : TOWPinList;

begin
  try
    ACollection := TOWPinList( GetOrdValue() );
    ACollection.Count := StrToInt( Value );
    Modified();
    OWResetObjectInspector( GetIntDesigner() );
      
  except;
    end;

end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
function TOWPinEditorForm.RootFromName( RootName : String ) : TComponent;
var
  RealName : String;
  iPos     : Integer;

  CurrentComp : TComponent;

begin
  RealName := RootName;
  iPos := Pos( ' ', RealName );
  if( iPos > 0 ) then
    Delete( RealName, iPos, 10000 );

  Result := Designer.GetComponent( RealName + SEPARATOR + RealName );
  if( Result = NIL ) then
    Result := Designer.GetComponent( RealName );

  CurrentComp := Result;
  if( CurrentComp <> NIL ) then 
    while( CurrentComp.Owner <> NIL ) do
      begin
      if( Result is TDataModule ) then
        Break;

      if( Result is TFrame ) then
        Break;

      if( ( CurrentComp.Owner is TCustomForm ) or ( CurrentComp.Owner is TFrame ) or ( CurrentComp.Owner is TDataModule ) ) then
        Result := CurrentComp.Owner;

      CurrentComp := CurrentComp.Owner
      end;

  if( Result = NIL ) then
    Result := Root;

end;
//---------------------------------------------------------------------------
procedure TOWPinEditorForm.FormsComboBoxChange(Sender: TObject);
var
  SelectedRoot : TComponent;
  FormName     : String;

begin
  SelectedRoot := NIL;
  FAllSelected := False;
  if( FormsComboBox.Items.Count > 1 ) then
    if( FormsComboBox.ItemIndex = FormsComboBox.Items.Count - 1 ) then
      begin
      PopulateAll();
      FAllSelected := True;
      Exit;
      end;

  if( FormsComboBox.ItemIndex <> -1 ) then
    begin
    FormName := FormsComboBox.Items.Strings[ FormsComboBox.ItemIndex ];
    SelectedRoot := RootFromName( FormName );
    end;

  PopulateForm( SelectedRoot );
end;


{$IFNDEF FPC}
type TIOWPinsEditorNotifier = class( TIAddInNotifier )
    procedure FileNotification(NotifyCode: TFileNotification;
      const FileName: String; var Cancel: Boolean); override; stdcall;
    procedure EventNotification(NotifyCode: TEventNotification;
      var Cancel: Boolean); override; stdcall;
end;

procedure TIOWPinsEditorNotifier.FileNotification(NotifyCode: TFileNotification;
      const FileName: String; var Cancel: Boolean);
begin
  if( NotifyCode <> fnFileOpened ) then
    Exit;

  OWRequestDesignerRefresh();
end;

procedure TIOWPinsEditorNotifier.EventNotification(NotifyCode: TEventNotification;
      var Cancel: Boolean);
begin
end;

var EditorNotifier : TIOWPinsEditorNotifier;
{$ENDIF}

procedure TOWPinEditorForm.Image1Click(Sender: TObject);
var
  AboutForm : TOWAboutForm;

begin
  AboutPanel.BevelInner := bvLowered;
  AboutForm := TOWAboutForm.Create( Self );
  AboutForm.ShowModal();
  AboutForm.Free();
  AboutPanel.BevelInner := bvRaised;
end;

procedure TOWPinEditorForm.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AboutPanel.BevelInner := bvLowered;
end;

procedure TOWPinEditorForm.Image1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AboutPanel.BevelInner := bvRaised;
end;

procedure TOWPinEditorForm.ChangeState( Item : TListItem );
var
  I : Integer;

begin
  if( Item = NIL ) then
    Exit;
    
  if( Item.StateIndex and 1 <> 0 ) then
    Item.StateIndex := Item.StateIndex and 2

  else
    begin
    if( FSinkPin <> NIL ) then
      begin
      if( Item.StateIndex < 2 ) then
        begin
        for I := 0 to ListView.Items.Count - 1 do
          if( ( ListView.Items[ I ].StateIndex < 2 ) or ( TOWEItemEntry( Item.Data ).ConnectedToPin is TOWBasicPin )) then
            ListView.Items[ I ].StateIndex := ListView.Items[ I ].StateIndex and 2;

        end

      else
        begin
        for I := 0 to ListView.Items.Count - 1 do
          if( TOWEItemEntry( ListView.Items[ I ].Data ).ConnectedToPin is TOWBasicPin ) then
            if( ListView.Items[ I ].StateIndex < 2 ) then
              ListView.Items[ I ].StateIndex := 0;
            
        end;
  //Form.Items [ I ].SubItems.Objects[ 0 ] is TOWPin

      end;

    Item.StateIndex := Item.StateIndex or 1;
    end;

//  Item.StateIndex := Item.StateIndex xor 1;
end;

procedure TOWPinEditorForm.ListViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Item : TListItem;

begin
  if( htOnStateIcon in ListView.GetHitTestInfoAt( X, Y )) then
    begin
    Item := ListView.GetItemAt( X, Y );
    Item.Selected := True;
    Item.Focused := True;
    ChangeState( Item );
    end;

end;

procedure TOWPinEditorForm.ListViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  if( Key = ' ' ) then
    begin
    ChangeState( ListView.ItemFocused );      
    Key := #0;
    end;
end;

procedure TOWPinEditorForm.ListViewDeletion(Sender: TObject;
  Item: TListItem);
begin
  TOWEItemEntry( Item.Data ).Free();
  Item.Data := NIL;
end;

procedure TOWPinEditorForm.AfterPinButtonClick(Sender: TObject);
var
  AForm  : TOWAfterPinSelectForm;
  AEntry : TOWEItemEntry;

begin
  AForm := TOWAfterPinSelectForm.Create( Self );
  AEntry := TOWEItemEntry( ListView.ItemFocused.Data ); 

  if( AEntry.ConnectedToPin is TOWSourcePin ) then
    AForm.FillFromSourcePin( FPin, TOWSourcePin( AEntry.ConnectedToPin ), AEntry.ConnectedAfterPin )

  else
    if( AEntry.ConnectedToPin.ConnectedDispatcherCount > 0 ) then
      AForm.FillFromDisparcher( FPin, AEntry.ConnectedToPin.ConnectedDispatcher[ 0 ], AEntry.ConnectedAfterPin );

  if( AForm.ShowModal() = mrOk ) then
    AEntry.ConnectedAfterPin := AForm.GetSelectedPin();

  AForm.Free();
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
constructor TOWEItemEntry.Create( AItem : TListItem; APin : TOWBasicPin );
begin
  inherited Create();
  FPin := APin;
  FItem := AItem;
  if( FItem = NIL ) then
    Exit;

    
end;
//---------------------------------------------------------------------------
procedure TOWEItemEntry.SetConnectedToPin( Value : TOWBasicPin );
begin
  FConnectedToPin := Value;
  Populate();
end;
//---------------------------------------------------------------------------
procedure TOWEItemEntry.SetConnectedAfterPin( Value : TOWBasicPin );
begin
  FConnectedAfterPin := Value;
  Populate();
end;
//---------------------------------------------------------------------------
procedure TOWEItemEntry.Populate();
begin
  if( FItem = NIL ) then
    Exit;

  if( FItem.SubItems.Count < 3 ) then
    Exit;
     
  FItem.Caption := FPin.GetName();
  FItem.SubItems[ 0 ] := FPin.GetOwnerName();
{
  if( FConnectedToPin = NIL ) then
    FItem.SubItems[ 1 ] := ''

  else
    FItem.SubItems[ 1 ] := FConnectedToPin.GetFullName( FPin.GetRoot() <> FConnectedToPin.GetRoot() );
}
  if( FConnectedAfterPin = NIL ) then
    FItem.SubItems[ 2 ] := ''

  else
    FItem.SubItems[ 2 ] := FConnectedAfterPin.GetFullName( FPin.GetRoot() <> FConnectedAfterPin.GetRoot() );
    
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
procedure Register;
begin
{$IFDEF D9} // Delphi 9.0
  LogoBitmap := TBitmap.Create();
  LogoBitmap.LoadFromResourceName( HInstance, 'OPENWIRELOGO' );
  if( SplashScreenServices <> nil ) then
    SplashScreenServices.AddProductBitmap( 'OpenWire', LogoBitmap.Handle );
    
  ForceDemandLoadState(dlDisable);
{$ENDIF}

{$IFNDEF FPC}
  {$IFDEF D6}
    RegisterPropertyInCategory( 'Input Pins',           TypeInfo(TOWSinkPin) );
    RegisterPropertyInCategory( 'Input Pins',           TypeInfo(TOWMultiSinkPin) );
    RegisterPropertyInCategory( 'Output Pins',          TypeInfo(TOWSourcePin) );
    RegisterPropertyInCategory( 'State Pins',           TypeInfo(TOWStatePin) );
    RegisterPropertyInCategory( 'Pin Lists',            TypeInfo(TOWPinList) );
  {$ELSE}
    RegisterPropertyInCategory( TOWInputPinsCategory,   TypeInfo(TOWSinkPin) );
    RegisterPropertyInCategory( TOWInputPinsCategory,   TypeInfo(TOWMultiSinkPin) );
    RegisterPropertyInCategory( TOWOutputPinsCategory,  TypeInfo(TOWSourcePin) );
    RegisterPropertyInCategory( TOWStatePinsCategory,   TypeInfo(TOWStatePin) );
    RegisterPropertyInCategory( TOWPinListCategory,     TypeInfo(TOWPinList) );
  {$ENDIF}
{$ENDIF}

  RegisterPropertyEditor( TypeInfo(TOWSourcePin),     NIL, '', TOWSourcePinPropertyEditor );
  RegisterPropertyEditor( TypeInfo(TOWMultiSinkPin),  NIL, '', TOWMultiSinkPinPropertyEditor );
  RegisterPropertyEditor( TypeInfo(TOWSinkPin),       NIL, '', TOWSinkPinPropertyEditor );
  RegisterPropertyEditor( TypeInfo(TOWStatePin),      NIL, '', TOWStatePinPropertyEditor );
  RegisterPropertyEditor( TypeInfo(TOWPinList),       NIL, '', TOWPinListPropertyEditor );
  RegisterPropertyEditor( TypeInfo(TOWPinListOwner),  NIL, '', TOWPinListOwnerPropertyEditor );
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
initialization
{$IFDEF FPC}
  {$i OpenWirePinEditors.lrs}
{$ENDIF}
  GOWPinEditorForm := TOWPinEditorForm.Create( Application );
  GOWRefreshForm := GOWPinEditorForm;
{$IFNDEF FPC}
  EditorNotifier := TIOWPinsEditorNotifier.Create();
  if( Assigned( ToolServices )) then
    ToolServices.AddNotifier( EditorNotifier );
{$ENDIF}

finalization
{$IFNDEF FPC}
  if( Assigned( ToolServices )) then
    ToolServices.RemoveNotifier( EditorNotifier );
{$ENDIF}

{$IFDEF D9} // Delphi 9.0
  LogoBitmap.Free();
{$ENDIF}
{$IFNDEF FPC}
  EditorNotifier.Free();
{$ENDIF}
  if( GOWPinEditorForm <> NIL ) then
    GOWPinEditorForm.Free();

  GOWPinEditorForm := NIL;
end.
