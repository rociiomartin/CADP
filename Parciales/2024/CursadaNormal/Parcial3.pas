{
TEMA 1 - CADP 2024 - 29/6/2024
Un supermercado está procesando las compras que realizaron sus clientes. Para ello, dispone de una estructura de datos con todas las compras realizadas, sin ningún orden en particular. De cada compra se conoce: código, año (entre 1980 y 2024), monto y DNI del cliente. Un cliente puede haber realizado más de una compra.
Realizar un programa procese la información de las compras y:
a. Almacene en otra estructura de datos las compras realizadas entre los años 2010 y 2020. Esta estructura debe quedar ordenada por el DNI del cliente.
b. Una vez almacenada la estructura del inciso a, procesar estos datos e informar:
1. El año con menor facturación.
2. Los dos DNI de los clientes que realizaron mayor cantidad de compras.
3. COMPLETO: El monto total facturado de compras con código múltiplo de 10.
}

program ejercicio3;
const 
    DF=2020;
type
    rango=1980..2024;
    rango2=2010..DF;
  
    compra= record
            cod:integer;
            anio:rango;
            monto:real;
            dni:integer;
          end;
          
    lista=^nodo; //se dispone
    nodo = record 
            datos:compra;
            sig:lista;
           end;
           
    vectorAnios = array [rango2]of real;
    
//PROCESOS
{SE DISPONE
procedure CargarLista(var l : lista);
    procedure LeerCompra(var c:compra);
    begin
        writeln(' Ingrese el codigo --FIN -1 -- ');
        readln(v.cod);
        if ( c.cod <> -1 )then
        begin
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
}

procedure CargarLista(var l : lista);//se dispone

procedure CargarLista2(l:lista;var l2:lista);
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
        if ( l^.datos.anio >=2010 ) and ( l^.datos.anio <=2020 ) then InsertarOrdenado(l2,l^.datos);
        l:=l^.sig;
    end;
end;

procedure RecorrerLista(l:lista;var vec:vectorAnios;var dni1,dni2:integer;var montoT:real);
    procedure InicializarDatos(var vec:vectorAnios;var max1,max2:real;var montoT:real);
    var
        i:rango2;
    begin
        for i:=2010 to DF do vec[i]:=0.0;
        max1:=-1;
        max2:=-1;
        montoT:=0.0;
    end;
    procedure Maximo(var max1,max2,dni1,dni2:integer;cant,dni:integer);
    begin
        if ( max1 < cant)then
        begin
            max2:=max1;
            dni2:=dni1;
            max1:=cant;
            dni1:=dni;
        end
        else
            if ( max2 < cant)then
            begin
                max2:=cant;
                dni2:=dni;
            end;
    end;
    function Cumple ( cod:integer):boolean;
    begin
        Cumple:= (cod mod 10) = 0;
    end;
var
    Dniactual,max1,max2,cant:integer;
begin
    InicializarDatos(vec,max1,max2,montoT);
    while( l <> nil)do
    begin
        Dniactual:=l^.datos.dni;
        cant:=0;
        while( l <> nil) and ( l^.datos.dni = Dniactual)do
        begin
            cant:=cant+1;
            vec[l^.datos.anio]:= vec[l^.datos.anio]+ l^.datos.monto;
            if ( Cumple (l^.datos.cod))then montoT:=montoT+ l^.datos.monto;
            l:=l^.sig;
        end;
        Maximo(max1,max2,dni1,dni2,cant,Dniactual);
    end;
end;

procedure ObtenerMinimo(vec:vectorAnios;var anioMin:rango2);
    procedure Minimo(var min:real;var anioMin:rango2;cant:real;anio:rango2);
    begin
        if ( min > cant)then
        begin
            min:=cant;
            anioMin:=anio;
        end;
    end;
var
    i:rango2;
    min:real;
begin
    min:=999.9;
    for i:=2010 to DF do Minimo(min,anioMin,vec[i],i);
end;

//PP
var 
    l,l2:lista;
    vec:vectorAnios;
    dni1,dni2:integer;
    montoT:real;
    anioMin:rango2;
begin
    CargarLista(l);//se dispone
    CargarLista2(l,l2);
    RecorrerLista(l2,vec,dni1,dni2,montoT);
    writeln('Los dos dni de los clientes que realizaron mayor cantidad de compras: ', dni1, ' y ', dni2);
    writeln('El monto total facturado de compras con codigo multiplo de 10 es: ', montoT);
    ObtenerMinimo(vec,anioMin);
    writeln('El anño con menor facturacion fue: ', anioMin);
end.
