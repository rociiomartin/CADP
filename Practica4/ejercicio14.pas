{
}
program ejercicio14;
const
  DF = 5;  
type
  rango=1..DF;
  rango2=1..5;
  rango3=1..100;
  
  
  
  tabla= array [rango] of integer; //se dispone

//PROCESOS
procedure CargarVector(var v:vector);//se dispon
var
    num:integer;
begin
  writeln('Ingrese numeros enteros'); //no se sabe el corte d control
  while(num <> FIN) do
  begin
    read(num);
    diml:=diml+1;
    v[diml] := num;
  end;
end;

//pp


