{
REDICTADO DE CADP 2019 - Parcial 3ra Fecha (17/12/2019) - COMPLETO
Un comercio de la ciudad de La Plata necesita un programa para administrar información de las ventas realizadas durante 2019. Para ello, se debe:

A) Leer y almacenar la información de las ventas. De cada venta se lee: código, fecha (día y mes), DNI del cliente y monto. La lectura de 
información finaliza cuando se lee el DNI -1 (que no debe procesarse). La información debe quedar almacenada de manera ordenada por DNI del cliente. 
Tener en cuenta que cada cliente puede aparecer en una o más ventas.

B) Una vez leída y almacenada toda la información, calcular e informar:
1. El monto total gastado por cada cliente.
2. Meses en los cuales se realizaron mayor y menor cantidad de ventas el primer día del mes.
3. Porcentaje de ventas realizadas entre Febrero y Septiembre y con código compuesto por la misma cantidad de dígitos pares que impares.

C) Implementar un módulo que elimine, de la estructura generada en "A)", la venta con código recibido por parámetro. Tener en cuenta que la venta puede 
no existir. El módulo debe retornar si pudo o no eliminarse la venta.
NOTA: Se pide realizar la invocación del módulo.
}

program parcial;
const
    FIN=-1;
    DF=12;
type
    rangoD=1..31;
    rangoM=1..DF;
    fecha=record
            dia: rangoD;
            mes: rangoM;
           end;
    venta=record
            cod:integer;
            f:fecha;
            dni:integer; //corte de control
            monto:real;
          end;

    lista=^nodo;
    nodo=record
            datos:venta;
            sig:lista;
         end;
         
    vectorContador = array [rangoM] of integer;
    
//PROCESOS
procedure CargarLista(var l:lista);
    procedure LeerVenta(var v:venta);
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
    var
        f:fecha;
    begin
        with v do
        begin
            writeln('Ingrese el dni --FIN -1--');
            readln(dni);
            if (dni <> FIN)then
            begin
                writeln('--INGRESE LA FECHA--');
                LeerFecha(f);
                writeln('Ingrese el codigo');
                readln(cod);
                writeln('Ingrese el monto');
                readln(monto);
                writeln('---------------------------------');
            end;
        end;
    end;
    procedure InsertarOrdenado(var l: lista; v:venta);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= v;
        while (act<>nil) and (act^.datos.dni < v.dni) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
    v:venta;
begin
    LeerVenta(v);
    while (v.dni <> FIN) do 
    begin
        InsertarOrdenado(l,v);
        LeerVenta(v);
    end;
end;

procedure RecorrerLista(l:lista; var vc:vectorContador);
    procedure InicializarVector(var vc:vectorContador);
    var
        i:rangoM;
    begin
        for i:= 1 to DF do vc[i]:=0;
    end;
    function Cumple(dni:integer):boolean;
    var
        cantP,cantI:integer;
    begin
        cantP:=0; cantI:=0;
        while ( dni <> 0 ) do
        begin
            if ( ( dni mod 2 ) = 0 )then cantP:=cantP+1
                                    else cantI:=cantI+1; 
            dni:=dni div 10;
        end;
        Cumple:= (cantP = cantI);
    end;
var
    actual,cant,cantT:integer;
    montoTotal,porcentaje:real;
begin
    InicializarVector(vc);
    cant:=0; cantT:=0;
    while ( l <> nil ) do
    begin
        actual:= l^.datos.dni;
        montoTotal:=0;
        while ( l <> nil ) and (actual = l^.datos.dni ) do
        begin
            montoTotal:=montoTotal+ l^.datos.monto;
            if (l^.datos.f.dia = 1)then vc[l^.datos.f.mes]:=vc[l^.datos.f.mes]+1;
            if ( ((l^.datos.f.mes = 2 ) or (l^.datos.f.mes = 9)) and (Cumple (l^.datos.dni)) ) then cant:=cant+1;
            cantT:=cantT+1;
            l:=l^.sig;
        end;  
        writeln('El monto total gastado para el cliente ', actual, ' es: ', montoTotal:00:00);
    end;
    porcentaje:=(cant/cantT)*100;
    writeln('Porcentaje de ventas realizadas entre Febrero y Septiembre y con código compuesto por la misma cantidad de dígitos pares que impares: ', porcentaje:00:00,'%');
end;

procedure RecorrerVector(vc:vectorContador);
    procedure Maximo(var mes1,max:integer; mes, cant:integer);
    begin
        if (cant > max)then
        begin
            max:=cant;
            mes1:=mes;
        end;
    end;
    procedure Minimo(var mes1,min:integer; mes, cant:integer);
    begin
        if (cant < min)then
        begin
            min:=cant;
            mes1:=mes;
        end;
    end;
var
    max,min,mes1,mes2:integer;
    i:rangoM;
begin
    max:=-1; min:=999;
    for i:=1 to DF do 
    begin
        Maximo(mes1,max,i,vc[i]);
        Minimo(mes2,min,i,vc[i]);
    end;
    writeln('Se realizaron cantidad de ventas el primer día del mes: ');
    writeln (' Mes mayor: ' , mes1);
    writeln (' Mes menor: ' , mes2);
end;

 procedure Eliminar (Var l: lista; cod:integer;var ok:boolean);
var
    actual,ant:lista;
begin
    actual:=l; 
    ok:=true;
    while (actual <> nil) and (ok) do
    begin
        if (actual^.datos.cod <> cod) then
        begin
            ant:=actual;
            actual:= actual^.sig;
        end
        else 
        begin
          if (actual = l) then l:= l^.sig 
                          else ant^.sig:= actual^.sig;
          dispose (actual);
          ok:=false;
          actual:= ant;
        end;
    end;
end;
//PP
var
    l:lista;
    vc:vectorContador;
    cod:integer;
    ok:boolean;
begin
    l:=nil;
    CargarLista(l);
    RecorrerLista(l,vc);
    RecorrerVector(vc);
    writeln('Ingrese un codigo a eliminar'); readln(cod);
    Eliminar(l,cod,ok);
    if (not ok) then writeln('Se borro');
end.
