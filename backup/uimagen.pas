unit uImagen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus,Uvarios,Uhistograma,uPuntuales,Ufunciongama;

type

  { TFrmImagen }

  TFrmImagen = class(TForm)
    EUmbral: TEdit;
    Image1: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    mAGuardar: TMenuItem;
    mASalir: TMenuItem;
    meeDeshacer: TMenuItem;
    mnuOpUmbral: TMenuItem;
    mnuPuntualGamma: TMenuItem;
    mnuVImagenCompleta: TMenuItem;
    mnuOpgris2: TMenuItem;
    mnuOpNegativo: TMenuItem;
    MHHistograma: TMenuItem;
    mnuArchivo: TMenuItem;
    mAABRIR: TMenuItem;
    nmuEditar: TMenuItem;
    nmuVer: TMenuItem;
    MenuItem5: TMenuItem;
    nmuOpRegionales: TMenuItem;
    nmuHerramientas: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    mnuOpGris1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure mAABRIRClick(Sender: TObject);
    procedure mAGuardarClick(Sender: TObject);
    procedure mASalirClick(Sender: TObject);
    procedure maaAbrirotsClick(Sender: TObject);
    procedure meeDeshacerClick(Sender: TObject);
    procedure MHHistogramaClick(Sender: TObject);
    procedure MImagen(B:TBitmap);
    procedure mnuOpGris1Click(Sender: TObject);
    procedure mnuOpgris2Click(Sender: TObject);
    procedure mnuOpNegativoClick(Sender: TObject);
    procedure mnuOpUmbralClick(Sender: TObject);
    procedure mnuPuntualGammaClick(Sender: TObject);
    procedure mnuVImagenCompletaClick(Sender: TObject);
    procedure GuardaEstadoImg();
    procedure RestauraEstadoImg();
  private

  public
   Bm: TBitmap;
    ImageHistory: TList;
   Iancho,Ialto: Integer;
    MTR,MRES: Mat3D;
     Picture: TPicture;
  end;

var
  FrmImagen: TFrmImagen;

implementation

{$R *.lfm}

{ TFrmImagen }
procedure TFrmImagen.mASalirClick(Sender: TObject);
begin
  close;
end;

procedure TFrmImagen.maaAbrirotsClick(Sender: TObject);
var
    nom: String;

begin
  if OpenDialog1.Execute then
  begin
    nom := OpenDialog1.FileName;
    Picture := TPicture.Create;  // Crea una instancia de TPicture

      Picture.LoadFromFile(nom);  // Carga la imagen en TPicture
      Image1.Picture.Assign(Picture);  // Asigna la imagen cargada a TImage
     Bm:=Picture.Bitmap;
     MImagen(Bm);



  end;
end;
procedure TFrmImagen.GuardaEstadoImg;
var
  Backup: TBitmap;
begin
  Backup := TBitmap.Create;
  Backup.Assign(Image1.Picture.Bitmap);

  if ImageHistory.Count = 2 then
  begin
    TBitmap(ImageHistory.First).Free;
    ImageHistory.Delete(0);
  end;

  ImageHistory.Add(Backup);
end;
procedure TFrmImagen.RestauraEstadoImg;
var
  LastImage: TBitmap;
begin
  if ImageHistory.Count > 0 then
  begin
    LastImage := TBitmap(ImageHistory.Last);
    Image1.Picture.Bitmap.Assign(LastImage);
    LastImage.Free;
    ImageHistory.Delete(ImageHistory.Count - 1);
  end;
end;
procedure TFrmImagen.meeDeshacerClick(Sender: TObject);
begin
         RestauraEstadoImg;
end;

procedure TFrmImagen.MHHistogramaClick(Sender: TObject);
begin
  BA.Assign(FrmImagen.Image1.Picture.Bitmap);
    FrmHistograma.show;
end;

procedure TFrmImagen.mAABRIRClick(Sender: TObject);
VAR
  nom : String;
begin
  if OpenDialog1.Execute then
  begin
    nom := OpenDialog1.FileName;
    Picture := TPicture.Create;  // Crea una instancia de TPicture

      Picture.LoadFromFile(nom);  // Carga la imagen en TPicture
      Image1.Picture.Assign(Picture);  // Asigna la imagen cargada a TImage
     Bm:=Picture.Bitmap;
     MImagen(Bm);


  end;


end;

procedure TFrmImagen.mAGuardarClick(Sender: TObject);
var
  nom : String;
