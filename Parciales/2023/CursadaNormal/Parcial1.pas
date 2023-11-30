{
CADP 2023 - Parcial Primera Fecha - 10/6/2023 - TEMA 1 - 10:30 hs

Una empresa de venta de tickets de tren está analizando la información de los viajes realizados por sus trenes
durante el año 2022. Para ello, se dispone de una estructura de datos con la información de todos los viajes.
De cada viaje se conoce el código de tren, el mes en que se realizó el viaje (entre 1 y 12), la cantidad de
pasajeros que viajaron, y el código de la ciudad de-destino (entre 1 y 20). La información se encuentra
ordenada por código de tren. Además, la empresa dispone de una estructura de datos con información del costo 
del ticket por ciudad destino.
Realizar un programa que procese la información de los viajes y:

A. Genere una lista que tenga por cada código del tren, a cantidad de viajes realizados
B. Informe el mes con mayor monto recaudado. 
C. COMPLETO: Informe el promedio de pasajeros por cada tren entre todos sus viajes.
}

program parcial;
const
    DF1=12;
    DF2=20;
type
    
    rango1=1..DF1;
    rango2=1..DF2;
    
    viaje=record
            cod:integer; //ordenada por este campo
            mes:rango1;
            cantP:integer;
            codCD:rango2;
          end;
    lista=^nodo; //se dispone
    nodo=record
            datos:viaje;
            sig:lista;
          end;
    
    vectorCiudad= array [rango2] of real; //se dispone   
    
    
    viaje2=record
            cod:integer;
            cant:integer;
           end;
    lista2=^nodo2; //se dispone
    nodo2=record
            datos:viaje2;
            sig:lista2;
          end;
          
    vectorContador= array [rango1] of real;
          
//PROCESOS
{SE DISPONE
procedure CargarLista(var l:lista);
    procedure LeerViajes(var v:viaje);
    begin
        with v do
        begin
            writeln('Ingrese el cod --FIN -1 --');
            readln(cod);
            if ( cod <> -1 )then
            begin
                writeln('Ingrese el mes');
                readln(mes);
                writeln('Ingrese cantidad de pasajeros');
                readln(cantP);
                writeln('Ingrese ciudad de destino --1 a 20--');
                readln(codCD);
            end;
        end;
    end;
    procedure InsertarOrdenado(var l: lista; v:viaje);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= v;
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
    v:viaje;
begin
    l:=nil;
    LeerViajes(v);
    while( v.cod <> -1 )do
    begin
        InsertarOrdenado(l,v);
        LeerViajes(v);
    end;
end;
procedure CargarVector(var v:vectorCiudad);
var
    i:rango2;
    precio:real;
begin
    writeln('Ingrese los precios de las 20 ciudades');
    for i:= 1 to DF2 do
    begin
        readln(precio);
        v[i]:=precio;
    end;
end;
}

procedure Recorrer(l:lista; v:vectorCiudad;var l2:lista2; var vec:vectorContador);
    procedure InicializarVector(var vec:vectorContador);
    var
        i:rango2;
    begin
        for i:=1 to DF2 do v[i]:=0;
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
var 
    codActual,cant,cantP:integer;
    promedio:real;
begin
    InicializarVector(vec); l2:=nil; 
    while ( l <> nil ) do
    begin
        codActual:=l^.datos.cod; cant:=0; cantP:=0;
        while( ( l <> nil ) and (codActual = l^.datos.cod) )do
        begin
            cant:=cant+1;
            cantP:=cant + l^.datos.cantP;
            vec[l^.datos.mes]:= vec[l^.datos.mes]+ v[l^.datos.codCD];
            l:=l^.sig;
        end;
        AgregarAdelante(l2,codActual,cant);
        promedio:=cantP / cant;
        writeln('El promedio de pasajeros del tren ' , codActual, ' entre todos sus viajes es: ', promedio:00:00);
    end;
end;

procedure ObtenerMaximo (v:vectorContador);
    procedure Maximo(var max:real;var mesMax:rango1;cant:real;mes:rango1);
    begin
        if( max < cant ) then
        begin
            max:=cant;
            mesMax:=mes;
        end;
    end;
var
    i,mesMax:rango1;
    max:real;
begin
    max:=-1;
    for i:=1 to DF1 do Maximo(max,mesMax,v[i],i);
    writeln('El mes con mayor monto recaudado fue: ', mesMax);
end;
//pp
var
    l:lista; l2:lista2;
    v:vectorCiudad;
    vec:vectorContador;
begin
    CargarLista(l);//se dispone
    CargarVector(v);//se dispone
    Recorrer(l,v,l2,vec);
    ObtenerMaximo(vec);
end.
