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
    OBJ: integer; // Объект с которым идет работа
    Status: integer; // Статус объекта
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
  { Без фигурных скобок }
  allOPERATOR =
    '\?|\+\=|\-\=|\*\=|\*\*\=|\/\=|\%\=|\.\.|\+{1,2}|\-{1,2}|<{0,1}={1,2}|new|\*{1,2}|\/|%|\/|if|=>|>{1,3}|<|>=|&{1,2}|\|{1,2}|\^|~|!{1}={0,1}|do|return|is|for|while|println|break|continue|switch|case|default|;|\[|\,|\(|\.';

  REGW1 = 'if';
  REGW2 = 'for';
  REGW3 = 'else';
  REGW4 = 'case[ ]*[^:]*:';
  REGW5 = 'while';
  REGW6 = 'switch.*{';
  REGW7 = 'default[ ]*:';
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

  DelKeywords(text);

  { Подсчет условных операторов }
  jabsFindOperators(text, absOPERATORS);
  { Общее количество операторов }
  jallFindOperators(text, allOPERATORS);
  { Максимальный уровень вложенности }
  result := MNL(text);
end;


Function ReadOneLexeme(var text: string; var numofobj: integer;
  var nos: integer): integer;
{ Возвращает результат чтения
  0 - успешное чтение
  1 - конец строки
  numofobj:
  REGW1 = 'if';
  REGW2 = 'for';
  REGW3 = 'else';
  REGW4 = 'case[ ]*[^:]*:';
  REGW5 = 'while';
  REGW14 = 'break';
  REGW6 = 'switch.*{';
  REGW7 = 'default[ ]*:';
  REGW8 = '\;';
  REGW9 = ' ';
  REGW10 = '\?';
  REGW11 = '$';
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
  dfl:boolean;
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
      dfl:=false;
      repeat
        resstr := resstr + text[nos];
        if text[nos] = '(' then
        begin
          inc(sk);
          dfl:=true;
        end;
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      until (sk = 0) and dfl=true;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW2)) then
    begin
      numofobj := 2;
      fl := false;
      sk := 0;
      dfl:=false;
      repeat
        resstr := resstr + text[nos];
        if text[nos] = '(' then
        begin
          inc(sk);
          dfl:=true;
        end;
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      until (sk = 0) and dfl=true;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW3)) then
    begin
      numofobj := 3;
      fl := false;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW4)) then
    begin
      numofobj := 4;
      fl := false;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW5)) then
    begin
      numofobj := 5;
      fl := false;
      sk := 0;
      dfl:=false;
      repeat
        resstr := resstr + text[nos];
        if text[nos] = '(' then
        begin
          inc(sk);
          dfl:=true;
        end;
        if text[nos] = ')' then
          dec(sk);
        inc(nos);
      until (sk = 0) and dfl=true;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW14)) then
    begin
      numofobj := 14;
      fl := false;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW6)) then
    begin
      numofobj := 6;
      fl := false;
      result := 0;
      Continue;
    end;
    if (_regexp.IsMatch(resstr, REGW7)) then
    begin
      numofobj := 7;
      fl := false;
      result := 0;
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
      result := 0;
      Continue;
    end;
    if ((_regexp.IsMatch(resstr, REGW9)) or (resstr[Length(resstr)]=#0)) then
    begin
      if length(resstr) = 1 then
      begin
        numofobj := 9;
      end
      else
      begin
        dec(nos);
        SetLength(resstr, length(resstr) - 1);
        numofobj := 15;
      end;
      fl := false;
      result := 0;
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
      result := 0;
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
      result := 0;
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
      result := 0;
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
      result := 0;
      Continue;
    end;
  end;
end;


Function MNL(var text: string): integer;
{ MNL - Maximum Nesting Level }
{
  IF
  OBJ = 1    //Объект IF
  Status = 1 //Ожидается { или #13#10
  Status = 2 //введен {, ожидать }       {
  Status = 3 //введен #13#10,ждем ; или #13#10

  FOR
  OBJ = 2    // Объект For
  Status = 1 // Ожидаем { | #13#10 | ;
  Status = 2 // Введен ; --> конец без ветвления
  Status = 3 // Введен { ожидание }       {
  Status = 4 // Введен #13#10 ожидание ; | #13#10

  while
  OBJ = 3    // Объект while
  Status = 1 // Ожидаем { | #13#10 | ;
  Status = 2 // Введен { ожидание }       {
  Status = 3 // Введен #13#10 ожидание ; | #13#10

  Switch
  OBJ = 4    // Объект switch
  Status = 1 // Ожидаем case: | default: | }          {
  Status = 2 // Введен case: ожидаем break
  Status = 3 // Введен break, ожидаем: case | default | }     {
}
var
  nos, numofobj: integer;
  wait: boolean;
  Mass: array of TProgress;
  tmpres: integer;

begin
  result := 0;
  tmpres := 0;
  while (nos <= length(text)) do
  begin
    numofobj := 0;
    ReadOneLexeme(text, numofobj, nos);
    if numofobj = 1 then
    begin
      SetLength(Mass, length(Mass) + 1);
      Mass[length(Mass) - 1].OBJ := 1;
      Mass[length(Mass) - 1].Status := 1;
      inc(tmpres);
      if tmpres > result then
        result := tmpres;
    end;
    if numofobj = 2 then
    begin
      SetLength(Mass, length(Mass) + 1);
      Mass[length(Mass) - 1].OBJ := 2;
      Mass[length(Mass) - 1].Status := 1;
      if tmpres <> 0 then
      begin
        inc(tmpres);
        if tmpres > result then
          result := tmpres;
      end;
    end;
    if numofobj = 5 then
    begin
      if tmpres <> 0 then
      begin
        inc(tmpres);
        if tmpres > result then
          result := tmpres;
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
    end;
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
                end;
              2:
                begin
                  if numofobj = 13 then
                  begin
                    Mass[length(Mass) - 1].Status := 4;
                    dec(tmpres);
                  end;
                end;
              3:
                begin
                  if (numofobj = 8) or (numofobj = 11) then
                  begin
                    Mass[length(Mass) - 1].Status := 4;
                    dec(tmpres);
                  end;
                end;
              4:
                begin
                  if numofobj = 15 then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                  end;
                  if numofobj = 3 then
                    Mass[length(Mass) - 1].Status := 5;
                end;
              5:
                begin
                  inc(tmpres);
                  if tmpres > result then
                    result := tmpres;
                  if numofobj = 12 then
                    Mass[length(Mass) - 1].Status := 6;
                  if numofobj = 11 then
                    Mass[length(Mass) - 1].Status := 7;
                end;
              6:
                begin
                  if numofobj = 13 then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                    dec(tmpres);
                  end;
                end;
              7:
                begin
                  if (numofobj = 8) or (numofobj = 11) then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                    dec(tmpres);
                  end;
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
                end;
              3:
                begin
                  if numofobj = 13 then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                    dec(tmpres);
                  end;
                end;
              4:
                begin
                  if (numofobj = 8) or (numofobj = 11) then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                    dec(tmpres);
                  end;
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
                end;
              2:
                begin
                  if numofobj = 13 then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                    dec(tmpres);
                  end;
                end;
              3:
                begin
                  if (numofobj = 8) or (numofobj = 11) then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                    dec(tmpres);
                  end;
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
                    inc(tmpres);
                    if tmpres > result then
                      result := tmpres;
                  end;
                  if (numofobj = 13) then
                  begin
                    SetLength(Mass, length(Mass) - 1);
                  end;

                end;
              2:
                begin
                  if numofobj = 14 then
                  begin
                    Mass[length(Mass) - 1].Status := 1;
                    dec(tmpres);
                  end;
                end;
            end;
          end;
      end;
    end;

  end;

end;

End.
