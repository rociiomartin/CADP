{
 Se dispone de un vector con 100 números enteros. Implementar los siguientes módulos:
a) posicion: dado un número X y el vector de números, retorna la posición del número X en dicho vector,
o el valor -1 en caso de no encontrarse.
b) intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números, y retorna el mismo vector
donde se intercambiaron los valores de las posiciones x e y.
c) sumaVector: retorna la suma de todos los elementos del vector.
d) promedio: devuelve el valor promedio de los elementos del vector.
e) elementoMaximo: retorna la posición del mayor elemento del vector
f) elementoMinimo: retorna la posicion del menor elemento del vector
}


program ejercicio4;
const
  dimF = 100;  { Dimensión física del vector }
type
  rango=1..dimF;
  vector = array[rango] of integer; //se dispone

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
//-------------
procedure IncisoA(v: vector; dimL: integer);
var
  i:rango;
begin
  for i := 1 to dimL do
    writeln('Elemento ', i, ': ', v[i]);
end;
{ MEJORAR
function BuscarPosicionEnVector(numero: Integer; vector: Vector; dimLogica: Integer): Integer;
begin
  for i := 1 to dimLogica do
  begin
    if vector[i] = numero then
    begin
      BuscarPosicionEnVector := i;  { Se encontró el número, retorna la posición }
      Exit;
    end;
  end;
  BuscarPosicionEnVector := -1;  { No se encontró el número, retorna -1 }
end;
}
//PP
var
  v: vector;
  dimL: integer;
begin
  CargarVector(v,dimL); //se dispone
  IncisoA(v, dimL);
  
end.
