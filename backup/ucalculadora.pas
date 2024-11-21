unit Ucalculadora;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, GraphType, Math;

type

  { TFrmCalculadora }

  TFrmCalculadora = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Button12Click(Sender: TObject);


  private

  public

  end;

var
  FrmCalculadora: TFrmCalculadora;

implementation

{$R *.lfm}

{ TFrmCalculadora }

procedure TFrmCalculadora.Button12Click(Sender: TObject);
begin
  OpenDialog1.Options := OpenDialog1.Options + [ofAllowMultiSelect];
  if OpenDialog1.Execute and (OpenDialog1.Files.Count >= 2) then
  begin
    Image1.Picture.LoadFromFile(OpenDialog1.Files[0]);
    Image2.Picture.LoadFromFile(OpenDialog1.Files[1]);
  end
  else
  begin
    ShowMessage('Por favor selecciona al menos dos imágenes.');
  end;
end;


end.
