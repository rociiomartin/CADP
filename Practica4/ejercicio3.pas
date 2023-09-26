{
Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
a) Realizar un módulo que imprima el vector desde la primera posición hasta la última.
b) Realizar un módulo que imprima el vector desde la última posición hasta la primera.
c) Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y
desde la mitad más uno hacia la última posición.
d) Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector desde la
posición X hasta la Y. Asuma que tanto X como Y son menores o igual a la dimensión lógica. Y considere
que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
e) Utilizando el módulo implementado en el inciso anterior, vuelva a realizar los incisos a, b y c.
}

program ejercicio3;
const
  dimF = 10;  { Dimensión física del vector }
type
  rango=1..dimF;
  vector = array[rango] of integer; //se dispone

//PROCESOS
procedure CargarVector(var v:vector; var dimL:integer);//se dispon
var
    num:integer;
begin
  dimL := 0;
  writeln('Ingrese numeros enteros'); //no se sabe el corte d control
  while(dimL < dimF) do
  begin
    read(num);
    diml:=diml+1;
    v[diml] := num;
  end;
end;
//-------------
procedure IncisoA(v: vector; dimL: integer);
var
  i:rango;
begin
  for i := 1 to dimL do
    writeln('Elemento ', i, ': ', v[i]);
end;
//--------------
procedure IncisoB(v: vector; dimL: integer);
var
 i:rango;
begin
  for i := dimL downto 1 do
    writeln('Elemento ', i, ': ', v[i]);
end;
//--------------
procedure IncisoC(v: vector; dimL: integer);
var 
    i:rango;
    aux:integer;
begin
  aux:= dimL div 2;
  for i := aux downto 1 do
    writeln('Elemento ', i, ': ', v[i]);
  aux:=aux+1;
  for i := aux to diml do
    writeln('Elemento ', i, ': ', v[i]); 
end;
//--------------
procedure IncisoD(v: vector; dimL,X,Y: integer);
var
 i:rango;
begin
  if (X > Y)then
      for i := X downto Y do
        writeln('Elemento ', i, ': ', v[i])
  else
      for i := X to Y do
        writeln('Elemento ', i, ': ', v[i]);
end;
//--------------
procedure IncisoE(v: vector; dimL: integer);
var
  i:rango;
  X,Y:integer;
begin
  writeln('Ingrese X e Y');
  readln(X, Y);
  IncisoD(v, dimL,X,Y);
  IncisoA(v, dimL);
  IncisoB(v, dimL);
  IncisoC(v, dimL);
end;

//PP
var
  v: vector;
  dimL,X,Y: integer;
begin
  CargarVector(v,dimL); //se dispone
  IncisoA(v, dimL);
  IncisoB(v, dimL);
  IncisoC(v, dimL);
  writeln('Ingrese X e Y');
  readln(X, Y);
  IncisoD(v, dimL,X,Y);
  IncisoE(v, dimL);
end.
