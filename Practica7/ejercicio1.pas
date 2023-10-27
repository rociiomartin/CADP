{

NO ESTA TERMINADO

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
    FIN=33555444;
    DF=5;
type
    cadena40=string[40];
    rango=1..DF;
    persona= record
                dni:integer; //corte de control
                nomApellido:cadena40;
                edad:integer;
                codG:rango;
              end;
    
    lista=  ^nodo;
    nodo = record 
            datos:persona;
            sig:lista;
           end;
    
    vectorContador = array [rango] of real; //se dispone    
           
//PROCESOS

procedure CargarLista(var l : lista);
    
    procedure LeerPersonas(var p:persona);
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
    procedure AgregarAdelante (var l:lista; p:persona);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= p;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   p:persona;
begin
    repeat
        LeerPersonas(p);
        AgregarAdelante(l,p);
    until p.dni = FIN
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
    cant:integer;
begin
    cant:=0;
    InicializarVector(v);
    while (l <> nil ) do
    begin
    
    end;
    writeln ('la cantidad de personas cuyo DNI contiene más dígitos pares que impares: ', cant);
end;

procedure ObtenerMaximo(v:vectorContador);
    procedure Maximo (cod,cant:integer; var cod1,cod2,max1,max2:integer);
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
var
    cod1,cod2,max1.max2:integer;
    i:rango;
begin
    max1:=-1; max2:=-1;
    for i:= 1 to DF Maximo(i,v[i],cod1,cod2,max1.max2);
    writeln(':' ,cod1,' ',cod2);
end;

procedure Eliminar (var l: lista; dni:integer);
Var
 actual,ant:lista;

Begin
  actual:=l; 
  while (actual <> nil) do
  begin
    if (actual^.datos.dni <> dni) then 
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
    v:vectorContador;
    l:lista;
    dni:integer;
begin
    l:=nil;
    CargarLista(l);
    RecorrerLista(l,v);
    ObtenerMaximo(v);
    writeln('Ingrese un dni a eliminar');readln(dni);
    Eliminar(l,dni);
end.
