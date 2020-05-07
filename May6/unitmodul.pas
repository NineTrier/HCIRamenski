unit unitModul;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;


type
    Calculation = record
                mas1,mas2,ras:real;
                pow:real;
    end;
    fzap = file of calculation;
    CalcArray = array[1..128] of calculation;

function PowerGrav(a,b,c:real):real;
Procedure SaveToTxt(b:CalcArray;m:integer;var t:text);
Procedure SaveParamToTip(b:CalcArray;m:integer;var t:fzap);
Procedure OpenParam(var b:CalcArray;var t:fzap);

implementation

Procedure SaveToTxt(b:CalcArray;m:integer;var t:text);//Сохраняет данные массива, запомнившего все данные в текстовый файл
var
   s,s1,s2,r:string;
   i:integer;
begin
  for i:=1 to m do begin
     writeln(t,'n= '+ IntToStr(i) + ':');
     s:=FloatToStr(b[i].mas1);
     s1:=FloatToStr(b[i].mas2);
     s2:=FloatToStr(b[i].ras);
     r:=FloatToStr(b[i].pow);
     writeln(t,'Масса 1-ого тела = ' + s);
     writeln(t,'Масса 2-ого тела = ' + s1);
     writeln(t,'Расстояние между телами = ' + s2);
     writeln(t,'Сила гравитации = ' + r);
  end;
end;

Procedure SaveParamToTip(b:CalcArray;m:integer;var t:fzap);//Сохранить параметры в типизированный файл
var
   i:integer;
begin
  for i:=1 to m do begin
     write(t,b[i]);
  end;
end;

Procedure OpenParam(var b:CalcArray;var t:fzap);//Взять все данные из типизированного файла для таблицы
var
   i:integer;
   a:calculation;
begin
   seek(t,0);
   i:=1;
   while not EOf(t) do begin
      read(t,a);
      b[i]:=a;
      inc(i);
   end;
end;

function PowerGrav(a,b,c:real):real;//Рассчитывает силу гравитации
var
   g,rez:real;
begin
   g:=6.67/(10*10*10*10*10*10*10*10*10*10*10);
   If c = 0 then rez:=0
   else rez:=((a*b)/sqr(c))*g;
   PowerGrav:=rez;
end;



end.

