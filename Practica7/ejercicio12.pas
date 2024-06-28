{
El centro de deportes Fortaco’s quiere procesar la información de los 4 tipos de suscripciones que ofrece:
1)Musculación, 2)Spinning, 3)Cross Fit, 4)Todas las clases. Para ello, el centro dispone de una tabla con
información sobre el costo mensual de cada tipo de suscripción.
Realizar un programa que lea y almacene la información de los clientes del centro. De cada cliente se conoce el
nombre, DNI, edad y tipo de suscripción contratada (valor entre 1 y 4). Cada cliente tiene una sola suscripción.
La lectura finaliza cuando se lee el cliente con DNI 0, el cual no debe procesarse.

Una vez almacenados todos los datos, procesar la estructura de datos generada, calcular e informar:
- La ganancia total de Fortaco’s
- Las 2 suscripciones con más clientes.
- Genere una lista con nombre y DNI de los clientes de más de 40 años que están suscritos a CrossFit o a
Todas las clases. Esta lista debe estar ordenada por DNI.
}

program ejercicio12;
const
    DF=4;
    FIN=0;
type
    cadena15=string[15];
    rango=1..DF;
    
    vectorPrecios = array [rango] of real; //se dispone
    
    cliente = record
                nombre:cadena15;
                dni:integer;
                edad:integer;
                tipo:rango; //solo 1 de 4
            end;
            
    lista = ^nodo;
    nodo = record
            datos:cliente;
            sig:lista;
         end;
    
    vectorContador = array [rango] of integer;
    
    nuevo = record
                nom:cadena15;
                dni:integer;
            end;
            
    lista2 = ^nodo2;
    nodo2 = record
            datos:nuevo;
            sig:lista2;
         end;

//PROCESOS Y FUNCIONES
{SE DISPONE}
procedure CargarVectorPrecios(var v:vectorPrecios);
var 
    i:rango;
    precio:real;
begin
    writeln('Ingrese el precio de las 4 suscripciones');
    for i:=1 to DF do 
    begin
        readln(precio);
        v[i]:=precio;
    end;
end;
//}

procedure CargarLista(var l : lista);
    procedure LeerCliente(var c:cliente);
    begin
        writeln(' Ingrese el dni --FIN 0 -- ');
        readln(c.dni);
        if ( c.dni <> FIN )then
        begin
            writeln(' Ingrese el nombre');
            readln(c.nombre);
            writeln(' Ingrese el edad de la persona');
            readln(c.edad);
            writeln(' Ingrese el tipo --1 a 4--');
            readln(c.tipo);
        end;
    end;
    procedure AgregarAdelante (var l:lista; c:cliente);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= c;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   c:cliente;
begin
    l:=nil;
    LeerCliente(c);
    while (c.dni <> FIN)do
    begin
        AgregarAdelante(l,c);
        LeerCliente(c);
    end;
end;

procedure Recorrer(l:lista; v:vectorPrecios;var monto:real;var vec:vectorContador;var l2:lista2);
    procedure InicializarDatos(var vec:vectorContador; var monto:real;var l2:lista2);
    var
        i:rango;
    begin
        for i:=1 to DF do vec[i]:=0;
        monto:=0;
        l2:=nil;
    end;
    procedure InsertarOrdenado(var l2: lista2; n:nuevo);
    var
        aux,ant,act:lista2;
    begin
        act:=l2;
        ant:=l2;
        new(aux);
        aux^.datos:= n;
        while (act<>nil) and (act^.datos.dni < aux^.datos.dni) do
        begin
            ant:=act;
            act:=act^.sig;
        end;
        if act = l2 then l2:=aux
                    else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
    n:nuevo;
begin
    InicializarDatos(vec,monto,l2);
    while ( l <> nil ) do 
    begin
        monto:= monto + v[l^.datos.tipo];
        v[l^.datos.tipo]:= v[l^.datos.tipo]+1;
        if ( ( l^.datos.edad >  40 ) and (( l^.datos.tipo = 3) or ( l^.datos.tipo = 4)) )then
        begin
            n.nom:=l^.datos.nombre;
            n.dni:=l^.datos.dni;
            InsertarOrdenado(l2,n);
        end;
        l:=l^.sig;
    end;
end;

procedure ObtenerMaximos (vec:vectorContador; var susc1,susc2:rango);
    procedure Maximo(var max1,max2:integer;var susc1,susc2:rango;cant:integer;tipo:rango);
    begin
        if ( max1 < cant )then
        begin
            max2:=max1;
            susc2:=susc1;
            max1:= cant;
            susc1:=tipo;
        end
        else 
            if ( max2 < cant )then
            begin
                max2:= cant;
                susc2:=tipo;
            end;
    end;
var
    i:rango;
    max1,max2:integer;
begin
    max1:=-1; max2:=-1;
    for i:=1 to DF do Maximo(max1,max2,susc1,susc2,vec[i],i);
end;
//PROGRAMA PRINCIPAL
var
    v:vectorPrecios;
    l:lista; l2:lista2;
    monto:real;
    vec: vectorContador;
    susc1,susc2:rango;
begin
    CargarVectorPrecios(v);//se dispone
    CargarLista(l);
    Recorrer(l,v,monto,vec,l2);
    writeln('La ganancia total de Fortaco’s es: ', monto);
    ObtenerMaximos(vec, susc1,susc2);
    writeln('Las 2 suscripciones con más clientes fueron: ', susc1, ' y ', susc2);
end.
