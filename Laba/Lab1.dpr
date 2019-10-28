program Lab1;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fmMain},
  Research in 'Research.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
