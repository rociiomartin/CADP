{
Realizar un programa para una empresa productora que necesita organizar 100 eventos culturales. De cada
evento se dispone la siguiente información: nombre del evento, tipo de evento (1: música, 2: cine, 3: obra de
teatro, 4: unipersonal y 5: monólogo), lugar del evento, cantidad máxima de personas permitidas para el evento
y costo de la entrada. Se pide:

1. Generar una estructura con las ventas de entradas para tales eventos culturales. De cada venta se debe
guardar: código de venta, número de evento (1..100), DNI del comprador y cantidad de entradas
adquiridas. La lectura de las ventas finaliza con código de venta -1.

2. Una vez leída y almacenada la información de las ventas, calcular e informar:
a. El nombre y lugar de los dos eventos que han tenido menos recaudación.
b. La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos pares que impares
y que sean para el evento de tipo “obra de teatro”.
c. Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad máxima de
personas permitidas.
}


program ejercicio11;
const
    DFE=100;
    DFT=5;
    FIN=-1;
type
    cadena15=string[15];
    rangoE=1..DFE;
    rangoT=1..DFT;
    
    evento=record
            nom:cadena15;
            tipo:rangoT;
            lugar:cadena15;
            cantM:integer;
            costo:real;
          end;
    vectorEventos = array [rangoE] of evento; //se dispone
    
    venta=record
            cod:integer; //corte de control
            numE:rangoE;
            dni:integer;
            cantEA:integer;
          end;
    lista= ^nodo;
    nodo = record 
              datos:venta;
              sig:lista;
           end;   
           
    vectorContador=array [rangoE] of real;
    
//PROCESOS
{SE DISPONE}
procedure CargarVector(var v:vectorEventos);
    procedure LeerEvento(var e:evento);
    begin
        with e do
        begin
            writeln('Ingrese costo');
            readln(costo);
            writeln('Ingrese el nombre');
            readln(nom);
            writeln('Ingrese el tipo --1 a 5--');
            readln(tipo);
            writeln('Ingrese el lugar');
            readln(lugar);
            writeln('Ingrese la cantidad maxima');
            readln(cantM);
        end;
    end;
var 
    i:rangoE;
    e:evento;
begin
    for i:=1 to DFE do
    begin
        LeerEvento(e);
        v[i]:=e;
    end;
end;

procedure CargarLista(var l:lista);
    procedure LeerVenta(var v:venta);
    begin
        with v do
        begin
            writeln('Ingrese el codigo --FIN -1--');
            readln(cod);
            if ( cod <> FIN )then
            begin
                writeln('Ingrese numero de evento --1 a 100--');
                readln(numE);
                writeln('Ingrese el dni');
                readln(dni);
                writeln('Ingrese la cantidad de entradas adquiridas');
                readln(cantEA);
            end;
        end;
    end;
    procedure AgregarAdelante(var l:lista;v:venta);
    var
        nue:lista;
    begin
        new(nue);
        nue^.datos:=v;
        nue^.sig:=l;
        l:=nue;
    end;    
var 
    v:venta;
begin
    l:=nil;
    LeerVenta(v);
    while ( v.cod <> FIN ) do 
    begin
        AgregarAdelante(l,v);
        LeerVenta(v);
    end;
end;

procedure RecorrerLista(l:lista;vE: vectorEventos; var v:vectorContador;var cant:integer;var aux:boolean);
    procedure InicializarDatos(var v:vectorContador;var cant:integer;var aux:boolean);
    var 
        i:rangoE;
    begin
        for i:= 1 to DFE do v[i]:=0.0;
        cant:=0;
        aux:=false;
    end;
    function Cumple (dni:integer):boolean;
    var
        cantP,cantI:integer;
    begin   
        cantP:=0; cantI:=0;
        while ( dni <> 0)do
        begin
            if ( (dni mod 2) = 0 ) then cantP:=cantP+1 
                                   else cantI:=cantI+1;
            dni:=dni div 10;
        end;
        Cumple:= cantP > cantI;
    end;
begin
    InicializarDatos(v,cant,aux);
    while ( l <> nil)do
    begin
        v[l^.datos.numE]:= v[l^.datos.numE] + (vE[l^.datos.numE].costo * l^.datos.cantEA);
        if ( ( Cumple(l^.datos.dni) ) and ( vE[l^.datos.numE].tipo = 3 ) ) then cant:=cant+1;
        if ( vE[50].cantM = l^.datos.cantEA) then aux:=true;
        l:=l^.sig;
    end;
end;

procedure ObtenerMinimos(vE:vectorEventos;v:vectorContador;var nom1,nom2,l1,l2:cadena15);
    procedure Minimo(var min1,min2:real;var nom1,nom2,l1,l2:cadena15;cant:real;nombre,lugar:cadena15);
    begin
        if ( min1 > cant )then
        begin
            min2:=min1; nom2:=nom1; l2:=l1;
            min1:=cant; nom1:=nombre; l1:=lugar;
        end
        else
            if ( min2 > cant )then
            begin
                min2:=cant; nom2:=nombre; l2:=lugar;
            end;
    end;
var
    min1,min2:real;
    i:rangoE;
begin
    min1:=999;min2:=999; nom1:=' '; nom2:= ' '; l1:= ' '; l2:= ' ';
    for i:=1 to DFE do Minimo(min1,min2,nom1,nom2,l1,l2,v[i],vE[i].nom,vE[i].lugar)
end;
//PP
var     
    vE:vectorEventos;
    l:lista;
    v:vectorContador;
    nom1,nom2,l1,l2:cadena15;
    cant:integer;
    aux:boolean;
begin
    CargarVector(vE);//se dispone
    CargarLista(l);
    RecorrerLista(l,vE,v,cant,aux);
    ObtenerMinimos(vE,v,nom1,nom2,l1,l2);
    writeln('El nombre y lugar de los dos eventos que han tenido menos recaudación: ', nom1, ' ',l1,' y ',nom2,' ',l2);
    writeln('La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos pares que impares y que sean para el evento de tipo obra de teatro: ',cant);
    if ( aux ) then writeln( 'La cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad máxima de personas permitidas.')
               else writeln ('La cantidad de entradas vendidas para el evento número 50  no alcanzó la cantidad máxima de personas permitidas.');
end.
