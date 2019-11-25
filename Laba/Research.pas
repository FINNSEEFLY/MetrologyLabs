Unit Research;

Interface

Uses
  Regularexpressions,
  Math, vcl.dialogs;

Type
  TOperator = record
    Operator: string;
    Used: integer;
  end;

  TOperand = record
    Operand: string;
    Used: integer;
  end;

  TProgress = record
    OBJ: integer; // ������ � ������� ���� ������
    Status: integer; // ������ �������
    Scase: integer;
  end;

  TVariable = record
    Name: string;
    P: boolean;
    M: boolean;
    C: boolean;
    T: boolean;
    I_O: boolean;
  end;

  TOperators = array of TOperator;
  TOperands = array of TOperand;
  TVariables = array of TVariable;

Const
  COMEXP = '(\/\*[\s\S]*?(.*)\*\/)|(\/\/.*)';
  OPERATOREXP =
  // '([a-zA-Z]([a-zA-Z0-9_$]+\.?)+(?=\())|\+{1,2}|\-{1,2}|<{0,1}={1,2}|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|is|for|while|break|continue|switch|case|;|{|\[|\,|\.';
  // '([a-zA-Z]([a-zA-Z0-9_$]+\.?)+(?=\())|\+{1,2}|\-{1,2}|<{0,1}={1,2}|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|\+\=|\-\=|\*\=|\/\=|\%\=|\.\.|is|for|while|println|break|continue|switch|case|default|;|{|\[|\,|\.';
    '([a-zA-Z]([a-zA-Z0-9_$]+\.?)+(?=\())|\?|\+\=|\-\=|\*\=|\*\*\=|\/\=|\%\=|\.\.|'
    + '\+{1,2}|\-{1,2}|<{0,1}={1,2}|new|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|is|for|while|println|break|continue|switch|case|default|;|{|\[|\,|\(|\.';
  KEYWORDEXP =
    ('\b(def|double|int|else|float|byte|short|long|char|boolean|string|void|static|register|String|const|[\s\w]*\([\w\s,]*\)'')\b');
  KEYWORDEXPUPD =
    ('\b(def|double|int|float|byte|short|long|char|boolean|string|void|static|register|String|const|[\s\w]*\([\w\s,]*\)'')\b');
  STRINGEXP = '("[^"]*")|(''[^'']*'')';
  OPERANDEXP =
  // '(?<!\\)(([a-zA-Z0-9][a-zA-z0-9_$]*)+\.?)*(([a-zA-Z0-9][a-zA-z0-9_$]*)+?)+';
    '\b[^() }{[\]]*\b';
  FUNCTIONDEF =
    '\b(def|double|int|float|byte|short|long|char|boolean|string|void)[ ]{0,}[a-zA-Z1-9]{1,}\({1,}.*\)';

  absOPERATOR = '(\b(for|if|while|case)\b)|\?';
  { ��� �������� ������ }
  allOPERATOR =
    '\?|\+\=|\-\=|\*\=|\*\*\=|\/\=|\%\=|\.\.|\+{1,2}|\-{1,2}|<{0,1}={1,2}|new|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|is|for|while|println|break|continue|switch|case|default|;|\[|\,|\(|\.';
  CREATESCAN = 'Scanner[^;]*;';
  DELSCAN = 'scanner[^;]*;';
  CHEPDELSCAN = 'scanner\.close\(\);';
  onlyvarOPERANDEXP = { '\b[^() }{ [\]0-9]*\b' } '\b[a-zA-Z_][a-zA-Z0-9]*\b';
  LINE = '.*';
  plplminmin = '(\+\+)|(\-\-)';


  fiws = '\b(for|while|�if|switch)\b';
  scanner = 'scanner.*;';
  regfor = '\bfor\b';
  infor = ';[^;]*;';
  regifswitchwhile = '\b(if|while|switch)\b';
  equally = '=';
  print = '\b(println|print)\b';
  REGW1 = 'if';
  REGW2 = 'for';
  REGW3 = 'else';
  REGW4 = 'case';
  REGW5 = 'while';
  REGW6 = 'switch';
  REGW7 = 'default';
  REGW8 = '\;';
  REGW9 = ' ';
  REGW10 = '\?';
  REGW11 = '$';
  REGW12 = '\{';
  REGW13 = '\}';
  REGW14 = 'break';

