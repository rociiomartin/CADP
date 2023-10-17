{

La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales lanzadas
al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la misión
(cantidad de meses que permanecerá activa), el costo de construcción, el costo de mantenimiento mensual y
rango del espectro electromagnético sobre el que realizará estudios. Dicho rango se divide en 7 categorías:
1. radio; 2. microondas; 3.infrarrojo; 4.luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma

Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura finaliza al
ingresar la sonda llamada “GAIA”, que debe procesarse.

Una vez finalizada la lectura, informar:

a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse la menor cantidad de veces posible
}


program ejercicio6;
const
    FIN='GAIA';
    DF=7;
type
    cadena20=string[20];
    rango=1..DF;
    sonda= record
                nombre:cadena20; //corte de control
                duracion:integer;
                costoC:real;
                costoM:real;
                rangoE:rango;
              end;
    
    lista=  ^nodo;
    nodo = record 
            datos:sonda;
            sig:lista;
           end;
           
    vectorContador = array [rango] of integer; 
           
//PROCESOS
procedure CargarLista(var l : lista);
    
    procedure LeerSondas(var s:sonda);
    begin
        writeln(' Ingrese el nombre --FIN GAIA -- ');
        readln(s.nombre);
        writeln(' Ingrese la duracion ');
        readln(s.duracion);
        writeln(' Ingrese el costo de construccion');
        readln(s.costoC);
        writeln(' Ingrese el costo de mantenimiento mensual');
        readln(s.costoM);
        writeln(' Ingrese el rango');
        readln(s.rangoE);
        writeln('------------------------------------------------');
    end;
    procedure AgregarAdelante (var l:lista; s:sonda);
    var
       nuevo:lista;
    Begin
       new (nuevo);
       nuevo^.datos:= s;
       nuevo^.sig:=nil; 
       if (l = nil) then l:= nuevo
       else 
       begin
         nuevo^.sig:= l;
         l:=nuevo;
       end;
    end;
var
   s:sonda;
begin
    repeat
        LeerSondas(s);
        AgregarAdelante(l,s);
    until s.nombre = FIN
end;

procedure RecorrerListayVector (l:lista; var v:vectorContador; var promeDur:real; var promeCosto:real);

    procedure Maximo(costoT:real; nom:cadena20; var max:real; var nomMax:cadena20);
    begin
        if(costoT > max )then
        begin
            max:=costoT;
            nomMax:=nom;
        end;
    end;
    procedure InicializarVector(var v:vectorContador);
    var
        i:rango;
    begin
        for i:=1 to DF do v[i]:=0;
    end;
var
    auxCosto,max, costoProme:real; nomCostoMax:cadena20;
    durProme,cant:integer; 
begin
    max:=-1; costoProme:=0; durProme:=0;cant:=0;
    InicializarVector(v);
    while(l<> nil)do
    begin
        auxCosto:=l^.datos.costoM+l^.datos.costoC;
        Maximo(auxCosto, l^.datos.nombre,max,nomCostoMax);
        v[l^.datos.rangoE]:=v[l^.datos.rangoE]+1;
        costoProme:=costoProme+l^.datos.costoC;
        durProme:=durProme+l^.datos.duracion;
        cant:=cant+1;
        l:=l^.sig;
    end;
    writeln('El nombre de la sonda más costosa es: ', nomCostoMax);
    promeDur:= durProme/cant;
    promeCosto:= costoProme/cant ;
end;

procedure Imprimir(v:vectorContador);
var
    i:rango;
begin
    for i:=1 to DF do writeln ('Rango ', i , ' tiene: ', v[i]);
end;
    
procedure RecorrerLista(l:lista; promeDur:real; promeCosto:real);
var 
    cantD:integer;
begin
    cantD:=0; 
    while ( l<> nil )do
    begin
        if ( l^.datos.duracion > promeDur ) then cantD:=cantD+1;
        if (l^.datos.costoC > promeCosto) then writeln (' El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sonda: ',l^.datos.nombre );
        l:=l^.sig;
    end;
    writeln(' La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas: ', cantD);
end;

//PP
var
    l:lista;
    v:vectorContador;
    promeDur,promeCosto:real;
begin
    l:=nil;
    CargarLista(l);
    RecorrerListayVector(l,v, promeDur, promeCosto);
    writeln ('La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético: ');
    Imprimir(v);
    RecorrerLista(l,promeDur, promeCosto);
end.
