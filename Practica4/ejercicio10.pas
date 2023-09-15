{

Realizar un programa que lea y almacene el salario de los empleados de una empresa de turismo (a lo
sumo 300 empleados). La carga finaliza cuando se lea el salario 0 (que no debe procesarse) o cuando se
completa el vector. Una vez finalizada la carga de datos se pide:

a) Realizar un módulo que incremente el salario de cada empleado en un 15%. Para ello, implementar un
módulo que reciba como parámetro un valor real X, el vector de valores reales y su dimensión lógica y
retorne el mismo vector en el cual cada elemento fue multiplicado por el valor X.

b) Realizar un módulo que muestre en pantalla el sueldo promedio de los empleados de la empresa.

}


program ejercicio10;
const
    FIN=0; DF=300;//a lo sumo

type
    rango=1..300;
    vector= array[rango] of real;

//PROCESOS
Procedure CargarVector(var v:vector; var diml:integer);
var
    salario:real;
begin   
    diml:=0;
    writeln('Ingrese un salario');
    readln(salario);
    while(salario <> FIN)and (diml<=DF)do 
    begin
        diml:=diml+1;
        v[diml]:=salario;
        readln(salario);
    end;
end;

Procedure Incrementar15 (X:real; var v:vector; diml:integer);
var 
    i:rango;
begin
    for i:= 1 to diml do v[i]:= v[i]*X;
end;

Procedure Promedio (v:vector; diml:integer);
var 
    i:rango;
    suma:real;
begin
    suma:=0;
    for i:= 1 to diml do suma:=suma+ v[i];
    writeln('El sueldo promedio de los empleados de la empresa: '  , (suma/diml));
end;

//PROGRAMA PRINCIPAL
var
    v:vector;
    diml:integer;
begin
    CargarVector(v,diml);
    Incrementar15(0.5,v,diml);
    Promedio(v,diml);
end.
