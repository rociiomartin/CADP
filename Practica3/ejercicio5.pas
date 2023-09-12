{
Realizar un programa que lea información de autos que están a la venta en una concesionaria. De cada auto se lee:
marca, modelo y precio. La lectura finaliza cuando se ingresa la marca “ZZZ” que no debe procesarse. La
información se ingresa ordenada por marca. Se pide calcular e informar:

a. El precio promedio por marca.
b. Marca y modelo del auto más caro.
}

program ejercicio5;
const 
  FIN='ZZZ'; 
type
   cadena10=string [10];
   
   auto=record
          marca:cadena10; //ordenada por este campo
          modelo:cadena10;
          precio:real;
        end;
  
//PROCESOS
Procedure Informar();
        
        Procedure LeerAutos(var a:auto);
        begin
            writeln('Ingrese la marca  -FINALIZA CON  ZZZ -');
            readln(a.marca);
            if (a.marca <> FIN)then
            begin
                writeln('Ingrese el modelo');
                readln(a.modelo);
                writeln('Ingrese el precio');
                readln(a.precio);
            end;
        end;
        Procedure Maximo(var model,mar:cadena10; var max:real; modelo,marca:cadena10; cant:real);
        begin
            if( max < cant)then
            begin
                max:= cant;
                model:= modelo; 
                mar:=marca;
            end
        end;
var 
    a:auto;
    marcaActual,modelMax,marMax:cadena10;
    cantM:integer;
    precio,prome,max:real;
begin
    max:=-1;
    LeerAutos(a);
    while (a.marca <> FIN)do
    begin
       marcaActual:=a.marca; cantM:=0; precio:=0.0;
       while (a.marca <> FIN) and (marcaActual = a.marca)do
       begin
            cantM:=cantm+1;
            precio:=precio+ a.precio;
            Maximo(modelMax,marMax,max,a.modelo,a.marca,a.precio);
            LeerAutos(a);
        end;
        prome:=precio / cantM;
        writeln (' El precio promedio para la marca: ', marcaActual, ' es: ' , prome:00:00);
    end;
    writeln('Marca y modelo del auto más caro.: ', marMax, ' ', modelMax);
end;

//PROGRAMA PRINCIPAL

begin
   Informar();
end.
