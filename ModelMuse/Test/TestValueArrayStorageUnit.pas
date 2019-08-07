unit TestValueArrayStorageUnit;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, RbwParser, Classes, ValueArrayStorageUnit, rwXMLConv;
type
  // Test methods for class TValueArrayStorage

  TestTValueArrayStorage = class(TTestCase)
  strict private
    FValueArrayStorage: TValueArrayStorage;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAssign;
    procedure TestAdd;
    procedure TestDelete;
    procedure TestInsert;
    procedure TestStore;
  end;

  TTestComponent = class(TComponent)
  private
    FValues: TValueArrayStorage;
    procedure SetValues(const Value: TValueArrayStorage);
  published
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    property Values: TValueArrayStorage read FValues write SetValues;
  end;

implementation

procedure TestTValueArrayStorage.SetUp;
begin
  FValueArrayStorage := TValueArrayStorage.Create;
end;

procedure TestTValueArrayStorage.TearDown;
begin
  FValueArrayStorage.Free;
  FValueArrayStorage := nil;
end;

procedure TestTValueArrayStorage.TestAssign;
var
  Source: TValueArrayStorage;
  Index: Integer;
begin
  Source := TValueArrayStorage.Create;
  try
    // TODO: Setup method call parameters
    Source.DataType := rdtDouble;
    Source.Count := 3;
    Source.RealValues[0] := 1.1;
    Source.RealValues[1] := 2.1;
    Source.RealValues[2] := 3.1;
    FValueArrayStorage.Assign(Source);
    Check(Source.Count = FValueArrayStorage.Count);
    Check(Source.DataType = FValueArrayStorage.DataType);
    for Index := 0 to 2 do
    begin
      Check(Source.RealValues[Index] = FValueArrayStorage.RealValues[Index]);
    end;

    Source.DataType := rdtInteger;
    Source.Count := 3;
    Source.IntValues[0] := 1;
    Source.IntValues[1] := 2;
    Source.IntValues[2] := 3;
    FValueArrayStorage.Assign(Source);
    Check(Source.Count = FValueArrayStorage.Count);
    Check(Source.DataType = FValueArrayStorage.DataType);
    for Index := 0 to 2 do
    begin
      Check(Source.IntValues[Index] = FValueArrayStorage.IntValues[Index]);
    end;

    Source.DataType := rdtBoolean;
    Source.Count := 3;
    Source.BooleanValues[0] := True;
    Source.BooleanValues[1] := False;
    Source.BooleanValues[2] := True;
    FValueArrayStorage.Assign(Source);
    Check(Source.Count = FValueArrayStorage.Count);
    Check(Source.DataType = FValueArrayStorage.DataType);
    for Index := 0 to 2 do
    begin
      Check(Source.BooleanValues[Index] = FValueArrayStorage.BooleanValues[Index]);
    end;

    Source.DataType := rdtString;
    Source.Count := 3;
    Source.StringValues[0] := '1.1';
    Source.StringValues[1] := '2.1';
    Source.StringValues[2] := '3.1';
    FValueArrayStorage.Assign(Source);
    Check(Source.Count = FValueArrayStorage.Count);
    Check(Source.DataType = FValueArrayStorage.DataType);
    for Index := 0 to 2 do
    begin
      Check(Source.StringValues[Index] = FValueArrayStorage.StringValues[Index]);
    end;
  finally
    Source.Free;
  end;
end;

procedure TestTValueArrayStorage.TestAdd;
var
  Count: integer;
begin
  Count := FValueArrayStorage.Count;
  FValueArrayStorage.Add;
  Check(Count+1 = FValueArrayStorage.Count);
  FValueArrayStorage.Clear;
  FValueArrayStorage.Add(5.0);
  Check(FValueArrayStorage.RealValues[0] = 5.0);

  FValueArrayStorage.Clear;
  FValueArrayStorage.DataType := rdtInteger;
  FValueArrayStorage.Add(5);
  Check(FValueArrayStorage.IntValues[0] = 5);

  FValueArrayStorage.Clear;
  FValueArrayStorage.DataType := rdtBoolean;
  FValueArrayStorage.Add(True);
  Check(FValueArrayStorage.BooleanValues[0] = True);

  FValueArrayStorage.Clear;
  FValueArrayStorage.DataType := rdtString;
  FValueArrayStorage.Add('5');
  Check(FValueArrayStorage.StringValues[0] = '5');
end;

procedure TestTValueArrayStorage.TestDelete;
begin
  FValueArrayStorage.DataType := rdtInteger;
  FValueArrayStorage.Count := 3;
  FValueArrayStorage.IntValues[0] := 1;
  FValueArrayStorage.IntValues[1] := 2;
  FValueArrayStorage.IntValues[2] := 3;
  FValueArrayStorage.Delete(1);
  Check(FValueArrayStorage.Count = 2);
  Check(FValueArrayStorage.IntValues[0] = 1);
  Check(FValueArrayStorage.IntValues[1] = 3);
end;

