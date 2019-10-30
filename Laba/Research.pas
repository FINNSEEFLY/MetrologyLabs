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

  TOperators = array of TOperator;
  TOperands = array of TOperand;

Const
  COMEXP = '(\/\*[\s\S]*?(.*)\*\/)|(\/\/.*)';
  OPERATOREXP =
  // '([a-zA-Z]([a-zA-Z0-9_$]+\.?)+(?=\())|\+{1,2}|\-{1,2}|<{0,1}={1,2}|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|is|for|while|break|continue|switch|case|;|{|\[|\,|\.';
  // '([a-zA-Z]([a-zA-Z0-9_$]+\.?)+(?=\())|\+{1,2}|\-{1,2}|<{0,1}={1,2}|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|\+\=|\-\=|\*\=|\/\=|\%\=|\.\.|is|for|while|println|break|continue|switch|case|default|;|{|\[|\,|\.';
    '([a-zA-Z]([a-zA-Z0-9_$]+\.?)+(?=\())|\?|\+\=|\-\=|\*\=|\*\*\=|\/\=|\%\=|\.\.|'
    + '\+{1,2}|\-{1,2}|<{0,1}={1,2}|new|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|is|for|while|println|break|continue|switch|case|default|;|{|\[|\,|\(|\.';
  KEYWORDEXP =
    ('\b(def|double|int|float|byte|short|long|char|boolean|string|else|void|static|register|String|const|[\s\w]*\([\w\s,]*\)'')\b');
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

  REGW1 = 'if';
  REGW2 = 'for';
  REGW3 = 'else';
  REGW4 = 'case[ ]*[^:]*:';
  REGW5 = 'while';
  REGW6 = 'switch';
  REGW7 = 'default[ ]*:';
  REGW8 = '\;';
  REGW9 = ' ';
  REGW10 = '\?';
  REGW11 = '$';

Var
  OPERATORS: TOperators;
  OPERANDS: TOperands;
  absOPERATORS, allOPERATORS: TOperators;

Procedure AddToOperators(var OPERATORS: TOperators; const lexeme: string);

Procedure AddToOperands(var OPERANDS: TOperands; const lexeme: string);

Procedure hAnalizeCode(var text: string; var OPERATORS: TOperators;
  var OPERANDS: TOperands);

Procedure jAnalizeCode(var text: string; var absOPERATORS: TOperators;
  var allOPERATORS: TOperators);

function OperatorsCount(const OPERATORS: TOperators): integer;

function OperandsCount(const OPERANDS: TOperands): integer;

function ProgramVolume(const pLen: integer; const pDict: integer): real;

function ProgramLength(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;

function ProgramDict(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;

Function MNL(var text: string): integer;

Implementation

function ProgramDict(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;
begin
  result := length(OPERANDS) + length(OPERATORS);
end;

function ProgramLength(const OPERATORS: TOperators;
  const OPERANDS: TOperands): integer;
begin
  result := OperatorsCount(OPERATORS) + OperandsCount(OPERANDS);
end;

function ProgramVolume(const pLen: integer; const pDict: integer): real;
begin
  if pDict <> 0 then
    result := pLen * Log2(pDict)
  else
    result := 0;
end;

function OperatorsCount(const OPERATORS: TOperators): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to length(OPERATORS) - 1 do
  begin
    result := result + OPERATORS[i].Used;
  end;
end;

function OperandsCount(const OPERANDS: TOperands): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to length(OPERANDS) - 1 do
  begin
    result := result + OPERANDS[i].Used;
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
  text := _regexp.Replace(text, '');
end;

Procedure DelKeywords(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(KEYWORDEXP);
  text := _regexp.Replace(text, '');
end;

Procedure Delfunctiondef(var text: string);
var
  _regexp: TRegEx;
begin
  _regexp := TRegEx.Create(FUNCTIONDEF);
  text := _regexp.Replace(text, '');
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

Procedure jallFindOperators(var text: string; var OPERATORS: TOperators);
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

Procedure jAnalizeCode(var text: string; var absOPERATORS: TOperators;
  var allOPERATORS: TOperators);
begin
  InitOperators(absOPERATORS);
  InitOperators(allOPERATORS);
  InitOperands(OPERANDS);
  DelComments(text);
  Delfunctiondef(text);
  DelStrings(text, OPERANDS);

  DelKeywords(text);

  { ������� �������� ���������� }
  jabsFindOperators(text, absOPERATORS);
  { ����� ���������� ���������� }
  jallFindOperators(text, allOPERATORS);
  { ������������ ������� ����������� }
end;

{ ���������� ��������� ������
  0 - �������� ������
  1 - ����� ������
  numofobj:
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
  12 = sometxt
}
Function ReadOneLexeme(var text: string; var numofobj: integer;
  var nos: integer): integer;
var
  i: integer;
  fl: boolean;
  resstr: string;
  _regexp: TRegEx;
  sk: integer;
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
      sk := 1;
      while (sk <> 0) do
      begin
        resstr := resstr + text[nos];
        if text[nos] = '(' then
          inc(sk);
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      end;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW2)) then
    begin
      numofobj := 2;
      fl := false;
      sk := 1;
      while (sk <> 0) do
      begin
        resstr := resstr + text[nos];
        if text[nos] = '(' then
          inc(sk);
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      end;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW3)) then
    begin
      numofobj := 3;
      fl := false;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW4)) then
    begin
      numofobj := 4;
      fl := false;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW5)) then
    begin
      numofobj := 5;
      fl := false;
      sk := 1;
      while (sk <> 0) do
      begin
        resstr := resstr + text[nos];
        if text[nos] = '(' then
          inc(sk);
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      end;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW6)) then
    begin
      numofobj := 6;
      fl := false;
      sk := 1;
      while (sk <> 0) do
      begin
        resstr := resstr + text[nos];
        if text[nos] = '(' then
          inc(sk);
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      end;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW7)) then
    begin
      numofobj := 7;
      fl := false;
      result := 0;
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
        numofobj := 12;
      end;
      fl := false;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW9)) then
    begin
      if length(resstr) = 1 then
      begin
        numofobj := 9;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 12;
      end;
      fl := false;
      result := 0;
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
        numofobj := 12;
      end;
      fl := false;
      result := 0;
    end;
    if (_regexp.IsMatch(resstr, REGW11)) then
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
        numofobj := 12;
      end;
      fl := false;
      result := 0;
    end;
  end;
end;

{ MNL - Maximum Nesting Level }
Function MNL(var text: string): integer;
var
  nos, numofobj: integer;
begin
  while (nos<=length(text)) do
  begin
    numofobj:=0;
    ReadOneLexeme(text,numofobj,nos);

  end;

end;

End.
