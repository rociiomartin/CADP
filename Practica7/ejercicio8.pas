{
Una entidad bancaria de la ciudad de La Plata solicita realizar un programa destinado a la
administración de transferencias de dinero entre cuentas bancarias, efectuadas entre los meses de
Enero y Noviembre del año 2018.

El banco dispone de una lista de transferencias realizadas entre Enero y Noviembre del 2018. De cada
transferencia se conoce: número de cuenta origen, DNI de titular de cuenta origen, número de cuenta
destino, DNI de titular de cuenta destino, fecha, hora, monto y el código del motivo de la
transferencia (1: alquiler, 2: expensas, 3: facturas, 4: préstamo, 5: seguro, 6: honorarios y 7: varios).
Esta estructura no posee orden alguno.

Se pide:

a) Generar una nueva estructura que contenga sólo las transferencias a terceros (son aquellas en las
que las cuentas origen y destino no pertenecen al mismo titular). Esta nueva estructura debe
estar ordenada por número de cuenta origen.

Una vez generada la estructura del inciso a), utilizar dicha estructura para:
b) Calcular e informar para cada cuenta de origen el monto total transferido a terceros.
c) Calcular e informar cuál es el código de motivo que más transferencias a terceros tuvo.
d) Calcular e informar la cantidad de transferencias a terceros realizadas en el mes de Junio en las
cuales el número de cuenta destino posea menos dígitos pares que impares.
}



program ejercicio8;
const
    DF=7;
type
    rangoD=1..31;
    rangoM=1..11;
    rangoC=1..DF;
    
    fecha =record
             dia:rangoD;
             mes:rangoM;
             //año es 2018
           end;
           
    transferencia=record
                numO:integer;
                dniCO:integer;
                numD:integer;
                dniCD:integer;
                fe:fecha; 
                hora:integer;
                monto:real;
                cod:rangoC;
           end;
           
    lista=  ^nodo; //se dispone sin orden
    nodo = record 
            datos:transferencia;
            sig:lista;
           end;
           
    vectorCodigos= array [rangoC] of integer;
    
//PROCESOS
procedure CargarLista(var l : lista);
    procedure LeerTransferencia(var t:transferencia);
        procedure LeerFecha(var f:fecha);
        begin
            with f do 
            begin
                writeln('Ingrese el dia');
                readln(dia);
                writeln('Ingrese el mes');
                readln(mes);
            end;
        end;
    begin
        with t do
        begin
            writeln(' Ingrese el numero de cuenta origen--FIN -1 -- ');
            readln(numO);
            if ( numO <> -1 ) then
            begin
                writeln(' Ingrese el dni de cuenta origen');
                readln(dniCO);
                writeln(' Ingrese el numero de cuenta destino');
                readln(numD);
                writeln(' Ingrese el dni de cuenta destino');
                readln(dniCD);
                writeln(' Ingrese la fecha');
                LeerFecha(fe);
                writeln(' Ingrese el monto');
                readln(monto);
                writeln(' Ingrese el codigo');
                readln(cod);
            end;
        end;
        writeln('------------------------------------------------');
    end;
    procedure AgregarAdelante (var l:lista; t:transferencia);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= t;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   t: transferencia;
begin
    l:=nil;
    LeerTransferencia(t);
    while ( t.numO <> -1 )do 
    begin
        AgregarAdelante(l,t);
        LeerTransferencia(t);
    end;
end;


procedure CargarNuevaLista(l:lista; var l2:lista);
    procedure InsertarOrdenado(var l: lista; t:transferencia);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= t;
        while (act<>nil) and (act^.datos.numO < aux^.datos.numO) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
begin
    l2:=nil;
    while ( l <> nil)do
    begin
        if ( l^.datos.dniCO <> l^.datos.dniCD)then InsertarOrdenado (l2,l^.datos);
        l:=l^.sig;
    end;
end;

procedure RecorrerLista(l:lista;var v:vectorCodigos;var cant:integer);
    procedure InicializarDatos(var v:vectorCodigos;var cant:integer);
    var
        i:rangoC;
    begin
        for i:=1 to DF do v[i]:=0;
        cant:=0;
    end;
    function Cumple(num:integer):boolean;
    var 
        cantP,cantI:integer;
    begin
        cantP:=0; cantI:=0;
        while ( num <> 0 )do 
        begin
            if ( (num mod 2) = 0)then cantP:=cantP+1
                                 else cantI:=cantI+1;
            num:=num div 10;
        end;
        Cumple:= (cantP < cantI);
    end;
var
    cuentaActual:integer;
    montoT:real;
begin
    InicializarDatos(v,cant);
    while ( l <> nil)do
    begin
        cuentaActual:=l^.datos.numO;
        montoT:=0;
        while( ( l <> nil ) and ( cuentaActual = l^.datos.numO) )do
        begin
            montoT:=montoT+l^.datos.monto;
            v[l^.datos.cod]:=  v[l^.datos.cod]+1;
            if( ( l^.datos.fe.mes = 6) and (Cumple (l^.datos.numD)) ) then cant:=cant+1;
            l:=l^.sig;
        end;
        writeln('El monto total transferido a terceros es: ', montoT);
    end;
end;

procedure ObtenerMaximo(v:vectorCodigos);
    procedure Maximo(var max:integer;var codMax:rangoC;cant:integer;codigo:rangoC);
    begin
        if ( max < cant )then
        begin
            max:= cant;
            codMax:=codigo;
        end;
    end;
var
    i,codMax:rangoC;
    max:integer;
begin
    max:=-1;
    for i:= 1 to DF do Maximo(max,codMax,v[i],i);
    writeln('el código de motivo que más transferencias a terceros tuvo fue: ', codMax);
end;
//PROGRAMA PRINCIPAL
var
    l,l2:lista;
    cant:integer;
    v:vectorCodigos;
begin
    CargarLista(l); //se dispone
    CargarNuevaLista(l,l2);
    RecorrerLista(l2,v,cant);
    writeln('la cantidad de transferencias a terceros realizadas en el mes de Junio en las cuales el número de cuenta destino posea menos dígitos pares que impares fue: ', cant);
    ObtenerMaximo(v);
end.
