{
TEMA 1 - CADP 2024 - 29/6/2024
Un supermercado está procesando las compras que realizaron sus clientes. Para ello, dispone de una estructura de datos con todas las compras,
sin ningún orden en particular. De cada compra se conoce código, mes, año (entre 2014 y 2024), monto y el DNI del cliente. Un cliente puede
haber realizado más de una compra.

Realizar un programa lea de teclado un año y luego:
a. Almacene en otra estructura de datos las compras realizadas en el año leído. Esta estructura debe quedar ordenada por DNI del cliente.

b. Una vez almacenada la información, procese los datos del inciso a. e informe:
1. Para cada cliente, el monto total facturado entre todas sus compras.
2. Los dos meses con menor facturación.
3. COMPLETO: La cantidad de compras con código múltiplo de 10.
}
program parcial;
const 
    DFM=12;
    DFA=2024;
type
    rangoM=1..DFM;
    rangoA=2014..DFA;
  
    compra= record
            cod:integer;
            mes:rangoM;
            anio:rangoA;
            monto:real;
            dni:integer;
          end;
          
    lista=^nodo; //se dispone
    nodo = record 
            datos:compra;
            sig:lista;
           end;
           
    vectorMeses = array [rangoM]of real;
    
//PROCESOS
//SE DISPONE
procedure CargarLista(var l : lista);
    procedure LeerCompra(var c:compra);
    begin
        writeln(' Ingrese el codigo --FIN -1 -- ');
        readln(c.cod);
        if ( c.cod <> -1 )then
        begin
          writeln(' Ingrese el mes');
          readln(c.mes);
          writeln(' Ingrese el año');
          readln(c.anio);
          writeln(' Ingrese el monto');
          readln(c.monto);
          writeln(' Ingrese el dni');
          readln(c.dni);
        end;
    end;
    procedure AgregarAdelante(var l:lista; c:compra);
    var
        nue:lista;
    begin
        new(nue);
        nue^.datos:=c;
        nue^.sig:=l;
        l:=nue;
    end;
var
   c:compra;
begin
    l:=nil;
    LeerCompra(c);
    while ( c.cod <> -1 )do
    begin
        AgregarAdelante(l,c);
        LeerCompra(c);
    end;
end;


//procedure CargarLista(var l : lista);//se dispone

procedure CargarLista2(l:lista;var l2:lista;anio:rangoA);
    procedure InsertarOrdenado(var l: lista; c:compra);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= c;
        while (act<>nil) and (act^.datos.dni < aux^.datos.dni) do
        begin
            ant:=act;
            act:=act^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
begin
    l2:=nil;
    while( l <> nil)do
    begin
        if ( l^.datos.anio = anio ) then InsertarOrdenado(l2,l^.datos);
        l:=l^.sig;
    end;
end;

procedure RecorrerLista(l:lista;var vec:vectorMeses;var cant:integer);
    procedure InicializarDatos(var vec:vectorMeses;var cant:integer);
    var
        i:rangoM;
    begin
        for i:=1 to DFM do vec[i]:=0.0;
        cant:=0;
    end;
    function Cumple ( cod:integer):boolean;
    begin
        Cumple:= (cod mod 10) = 0;
    end;
var
    Dniactual:integer;
    montoT:real;
begin
    InicializarDatos(vec,cant);
    while( l <> nil)do
    begin
        Dniactual:=l^.datos.dni;
        montoT:=0.0;
        while( l <> nil) and ( l^.datos.dni = Dniactual)do
        begin;
            vec[l^.datos.mes]:= vec[l^.datos.mes]+ l^.datos.monto;
            montoT:=montoT+ l^.datos.monto;
            if ( Cumple (l^.datos.cod) ) then cant:=cant+1;
            l:=l^.sig;
        end;
        writeln('El monto total facturado para el cliente ', Dniactual, ' es: ', montoT);
    end;
end;

procedure ObtenerMinimo(vec:vectorMeses;var mes1,mes2:rangoM);
    procedure Minimo(var min1,min2:real; var mes1,mes2:rangoM;cant:real;mes:rangoM);
    begin
        if ( min1 > cant)then
        begin
            min2:=min1;
            mes2:=mes1;
            min1:=cant;
            mes1:=mes;
        end
        else
            if ( min2 > cant)then
            begin
                min2:=cant;
                mes2:=mes;
            end;
    end;
var
    i:rangoM;
    min1,min2:real;
begin
    min1:=999.9; min2:=999.9;
    for i:=1 to DFM do Minimo(min1,min2,mes1,mes2,vec[i],i);
end;

//PP
var 
    l,l2:lista;
    vec:vectorMeses;
    anio:rangoA;
    cant:integer;
    mes1,mes2:rangoM;
begin
    CargarLista(l);//se dispone
    writeln('Ingrese un año');readln(anio);
    CargarLista2(l,l2,anio);
    RecorrerLista(l2,vec,cant);
    writeln ('La cantidad de compras con código múltiplo de 10 fueron:', cant);
    ObtenerMinimo(vec,mes1,mes2);
    writeln('Los dos meses con menor facturacion fueron: ', mes1, ' y ',mes2);
end.
