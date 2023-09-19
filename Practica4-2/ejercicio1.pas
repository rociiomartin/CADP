{
 a. Dado un vector de enteros de a lo sumo 500 valores, realice un módulo que reciba dicho vector y un valor
n y retorne si n se encuentra en el vector o no.
b. Modifique el módulo del inciso a. considerando ahora que el vector se encuentra ordenado de manera
ascendente.
}
{
 a. Dado un vector de enteros de a lo sumo 500 valores, realice un módulo que reciba dicho vector y un valor
n y retorne si n se encuentra en el vector o no.
b. Modifique el módulo del inciso a. considerando ahora que el vector se encuentra ordenado de manera
ascendente.
}                                    

{
 a. Dado un vector de enteros de a lo sumo 500 valores, realice un módulo que reciba dicho vector y un valor
n y retorne si n se encuentra en el vector o no.
b. Modifique el módulo del inciso a. considerando ahora que el vector se encuentra ordenado de manera
ascendente.
}                                    


program ejercicio1;
const 
    DF=2; //a lo sumo
type
    rango=1..DF;
    vector=array [rango] of integer;

//PROCESOS
procedure CargarVector(var v:vector; var diml:integer);
var 
    num:integer;
begin
    writeln('Ingrese un numero entero');
    readln(num);
    diml:=0;
    while(diml < DF)do
    begin
        diml:=diml+1;
        v[diml]:=num;
        readln(num);
    end;
end;
function Buscar(v:vector; diml,n:integer):boolean;
var
    i:integer;
    ok:boolean;
begin
    i:=1;
    ok:=false;
    while(i <= diml) and not(ok)do
    begin
       if (v[i] <> n) then i:=i+1
                      else Buscar:=true;
    end;
    Buscar:=ok;
end;
procedure Ordenar(var v:vector;diml:integer);
var
    i,aux:integer;
begin
    i:=1;
    while (i < dimL)do
    begin
        while ( (i+1 <= dimL) and (v[i] > v[i+1]) ) do
        begin
            aux:= v[i];
            v[i]:=v[i+1];
            v[i+1]:=aux;
            i:=i+1;
        end;
    end;
end;

function Dicotomica (v:vector; dL:integer; valor:integer):boolean;
Var 
    pri, ult, medio : integer;
    ok:boolean;
Begin
    ok:= false;
    pri:= 1 ;  ult:= dL;  medio := (pri + ult ) div 2 ;
    while ( ( pri <= ult ) and ( valor <> v[medio]) ) do 
    begin
        if ( valor < v[medio] ) then ult:= medio-1
                                else pri:= medio+1 ;
        medio := ( pri + ult ) div 2 ;
    end;
    if (pri <= ult) and (valor = v[medio]) then ok:=true; 
    Dicotomica:= ok;
end;
//PP
var
    v:vector;
    diml,n:integer;
    //diml:integer;
begin
  CargarVector(v,diml);
  writeln('Ingrese el numero a buscar');
  readln(n);
  if( Buscar(v,diml,n) )then writeln('Se encontro')
                            else writeln('No encontro');
  //Ordenar(v,diml);
  if( Dicotomica(v,diml,n) ) then writeln('Se encontro')
                                else writeln('No encontro');
end.

