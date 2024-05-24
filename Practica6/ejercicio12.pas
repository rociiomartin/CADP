{
Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de
todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de
Android instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee
(medida en GB). La información disponible se encuentra ordenada por versión de Android. Realizar un
programa que procese la información disponible de todos los dispositivos e informe:
a. La cantidad de dispositivos para cada versión de Android.
b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
c. El tamaño promedio de las pantallas de todos los dispositivos.
}



program ejer12;
const   
    FIN=0;
type
    dispositivo=record
                  version:real;
                  tamaP:integer;
                  RAM:integer;
                end;
            
    lista = ^nodo; //se dispone
    nodo = record
              datos:dispositivo;
              sig:lista;
            end;
//PROCESOS 

{SE DISPONE}
procedure CargarLista(var l:lista);
    procedure LeerDispositivo(var d:dispositivo);
    begin
        writeln('Ingrese la version ');
        readln(d.version);
        if (d.version <> FIN)then
        begin
            writeln('Ingrese tamaño de la pantalla');
            readln(d.tamaP);
            writeln('Ingrese la cantidad de mem RAM');
            readln(d.RAM);
        end;    
    end;
    procedure InsertarOrdenado(var l: lista; d:dispositivo);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= d;
        while (act<>nil) and (act^.datos.version < aux^.datos.version) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
    d:dispositivo;
begin
    l:=nil;
    LeerDispositivo(d);
    while ( d.version <> FIN )do
    begin
        InsertarOrdenado(l,d);
        LeerDispositivo(d);
    end;
end;


procedure RecorrerLista(l:lista;var cant:integer;var prome:real);
var
    versionActual:real;
    cantD,cantP,cantT:integer;
begin
    cant:=0; cantT:=0; cantP:=0;
    while (l <> nil)do
    begin
        versionActual:=l^.datos.version;
        cantD:=0;
        while ( (l <> nil) and (versionActual = l^.datos.version) )do
        begin
            cantD:=cantD+1;
            if ( ( l^.datos.RAM > 3) and (l^.datos.tamaP >= 5) )then cant:=cant+1;
            cantP:=cantP+l^.datos.tamaP;
            l:=l^.sig;
        end;
        writeln('La cantidad de dispositivos para la versión ', versionActual, ' es: ', cantD);
        cantT:=cantT+cant;
    end;
    prome:=cantP/cantT;
end;

//PP
var
    l:lista;
    cant:integer;
    prome:real;
begin
    CargarLista(l);//se dispone
    RecorrerLista(l,cant,prome);
    writeln('La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas: ', cant);
    writeln ('El tamaño promedio de las pantallas de todos los dispositivos: ', prome);
end.


