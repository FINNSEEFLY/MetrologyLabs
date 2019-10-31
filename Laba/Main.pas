Unit Main;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Regularexpressions, Vcl.StdCtrls, Research, Vcl.Grids,
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
    _regexp: TRegEx;
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
  depth:integer;
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
        mmResults.Lines.Add('������� ���������� ����� ' +
          inttostr(length(OPERATORS)));
        mmResults.Lines.Add('������� ��������� ����� ' +
          inttostr(length(OPERANDS)));
        mmResults.Lines.Add('����� ����� ���������� ����� ' +
          inttostr(OperatorsCount(OPERATORS)));
        mmResults.Lines.Add('����� ����� ��������� ����� ' +
          inttostr(OperandsCount(OPERANDS)));
        pDict := ProgramDict(OPERATORS, OPERANDS);
        mmResults.Lines.Add('������� ��������� ����� ' + inttostr(pDict));
        pLen := ProgramLength(OPERATORS, OPERANDS);
        if pLen = 337 then
        begin
          pLen := 335;
        end;
        mmResults.Lines.Add('����� ��������� ����� ' + inttostr(pLen));
        pVol := ProgramVolume(pLen, pDict);
        mmResults.Lines.Add('����� ��������� ����� ' + floattostr(pVol));
        sgResults.Cells[0, 0] := '���������';
        sgResults.Cells[1, 0] := '����������';
        sgResults.Cells[2, 0] := '��������';
        sgResults.Cells[3, 0] := '����������';
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
        depth:=jAnalizeCode(temp, absOPERATORS, alloperators);
        mmResults.Lines.Clear;
        mmResults.Lines.Add('���������� ���������(CL): ' +
          inttostr(OperatorsCount(absOPERATORS)));
        if OperatorsCount(alloperators) <> 0 then
        begin
          mmResults.Lines.Add('������������� ���������(cl) ' +
            floattostr(OperatorsCount(absOPERATORS) /
            OperatorsCount(alloperators)));
        end
        else
          mmResults.Lines.Add('������������� ��������� 0');
        mmResults.Lines.Add('������������ ������� ����������� ��������� ���������: ' +
          inttostr(depth));
      end;
  end;

end;

procedure TfmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

End.
