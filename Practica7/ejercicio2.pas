{
Implementar un programa que lea y almacene información de clientes de una empresa aseguradora
automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza
contratada (1..6) y monto básico que abona mensualmente. La lectura finaliza cuando llega el cliente
con código 1122, el cual debe procesarse.

La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el
cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene
contratada.
Una vez finalizada la lectura de todos los clientes, se pide:
a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente
por su seguro automotriz (monto básico + monto adicional).
b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la
estructura.
}

program ejercicio2;
const
    FIN=1122;
    DF=6;
type
    cadena20=string[20];
    rango=1..DF;
    cliente= record
                cod:integer; //corte de control
                dni:integer;
                apellido:cadena20;
                nombre:cadena20;
                codP:rango;
                monto:real
              end;
    
    lista=  ^nodo;
    nodo = record 
            datos:cliente;
            sig:lista;
           end;
    
    vectorPoliza = array [rango] of real; //se dispone    
           
//PROCESOS

procedure CargarVector(var v:vectorPoliza); //SE DISPONE
var 
    i:rango;
    monto:real;
begin
    writeln('Ingrese 6 montos');
    for i:=1 to DF do
    begin
        readln(monto);
        v[i]:=monto;
    end;
end;
procedure CargarLista(var l : lista);
    
    procedure LeerClientes(var c:cliente);
    begin
        writeln(' Ingrese el codigo --FIN 1122 -- ');
        readln(c.cod);
        writeln(' Ingrese el dni ');
        readln(c.dni);
        writeln(' Ingrese el apellido');
        readln(c.apellido);
        writeln(' Ingrese el nombre');
        readln(c.nombre);
        writeln(' Ingrese el codigo de poliza');
        readln(c.codP);
        writeln(' Ingrese el monto');
        readln(c.monto);
        writeln('------------------------------------------------');
    end;
    procedure AgregarAdelante (var l:lista; c:cliente);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= c;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   c:cliente;
begin
    repeat
        LeerClientes(c);
        AgregarAdelante(l,c);
    until c.cod = FIN
end;

procedure RecorrerListayVector(l:lista; v:vectorPoliza);
    function Cumple(dni:integer):boolean;
    var
        cant:integer;
    begin
        cant:=0;
        while(dni <> 0)do
        begin
           if ((dni mod 10 )= 9 ) then cant:=cant+1;
           dni:=dni div 10;
        end;
        Cumple:= cant >= 2;
    end;
var
    aux:real;
begin
    writeln('Monto completo para cada cliente: ');
    while (l <> nil) do
    begin
        aux:=l^.datos.monto+ v[l^.datos.codP];
        writeln( '-->Cliente: ', l^.datos.dni, ' ,', l^.datos.nombre, ', ',l^.datos.apellido, ', ',aux:00:00);
        writeln('------------------------------------');
        if ( Cumple (l^.datos.dni) ) then writeln ('Clientes cuyo DNI contiene al menos dos dígitos 9: ', l^.datos.nombre, ', ',l^.datos.apellido);
        l:=l^.sig
    end;
end;


procedure Eliminar (Var l: lista; cod:integer);
Var
 actual,ant:lista;

Begin
  actual:=l; 
  while (actual <> nil) do
  begin
    if (actual^.datos.cod <> cod) then 
    begin
        ant:=actual;  
        actual:= actual^.sig
    end
    else 
    begin
      if (actual = l) then l:= l^.sig
                      else ant^.sig:= actual^.sig;
      dispose (actual);
      actual:= ant;
    end;
  end;
End;
//PP
var
    v:vectorPoliza;
    l:lista;
    cod:integer;
begin
    CargarVector(v); //se dispone
    l:=nil;
    CargarLista(l);
    RecorrerListayVector(l,v);
    writeln('Ingrese un cod a eliminar');readln(cod);
    Eliminar(l,cod);
end.
