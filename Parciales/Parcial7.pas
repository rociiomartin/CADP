{
CADP 2023 Parcial - Primera Fecha - 10/6/2023 - TEMA-2 - 10:30 hs

Un teatro esta analizando la información de los tickets vendidos durante el año 2022. Para ello, se dispone una estructura
de datos con la información de todos los tickets vendidos. De cada ticket se conoce el código del evento, dni del comprador,
mes de la función (entre 1 y 12) y ubicación (1: Palco, 2: Pullman, 3: Platea alta, 4: Platea baja).La informacion se 
encuentra ordenada por código de evento.
Además, la empresa dispone de una estructura de datos con información del costo del ticket por ubicación.

Realizar un programa que procese la información de los tickets y:
A. Genere una lista que tenga por cada código de evento, la cantidad de tickets vendidos.
B. Informe el mes con mayor monto recaudado.
C. COMPLETO: Informe el promedio recaudado por cada evento entre todos sus tickets.
}


program parcial;
const
    DFm=12;
    DFu=4;
type 
    rango1=1..DFm;
    rango2=1..DFu;
    
    ticket=record
            cod:integer; //ordenada por este campo
            dni:integer;
            mes:rango1;
            ubi:rango2;
           end;
    lista=^nodo; //se dispone
    nodo=record 
            datos:ticket;
            sig:lista;
           end;
    vectorUbicacion = array [rango2] of real; //se dispone
    
    
    ticket2=record
                cod:integer;
                cant:integer;
            end;
    lista2=^nodo2; //se dispone
    nodo2=record 
            datos:ticket2;
            sig:lista2;
           end;
           
    vectorContador = array [rango1] of integer;
//PROCESOS
{SE DISPONE}
procedure CargarLista(var l:lista);
    procedure LeerTickets(var t:ticket);
    begin
        with t do
        begin
            writeln('Ingrese el dni --FIN 0--');
            readln(dni);
            if ( dni <> 0 )then
            begin
                writeln('Ingrese codigo');
                readln(cod);
                writeln('Ingrese mes');
                readln(mes);
                writeln('Ingrese ubicacion --1 a 4--');
                readln(ubi);
            end;
        end;
    end;
    procedure InsertarOrdenado(var l: lista; t:ticket);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= t;
        while (act<>nil) and (act^.datos.cod < aux^.datos.cod) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
    t:ticket;
begin
    l:=nil;
    LeerTickets(t);
    while( t.dni <> 0 )do
    begin
        InsertarOrdenado(l,t);
        LeerTickets(t);
    end;
end;
procedure CargarVector(var v:vectorUbicacion);
var
    i:rango2;
    precio:real;
begin
    writeln('Ingrese los precios de las 4 ubicaciones');
    for i:= 1 to DFu do
    begin
        readln(precio);
        v[i]:=precio;
    end;
end;

procedure Recorrer(l:lista; v:vectorUbicacion; var l2:lista2; var vec:vectorContador);
    procedure InicializarVector(var vec:vectorContador);
    var
        i:rango1;
    begin
        for i:=1 to DFm do v[i]:=0;
    end;
    procedure AgregarAdelante (var l:lista2; cod,cant:integer);
    var
      nuevo:lista2;
    begin
      new (nuevo);
      nuevo^.datos.cod:= cod;
      nuevo^.datos.cant:=cant;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
    Function Promedio(total:real;cant:integer):real;
    begin
        Promedio:=total/cant;
    end;
var
    codActual,cant:integer;
    preProme:real;
begin
    InicializarVector(vec); l2:=nil;
    while ( l <> nil )do
    begin       
        codActual:=l^.datos.cod;
        cant:=0; preProme:=0.0;
        while( ( l <> nil ) and ( codActual = l^.datos.cod ) )do
        begin
            cant:=cant+1;
            vec[l^.datos.mes]:= vec[l^.datos.mes]+1;
            preProme:=preProme+ v[l^.datos.ubi];
            l:=l^.sig;
        end;
        AgregarAdelante(l2, codActual, cant);
        writeln(' El promedio recaudado por cada evento entre todos sus tickets', Promedio(preProme,cant):00:00);
    end;

end;

procedure ObtenerMaximo(v:vectorContador);
    procedure Maximo(var max,mes:integer;m,cant:integer);
    begin
        if( max < cant )then
        begin
            max:=cant;
            mes:=m;
        end;
    end;
var
    i:rango1;
    max,mes:integer;
begin
    max:=-1;
    for i:=1 to DFm do Maximo(max,mes,i,v[i]);
    writeln('El mes con mayor monto recaudado: ', mes);
end;
//PP
var
    l:lista; l2:lista2;
    v:vectorUbicacion; vec:vectorContador;
begin
    CargarLista(l); //se dispone
    CargarVector(v);//se dispone
    Recorrer(l,v,l2,vec);
    ObtenerMaximo(vec);
end.
