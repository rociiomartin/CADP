{
Una productora nacional realiza un casting de personas para la selección de actores extras de una
nueva película, para ello se debe leer y almacenar la información de las personas que desean
participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de
género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura
finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.

Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
b. Informar los dos códigos de género más elegidos.
c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho módulo en el programa principal.
}
{
Una productora nacional realiza un casting de personas para la selección de actores extras de una
nueva película, para ello se debe leer y almacenar la información de las personas que desean
participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de
género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura
finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.

Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
b. Informar los dos códigos de género más elegidos.
c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho módulo en el programa principal.
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

procedure CargarLista(var l : lista);
    
    procedure LeerClientes(var c:cliente);
    begin
        writeln(' Ingrese el dni --FIN 345 -- ');
        readln(p.dni);
        writeln(' Ingrese el nombre y apellido');
        readln(p.nomApe);
        writeln(' Ingrese el edad de poliza');
        readln(p.edad);
        writeln(' Ingrese el codigo de poliza');
        readln(p.codP);
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

procedure RecorrerLista (l:lista; var v:vectorContador);
    function Cumple(dni:integer):boolean;
    var
     cantI,cantP:integer;
    begin
        cantI:=0; cantP:=0;
        while ( dni <> 0) do
        begin
            if ( (dni mod 2 )= 1 ) then cantI:=cantI+1;
                                   else cantP:=cantP+1;
            cod:=cod div 10;
        end;
        Cumple:=(cantP > cantI);
    end;
    procedure InicializarVector(var v:vectorContador); 
    var 
        i:rango;
    begin
        for i:=1 to DF do v[i]:=0; 
    end;
var

begin

end;

procedure Maximo (dni,cant:integer; var cod1,cod2,max1,max2:integer);
    begin
        if (cant > max1)then
        begin
            max2:=max1;
            cod2:=cod1;
            max1:=cant;
            cod1:=cod;
        end
        else
            if( cant > max2 )then
            begin
                max2:=cant;
                cod2:=cod;
            end;
    end;
procedure ObtenerMaximo(v:vectorContador);
    
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
    dni:integer;
begin
    l:=nil;
    CargarLista(l);
    RecorrerLista(l,v);
    writeln('Ingrese un dni a eliminar');readln(dni);
    Eliminar(l,cod);
end.