Var
  OPERATORS: TOperators;
  OPERANDS: TOperands;
  absOPERATORS, allOPERATORS: TOperators;

Procedure AddToOperators(var OPERATORS: TOperators; const lexeme: string);

Procedure AddToOperands(var OPERANDS: TOperands; const lexeme: string);

Procedure hAnalizeCode(var text: string; var OPERATORS: TOperators;
  var OPERANDS: TOperands);

Function jAnalizeCode(var text: string; var absOPERATORS: TOperators;
  var allOPERATORS: TOperators): integer;

function OperatorsCount(const OPERATORS: TOperators): integer;

function OperandsCount(const OPERANDS: TOperands): integer;

function ProgramVolume(const pLen: integer; const pDict: integer): real;

function ProgramLength(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;

function ProgramDict(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;

Function MNL(var text: string): integer;

Procedure spnAnalizeCode(var text: string; var OPERATORS: TOperators;
  var OPERANDS: TOperands);

Procedure FullChepin(var text: string; var OPERANDS: TOperands;
  var Result: TVariables);

Implementation

function ProgramDict(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;
begin
  Result := length(OPERANDS) + length(OPERATORS);
end;

function ProgramLength(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;
begin
  Result := OperatorsCount(OPERATORS) + OperandsCount(OPERANDS);
end;

function ProgramVolume(const pLen: integer; const pDict: integer): real;
begin
  if pDict <> 0 then
    Result := pLen * Log2(pDict)
  else
    Result := 0;
end;

function OperatorsCount(const OPERATORS: TOperators): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to length(OPERATORS) - 1 do
  begin
    Result := Result + OPERATORS[i].Used;
  end;
end;

function OperandsCount(const OPERANDS: TOperands): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to length(OPERANDS) - 1 do
  begin
    Result := Result + OPERANDS[i].Used;
  end;
end;

Procedure InitOperators(var OPERATORS: TOperators);
begin
  SetLength(OPERATORS, 0);
end;

Procedure InitOperands(var OPERANDS: TOperands);
begin
  SetLength(OPERANDS, 0);
end;

Procedure AddToOperands(var OPERANDS: TOperands; const lexeme: string);
begin
  SetLength(OPERANDS, length(OPERANDS) + 1);
  OPERANDS[length(OPERANDS) - 1].Operand := lexeme;
  OPERANDS[length(OPERANDS) - 1].Used := 1;
end;

Procedure AddToOperators(var OPERATORS: TOperators; const lexeme: string);
begin
  SetLength(OPERATORS, length(OPERATORS) + 1);
  OPERATORS[length(OPERATORS) - 1].Operator := lexeme;
  OPERATORS[length(OPERATORS) - 1].Used := 1;
end;

Procedure DelComments(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(COMEXP);
  text := _regexp.Replace(text, ' ');
end;

Procedure DelKeywords(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(KEYWORDEXP);
  text := _regexp.Replace(text, ' ');
end;

Procedure jDelKeywords(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(KEYWORDEXPUPD);
  text := _regexp.Replace(text, '');
end;

Procedure Delfunctiondef(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(FUNCTIONDEF);
  text := _regexp.Replace(text, ' ');
end;

Procedure DelStrings(var text: string; var OPERANDS: TOperands);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  flag: boolean;
begin
  _regexp := TRegEx.Create(STRINGEXP);
  temp := _regexp.Matches(text);
  text := _regexp.Replace(text, ' ');
  for i := 0 to temp.Count - 1 do
  begin
    flag := false;
    j := 0;
    while (j < length(OPERANDS)) and (not(flag)) do
    begin
      if temp.Item[i].Value = OPERANDS[j].Operand then
      begin
        flag := true;
        OPERANDS[j].Used := OPERANDS[j].Used + 1;
      end;
      j := j + 1;
    end;
    if not(flag) then
      AddToOperands(OPERANDS, temp.Item[i].Value);
  end;
end;

Procedure spnDelStrings(var text: string; OPERANDS: TOperands);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  flag: boolean;
begin
  _regexp := TRegEx.Create(STRINGEXP);
  text := _regexp.Replace(text, ' ');
end;

Procedure DelOperands(var text: string; var OPERANDS: TOperands);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  flag: boolean;
begin
  _regexp := TRegEx.Create(OPERANDEXP);
  temp := _regexp.Matches(text);
  text := _regexp.Replace(text, ' ');
  for i := 0 to temp.Count - 1 do
  begin
    flag := false;
    j := 0;
    while (j < length(OPERANDS)) and (not(flag)) do
    begin
      if temp.Item[i].Value = OPERANDS[j].Operand then
      begin
        flag := true;
        OPERANDS[j].Used := OPERANDS[j].Used + 1;
      end;
      j := j + 1;
    end;
    if not(flag) then
      AddToOperands(OPERANDS, temp.Item[i].Value);
  end;
end;

Procedure varDelOperands(var text: string; var OPERANDS: TOperands);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  flag: boolean;
begin
  _regexp := TRegEx.Create(onlyvarOPERANDEXP);
  temp := _regexp.Matches(text);
  text := _regexp.Replace(text, ' ');
  for i := 0 to temp.Count - 1 do
  begin
    flag := false;
    j := 0;
    while (j < length(OPERANDS)) and (not(flag)) do
    begin
      if temp.Item[i].Value = OPERANDS[j].Operand then
      begin
        flag := true;
        OPERANDS[j].Used := OPERANDS[j].Used + 1;
      end;
      j := j + 1;
    end;
    if not(flag) then
      AddToOperands(OPERANDS, temp.Item[i].Value);
  end;
end;

Procedure DelOperators(var text: string; var OPERATORS: TOperators);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  strbuf: string;
  flag: boolean;
begin
  _regexp := TRegEx.Create(OPERATOREXP);
  temp := _regexp.Matches(text);
  text := _regexp.Replace(text, ' ');
  for i := 0 to temp.Count - 1 do
  begin
    flag := false;
    j := 0;
    while (j < length(OPERATORS)) and (not(flag)) do
    begin
      strbuf := temp.Item[i].Value;

      if '{' = strbuf then
      begin
        strbuf := strbuf + '}';
      end;
      if '?' = strbuf then
      begin
        strbuf := strbuf + ':';
      end;
      if strbuf = 'do' then
      begin
        strbuf := strbuf + '...while';
      end;
      if strbuf = '[' then
      begin
        strbuf := strbuf + ']';
      end;
      if strbuf = '(' then
      begin
        strbuf := strbuf + ')';
      end;
      if strbuf = OPERATORS[j].Operator then
      begin
        flag := true;
        OPERATORS[j].Used := OPERATORS[j].Used + 1;
      end;
      j := j + 1;
    end;
    if not(flag) then
      AddToOperators(OPERATORS, strbuf);
  end;
end;

Procedure jabsFindOperators(text: string; var OPERATORS: TOperators);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  strbuf: string;
  flag: boolean;
begin
  _regexp := TRegEx.Create(absOPERATOR);
  temp := _regexp.Matches(text);
  text := _regexp.Replace(text, ' ');
  for i := 0 to temp.Count - 1 do
  begin
    flag := false;
    j := 0;
    while (j < length(OPERATORS)) and (not(flag)) do
    begin
      strbuf := temp.Item[i].Value;
      if '?' = strbuf then
      begin
        strbuf := strbuf + ':';
      end;
      if strbuf = OPERATORS[j].Operator then
      begin
        flag := true;
        OPERATORS[j].Used := OPERATORS[j].Used + 1;
      end;
      j := j + 1;
    end;
    if not(flag) then
      AddToOperators(OPERATORS, strbuf);
  end;
end;

Procedure jallFindOperators(text: string; var OPERATORS: TOperators);
var
  _regexp: TRegEx;
  temp: TMatchCollection;
  i: integer;
  j: integer;
  strbuf: string;
  flag: boolean;
begin
  _regexp := TRegEx.Create(allOPERATOR);
  temp := _regexp.Matches(text);
  text := _regexp.Replace(text, ' ');
  for i := 0 to temp.Count - 1 do
  begin
    flag := false;
    j := 0;
    while (j < length(OPERATORS)) and (not(flag)) do
    begin
      strbuf := temp.Item[i].Value;

      if '{' = strbuf then
      begin
        strbuf := strbuf + '}';
      end;
      if '?' = strbuf then
      begin
        strbuf := strbuf + ':';
      end;
      if strbuf = '[' then
      begin
        strbuf := strbuf + ']';
      end;
      if strbuf = '(' then
      begin
        strbuf := strbuf + ')';
      end;
      if strbuf = OPERATORS[j].Operator then
      begin
        flag := true;
        OPERATORS[j].Used := OPERATORS[j].Used + 1;
      end;
      j := j + 1;
    end;
    if not(flag) then
      AddToOperators(OPERATORS, strbuf);
  end;
end;

Procedure Delscaner(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(CREATESCAN);
  text := _regexp.Replace(text, ' ');
  _regexp := TRegEx.Create(DELSCAN);
  text := _regexp.Replace(text, ' ');

end;

Procedure CHEPDelscaner(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(CREATESCAN);
  text := _regexp.Replace(text, ' ');
  _regexp := TRegEx.Create(CHEPDELSCAN);
  text := _regexp.Replace(text, ' ');

end;

Procedure hAnalizeCode(var text: string; var OPERATORS: TOperators;
  var OPERANDS: TOperands);
begin
  InitOperands(OPERANDS);
  InitOperators(OPERATORS);
  DelComments(text);
  Delfunctiondef(text);
  DelStrings(text, OPERANDS);
  // showmessage(text);

  DelKeywords(text);
  // showmessage(text);

  DelOperators(text, OPERATORS);
  // showmessage(text);

  DelOperands(text, OPERANDS);
  // showmessage(text);
end;

Function jAnalizeCode(var text: string; var absOPERATORS: TOperators;
  var allOPERATORS: TOperators): integer;
begin
  InitOperators(absOPERATORS);
  InitOperators(allOPERATORS);
  InitOperands(OPERANDS);
  DelComments(text);
  Delfunctiondef(text);
  DelStrings(text, OPERANDS);

  jDelKeywords(text);

  { ������� �������� ���������� }
  jabsFindOperators(text, absOPERATORS);
  { ����� ���������� ���������� }
  jallFindOperators(text, allOPERATORS);
  { ������������ ������� ����������� }
  Result := MNL(text);
end;

Function ReadOneLexeme(var text: string; var numofobj: integer;
  var nos: integer): string;
{ ���������� ��������� ������
  0 - �������� ������
  1 - ����� ������
  numofobj:
  REGW1 = 'if';
  REGW2 = 'for';
  REGW3 = 'else';
  REGW4 = 'case:';
  REGW5 = 'while()';
  REGW14 = 'break';
  REGW6 = 'switch{';
  REGW7 = 'default:';
  REGW8 = '\;';
  REGW9 = ' ';
  REGW10 = '\?';
  REGW11 = '#13#10';
  REGW12 = '{';
  REGW13 = ' }{ ';
  15 = sometxt
}
var
  i: integer;
  fl: boolean;
  resstr: string;
  _regexp: TRegEx;
  sk: integer;
  dfl: boolean;
begin
  fl := true;
  resstr := '';
  i := 1;
  while (fl) and (nos <= length(text)) do
  begin
    resstr := resstr + text[nos];
    inc(nos);
    if (_regexp.IsMatch(resstr, REGW1)) then
    begin
      numofobj := 1;
      fl := false;
      sk := 0;
      dfl := false;
      repeat
        resstr := resstr + text[nos];
        if text[nos] = '(' then
        begin
          inc(sk);
          dfl := true;
        end;
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      until (sk = 0) and dfl = true;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW2)) then
    begin
      numofobj := 2;
      fl := false;
      sk := 0;
      dfl := false;
      repeat
        resstr := resstr + text[nos];
        if text[nos] = '(' then
        begin
          inc(sk);
          dfl := true;
        end;
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      until (sk = 0) and dfl = true;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW3)) then
    begin
      numofobj := 3;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW4)) then
    begin
      numofobj := 4;
      fl := false;
      dfl := false;
      while dfl = false do
      begin
        resstr := resstr + text[nos];
        inc(nos);
        if text[nos - 1] = ':' then
          dfl := true;
      end;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW5)) then
    begin
      numofobj := 5;
      fl := false;
      sk := 0;
      dfl := false;
      repeat
        resstr := resstr + text[nos];
        if text[nos] = '(' then
        begin
          inc(sk);
          dfl := true;
        end;
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      until (sk = 0) and dfl = true;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW14)) then
    begin
      numofobj := 14;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW6)) then
    begin
      numofobj := 6;
      fl := false;
      dfl := false;
      while dfl = false do
      begin
        resstr := resstr + text[nos];
        inc(nos);
        if (text[nos - 1] = '{') then
          dfl := true;
      end;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW7)) then
    begin
      numofobj := 7;
      fl := false;
      while dfl = false do
      begin
        resstr := resstr + text[nos];
        inc(nos);
        if text[nos - 1] = ':' then
          dfl := true;
      end;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW8)) then
    begin
      if length(resstr) = 1 then
      begin
        numofobj := 8;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if ((_regexp.IsMatch(resstr, REGW9)) or (resstr[length(resstr)] = #0)) then
    begin
      if length(resstr) = 1 then
      begin
        while (text[nos] = ' ') or (text[nos] = #0) do
        begin
          resstr := resstr + text[nos];
          inc(nos);
        end;

        numofobj := 9;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW10)) then
    begin
      if length(resstr) = 1 then
      begin
        numofobj := 10;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if ((resstr[length(resstr) - 1] = #13) and (resstr[length(resstr)] = #10))
    then
    begin
      if length(resstr) = 2 then
      begin
        numofobj := 11;
      end
      else
      begin
        dec(nos);
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW12)) then
    begin
      if length(resstr) = 1 then
      begin
        numofobj := 12;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      Result := resstr;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW13)) then
    begin
      if length(resstr) = 1 then
      begin
        numofobj := 13;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      Result := resstr;
      Continue;
    end;
  end;
