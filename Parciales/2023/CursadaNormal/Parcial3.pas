{
CADP 2023 - Parcial Primera Fecha - 10/6/2023 - TEMA 2 - 8:00 AM

Una empresa de ventas de pasajes en colectivo está analizando la información de los viajes realizados a Mar del Plata en el último 
año. Para ello, se dispone de una estructura de datos con la información de todos los viajes realizados. De cada viaje se conoce el
código de viaje, el número de coche (entre 1000 y 2500), el mes en que se realizó el viaje, cantidad de pasajes vendidos y el dni 
del chófer. La información no se encuentra ordenada por ningún criterio. Además, la empresa dispone de una estructura de datos con
información sobre la capacidad máxima de cada coche.
Realizar un programa que procese la información de los viajes e:

A. Informe el número de coche con el cual se realizaron más viajes.
B. Genere una lista con los viajes realizados en el mes 2 por un chofer con dni múltiplo de 10, donde la cantidad de pasajes
vendidos no alcanza la capacidad máxima del coche.
C. COMPLETO: Para cada coche, informe el promedio de pasajeros que viajaron entre todos sus viajes.
}


program parcial;
const   
    DF=2500;
type
    rango1=1000..DF;
    rango2=1..12;
    
    viaje=record
            cod:integer;
            numC:rango1;
            mes:rango2;
            cantV:integer;
            dni:integer;
          end;
    lista=^nodo; //se dispone
    nodo=record 
            datos:viaje;
            sig:lista;
           end;
    VectorCapacidad = array [rango1] of integer; // se dispone
    
    nueva=record
            dni:integer;
            cant:integer;
          end;
          
    lista2=^nodo2; 
    nodo2=record 
            datos:viaje;
            sig:lista2;
           end;
    vectorContador = array [rango1] of integer;
           
//PROCESOS
//SE DISPONE
procedure CargarLista(var l:lista);
    procedure LeerViajes(var v:viaje);
    begin
        with v do
        begin
            writeln('Ingrese el dni --FIN 0--');
            readln(dni);
            if ( dni <> 0 )then
            begin
                writeln('Ingrese codigo');
                readln(cod);
                writeln('Ingrese mes');
                readln(mes);
                writeln('Ingrese la cantidad de pasajes vendidos');
                readln(cantV);
                writeln('Ingrese el numero de coche --1000 a 2500--');
                readln(numC);
            end;
        end;
    end;
    procedure AgregarAdelante (var l:lista; v:viaje);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= v;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   v:viaje;
begin
    l:=nil;
    LeerViajes(v);
    while( v.dni <> 0 )do
    begin
        AgregarAdelante(l,v);
        LeerViajes(v);
    end;
end;

procedure CargarVector(var v:VectorCapacidad);
var
    i:rango1;
    cap:integer;
begin
    writeln('Ingrese las capacidades maximas');
    for i:=1000 to DF do 
    begin
        readln(cap);
        v[i]:=cap;
    end;
end;

C. COMPLETO: Para cada coche, informe el promedio de pasajeros que viajaron entre todos sus viajes.

procedure Recorrer(l:lista;v:VectorCapacidad;var l2:lista2;var vec:vectorContador);
    procedure InicializarVector(var vec:vectorContador);
    var
        i:rango1;
    begin
        for i:=1000 to DF do vec[i]:=0;
    end;
    function Cumple(dni:integer):boolean;
    begin
        if ( (dni mod 10 ) = 0 ) then Cumple:=true 
                                 else Cumple:=false;
    end;
    procedure AgregarAdelante (var l:lista2; n:nueva);
    var
      nuevo:lista2;
    begin
      new (nuevo);
      nuevo^.datos:= n;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var

begin
    InicializarVector(vec); l2:=nil; 
    while ( l <> nil )do
    begin
        v[l^.datos.numC]:= v[l^.datos.numC]+1;
        if ( (l^.datos.mes = 2 ) and ( Cumple(l^.datos.dni) ) and (l^.datos.cantV < v[l^.datos.numC]) ) then AgregarAdelante(l2,l^.datos);
        l:=l^.sig;
    end;
end;

procedure ObtenerMaximo(v:vectorContador);
    procedure Maximo(var max:integer; var numMax:rango1;cant:integer;num:rango1);
    begin
        if ( max < cant ) then
        begin
            max:=cant;
            numMax:=num;
        end;
    end;
var
    i,numMax:rango1;
    max:integer;
begin
    max:=-1;
    for i:=1000 to DF do Maximo(max,numMax,v[i],i);
    writeln('El número de coche con el cual se realizaron más viajes: ', numMax);
end;

var
    l:lista; l2:lista2;
    v:VectorCapacidad;
begin
    CargarLista(l);//se dispone
    CargarVector(v); //se dispone
    Recorrer(l,v,l2);
    ObtenerMaximo(vec);
end.
