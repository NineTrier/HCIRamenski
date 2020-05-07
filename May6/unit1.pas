unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, ComCtrls, Grids, unitModul;

type

  { TFormPG }

  TFormPG = class(TForm) //Класс формы
    Button_Rezult: TButton;
    Image1: TImage;
    LabelRez: TLabel;
    MainMenu1: TMainMenu;
    ParamToTxt: TMenuItem;
    ParamToTip: TMenuItem;
    RezToTxt: TMenuItem;
    ParamTip: TMenuItem;
    MenuItemSpravka: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemSaveOtchet: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemOpen: TMenuItem;
    MenuItemFile: TMenuItem;
    OpenTxt: TOpenDialog;
    OpenTip: TOpenDialog;
    SaveTip: TSaveDialog;
    SaveTxtRez: TSaveDialog;
    SaveTxt: TSaveDialog;
    Tabl: TStringGrid;
    TEditM1: TEdit;
    TEditM2: TEdit;
    TEditRast: TEdit;
    LabelM1: TLabel;
    LabelM2: TLabel;
    LabelRast: TLabel;
    procedure Button_RezultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ParamToTxtClick(Sender: TObject);
    procedure ParamToTipClick(Sender: TObject);
    procedure RezToTxtClick(Sender: TObject);
    procedure ParamTipClick(Sender: TObject);
    procedure MenuItemSpravkaClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);//Метод класса всё что выше до предыдущего комментария(Объявление)
    procedure DataFromForm();
  private

  public

  end;

var
  FormPG: TFormPG;//Объект класса
  Calcul:CalcArray;
  ftip:fzap;
  ftxt:text;
  b:calculation;
  n:integer;//Счётчик кликов на кнопку

implementation

{$R *.lfm}

{ TFormPG }

procedure TFormPG.DataFromForm();//Проверка данных на правильный ввод
begin

  if TryStrToFloat(TEditM1.text,b.mas1) = false then
  begin
     TEditM1.Color:=clRed;
     ShowMessage('Неправильно введён параметр m1');
     exit;
  end
  else TEditM1.Color:=clDefault;
  if TryStrToFloat(TEditM2.text,b.mas2) = false then
  begin
     TEditM2.Color:=clRed;
     ShowMessage('Неправильно введён параметр m2');
     exit;
  end
  else TEditM1.Color:=clDefault;
  if TryStrToFloat(TEditRast.text,b.ras) = false then
  begin
     TEditRast.Color:=clRed;
     ShowMessage('Неправильно введён параметр r');
     exit;
  end
  else TEditM1.Color:=clDefault;
end;

procedure TFormPG.Button_RezultClick(Sender: TObject); //Пример определения метода класса. Имя метода описывается по принципу <Имя класса>.<Имя метода>
var
   rez:real;
begin
  n:=n+1;
  datafromform();
  if (b.mas1<>0) and (b.mas2<>0) and (b.ras<>0) then begin
  rez:=PowerGrav(b.mas1,b.mas2,b.ras);
  b.pow:=rez;
  calcul[n]:=b;
  if n>1 then begin
     Tabl.RowCount:=n+1;
     Tabl.Height:=Tabl.Height+24;
  end;
  if n>2 then FormPG.Height:=FormPG.Height+24;
  tabl.cells[1,n]:=FloatTostr(calcul[n].mas1);
  tabl.cells[2,n]:=FloatToStr(calcul[n].mas2);
  tabl.cells[3,n]:=FloatToStr(calcul[n].ras);
  tabl.cells[4,n]:=FloatToStr(calcul[n].pow);
  end;
end;

procedure TFormPG.FormCreate(Sender: TObject);
begin
  n:=0;
end;

procedure TFormPG.ParamToTxtClick(Sender: TObject);
var
   NameFile:string;
begin
  if not SaveTxt.execute then exit;
  NameFile:=SaveTxt.FileName;
  AssignFile(ftxt,NameFile);
  Append(ftxt);
  SaveToTxt(calcul,n,ftxt);
  closefile(ftxt);
end;

procedure TFormPG.ParamToTipClick(Sender: TObject);
var
   NameFile: string;
begin
     datafromform();
     if SaveTip.Execute then begin
     NameFile := SaveTip.FileName;
     AssignFile(ftip,NameFile);
     Rewrite(ftip);
     SaveParamToTip(calcul,n,ftip);
     closeFile(ftip);
     end;
end;

procedure TFormPG.RezToTxtClick(Sender: TObject);
var
   NameFile:string;
begin
     if not SaveTxt.execute then exit;
     NameFile:=SaveTxtRez.FileName;
     assignfile(ftxt,namefile);
     append(ftxt);
     SaveToTxt(calcul,n,ftxt);
     closefile(ftxt);
end;

procedure TFormPG.ParamTipClick(Sender: TObject);
var
   m:integer;
   namefile:string;
begin
  if OpenTip.Execute then begin
  NameFile := OpenTip.FileName;
  AssignFile(ftip,NameFile);
  reset(ftip);
  m:=StrToInt(inputbox('Введите порядковый номер параметров','',''));
  openparam(calcul,ftip);
  closefile(ftip);
  TEditM1.text:=FloatToStr(calcul[m].mas1);
  TEditM2.text:=FloatToStr(calcul[m].mas2);
  TEditRast.text:=FloatToStr(calcul[m].ras);
  end;
end;


procedure TFormPG.MenuItemSpravkaClick(Sender: TObject);
begin
   showmessage('Задача N14'+ sLineBreak +'Условие: Определить силу притяжения F между телами массы m 1 и m2 , находящимся на расстоянии r друг от друга.' + sLineBreak + 'Автор: Раменский Александр из группы ИВТ-19-2');
end;

procedure TFormPG.MenuItemExitClick(Sender: TObject);
begin
   Close;
end;


end.