end;

Function MNL(var text: string): integer;
{ MNL - Maximum Nesting Level }
{
  IF
  OBJ = 1    //������ IF
  Status = 1 //��������� { ��� #13#10
  Status = 2 //������ {, ������� }                            {
  Status = 3 //������ #13#10,���� ; ��� #13#10
  Status = 4 //����� }{ |#13#10|; ������� sometxt | else
  {else }                                                      {
  Status = 5 //������ else, ��������� { ��� #13#10
  Status = 6 //������ { ��������� }                            {
  Status = 7 //������ #13#10,���� ; ��� #13#10

  FOR
  OBJ = 2    // ������ For
  Status = 1 // ������� { | #13#10 | ;
  Status = 2 // ������ ; --> ����� ��� ���������
  Status = 3 // ������ { �������� }                           {
  Status = 4 // ������ #13#10 �������� ; | #13#10

  while
  OBJ = 3    // ������ while
  Status = 1 // ������� { | #13#10 | ;
  Status = 2 // ������ { �������� }                           {
  Status = 3 // ������ #13#10 �������� ; | #13#10

  Switch
  OBJ = 4    // ������ switch
  Status = 1 // ������� case: | default: | }                  {
  Status = 2 // ������ case: ������� break
  Status = 1 // ������ break, �������: case | default | }      {

}
var
  nos, numofobj: integer;
  wait: boolean;
  Mass: array of TProgress;
  tmpres: integer;
  str: string;

begin
  Result := 0;
  tmpres := 0;
  while (nos <= length(text)) do
  begin
    numofobj := 0;
    str := ReadOneLexeme(text, numofobj, nos);
    if numofobj = 1 then
    begin
      SetLength(Mass, length(Mass) + 1);
      Mass[length(Mass) - 1].OBJ := 1;
      Mass[length(Mass) - 1].Status := 1;
      inc(tmpres);
      if tmpres > Result then
        Result := tmpres;
    end;
    if numofobj = 2 then
    begin
      if length(Mass) <> 0 then
      begin
        inc(tmpres);
        if tmpres > Result then
          Result := tmpres;
      end;
      SetLength(Mass, length(Mass) + 1);
      Mass[length(Mass) - 1].OBJ := 2;
      Mass[length(Mass) - 1].Status := 1;
    end;
    if numofobj = 5 then
    begin
      if length(Mass) <> 0 then
      begin
        inc(tmpres);
        if tmpres > Result then
          Result := tmpres;
      end;
      SetLength(Mass, length(Mass) + 1);
      Mass[length(Mass) - 1].OBJ := 3;
      Mass[length(Mass) - 1].Status := 1;
    end;
    if numofobj = 6 then
    begin
      SetLength(Mass, length(Mass) + 1);
      Mass[length(Mass) - 1].OBJ := 4;
      Mass[length(Mass) - 1].Status := 1;
      Mass[length(Mass) - 1].Scase := 0;
    end;
    wait := true;
    repeat
      if length(Mass) > 0 then
      begin

        case Mass[length(Mass) - 1].OBJ of
          1: { IF }
            begin
              case Mass[length(Mass) - 1].Status of
                1:
                  begin
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 2;
                    if numofobj = 11 then
                      Mass[length(Mass) - 1].Status := 3;
                    wait := true;
                  end;
                2:
                  begin
                    if numofobj = 13 then
                    begin
                      Mass[length(Mass) - 1].Status := 4;
                      if (length(Mass) > 0) then
                        dec(tmpres);
                    end;
                    wait := true;
                  end;
                3:
                  begin
                    if (numofobj = 8) or (numofobj = 11) then
                    begin
                      Mass[length(Mass) - 1].Status := 4;
                      if (length(Mass) > 0) then
                        dec(tmpres);
                    end;
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 2;
                    wait := true;
                  end;
                4:
                  begin
                    if (numofobj in [1, 2, 4, 5, 6, 7, 8, 10, 12, 13, 14, 15])
                    then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      wait := false;
                    end;
                    if (numofobj = 15) then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      wait := true;
                    end;
                    if numofobj = 3 then
                    begin
                      Mass[length(Mass) - 1].Status := 5;
                      wait := true;
                    end;

                  end;
                5:
                  begin

                    if numofobj = 12 then
                    begin
                      // inc(tmpres);
                      if tmpres > Result then
                        Result := tmpres;
                      Mass[length(Mass) - 1].Status := 6;
                    end;
                    if numofobj = 11 then
                    begin
                      Mass[length(Mass) - 1].Status := 7;
                      // inc(tmpres);
                      if tmpres > Result then
                        Result := tmpres;
                    end;
                    wait := true;
                  end;
                6:
                  begin
                    if numofobj = 13 then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      // dec(tmpres);
                    end;
                    wait := true;
                  end;
                7:
                  begin
                    if (numofobj = 8) or (numofobj = 11) then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      // dec(tmpres);
                    end;
                    wait := true;
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 6;
                  end;
              end;
            end;
          2: { FOR }
            begin
              case Mass[length(Mass) - 1].Status of
                1:
                  begin
                    if numofobj = 8 then
                    begin
                      Mass[length(Mass) - 1].Status := 2;
                      SetLength(Mass, length(Mass) - 1);
                      dec(tmpres);
                    end;
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 3;
                    if numofobj = 11 then
                      Mass[length(Mass) - 1].Status := 4;
                    wait := true;
                  end;
                3:
                  begin
                    if numofobj = 13 then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      if (length(Mass) > 0) then
                        dec(tmpres);
                    end;
                    wait := true;
                  end;
                4:
                  begin
                    if (numofobj = 8) or (numofobj = 11) then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      if (length(Mass) > 0) then
                        dec(tmpres);
                    end;
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 3;
                    wait := true;
                  end;
              end;
            end;
          3: { WHILE }
            begin
              case Mass[length(Mass) - 1].Status of
                1:
                  begin
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 2;
                    if numofobj = 11 then
                      Mass[length(Mass) - 1].Status := 3;
                    wait := true;
                  end;
                2:
                  begin
                    if numofobj = 13 then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      if (length(Mass) > 0) then
                        dec(tmpres);
                    end;
                    wait := true;
                  end;
                3:
                  begin
                    if (numofobj = 8) or (numofobj = 11) then
                    begin
                      SetLength(Mass, length(Mass) - 1);
                      if (length(Mass) > 0) then
                        dec(tmpres);
                    end;
                    if numofobj = 12 then
                      Mass[length(Mass) - 1].Status := 2;
                    wait := true;
                  end;
              end;
            end;
          4: { SWITCH }
            begin
              case Mass[length(Mass) - 1].Status of
                1:
                  begin
                    if (numofobj = 4) or (numofobj = 7) then
                    begin
                      Mass[length(Mass) - 1].Status := 2;
                      if numofobj = 4 then
                      begin
                        inc(tmpres);
                        inc(Mass[length(Mass) - 1].Scase);
                        if tmpres > Result then
                          Result := tmpres;
                      end;
                    end;
                    wait := true;
                    if (numofobj = 13) then
                    begin
                      tmpres := tmpres - Mass[length(Mass) - 1].Scase;
                      SetLength(Mass, length(Mass) - 1);
                    end;
                    wait := true;

                  end;
                2:
                  begin
                    if numofobj = 14 then
                    begin
                      Mass[length(Mass) - 1].Status := 1;
                    end;
                    if numofobj = 13 then
                    begin
                      tmpres := tmpres - Mass[length(Mass) - 1].Scase;
                      SetLength(Mass, length(Mass) - 1);

                    end;

                    wait := true;
                  end;
              end;
            end;
        else
          begin
            wait := true;
          end;
        end;

      end
      else
      begin
        wait := true;
      end;
    until wait = true;
  end;

end;

Procedure MinusOneOPERANDS(var OPERANDS: TOperands);
var
  i: integer;
begin
  for i := 0 to length(OPERANDS) do
    dec(OPERANDS[i].Used);
end;

Procedure spnAnalizeCode(var text: string; var OPERATORS: TOperators;
  var OPERANDS: TOperands);
begin
  InitOperands(OPERANDS);
  InitOperators(OPERATORS);
  DelComments(text);
  Delfunctiondef(text);
  Delscaner(text);
  spnDelStrings(text, OPERANDS);
  // showmessage(text);

  DelKeywords(text);
  // showmessage(text);

  DelOperators(text, OPERATORS);
  // showmessage(text);

  varDelOperands(text, OPERANDS);
  // showmessage(text);
end;

Procedure InitVariables(var OPERANDS: TOperands; var Variables: TVariables);
var
  i: integer;
begin
  SetLength(Variables, 0);
  for i := 0 to length(OPERANDS) - 1 do
  begin
    SetLength(Variables, length(Variables) + 1);
    Variables[i].Name := OPERANDS[i].Operand;
    Variables[i].P := false;
    Variables[i].M := false;
    Variables[i].C := false;
    Variables[i].T := true;
    Variables[i].I_O := false;
  end;
end;

Function FindNumInVariables(const s: string;
  const Variables: TVariables): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to length(Variables) - 1 do
  begin
    if s = Variables[i].Name then
    begin
      Result := i;
      break;
    end;
  end;
end;

Procedure LineTo2Line(const s: string; const equalpos: integer;
  var left, right: string);
var
  i: integer;
  fl: boolean;
begin
  SetLength(left, 0);
  SetLength(right, 0);
  fl := false;
  for i := 1 to length(s) do
  begin
    if not fl then
    begin
      if i <> equalpos then
      begin
        left := left + s[i];
      end
      else
      begin
        fl := true;
      end;
    end
    else
    begin
      right := right + s[i];
    end;
  end;
end;

Procedure SwitchTagVar(var Variable: TVariable; const tag: integer);
// ---------------����----------------
// 1 - �� T - ����������
// 2 - C - ���������� ����������
// 3 - M - �������������� �� �� C
// 4 - P - �������� �� �� M � �� C
// 5 - I/O ����������
// 6 - �� P
// ��������� ��������� {P,PT,M,MT,C,T}
// -----------------------------------

begin
  case tag of
    1: // not T
      begin
        Variable.T := false;
      end;
    2: // C
      begin
        Variable.T := false;
        Variable.P := false;
        Variable.M := false;
        Variable.C := true;
      end;
    3: // M
      begin
        if (Variable.C = false) and (Variable.P = false) then
        begin
          Variable.M := true;
        end;
      end;
    4: // P
      begin
        if (Variable.C = false) and (Variable.M = false) then
        begin
          Variable.P := true;
        end;

      end;
    5: // I/O
      begin
        Variable.I_O := true;
      end;
    6: // not P
      begin
        Variable.P := false;
      end;
  end;
end;

Procedure LeftRightCheck(const left, right: string; var Variables: TVariables);
var
  _regexp: TRegEx;
  Matches, Matches2: TMatchCollection;
  i: integer;
  LeftVariable: TVariable;
begin
  _regexp.Create(onlyvarOPERANDEXP);
  Matches := _regexp.Matches(left);
  LeftVariable := Variables[FindNumInVariables(Matches.Item[0].Value,
    Variables)];
  Matches2 := _regexp.Matches(right);
  for i := 0 to Matches2.Count - 1 do
  begin
    if Matches2.Item[i].Value <> LeftVariable.Name then
    begin
      SwitchTagVar(Variables[FindNumInVariables(Matches2.Item[i].Value,
        Variables)], 3);
      SwitchTagVar(Variables[FindNumInVariables(Matches2.Item[i].Value,
        Variables)], 1);
    end
    else
    begin
      SwitchTagVar(Variables[FindNumInVariables(Matches2.Item[i].Value,
        Variables)], 6);
      SwitchTagVar(Variables[FindNumInVariables(Matches2.Item[i].Value,
        Variables)], 3);
    end;
  end;
  for i := 0 to Matches.Count - 1 do
  begin
    if i = 0 then
    begin
      SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
      Variables)], 6);
      SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
      Variables)], 3);
    end
    else
    begin
      SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
      Variables)], 2);
    end;

  end;