begin
  SaveDialog1.Filter:='BMP';
  SaveDialog1.FileName:='BMP';
  if SaveDialog1.Execute then
  begin
    nom:=SaveDialog1.FileName;
    if nom <> ''then
    begin
      nom := nom+'.bmp';
      Image1.Picture.SaveToFile(nom);
    end;
  end;
end;

procedure TFrmImagen.FormCreate(Sender: TObject);
begin
  Bm := TBitmap.Create;
  BA:=TBitmap.Create;
   ImageHistory := TList.Create;
end;

procedure TFrmImagen.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ImageHistory.Count - 1 do
    TBitmap(ImageHistory[i]).Free;
  ImageHistory.Free;
  Bm.Free;
  BA.Free;
end;

procedure TFrmImagen.Label1Click(Sender: TObject);
begin

end;


procedure TFrmImagen.MImagen(B:TBitmap);
begin
  GuardaEstadoImg;
    Image1.Picture.Assign(B);
end;

procedure TFrmImagen.mnuOpGris1Click(Sender: TObject);
begin
   Iancho:=Bm.Width;
   Ialto:=Bm.Height;
   BM_MAT(Bm,MTR);
   FPGris1(MTR,MRES,Iancho,Ialto);
   MAT_BM(MRES,Bm,Iancho,Ialto);
   MImagen(Bm);
end;

procedure TFrmImagen.mnuOpgris2Click(Sender: TObject);
begin
      Iancho:=Bm.Width;
   Ialto:=Bm.Height;
   BM_MAT(Bm,MTR);
   FPGris2(MTR,MRES,Iancho,Ialto);
   MAT_BM(MRES,Bm,Iancho,Ialto);
   MImagen(Bm);
end;

procedure TFrmImagen.mnuOpNegativoClick(Sender: TObject);
begin
   Iancho:=Bm.Width;
   Ialto:=Bm.Height;
   BM_MAT(Bm,MTR);
   FPNegativo(MTR,MRES,Iancho,Ialto);
   MAT_BM(MRES,Bm,Iancho,Ialto);
   MImagen(Bm);
end;

procedure TFrmImagen.mnuOpUmbralClick(Sender: TObject);
var
  umbralStr: String;
  umbral: Integer;
  sentidoStr: String;
  sentido: Boolean;
begin
  // Solicita el umbral
  umbralStr := InputBox('Configuración de Umbral', 'Introduzca el umbral (0-255):', '128');
  if TryStrToInt(umbralStr, umbral) and (umbral >= 0) and (umbral <= 255) then
  begin
    // Solicita el sentido
    sentidoStr := InputBox('Configuración de Sentido', 'Introduzca 1 para invertido, 0 para normal:', '0');
    sentido := (sentidoStr = '1');

    // Llama al procedimiento con los valores ingresados
        // Procesa la imagen con los valores recibidos por mensaje
    Iancho := BM.Width;
    Ialto := BM.Height;
    BM_MAT(BM, MTR);
    FPGris2(MTR, MRES, Iancho, Ialto);
    FPUmbral(MTR, MRES, Iancho, Ialto, sentido, umbral);
    MAT_BM(MRES, BM, Iancho, Ialto);
    MImagen(BM);
  end
  else
  begin
    ShowMessage('El umbral debe ser un número entre 0 y 255.');
  end;
end;

procedure TFrmImagen.mnuPuntualGammaClick(Sender: TObject);
var
  gam: real;
begin
    frmfunciongama.ShowModal;
    if frmfunciongama.ModalResult = mrOK then
    begin
      gam:= frmfunciongama.g;
      Iancho:=Bm.Width;
      Ialto:=Bm.Height;
      BM_MAT(Bm,MTR);
      FPGamma(MTR,MRES,Iancho,Ialto,gam);
      MAT_BM(MRES,Bm,Iancho,Ialto);
       MImagen(Bm);
    end;
end;

procedure TFrmImagen.mnuVImagenCompletaClick(Sender: TObject);
begin

  // Cambia el estado de Stretch según el valor de Checked
  Image1.Stretch := mnuVImagenCompleta.Checked;
  Image1.AutoSize:=not mnuVImagenCompleta.Checked;

  // Cambia el estado de Checked al hacer clic
  mnuVImagenCompleta.Checked := not mnuVImagenCompleta.Checked;



  // Si Stretch es falso, redimensiona el TImage al tamaño original de la imagen
end;


end.