procedure TestTValueArrayStorage.TestInsert;
begin
  FValueArrayStorage.DataType := rdtInteger;
  FValueArrayStorage.Count := 3;
  FValueArrayStorage.IntValues[0] := 1;
  FValueArrayStorage.IntValues[1] := 3;
  FValueArrayStorage.IntValues[2] := 5;

  FValueArrayStorage.Insert(1);
  FValueArrayStorage.IntValues[1] := 2;
  Check(FValueArrayStorage.Count = 4);
  Check(FValueArrayStorage.IntValues[0] = 1);
  Check(FValueArrayStorage.IntValues[1] = 2);
  Check(FValueArrayStorage.IntValues[2] = 3);
  Check(FValueArrayStorage.IntValues[3] = 5);

  FValueArrayStorage.Insert(3);
  FValueArrayStorage.IntValues[3] := 4;
  Check(FValueArrayStorage.Count = 5);
  Check(FValueArrayStorage.IntValues[0] = 1);
  Check(FValueArrayStorage.IntValues[1] = 2);
  Check(FValueArrayStorage.IntValues[2] = 3);
  Check(FValueArrayStorage.IntValues[3] = 4);
  Check(FValueArrayStorage.IntValues[4] = 5);

  FValueArrayStorage.Insert(5);
  FValueArrayStorage.IntValues[5] := 6;
  Check(FValueArrayStorage.Count = 6);
  Check(FValueArrayStorage.IntValues[0] = 1);
  Check(FValueArrayStorage.IntValues[1] = 2);
  Check(FValueArrayStorage.IntValues[2] = 3);
  Check(FValueArrayStorage.IntValues[3] = 4);
  Check(FValueArrayStorage.IntValues[4] = 5);
  Check(FValueArrayStorage.IntValues[5] = 6);
end;

procedure TestTValueArrayStorage.TestStore;
var
  MemStream, TempStream: TMemoryStream;
  TestComponent: TTestComponent;
  NewTestComponent: TTestComponent;
begin
  TestComponent := TTestComponent.Create(nil);
  try
    // Name must be assigned for XML.
    TestComponent.Name := 'TestComponent';
    TestComponent.Values.DataType := rdtInteger;
    TestComponent.Values.Count := 3;
    TestComponent.Values.IntValues[0] := 1;
    TestComponent.Values.IntValues[1] := 2;
    TestComponent.Values.IntValues[2] := 3;

    MemStream := TMemoryStream.Create;
    TempStream := TMemoryStream.Create;
    try
      MemStream.WriteComponent(TestComponent);
      MemStream.Position := 0;
      ObjectBinaryToText(MemStream, TempStream);

      MemStream.Clear;
      TempStream.Position := 0;
      MemStream.Position := 0;
      ObjectTextToBinary(TempStream, MemStream);
      NewTestComponent := TTestComponent.Create(nil);;
      try
        MemStream.Position := 0;
        MemStream.ReadComponent(NewTestComponent);
        Check(NewTestComponent <> nil, 'Component not created with ASCII');
        Check(TestComponent.Values.DataType = NewTestComponent.Values.DataType, 'Wrong data type: ASCII');
        Check(TestComponent.Values.Count = NewTestComponent.Values.Count, 'Wrong count: ASCII');
        Check(TestComponent.Values.IntValues[0] = NewTestComponent.Values.IntValues[0], 'Wrong value 0: ASCII');
        Check(TestComponent.Values.IntValues[1] = NewTestComponent.Values.IntValues[1], 'Wrong value 1: ASCII');
        Check(TestComponent.Values.IntValues[2] = NewTestComponent.Values.IntValues[2], 'Wrong value 2: ASCII');
      finally
        NewTestComponent.Free;
      end;

      TempStream.Clear;
      MemStream.Clear;
      MemStream.WriteComponent(TestComponent);
      MemStream.Position := 0;
      rwObjectBinaryToXML(MemStream, TempStream);

      MemStream.Clear;
      TempStream.Position := 0;
      MemStream.Position := 0;
      rwObjectXMLToBinary(TempStream, MemStream);
      NewTestComponent := TTestComponent.Create(nil);;
      try
        MemStream.Position := 0;
        MemStream.ReadComponent(NewTestComponent);
        Check(NewTestComponent <> nil, 'Component not created with XML');
        Check(TestComponent.Values.DataType = NewTestComponent.Values.DataType, 'Wrong data type: XML');
        Check(TestComponent.Values.Count = NewTestComponent.Values.Count, 'Wrong count: XML');
        Check(TestComponent.Values.IntValues[0] = NewTestComponent.Values.IntValues[0], 'Wrong value 0: XML');
        Check(TestComponent.Values.IntValues[1] = NewTestComponent.Values.IntValues[1], 'Wrong value 1: XML');
        Check(TestComponent.Values.IntValues[2] = NewTestComponent.Values.IntValues[2], 'Wrong value 2: XML');
      finally
        NewTestComponent.Free;
      end;

    finally
      MemStream.Free;
      TempStream.Free;
    end;
  finally
   TestComponent.Free;
  end;
end;

{ TTestComponent }

constructor TTestComponent.Create(AOwner: TComponent);
begin
  inherited;
  FValues:= TValueArrayStorage.Create;
end;

destructor TTestComponent.Destroy;
begin
  FValues.Free;
  inherited;
end;

procedure TTestComponent.SetValues(const Value: TValueArrayStorage);
begin
  FValues.Assign(Value);
end;

initialization
  RegisterClass(TTestComponent);
  // Register any test cases with the test runner
  RegisterTest(TestTValueArrayStorage.Suite);
end.
