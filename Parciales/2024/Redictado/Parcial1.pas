{
Una fábrica de automóviles necesita un programa para administrar las 900.000 
piezas de los diferentes modelos de automóviles que fabrica. De cada pieza, 
se conoce, código de pieza, descripción, cantidad en stock, costo de la pieza,
código de modelo al que pertenece (1 al 10), stock mínimo y su peso en kg.

A. Leer y almacenar la información de las piezas en una estructura de datos
adecuada. La información debe quedar almacenada en el mismo orden que fue leída, 

B. A partir de la estructura generada en A. se requiere:
1. Realizar una lista de las piezas cuyo stock actual sea Igual al stock mínimo.
2. Calcular el promedio de piezas que pesan más de 1 kg y su código de pieza 
posea al menos 3 dígitos múltiplos de 2.
3. Utilizando la lista generada en B) 1. Calcular e informar los dos codigos de
piezas mas costosas cuyo codigo de modelo sea menor que 5.    
}


program Parcial;
const
    DFP=2; //DFP=90000;
    DFC=10;
type
    cadena30=string[30];
    rango1=1..DFP;
    rango2=1..DFC;
    pieza= record
                cod:integer;
                desc:cadena30;
                cantS:integer;
                costoP:real;
                codM:rango2;
                stockM:integer;
                peso: integer; //en kg
            end;
    vector = array [rango1] of pieza;
    
    lista=^nodo;
    nodo=record
            datos:pieza;
            sig:lista;
        end;
    
//PROCESOS Y FUNCIONES 
procedure CargarVector(var v:vector);
    procedure LeerPieza(var p:pieza);
    begin
        with p do 
        begin
            writeln('Ingrese el codigo');
            readln(cod);
            writeln('Ingrese la descripción');
            readln(desc);
            writeln('Ingrese cantidad de stock');
            readln(cantS);
            writeln('Ingrese el costo de la pieza');
            readln(costoP);
            writeln('Ingrese la cantidad de modelo --1 a 10--');
            readln(codM);
            writeln('Ingrese el stock minimo');
            readln(stockM);
            writeln('Ingrese el peso');
            readln(peso); //en kg
        end;
    end;
var
    p:pieza;
    i:rango1;
begin
    for i:=1 to DFP do 
    begin
        LeerPieza(p);
        v[i]:=p;
    end;
end;

procedure RecorrerVector(v:vector; var l:lista; var cant:integer);
    procedure AgregarAdelante(var l:lista; p:pieza);
    var
        nue:lista;
    begin
        new(nue);
        nue^.datos:=p;
        nue^.sig:=l;
        l:=nue;
    end;
    function Cumple (cod:integer):boolean;
    var
        cant:integer;
    begin
        cant:=0;
        while ( (cod <> 0) and (cant < 3) )do
        begin
            if ( (cod mod 2) = 0 ) then cant:=cant+1;
            cod:=cod div 10;
        end;
        if ( cant = 3) then Cumple:=true
                       else Cumple:=false;
    end;
var
    i:rango1;
begin
    l:=nil; cant:=0;
    for i:=1 to DFP do
    begin
        if (v[i].cantS = v[i].stockM ) then AgregarAdelante(l,v[i]);
        if ( (v[i].peso > 1) and (Cumple(v[i].cod)) ) then cant:=cant+1;
    end;
end;
procedure RecorrerLista(l:lista;var cod1,cod2:integer);
    procedure Maximo(var max1,max2:real; var cod1,cod2:integer; cod:integer; costo:real);
    begin
        if ( max1 < costo )then
        begin
            max2:=max1;
            cod2:=cod1;
            max1:=costo;
            cod1:=cod;
        end
        else
            if ( max2 < costo )then
            begin
                max2:= costo;
                cod2:= cod;
            end;
    end;
var
    max1,max2:real;
begin
    max1:=0.0; max2:=0.0; cod1:= -1; cod2:=-1;
    while ( l<> nil ) do
    begin
        if ( l^.datos.codM > 5) then Maximo(max1,max2,cod1,cod2,l^.datos.cod,l^.datos.costoP);

        l:=l^.sig;
    end;
end;

//PROGRAMA PRINCIPAL

var
    v:vector; 
    l:lista;
    cant,cod1,cod2:integer;
begin
    CargarVector(v);
    RecorrerVector(v,l,cant);
    writeln('El promedio es: ', cant/DFP);
    RecorrerLista(l,cod1,cod2);
    writeln('Los codigos son:', cod1, ' ' ,cod2);
end.   
