unit Mt3dSftUnit;

interface

uses ModflowCellUnit, Mt3dmsChemUnit, System.Classes, ModflowBoundaryUnit,
  GoPhastTypes, FormulaManagerUnit, SubscriptionUnit;

type
  TMt3dSftInitConcItem = class(TCustomMt3dmsConcItem)
  protected
    procedure AssignObserverEvents(Collection: TCollection); override;
//    procedure InvalidateModel; override;
  end;

  TMt3dSftInitConcTimeListLink = class(TCustomMt3dmsConcTimeListLink)
  protected
    procedure CreateTimeLists; override;
  end;

  TMt3dSftInitConcCollection = class(TCustomMt3dmsArrayConcCollection)
  private
    procedure InvalidateSftInitConc(Sender: TObject);
  protected
    // See @link(TCustomNonSpatialBoundColl.ItemClass
    // TCustomNonSpatialBoundColl.ItemClass)
    class function ItemClass: TBoundaryItemClass; override;
//    procedure InvalidateModel; override;
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
//    function ConcName: string; override;
  end;

  TMt3dSftDispItem = class(TCustomMt3dmsConcItem)
  protected
    procedure AssignObserverEvents(Collection: TCollection); override;
//    procedure InvalidateModel; override;
  end;

  TMt3dSftDispTimeListLink = class(TCustomMt3dmsConcTimeListLink)
  protected
    procedure CreateTimeLists; override;
  end;

  TMt3dSftDispCollection = class(TCustomMt3dmsArrayConcCollection)
  private
    procedure InvalidateSftInitConc(Sender: TObject);
  protected
    // See @link(TCustomNonSpatialBoundColl.ItemClass
    // TCustomNonSpatialBoundColl.ItemClass)
    class function ItemClass: TBoundaryItemClass; override;
