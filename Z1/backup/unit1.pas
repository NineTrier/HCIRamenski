unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, ComCtrls, unitModul;

type

  { TForm1 }

  TForm1 = class(TForm) //Класс формы
    Button_Rezult: TButton;
    Image1: TImage;
    LabelRez: TLabel;
    MainMenu1: TMainMenu;
    MenuItemSpravka: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemSaveOtchet: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemFile: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialogMMR: TSaveDialog;
    SaveFile: TSaveDialog;
    TEditM1: TEdit;
    TEditM2: TEdit;
    TEditRast: TEdit;
    LabelM1: TLabel;
    LabelM2: TLabel;
    LabelRast: TLabel;
    Memo_Otvet: TMemo;//Поля класса всё что выше до предыдущего комментария
    procedure Button_RezultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabelM1Click(Sender: TObject);
    procedure LabelM2Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Memo_OtvetChange(Sender: TObject);
    procedure Memo_OtvetEditingDone(Sender: TObject);
    procedure MenuItemSpravkaClick(Sender: TObject);
    procedure MenuItemSaveOtchetClick(Sender: TObject);
    procedure MenuItemSaveClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemOpenClick(Sender: TObject);
    procedure MenuItemFileClick(Sender: TObject);//Метод класса всё что выше до предыдущего комментария(Объявление)
    procedure DataFromForm();
  private

  public

  end;

var
  Form1: TForm1;//Объект класса
  m1,m2,r:real;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.LabelM1Click(Sender: TObject);
begin

end;

procedure TForm1.LabelM2Click(Sender: TObject);
begin

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

procedure TForm1.DataFromForm();
begin

  if TryStrToFloat(TEditM1.text,m1) = false then
  begin
     TEditM1.Color:=clRed;
     ShowMessage('Неправильно введён параметр m1');
     exit;
  end;
  if TryStrToFloat(TEditM2.text,m2) = false then
  begin
     TEditM2.Color:=clRed;
     ShowMessage('Неправильно введён параметр m2');
     exit;
  end;
  if TryStrToFloat(TEditRast.text,r) = false then
  begin
     TEditRast.Color:=clRed;
     ShowMessage('Неправильно введён параметр r');
     exit;
  end;
end;

procedure TForm1.Button_RezultClick(Sender: TObject); //Пример определения метода класса. Имя метода описывается по принципу <Имя класса>.<Имя метода>
var
   rez:real;
begin
  datafromform();
  if (m1<>0) and (m2<>0) and (r<>0) then begin
  rez:=PowerGrav(m1,m2,r);
  Memo_Otvet.lines.add('Масса первого тела: '+ FloatToStr(m1));
  Memo_Otvet.lines.add('Масса второго тела: '+ FloatToStr(m2));
  Memo_Otvet.lines.add('Расстояние между телами: '+ FloatToStr(r));
  Memo_Otvet.lines.add('Гравитационная сила = '+ FloatToStr(rez));
  Memo_Otvet.lines.add('----------------------------');
  end;
end;


procedure TForm1.Memo_OtvetChange(Sender: TObject);
begin

end;

procedure TForm1.Memo_OtvetEditingDone(Sender: TObject);
begin

end;

procedure TForm1.MenuItemSpravkaClick(Sender: TObject);
begin
   showmessage('Задача N14'+ sLineBreak +'Условие: Определить силу притяжения F между телами массы m 1 и m2 , находящимся на расстоянии r друг от друга.' + sLineBreak + 'Автор: Раменский Александр из группы ИВТ-19-2');

end;

procedure TForm1.MenuItemSaveOtchetClick(Sender: TObject);
begin
    if SaveFile.execute then
   begin
     Memo_otvet.Lines.savetofile(SaveFile.FileName);
     OpenDialog.filename:=SaveFile.FileName;
   end;
end;

procedure TForm1.MenuItemSaveClick(Sender: TObject);
var NameFile,s,s1,s2: string;
    f:text;
begin
     datafromform();
     if SaveDialogMMR.Execute then begin
     NameFile := SaveDialogMMR.FileName;
     AssignFile(f,NameFile);
     Rewrite(f);
     s:=TEditM1.Text;
     s1:=TEditM2.Text;
     s2:=TEditRast.Text;
     SaveParam(s,s1,s2,f);
     closeFile(f);
     OpenDialog.FileName:=NameFile;
     end;
end;

procedure TForm1.MenuItemExitClick(Sender: TObject);
begin
   Close;
end;


procedure TForm1.MenuItemOpenClick(Sender: TObject);
  var
   s,s1,s2:string;
   f:text;
begin
  If OpenDialog.Execute then begin
     assignfile(f,OpenDialog.FileName);
     reset(f);
     s:='';
     s1:='';
     s2:='';
     ReadParam(s,s1,s2,f);
     TEditM1.text:=s;
     TEditM2.text:=s1;
     TEditRast.text:=s2;
     closefile(f);
  end;
end;

procedure TForm1.MenuItemFileClick(Sender: TObject);
begin

end;










end.