end;

Procedure LineCheckFullCHepin(const s: string; var Variables: TVariables);
var
  _regexp: TRegEx;
  Matches: TMatchCollection;
  i: integer;
  str: string;
  leftstr, rightstr: string;
begin
  _regexp.Create(onlyvarOPERANDEXP);
  // ���� ������� ��������
  if _regexp.IsMatch(s) then
  begin
    _regexp.Create('scanner');
    // ������ ����
    if _regexp.IsMatch(s) then
    begin
      _regexp.Create(onlyvarOPERANDEXP);
      SwitchTagVar(Variables[FindNumInVariables(_regexp.Matches(s)
        .Item[0].Value, Variables)], 4);
      SwitchTagVar(Variables[FindNumInVariables(_regexp.Matches(s)
        .Item[0].Value, Variables)], 5);
    end
    else
    begin
      _regexp.Create(fiws);
      // ���� ������ for|if|while|switch
      if _regexp.IsMatch(s) then
      begin
        _regexp.Create(regfor);
        // ������ ������ for
        if _regexp.IsMatch(s) then
        begin
          _regexp.Create(infor);
          str := _regexp.Matches(s).Item[0].Value;
          _regexp.Create(onlyvarOPERANDEXP);
          Matches := _regexp.Matches(str);
          // ����������� � ������� � for
          for i := 0 to Matches.Count - 1 do
          begin
            SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
              Variables)], 2);
          end;
        end
        else
        begin
          _regexp.Create(regifswitchwhile);
          // ������ ������ if|switch|while
          if _regexp.IsMatch(s) then
          begin
            _regexp.Create(onlyvarOPERANDEXP);
            Matches := _regexp.Matches(s);
            for i := 1 to Matches.Count - 1 do
            begin
              SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
                Variables)], 2);
            end;
          end;
        end;
      end
      else
      begin
        _regexp.Create(equally);
        // ������� ������������
        if _regexp.IsMatch(s) then
        begin
          LineTo2Line(s, pos(equally, s), leftstr, rightstr);
          LeftRightCheck(leftstr, rightstr, Variables);
        end
        else
        begin
          _regexp.Create(plplminmin);
          if _regexp.IsMatch(s) then
          begin
          _regexp.Create(onlyvarOPERANDEXP);
            Matches := _regexp.Matches(s);
            for i := 0 to Matches.Count - 1 do
            begin
              SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
                Variables)], 6);
              SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
                Variables)], 3);
            end;
          end
          else
          begin
            _regexp.Create(print);
            // ������ println
            if _regexp.IsMatch(s) then
            begin
              _regexp.Create(onlyvarOPERANDEXP);
              Matches := _regexp.Matches(s);
              for i := 1 to Matches.Count - 1 do
              begin
                SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
                  Variables)], 1);
                SwitchTagVar(Variables[FindNumInVariables(Matches.Item[i].Value,
                  Variables)], 3);
                SwitchTagVar
                  (Variables[FindNumInVariables(_regexp.Matches(s)
                  .Item[i].Value, Variables)], 5);
              end;
            end;
          end;
        end;
      end;

    end;
  end;
end;

Procedure FullChepin(var text: string; var OPERANDS: TOperands;
  var Result: TVariables);
var
  Matches: TMatchCollection;
  i: integer;
  _regexp: TRegEx;
begin
  InitVariables(OPERANDS, Result);
  DelComments(text);
  Delfunctiondef(text);
  CHEPDelscaner(text);
  spnDelStrings(text, OPERANDS);
  DelKeywords(text);
  _regexp.Create(LINE);
  Matches := _regexp.Matches(text);
  for i := 0 to Matches.Count - 1 do
  begin
    LineCheckFullCHepin(Matches.Item[i].Value, Result);
  end;

end;

End.
