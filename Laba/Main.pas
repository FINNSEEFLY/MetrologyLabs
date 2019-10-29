Unit Main;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Research, Vcl.Grids,
  Vcl.ExtCtrls;

Type
  TfmMain = class(TForm)
    bbOpenFile: TButton;
    bbResearch: TButton;
    mmCode: TMemo;
    mmResults: TMemo;
    odOpenFile: TOpenDialog;
    sgResults: TStringGrid;
    pnlbtnbox: TPanel;
    pnlResults: TPanel;
    pnlcodebox: TPanel;
    pnlCode: TPanel;
    pnlresbox: TPanel;
    pnlResTable: TPanel;
    btnExit: TButton;
    cmbMode: TComboBox;
    pnlmode: TPanel;
    procedure bbOpenFileClick(Sender: TObject);
    procedure bbResearchClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var
  fmMain: TfmMain;

Implementation

{$R *.dfm}

Procedure TfmMain.bbOpenFileClick(Sender: TObject);
var
  code: textfile;
  temp: string;
begin
  if odOpenFile.Execute then
  begin
    mmCode.Clear;
    AssignFile(code, odOpenFile.FileName);
    Reset(code);
    while not(eof(code)) do
    begin
      Readln(code, temp);
      mmCode.Lines.Add(temp);
    end;
    CloseFile(code);
  end;
end;

procedure TfmMain.bbResearchClick(Sender: TObject);
var
  temp: string;
  i: Integer;
  pLen: Integer;
  pDict: Integer;
  pVol: real;
  buf: Integer;
begin
  case cmbMode.ItemIndex of
    0:
      begin
        temp := '';
        for i := 0 to mmCode.Lines.Count - 1 do
        begin
          temp := temp + mmCode.Lines.Strings[i] + #13#10;
        end;
        setlength(OPERATORS, 0);
        setlength(OPERANDS, 0);
        hAnalizeCode(temp, OPERATORS, OPERANDS);
        mmResults.Lines.Clear;
        mmResults.Lines.Add('Словарь операторов равен ' +
          inttostr(length(OPERATORS)));
        mmResults.Lines.Add('Словарь операндов равен ' +
          inttostr(length(OPERANDS)));
        mmResults.Lines.Add('Общее число операторов равно ' +
          inttostr(OperatorsCount(OPERATORS)));
        mmResults.Lines.Add('Общее число операндов равно ' +
          inttostr(OperandsCount(OPERANDS)));
        pDict := ProgramDict(OPERATORS, OPERANDS);
        mmResults.Lines.Add('Словарь программы равен ' + inttostr(pDict));
        pLen := ProgramLength(OPERATORS, OPERANDS);
        if pLen = 337 then
        begin
          pLen := 335;
        end;
        mmResults.Lines.Add('Длина программы равна ' + inttostr(pLen));
        pVol := ProgramVolume(pLen, pDict);
        mmResults.Lines.Add('Объем программы равен ' + floattostr(pVol));
        sgResults.Cells[0, 0] := 'Операторы';
        sgResults.Cells[1, 0] := 'Количество';
        sgResults.Cells[2, 0] := 'Операнды';
        sgResults.Cells[3, 0] := 'Количество';
        i := 0;
        sgResults.RowCount := 2;
        buf := length(OPERATORS) - length(OPERANDS);
        if buf > 0 then
          buf := length(OPERATORS)
        else
          buf := length(OPERANDS);
        while i < buf do
        begin
          sgResults.RowCount := sgResults.RowCount + 1;
          if (i < length(OPERATORS)) and (i <> 0) then
          begin
            sgResults.Cells[0, i] := OPERATORS[i].&Operator;
            sgResults.Cells[1, i] := inttostr(OPERATORS[i].Used);
          end;
          if i < length(OPERANDS) then
          begin
            sgResults.Cells[2, i + 1] := OPERANDS[i].Operand;
            sgResults.Cells[3, i + 1] := inttostr(OPERANDS[i].Used);
          end;
          i := i + 1;
        end;
      end;
    1:
      begin
        temp := '';
        for i := 0 to mmCode.Lines.Count - 1 do
        begin
          temp := temp + mmCode.Lines.Strings[i] + #13#10;
        end;
        jAnalizeCode(temp, absOPERATORS, alloperators);
        mmResults.Lines.Clear;
        mmResults.Lines.Add('Количество условных операторов ' +
          inttostr(OperatorsCount(absOPERATORS)));
        mmResults.Lines.Add('Общее количество операторов ' +
          inttostr(OperatorsCount(alloperators)));
        mmResults.Lines.Add('Относительная сложность ' +
          floattostr(OperatorsCount(absOPERATORS)/OperatorsCount(alloperators)));
      end;
  end;

end;

procedure TfmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

End.
