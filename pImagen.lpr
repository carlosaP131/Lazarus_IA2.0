program pImagen;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uImagen, Uvarios, Uhistograma, uPuntuales, Ufunciongama
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrmImagen, FrmImagen);
  Application.CreateForm(TFrmHistograma, FrmHistograma);
  Application.CreateForm(TFrmfunciongama, Frmfunciongama);
  Application.Run;
end.

