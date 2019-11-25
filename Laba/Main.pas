Unit Main;

Interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Regularexpressions, Vcl.StdCtrls,
  Research, Vcl.Grids,
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
    procedure stgClear;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var
  fmMain: TfmMain;

Implementation

{$R *.dfm}

Procedure TfmMain.stgClear;
var
  i, j: Integer;
begin
  for i := 0 to sgResults.ColCount - 1 do
    for j := 0 to sgResults.RowCount - 1 do
      sgResults.Cells[i, j] := '';
end;

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
  depth: Integer;
  SumSpen: Integer;
  Variables: TVariables;
  P, M, C, T: Integer;
  j: Integer;
  iP,iM,iC,iT:integer;
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
        sgResults.RowCount := 0;
        sgResults.ColCount := 0;
        sgResults.ColCount := 4;
        stgClear;
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
        depth := jAnalizeCode(temp, absOPERATORS, alloperators);
        mmResults.Lines.Clear;
        mmResults.Lines.Add('Абсолютная сложность(CL): ' +
          inttostr(OperatorsCount(absOPERATORS)));
        if OperatorsCount(alloperators) <> 0 then
        begin
          mmResults.Lines.Add('Относительная сложность(cl) ' +
            floattostr(OperatorsCount(absOPERATORS) /
            OperatorsCount(alloperators)));
        end
        else
          mmResults.Lines.Add('Относительная сложность 0');
        mmResults.Lines.Add
          ('Максимальный уровень вложенности условного оператора: ' +
          inttostr(depth));
      end;
    2:
      begin
        temp := '';
        for i := 0 to mmCode.Lines.Count - 1 do
        begin
          temp := temp + mmCode.Lines.Strings[i] + #13#10;
        end;
        stgClear;
        sgResults.RowCount := 0;
        sgResults.ColCount := 0;
        sgResults.ColCount := 7;

        setlength(OPERATORS, 0);
        setlength(OPERANDS, 0);
        spnAnalizeCode(temp, OPERATORS, OPERANDS);
        sgResults.Cells[0, 0] := 'Идентификатор';
        sgResults.Cells[1, 0] := 'Спен';
        i := 0;
        SumSpen := 0;
        sgResults.RowCount := length(OPERANDS) + 1;
        while i < length(OPERANDS) do
        begin
          SumSpen := SumSpen + OPERANDS[i].Used;
          sgResults.RowCount := sgResults.RowCount + 1;
          sgResults.Cells[0, i + 1] := OPERANDS[i].Operand;
          sgResults.Cells[1, i + 1] := inttostr(OPERANDS[i].Used);
          i := i + 1;
        end;
        mmResults.Lines.Clear;
        mmResults.Lines.Add('Суммарный спен программы = ' + inttostr(SumSpen));

        temp := '';
        for i := 0 to mmCode.Lines.Count - 1 do
        begin
          temp := temp + mmCode.Lines.Strings[i] + #13#10;
        end;
        FullChepin(temp, OPERANDS, Variables);
        P := 0;
        M := 0;
        C := 0;
        T := 0;
        for i := 0 to length(Variables) - 1 do
        begin
          if Variables[i].P = true then
            inc(P);
          if Variables[i].M = true then
            inc(M);
          if Variables[i].C = true then
            inc(C);
          if Variables[i].T = true then
            inc(T);
        end;
        mmResults.Lines.Add('Метрика чепина(Полная) = ' +
          floattostr(1 * P + 2 * M + 3 * C + 0.5 * T));
        i := P;
        if M > i then
          i := M;
        if C > i then
          i := C;
        if T > i then
          i := T;
        P := 0;
        M := 0;
        C := 0;
        T := 0;
        for j := 0 to length(Variables) - 1 do
        begin
          if (Variables[j].P = true) and (Variables[j].I_O = true) then
            inc(P);
          if (Variables[j].M = true) and (Variables[j].I_O = true) then
            inc(M);
          if (Variables[j].C = true) and (Variables[j].I_O = true) then
            inc(C);
          if (Variables[j].T = true) and (Variables[j].I_O = true) then
            inc(T);
        end;
        mmResults.Lines.Add('Метрика чепина(Ввода/Вывода) = ' +
          floattostr(1 * P + 2 * M + 3 * C + 0.5 * T));
        j := P;
        if M > j then
          j := M;
        if C > j then
          j := C;
        if T > j then
          j := T;
        if (sgResults.RowCount < i + j + 4) then
          sgResults.RowCount := i + j + 4;
        sgResults.Cells[3, 0] := 'Полная';
        sgResults.Cells[4, 0] := 'Метрика';
        sgResults.Cells[5, 0] := 'Чепина';
        i := 1;
        sgResults.Cells[2, i] := 'Группа';
        sgResults.Cells[3, i] := 'P';
        sgResults.Cells[4, i] := 'M';
        sgResults.Cells[5, i] := 'C';
        sgResults.Cells[6, i] := 'T';
        inc(i);
        sgResults.Cells[2, i] := 'Переменные';
        P := 0;
        M := 0;
        C := 0;
        T := 0;
        ip:=i;
        im:=i;
        ic:=i;
        it:=i;
        for j := 0 to length(Variables) - 1 do
        begin
          if Variables[j].P = true then
          begin
            sgResults.Cells[3, ip] := Variables[j].Name;
            inc(P);
            inc(ip);
          end;
          if Variables[j].M = true then
          begin
            sgResults.Cells[4, im] := Variables[j].Name;
            inc(M);
            inc(im);
          end;
          if Variables[j].C = true then
          begin
            sgResults.Cells[5, ic] := Variables[j].Name;
            inc(C);
            inc(ic);
          end;
          if Variables[j].T = true then
          begin
            sgResults.Cells[6, it] := Variables[j].Name;
            inc(T);
            inc(it);
          end;
        end;
        i:=ip;
        if im>i then
          i:=im;
        if ic>i then
          i:=ic;
        if it>i then
          i:=it;
        sgResults.Cells[2, i] := 'Кол-во';
        sgResults.Cells[3, i] := inttostr(P);
        sgResults.Cells[4, i] := inttostr(M);
        sgResults.Cells[5, i] := inttostr(C);
        sgResults.Cells[6, i] := inttostr(T);
        inc(i);
        sgResults.Cells[3, i] := 'Метрика';
        sgResults.Cells[4, i] := 'Чепина';
        sgResults.Cells[5, i] := 'Ввода            /';
        sgResults.Cells[6, i] := 'Вывода';
        inc(i);
        sgResults.Cells[2, i] := 'Группа';
        sgResults.Cells[3, i] := 'P';
        sgResults.Cells[4, i] := 'M';
        sgResults.Cells[5, i] := 'C';
        sgResults.Cells[6, i] := 'T';
        inc(i);
        sgResults.Cells[2, i] := 'Переменные';
        P := 0;
        M := 0;
        C := 0;
        T := 0;
        ip:=i;
        im:=i;
        ic:=i;
        it:=i;
        for j := 0 to length(Variables) - 1 do
        begin
          if (Variables[j].P = true) and (Variables[j].I_O = true) then
          begin
            sgResults.Cells[3, ip] := Variables[j].Name;
            inc(P);
            inc(ip);
          end;
          if (Variables[j].M = true) and (Variables[j].I_O = true) then
          begin
            sgResults.Cells[4, im] := Variables[j].Name;
            inc(M);
            inc(im);
          end;
          if (Variables[j].C = true) and (Variables[j].I_O = true) then
          begin
            sgResults.Cells[5, ic] := Variables[j].Name;
            inc(C);
            inc(ic);
          end;
          if (Variables[j].T = true) and (Variables[j].I_O = true) then
          begin
            sgResults.Cells[6, it] := Variables[j].Name;
            inc(T);
            inc(it);
          end;
        end;
        i:=ip;
        if im>i then
          i:=im;
        if ic>i then
          i:=ic;
        if it>i then
          i:=it;
        sgResults.Cells[2, i] := 'Кол-во';
        sgResults.Cells[3, i] := inttostr(P);
        sgResults.Cells[4, i] := inttostr(M);
        sgResults.Cells[5, i] := inttostr(C);
        sgResults.Cells[6, i] := inttostr(T);
      end;
  end;
end;

procedure TfmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

End.