//    procedure InvalidateModel; override;
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
//    function ConcName: string; override;
  end;

  TSftBoundaryType = (sbtHeadwater, sbtPrecipitation, sbtRunoff, sbtConstConc);

  TSftReachItem = class(TCustomMt3dmsConcItem)
  private
    function GetBoundaryType: TSftBoundaryType;
  protected
    procedure AssignObserverEvents(Collection: TCollection); override;
    procedure InvalidateModel; override;
    property BoundaryType: TSftBoundaryType read GetBoundaryType;
  end;

  TCustomSftReachTimeListLink = class(TCustomMt3dmsConcTimeListLink)
  private
    FBoundaryType: TSftBoundaryType;
    procedure SetBoundaryType(const Value: TSftBoundaryType);
  protected
    procedure CreateTimeLists; override;
  public
    property BoundaryType: TSftBoundaryType read FBoundaryType write SetBoundaryType;
  end;

  THeadWaterSftReachTimeListLink = class(TCustomSftReachTimeListLink)
    Constructor Create(AModel: TBaseModel;
      ABoundary: TCustomMF_BoundColl); override;
  end;

  TPrecipitationSftReachTimeListLink = class(TCustomSftReachTimeListLink)
    Constructor Create(AModel: TBaseModel;
      ABoundary: TCustomMF_BoundColl); override;
  end;

  TRunoffSftReachTimeListLink = class(TCustomSftReachTimeListLink)
    Constructor Create(AModel: TBaseModel;
      ABoundary: TCustomMF_BoundColl); override;
  end;

  TConstConcSftReachTimeListLink = class(TCustomSftReachTimeListLink)
    Constructor Create(AModel: TBaseModel;
      ABoundary: TCustomMF_BoundColl); override;
  end;

  TCustomMt3dSftReachCollection = class(TCustomMt3dmsArrayConcCollection)
  private
    FBoundaryType: TSftBoundaryType;
    procedure InvalidateSfrConc(Sender: TObject);
    procedure SetBoundaryType(const Value: TSftBoundaryType);
  protected
    // See @link(TCustomNonSpatialBoundColl.ItemClass
    // TCustomNonSpatialBoundColl.ItemClass)
    class function ItemClass: TBoundaryItemClass; override;
    procedure InvalidateModel; override;
    function ConcName: string; override;
  public
    property BoundaryType: TSftBoundaryType read FBoundaryType write SetBoundaryType;
  end;

  THeadWaterMt3dSftReachCollection = class(TCustomMt3dSftReachCollection)
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
  public
    constructor Create(Boundary: TModflowScreenObjectProperty;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TPrecipitationMt3dSftReachCollection = class(TCustomMt3dSftReachCollection)
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
  public
    constructor Create(Boundary: TModflowScreenObjectProperty;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TRunoffMt3dSftReachCollection = class(TCustomMt3dSftReachCollection)
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
  public
    constructor Create(Boundary: TModflowScreenObjectProperty;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

  TConstConcMt3dSftReachCollection = class(TCustomMt3dSftReachCollection)
  protected
    function GetTimeListLinkClass: TTimeListsModelLinkClass; override;
  public
    constructor Create(Boundary: TModflowScreenObjectProperty;
      Model: TBaseModel; ScreenObject: TObject); override;
  end;

{  TCustomMt3dSftReachBoundary = class(TCustomMt3dmsConcBoundary)
  protected
    // @name fills ValueTimeList with a series of TObjectLists - one for
    // each stress period.  Each such TObjectList is filled with
    // @link(TMt3dmsConc_Cell)s for that stress period.
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
  public
    // @name fills ValueTimeList via a call to AssignCells for each
    // link  @link(TMt3dmsConcStorage) in
    // @link(TCustomMF_BoundColl.Boundaries Values.Boundaries);
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
  end;

  THeadWaterMt3dSftReachBoundary = class(TCustomMt3dSftReachBoundary)
  protected
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
  public
    procedure InvalidateDisplay; override;
  end;

  TPrecipitationMt3dSftReachBoundary = class(TCustomMt3dSftReachBoundary)
  protected
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
  public
    procedure InvalidateDisplay; override;
  end;

  TRunoffMt3dSftReachBoundary = class(TCustomMt3dSftReachBoundary)
  protected
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
  public
    procedure InvalidateDisplay; override;
  end;

  TConstConcMt3dSftReachBoundary = class(TCustomMt3dSftReachBoundary)
  protected
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
  public
    procedure InvalidateDisplay; override;
  end;   }

  TSftObsLocation = (solNone, solFirst, solLast, solAll);

  TMt3dSftBoundary = class(TCustomMt3dmsConcBoundary)
  private
    FObsLocation: TSftObsLocation;
//    FInitialConcentrationObserver: TObserver;
//    FDispCoeffObserver: TObserver;
    FPrecipitation: TPrecipitationMt3dSftReachCollection;
    FRunOff: TRunoffMt3dSftReachCollection;
    FConstConc: TConstConcMt3dSftReachCollection;
    FInitialConcentration: TMt3dSftInitConcCollection;
    FDispersionCoefficient: TMt3dSftDispCollection;
    procedure SetObsLocation(const Value: TSftObsLocation);
    procedure SetConstConc(const Value: TConstConcMt3dSftReachCollection);
    procedure SetPrecipitation(
      const Value: TPrecipitationMt3dSftReachCollection);
    procedure SetRunOff(const Value: TRunoffMt3dSftReachCollection);
    procedure AssignSftCells(BoundaryStorage: TMt3dmsConcStorage;
      ValueTimeList: TList);
    procedure SetDispersionCoefficient(const Value: TMt3dSftDispCollection);
    procedure SetInitialConcentration(const Value: TMt3dSftInitConcCollection);
  protected
//    procedure HandleChangedValue(Observer: TObserver); override;
    // @name fills ValueTimeList with a series of TObjectLists - one for
    // each stress period.  Each such TObjectList is filled with
    // @link(TMt3dmsConc_Cell)s for that stress period.
    procedure AssignCells(BoundaryStorage: TCustomBoundaryStorage;
      ValueTimeList: TList; AModel: TBaseModel); override;
    class function BoundaryCollectionClass: TMF_BoundCollClass; override;
    procedure ClearBoundaries(AModel: TBaseModel); override;
    procedure InsertNewSpecies(SpeciesIndex: integer; const Name: string); override;
    procedure RenameSpecies(const OldSpeciesName, NewSpeciesName: string); override;
    procedure ChangeSpeciesPosition(OldIndex, NewIndex: integer); override;
    procedure DeleteSpecies(SpeciesIndex: integer); override;
    function Used: boolean; override;
    function BoundaryObserverPrefix: string; override;
  public
    Procedure Assign(Source: TPersistent); override;
    Constructor Create(Model: TBaseModel; ScreenObject: TObject);
    destructor Destroy; override;
    // @name fills ValueTimeList via a call to AssignCells for each
    // link  @link(TMt3dmsConcStorage) in
    // @link(TCustomMF_BoundColl.Boundaries Values.Boundaries);
    procedure GetCellValues(ValueTimeList: TList; ParamList: TStringList;
      AModel: TBaseModel); override;
    procedure Clear; override;
    procedure EvaluateArrayBoundaries(AModel: TBaseModel); override;
    procedure GetPrecipCells(PrecipTimeList: TList; AModel: TBaseModel);
    procedure GetRunOffCells(PrecipTimeList: TList; AModel: TBaseModel);
    procedure GetConstConcCells(PrecipTimeList: TList; AModel: TBaseModel);
    procedure Loaded;
  published
    property InitialConcentration: TMt3dSftInitConcCollection read FInitialConcentration
      write SetInitialConcentration;
    property DispersionCoefficient: TMt3dSftDispCollection read FDispersionCoefficient
      write SetDispersionCoefficient;
    property ObsLocation: TSftObsLocation read FObsLocation write SetObsLocation;
    property Precipitation: TPrecipitationMt3dSftReachCollection read FPrecipitation write SetPrecipitation;
    property RunOff: TRunoffMt3dSftReachCollection read FRunOff write SetRunOff;
    property ConstConc: TConstConcMt3dSftReachCollection read FConstConc write SetConstConc;
  end;

implementation

uses
  PhastModelUnit, Mt3dmsChemSpeciesUnit,
  frmGoPhastUnit, ModflowTimeUnit, ScreenObjectUnit;

resourcestring
  StrHeadwater = 'Headwater';
  StrPrecipitation = 'Precipitation';
  StrRunoff = 'Runoff';
  StrConstantConcentrati = 'Constant Concentration';

const
  InitialConcPosition = 0;
  DispCoeffPosition = 1;


{ TSftReachItem }

procedure TSftReachItem.AssignObserverEvents(Collection: TCollection);
var
  ParentCollection: TCustomMt3dSftReachCollection;
  ConcentrationObserver: TObserver;
  Index: integer;
begin
  ParentCollection := Collection as TCustomMt3dSftReachCollection;
  for Index := 0 to BoundaryFormulaCount - 1 do
  begin
    ConcentrationObserver := FObserverList[Index];
    ConcentrationObserver.OnUpToDateSet :=
      ParentCollection.InvalidateSfrConc;
  end;
end;

function TSftReachItem.GetBoundaryType: TSftBoundaryType;
var
  ParentCollection: TCustomMt3dSftReachCollection;
begin
  ParentCollection := Collection as TCustomMt3dSftReachCollection;
  result := ParentCollection.BoundaryType;
end;

procedure TSftReachItem.InvalidateModel;
var
  PhastModel: TPhastModel;
begin
  inherited;
  PhastModel := Model as TPhastModel;
  if (PhastModel <> nil)
    and not (csDestroying in PhastModel.ComponentState)
    and not PhastModel.Clearing then
  begin
    case BoundaryType of
      sbtHeadwater:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      sbtPrecipitation:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      sbtRunoff:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      sbtConstConc:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      else
        Assert(False);
    end;
  end;
end;

{ TSftReachTimeListLink }

procedure TCustomSftReachTimeListLink.CreateTimeLists;
var
  Index: Integer;
  SftConcData: TModflowTimeList;
  Item: TChemSpeciesItem;
  LocalModel: TPhastModel;
begin
  inherited;
  TimeLists.Clear;
  ListOfTimeLists.Clear;
  LocalModel := frmGoPhast.PhastModel;
  for Index := 0 to LocalModel.MobileComponents.Count - 1 do
  begin
    Item := LocalModel.MobileComponents[Index];
    SftConcData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
    case FBoundaryType of
      sbtHeadwater:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrHeadwater;
          SftConcData.ParamDescription := Item.Name +  StrHeadwater;
        end;
      sbtPrecipitation:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrPrecipitation;
          SftConcData.ParamDescription := Item.Name +  StrPrecipitation;
        end;
      sbtRunoff:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrRunoff;
          SftConcData.ParamDescription := Item.Name +  StrRunoff;
        end;
      sbtConstConc:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrConstantConcentrati;
          SftConcData.ParamDescription := Item.Name +  StrConstantConcentrati;
        end;
      else
        Assert(False);
    end;
    if Model <> nil then
    begin
//      SftConcData.OnInvalidate :=
//        (Model as TCustomModel).InvalidateUztRechConc;
    end;
    AddTimeList(SftConcData);
    ListOfTimeLists.Add(SftConcData);
  end;
  for Index := 0 to LocalModel.ImmobileComponents.Count - 1 do
  begin
    Item := LocalModel.ImmobileComponents[Index];
    SftConcData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
    case FBoundaryType of
      sbtHeadwater:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrHeadwater;
          SftConcData.ParamDescription := Item.Name +  StrHeadwater;
        end;
      sbtPrecipitation:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrPrecipitation;
          SftConcData.ParamDescription := Item.Name +  StrPrecipitation;
        end;
      sbtRunoff:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrRunoff;
          SftConcData.ParamDescription := Item.Name +  StrRunoff;
        end;
      sbtConstConc:
        begin
          SftConcData.NonParamDescription := Item.Name +  StrConstantConcentrati;
          SftConcData.ParamDescription := Item.Name +  StrConstantConcentrati;
        end;
      else
        Assert(False);
    end;
    if Model <> nil then
    begin
      case FBoundaryType of
        sbtHeadwater:
          begin
//            SftConcData.OnInvalidate :=
//              (Model as TCustomModel).InvalidateUztRechConc;
          end;
        sbtPrecipitation:
          begin
//            SftConcData.OnInvalidate :=
//              (Model as TCustomModel).InvalidateUztRechConc;
          end;
        sbtRunoff:
          begin
//            SftConcData.OnInvalidate :=
//              (Model as TCustomModel).InvalidateUztRechConc;
          end;
        sbtConstConc:
          begin
//            SftConcData.OnInvalidate :=
//              (Model as TCustomModel).InvalidateUztRechConc;
          end;
        else
          Assert(False);
      end;
    end;
    AddTimeList(SftConcData);
    ListOfTimeLists.Add(SftConcData);
  end;
end;

procedure TCustomSftReachTimeListLink.SetBoundaryType(const Value: TSftBoundaryType);
begin
  FBoundaryType := Value;
end;

{ TCustomMt3dSftReachCollection }

function TCustomMt3dSftReachCollection.ConcName: string;
begin
    case FBoundaryType of
      sbtHeadwater:
        begin
          result := StrHeadwater;
        end;
      sbtPrecipitation:
        begin
          result := StrPrecipitation;
        end;
      sbtRunoff:
        begin
          result := StrRunoff;
        end;
      sbtConstConc:
        begin
          result := StrConstantConcentrati;
        end;
      else
        Assert(False);
    end;
end;

procedure TCustomMt3dSftReachCollection.InvalidateModel;
var
  PhastModel: TPhastModel;
begin
  inherited;
  PhastModel := Model as TPhastModel;
  if (PhastModel <> nil)
    and not (csDestroying in PhastModel.ComponentState)
    and not PhastModel.Clearing then
  begin
    case BoundaryType of
      sbtHeadwater:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      sbtPrecipitation:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      sbtRunoff:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      sbtConstConc:
        begin
//          PhastModel.InvalidateUztRechConc(self);
        end;
      else
        Assert(False);
    end;
  end;
end;

procedure TCustomMt3dSftReachCollection.InvalidateSfrConc(Sender: TObject);
var
  PhastModel: TPhastModel;
  Link: TCustomSftReachTimeListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
  index: Integer;
  ATimeList: TModflowTimeList;
begin
  if not (Sender as TObserver).UpToDate then
  begin
    PhastModel := frmGoPhast.PhastModel;
    Link := TimeListLink.GetLink(PhastModel) as TCustomSftReachTimeListLink;
    for index := 0 to Link.TimeLists.Count - 1 do
    begin
      ATimeList := Link.TimeLists[index];
      ATimeList.Invalidate;
    end;
    for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
    begin
      ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
      Link := TimeListLink.GetLink(ChildModel) as TCustomSftReachTimeListLink;
      for index := 0 to Link.TimeLists.Count - 1 do
      begin
        ATimeList := Link.TimeLists[index];
        ATimeList.Invalidate;
      end;
    end;
  end;
end;

class function TCustomMt3dSftReachCollection.ItemClass: TBoundaryItemClass;
begin
  result := TSftReachItem;
end;

procedure TCustomMt3dSftReachCollection.SetBoundaryType(
  const Value: TSftBoundaryType);
begin
  FBoundaryType := Value;
end;

{ TCustomMt3dSftReachBoundary }

{procedure TCustomMt3dSftReachBoundary.AssignCells(
  BoundaryStorage: TCustomBoundaryStorage; ValueTimeList: TList;
  AModel: TBaseModel);
var
  Cell: TMt3dmsConc_Cell;
  BoundaryValues: TMt3dmsConcentrationRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TMt3dmsConcStorage;
  LocalModel: TCustomModel;
  LocalScreenObject: TScreenObject;
//  Grid: TCustomModelGrid;
begin
  LocalModel := AModel as TCustomModel;

  Assert(ScreenObject <> nil);
  LocalScreenObject := ScreenObject as TScreenObject;

  LocalBoundaryStorage := BoundaryStorage as TMt3dmsConcStorage;
  for TimeIndex := 0 to
    LocalModel.ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TMt3dmsConc_Cell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := LocalModel.ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime + LocalModel.SP_Epsilon >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime - LocalModel.SP_Epsilon <= LocalBoundaryStorage.EndingTime) then
    begin
      if Cells.Capacity < Cells.Count
        + Length(LocalBoundaryStorage.Mt3dmsConcArray) then
      begin
        Cells.Capacity := Cells.Count
          + Length(LocalBoundaryStorage.Mt3dmsConcArray)
      end;
      // Cells.CheckRestore;
      for BoundaryIndex := 0 to
        Length(LocalBoundaryStorage.Mt3dmsConcArray) - 1 do
      begin
        BoundaryValues := LocalBoundaryStorage.Mt3dmsConcArray[BoundaryIndex];
        Cell := TMt3dmsConc_Cell.Create;
        Cells.Add(Cell);

        LocalModel.AdjustCellPosition(Cell);
        Cell.IFace := LocalScreenObject.IFace;
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
        Cell.ScreenObject := ScreenObject;
        Cell.SetConcentrationLength(Length(Cell.Values.Concentration));
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

procedure TCustomMt3dSftReachBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TMt3dmsConcStorage;
begin
  EvaluateArrayBoundaries(AModel);
  for ValueIndex := 0 to Values.Count - 1 do
  begin
    if ValueIndex < Values.BoundaryCount[AModel] then
    begin
      BoundaryStorage := Values.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
  ClearBoundaries(AModel);
end;

{ THeadWaterSftReachTimeListLink }

constructor THeadWaterSftReachTimeListLink.Create(AModel: TBaseModel;
  ABoundary: TCustomMF_BoundColl);
begin
  inherited;
  FBoundaryType := sbtHeadwater;
end;

{ TPrecipitationSftReachTimeListLink }

constructor TPrecipitationSftReachTimeListLink.Create(AModel: TBaseModel;
  ABoundary: TCustomMF_BoundColl);
begin
  inherited;
  FBoundaryType := sbtPrecipitation;
end;

{ TRunoffSftReachTimeListLink }

constructor TRunoffSftReachTimeListLink.Create(AModel: TBaseModel;
  ABoundary: TCustomMF_BoundColl);
begin
  inherited;
  FBoundaryType := sbtRunoff;
end;

{ TConstConcSftReachTimeListLink }

constructor TConstConcSftReachTimeListLink.Create(AModel: TBaseModel;
  ABoundary: TCustomMF_BoundColl);
begin
  inherited;
  FBoundaryType := sbtConstConc;
end;

{ THeadWaterMt3dSftReachCollection }

constructor THeadWaterMt3dSftReachCollection.Create(
  Boundary: TModflowScreenObjectProperty; Model: TBaseModel;
  ScreenObject: TObject);
begin
  inherited;
  FBoundaryType := sbtHeadwater;
end;

function THeadWaterMt3dSftReachCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := THeadWaterSftReachTimeListLink;
end;

{ TPrecipitationMt3dSftReachCollection }

constructor TPrecipitationMt3dSftReachCollection.Create(
  Boundary: TModflowScreenObjectProperty; Model: TBaseModel;
  ScreenObject: TObject);
begin
  inherited;
  FBoundaryType := sbtPrecipitation;
end;

function TPrecipitationMt3dSftReachCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TPrecipitationSftReachTimeListLink;
end;

{ TRunoffMt3dSftReachCollection }

constructor TRunoffMt3dSftReachCollection.Create(
  Boundary: TModflowScreenObjectProperty; Model: TBaseModel;
  ScreenObject: TObject);
begin
  inherited;
  FBoundaryType := sbtRunoff;
end;

function TRunoffMt3dSftReachCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TRunoffSftReachTimeListLink;
end;

{ TConstConcMt3dSftReachCollection }

constructor TConstConcMt3dSftReachCollection.Create(
  Boundary: TModflowScreenObjectProperty; Model: TBaseModel;
  ScreenObject: TObject);
begin
  inherited;
  FBoundaryType := sbtConstConc;
end;

function TConstConcMt3dSftReachCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TConstConcSftReachTimeListLink;
end;

{ THeadWaterMt3dSftReachBoundary }

{class function THeadWaterMt3dSftReachBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := THeadWaterMt3dSftReachCollection;
end;

procedure THeadWaterMt3dSftReachBoundary.InvalidateDisplay;
var
  LocalModel: TPhastModel;
begin
  inherited;
  if Used and (ParentModel <> nil) then
  begin
    LocalModel := ParentModel as TPhastModel;
//    LocalModel.InvalidateUztRechConc(self);
  end;
end;

{ TPrecipitationMt3dSftReachBoundary }

{class function TPrecipitationMt3dSftReachBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TPrecipitationMt3dSftReachCollection;
end;

procedure TPrecipitationMt3dSftReachBoundary.InvalidateDisplay;
var
  LocalModel: TPhastModel;
begin
  inherited;
  if Used and (ParentModel <> nil) then
  begin
    LocalModel := ParentModel as TPhastModel;
//    LocalModel.InvalidateUztRechConc(self);
  end;
end;

{ TRunoffMt3dSftReachBoundary }

{class function TRunoffMt3dSftReachBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TRunoffMt3dSftReachCollection;
end;

procedure TRunoffMt3dSftReachBoundary.InvalidateDisplay;
var
  LocalModel: TPhastModel;
begin
  inherited;
  if Used and (ParentModel <> nil) then
  begin
    LocalModel := ParentModel as TPhastModel;
//    LocalModel.InvalidateUztRechConc(self);
  end;
end;

{ TConstConcMt3dSftReachBoundary }

{class function TConstConcMt3dSftReachBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := TConstConcMt3dSftReachCollection;
end;

procedure TConstConcMt3dSftReachBoundary.InvalidateDisplay;
var
  LocalModel: TPhastModel;
begin
  inherited;
  if Used and (ParentModel <> nil) then
  begin
    LocalModel := ParentModel as TPhastModel;
//    LocalModel.InvalidateUztRechConc(self);
  end;
end;

{ TSftSteadyBoundary }

procedure TMt3dSftBoundary.Assign(Source: TPersistent);
var
  SftBoundary: TMt3dSftBoundary;
begin
  if Source is TMt3dSftBoundary then
  begin
    SftBoundary := TMt3dSftBoundary(Source);
    InitialConcentration := SftBoundary.InitialConcentration;
    DispersionCoefficient := SftBoundary.DispersionCoefficient;
    ObsLocation := SftBoundary.ObsLocation;

    Precipitation := SftBoundary.Precipitation;
    RunOff := SftBoundary.RunOff;
    ConstConc := SftBoundary.ConstConc;
  end;
  inherited;

end;

procedure TMt3dSftBoundary.AssignCells(
  BoundaryStorage: TCustomBoundaryStorage; ValueTimeList: TList;
  AModel: TBaseModel);
var
  Cell: TMt3dmsConc_Cell;
  BoundaryValues: TMt3dmsConcentrationRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TMt3dmsConcStorage;
  LocalModel: TCustomModel;
  LocalScreenObject: TScreenObject;
//  Grid: TCustomModelGrid;
begin
  LocalModel := AModel as TCustomModel;

  Assert(ScreenObject <> nil);
  LocalScreenObject := ScreenObject as TScreenObject;

  LocalBoundaryStorage := BoundaryStorage as TMt3dmsConcStorage;
  for TimeIndex := 0 to
    LocalModel.ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TMt3dmsConc_Cell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := LocalModel.ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime + LocalModel.SP_Epsilon >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime - LocalModel.SP_Epsilon <= LocalBoundaryStorage.EndingTime) then
    begin
      if Cells.Capacity < Cells.Count
        + Length(LocalBoundaryStorage.Mt3dmsConcArray) then
      begin
        Cells.Capacity := Cells.Count
          + Length(LocalBoundaryStorage.Mt3dmsConcArray)
      end;
      // Cells.CheckRestore;
      for BoundaryIndex := 0 to
        Length(LocalBoundaryStorage.Mt3dmsConcArray) - 1 do
      begin
        BoundaryValues := LocalBoundaryStorage.Mt3dmsConcArray[BoundaryIndex];
        Cell := TMt3dmsConc_Cell.Create;
        Cells.Add(Cell);

        LocalModel.AdjustCellPosition(Cell);
        Cell.IFace := LocalScreenObject.IFace;
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
        Cell.ScreenObject := ScreenObject;
        Cell.SetConcentrationLength(Length(Cell.Values.Concentration));
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

procedure TMt3dSftBoundary.AssignSftCells(BoundaryStorage: TMt3dmsConcStorage;
  ValueTimeList: TList);
var
  Cell: TMt3dmsConc_Cell;
  BoundaryValues: TMt3dmsConcentrationRecord;
  BoundaryIndex: Integer;
  StressPeriod: TModflowStressPeriod;
  TimeIndex: Integer;
  Cells: TValueCellList;
  LocalBoundaryStorage: TMt3dmsConcStorage;
begin
  LocalBoundaryStorage := BoundaryStorage;// as TEvtStorage;
  for TimeIndex := 0 to
    (ParentModel as TPhastModel).ModflowFullStressPeriods.Count - 1 do
  begin
    if TimeIndex < ValueTimeList.Count then
    begin
      Cells := ValueTimeList[TimeIndex];
    end
    else
    begin
      Cells := TValueCellList.Create(TMt3dmsConc_Cell);
      ValueTimeList.Add(Cells);
    end;
    StressPeriod := (ParentModel as TPhastModel).ModflowFullStressPeriods[TimeIndex];
    // Check if the stress period is completely enclosed within the times
    // of the LocalBoundaryStorage;
    if (StressPeriod.StartTime >= LocalBoundaryStorage.StartingTime)
      and (StressPeriod.EndTime <= LocalBoundaryStorage.EndingTime) then
    begin
//      Cells.CheckRestore;
      for BoundaryIndex := 0 to Length(LocalBoundaryStorage.Mt3dmsConcArray) - 1 do
      begin
//        Cells.Cached := False;
        BoundaryValues := LocalBoundaryStorage.Mt3dmsConcArray[BoundaryIndex];
        Cell := TMt3dmsConc_Cell.Create;
        Cells.Add(Cell);
        Cell.StressPeriod := TimeIndex;
        Cell.Values := BoundaryValues;
        Cell.SetConcentrationLength(Length(BoundaryValues.Concentration));
      end;
      Cells.Cache;
    end;
  end;
  LocalBoundaryStorage.CacheData;
end;

class function TMt3dSftBoundary.BoundaryCollectionClass: TMF_BoundCollClass;
begin
  result := THeadWaterMt3dSftReachCollection;
end;

function TMt3dSftBoundary.BoundaryObserverPrefix: string;
begin
  result := 'Sft';
end;

procedure TMt3dSftBoundary.ChangeSpeciesPosition(OldIndex, NewIndex: integer);
var
  SftItem: TCustomBoundaryItem;
begin
  inherited;
  Precipitation.ChangeSpeciesItemPosition(OldIndex, NewIndex);
  Precipitation.ChangeSpeciesTimeListPosition(OldIndex, NewIndex);

  RunOff.ChangeSpeciesItemPosition(OldIndex, NewIndex);
  RunOff.ChangeSpeciesTimeListPosition(OldIndex, NewIndex);

  ConstConc.ChangeSpeciesItemPosition(OldIndex, NewIndex);
  ConstConc.ChangeSpeciesTimeListPosition(OldIndex, NewIndex);

  SftItem := FInitialConcentration.Items[OldIndex];
  SftItem.Index := NewIndex;

  SftItem := FDispersionCoefficient.Items[OldIndex];
  SftItem.Index := NewIndex;

end;

procedure TMt3dSftBoundary.Clear;
begin
  inherited;
  FPrecipitation.Clear;
  FRunOff.Clear;
  FConstConc.Clear;

  FInitialConcentration.Clear;
  FDispersionCoefficient.Clear;
end;

procedure TMt3dSftBoundary.ClearBoundaries(AModel: TBaseModel);
begin
  inherited;
  Precipitation.ClearBoundaries(AModel);
  RunOff.ClearBoundaries(AModel);
  ConstConc.ClearBoundaries(AModel);

end;

constructor TMt3dSftBoundary.Create(Model: TBaseModel; ScreenObject: TObject);
begin
  inherited;
//  CreateFormulaObjects;
  CreateBoundaryObserver;

//  CreateObservers;

  FPrecipitation := TPrecipitationMt3dSftReachCollection.Create(Self, Model, ScreenObject);
  FRunOff := TRunoffMt3dSftReachCollection.Create(Self, Model, ScreenObject);
  FConstConc := TConstConcMt3dSftReachCollection.Create(Self, Model, ScreenObject);

  FInitialConcentration := TMt3dSftInitConcCollection.Create(Self, Model, ScreenObject);

  FDispersionCoefficient:= TMt3dSftDispCollection.Create(self, Model,
    ScreenObject);
end;


procedure TMt3dSftBoundary.DeleteSpecies(SpeciesIndex: integer);
begin
  inherited;
  Precipitation.DeleteSpecies(SpeciesIndex);
  RunOff.DeleteSpecies(SpeciesIndex);
  ConstConc.DeleteSpecies(SpeciesIndex);

  FInitialConcentration.DeleteSpecies(SpeciesIndex);
  FDispersionCoefficient.DeleteSpecies(SpeciesIndex);
end;

destructor TMt3dSftBoundary.Destroy;
begin
//  InitialConcentration := '0';
//  DispersionCoefficient := '0';
  FPrecipitation.Free;
  FRunOff.Free;
  FConstConc.Free;


  FInitialConcentration.Free;
  FDispersionCoefficient.Free;
  inherited;
end;

procedure TMt3dSftBoundary.EvaluateArrayBoundaries(AModel: TBaseModel);
begin
  inherited;
  Precipitation.EvaluateArrayBoundaries(AModel);
  RunOff.EvaluateArrayBoundaries(AModel);
  ConstConc.EvaluateArrayBoundaries(AModel);
end;

procedure TMt3dSftBoundary.GetCellValues(ValueTimeList: TList;
  ParamList: TStringList; AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TMt3dmsConcStorage;
begin
  EvaluateArrayBoundaries(AModel);
  for ValueIndex := 0 to Values.Count - 1 do
  begin
    if ValueIndex < Values.BoundaryCount[AModel] then
    begin
      BoundaryStorage := Values.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
  for ValueIndex := 0 to Precipitation.Count - 1 do
  begin
    if ValueIndex < Precipitation.BoundaryCount[AModel] then
    begin
      BoundaryStorage := Precipitation.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
  for ValueIndex := 0 to RunOff.Count - 1 do
  begin
    if ValueIndex < RunOff.BoundaryCount[AModel] then
    begin
      BoundaryStorage := RunOff.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
  for ValueIndex := 0 to ConstConc.Count - 1 do
  begin
    if ValueIndex < ConstConc.BoundaryCount[AModel] then
    begin
      BoundaryStorage := ConstConc.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignCells(BoundaryStorage, ValueTimeList, AModel);
    end;
  end;
  ClearBoundaries(AModel);
end;

procedure TMt3dSftBoundary.GetConstConcCells(PrecipTimeList: TList;
  AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TMt3dmsConcStorage;
begin
  for ValueIndex := 0 to ConstConc.Count - 1 do
  begin
    if ValueIndex < ConstConc.BoundaryCount[AModel] then
    begin
      BoundaryStorage := ConstConc.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignSftCells(BoundaryStorage, PrecipTimeList);
    end;
  end;
end;


procedure TMt3dSftBoundary.GetPrecipCells(PrecipTimeList: TList;
  AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TMt3dmsConcStorage;
begin
  for ValueIndex := 0 to Precipitation.Count - 1 do
  begin
    if ValueIndex < Precipitation.BoundaryCount[AModel] then
    begin
      BoundaryStorage := Precipitation.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignSftCells(BoundaryStorage, PrecipTimeList);
    end;
  end;
end;


procedure TMt3dSftBoundary.GetRunOffCells(PrecipTimeList: TList;
  AModel: TBaseModel);
var
  ValueIndex: Integer;
  BoundaryStorage: TMt3dmsConcStorage;
begin
  for ValueIndex := 0 to RunOff.Count - 1 do
  begin
    if ValueIndex < RunOff.BoundaryCount[AModel] then
    begin
      BoundaryStorage := RunOff.Boundaries[ValueIndex, AModel] as TMt3dmsConcStorage;
      AssignSftCells(BoundaryStorage, PrecipTimeList);
    end;
  end;
end;

procedure TMt3dSftBoundary.InsertNewSpecies(SpeciesIndex: integer;
  const Name: string);
var
  SftItem: TCollectionItem;
begin
  inherited;
  Precipitation.InsertNewSpecies(SpeciesIndex, Name);
  RunOff.InsertNewSpecies(SpeciesIndex, Name);
  ConstConc.InsertNewSpecies(SpeciesIndex, Name);

  SftItem := FInitialConcentration.Add;
  SftItem.Index := SpeciesIndex;

  SftItem := FDispersionCoefficient.Add;
  SftItem.Index := SpeciesIndex;
end;

procedure TMt3dSftBoundary.Loaded;
begin
//  FInitialConcentration.Loaded;
//  FDispersionCoefficient.Loaded;
end;

procedure TMt3dSftBoundary.RenameSpecies(const OldSpeciesName,
  NewSpeciesName: string);
begin
  inherited;
  Precipitation.RenameTimeList(OldSpeciesName, NewSpeciesName);
  Precipitation.RenameItems(OldSpeciesName, NewSpeciesName);

  RunOff.RenameTimeList(OldSpeciesName, NewSpeciesName);
  RunOff.RenameItems(OldSpeciesName, NewSpeciesName);

  ConstConc.RenameTimeList(OldSpeciesName, NewSpeciesName);
  ConstConc.RenameItems(OldSpeciesName, NewSpeciesName);

end;

//procedure TSftSteadyBoundary.HandleChangedValue(Observer: TObserver);
//begin
//  inherited;
//
//end;

procedure TMt3dSftBoundary.SetConstConc(
  const Value: TConstConcMt3dSftReachCollection);
begin
  FConstConc.Assign(Value);
end;

procedure TMt3dSftBoundary.SetDispersionCoefficient(
  const Value: TMt3dSftDispCollection);
begin
  FDispersionCoefficient.Assign(Value);
end;

procedure TMt3dSftBoundary.SetInitialConcentration(
  const Value: TMt3dSftInitConcCollection);
begin
  FInitialConcentration.Assign(Value);
end;

procedure TMt3dSftBoundary.SetObsLocation(const Value: TSftObsLocation);
begin
  if FObsLocation <> Value then
  begin
    FObsLocation := Value;
    InvalidateModel;
  end;
end;

procedure TMt3dSftBoundary.SetPrecipitation(
  const Value: TPrecipitationMt3dSftReachCollection);
begin
  FPrecipitation.Assign(Value);
end;

procedure TMt3dSftBoundary.SetRunOff(
  const Value: TRunoffMt3dSftReachCollection);
begin
  FRunOff.Assign(Value);
end;

function TMt3dSftBoundary.Used: boolean;
begin
  result := inherited Used
    or Precipitation.Used
    or RunOff.Used
    or ConstConc.Used
//    or (InitialConcentration <> '0')
//    or (DispersionCoefficient <> '0')
    or (ObsLocation <> solNone)
end;

{ TMt3dSftInitConcItem }

procedure TMt3dSftInitConcItem.AssignObserverEvents(Collection: TCollection);
var
  ParentCollection: TMt3dSftInitConcCollection;
  InitConcObserver: TObserver;
//  ScreenTopObserver: TObserver;
//  SkinKObserver: TObserver;
//  SkinRadiusObserver: TObserver;
begin
  ParentCollection := Collection as TMt3dSftInitConcCollection;

//  InitConcObserver := FObserverList[InitConcPosition];
//  InitConcObserver.OnUpToDateSet := ParentCollection.InvalidateLktConc;
end;

{ TMt3dSftInitConcTimeListLink }

procedure TMt3dSftInitConcTimeListLink.CreateTimeLists;
var
  Index: Integer;
//  Mt3dmsConcData: TModflowTimeList;
//  Item: TChemSpeciesItem;
  LocalModel: TPhastModel;
begin
  TimeLists.Clear;
//  FListOfTimeLists.Clear;
  LocalModel := frmGoPhast.PhastModel;
  for Index := 0 to LocalModel.MobileComponents.Count - 1 do
  begin
//    Item := LocalModel.MobileComponents[Index];
//    Mt3dmsConcData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
//    Mt3dmsConcData.NonParamDescription := Item.Name +  StrConcentration;
//    Mt3dmsConcData.ParamDescription := Item.Name +  StrConcentrationMulti;
//    if Model <> nil then
//    begin
//      Mt3dmsConcData.OnInvalidate :=
//        (Model as TCustomModel).InvalidateMt3dmsChemSources;
//    end;
//    AddTimeList(Mt3dmsConcData);
//    FListOfTimeLists.Add(Mt3dmsConcData);
    AddTimeList(nil);
//    FListOfTimeLists.Add(nil);
  end;
  for Index := 0 to LocalModel.ImmobileComponents.Count - 1 do
  begin
//    Item := LocalModel.ImmobileComponents[Index];
//    Mt3dmsConcData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
//    Mt3dmsConcData.NonParamDescription := Item.Name +  StrConcentration;
//    Mt3dmsConcData.ParamDescription := Item.Name +  StrConcentrationMulti;
//    if Model <> nil then
//    begin
//      Mt3dmsConcData.OnInvalidate :=
//        (Model as TCustomModel).InvalidateMt3dmsChemSources;
//    end;
//    AddTimeList(Mt3dmsConcData);
//    FListOfTimeLists.Add(Mt3dmsConcData);
    AddTimeList(nil);
//    FListOfTimeLists.Add(nil);
  end;
end;

{ TMt3dSftInitConcCollection }

function TMt3dSftInitConcCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TMt3dSftInitConcTimeListLink;
end;

procedure TMt3dSftInitConcCollection.InvalidateSftInitConc(Sender: TObject);
var
  PhastModel: TPhastModel;
  Link: TMt3dSftInitConcTimeListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
//  ScreenTopDataArray: TDataArray;
begin
  if not (Sender as TObserver).UpToDate then
  begin
    PhastModel := frmGoPhast.PhastModel;
    Link := TimeListLink.GetLink(PhastModel) as TMt3dSftInitConcTimeListLink;
//    Link.FInitCondData.Invalidate;
    for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
    begin
      ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
      Link := TimeListLink.GetLink(ChildModel) as TMt3dSftInitConcTimeListLink;
//      Link.FInitCondData.Invalidate;
    end;

  end;
end;

class function TMt3dSftInitConcCollection.ItemClass: TBoundaryItemClass;
begin
  result := TMt3dSftInitConcItem;
end;

{ TMt3dSftDispItem }

procedure TMt3dSftDispItem.AssignObserverEvents(Collection: TCollection);
var
  ParentCollection: TMt3dSftDispCollection;
  InitConcObserver: TObserver;
//  ScreenTopObserver: TObserver;
//  SkinKObserver: TObserver;
//  SkinRadiusObserver: TObserver;
begin
  ParentCollection := Collection as TMt3dSftDispCollection;

//  InitConcObserver := FObserverList[InitConcPosition];
//  InitConcObserver.OnUpToDateSet := ParentCollection.InvalidateLktConc;
end;

{ TMt3dSftDispTimeListLink }

procedure TMt3dSftDispTimeListLink.CreateTimeLists;
var
  Index: Integer;
//  Mt3dmsConcData: TModflowTimeList;
//  Item: TChemSpeciesItem;
  LocalModel: TPhastModel;
begin
  TimeLists.Clear;
//  FListOfTimeLists.Clear;
  LocalModel := frmGoPhast.PhastModel;
  for Index := 0 to LocalModel.MobileComponents.Count - 1 do
  begin
//    Item := LocalModel.MobileComponents[Index];
//    Mt3dmsConcData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
//    Mt3dmsConcData.NonParamDescription := Item.Name +  StrConcentration;
//    Mt3dmsConcData.ParamDescription := Item.Name +  StrConcentrationMulti;
//    if Model <> nil then
//    begin
//      Mt3dmsConcData.OnInvalidate :=
//        (Model as TCustomModel).InvalidateMt3dmsChemSources;
//    end;
//    AddTimeList(Mt3dmsConcData);
//    FListOfTimeLists.Add(Mt3dmsConcData);
    AddTimeList(nil);
//    FListOfTimeLists.Add(nil);
  end;
  for Index := 0 to LocalModel.ImmobileComponents.Count - 1 do
  begin
//    Item := LocalModel.ImmobileComponents[Index];
//    Mt3dmsConcData := TModflowTimeList.Create(Model, Boundary.ScreenObject);
//    Mt3dmsConcData.NonParamDescription := Item.Name +  StrConcentration;
//    Mt3dmsConcData.ParamDescription := Item.Name +  StrConcentrationMulti;
//    if Model <> nil then
//    begin
//      Mt3dmsConcData.OnInvalidate :=
//        (Model as TCustomModel).InvalidateMt3dmsChemSources;
//    end;
//    AddTimeList(Mt3dmsConcData);
//    FListOfTimeLists.Add(Mt3dmsConcData);
    AddTimeList(nil);
//    FListOfTimeLists.Add(nil);
  end;
end;

{ TMt3dSftDispCollection }

function TMt3dSftDispCollection.GetTimeListLinkClass: TTimeListsModelLinkClass;
begin
  result := TMt3dSftDispTimeListLink;
end;

procedure TMt3dSftDispCollection.InvalidateSftInitConc(Sender: TObject);
var
  PhastModel: TPhastModel;
  Link: TMt3dSftDispTimeListLink;
  ChildIndex: Integer;
  ChildModel: TChildModel;
//  ScreenTopDataArray: TDataArray;
begin
  if not (Sender as TObserver).UpToDate then
  begin
    PhastModel := frmGoPhast.PhastModel;
    Link := TimeListLink.GetLink(PhastModel) as TMt3dSftDispTimeListLink;
//    Link.FInitCondData.Invalidate;
    for ChildIndex := 0 to PhastModel.ChildModels.Count - 1 do
    begin
      ChildModel := PhastModel.ChildModels[ChildIndex].ChildModel;
      Link := TimeListLink.GetLink(ChildModel) as TMt3dSftDispTimeListLink;
//      Link.FInitCondData.Invalidate;
    end;

  end;
end;

class function TMt3dSftDispCollection.ItemClass: TBoundaryItemClass;
begin
  result := TMt3dSftDispItem;
end;

end.