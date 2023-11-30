{
REDICTADO CADP 2023 (31/10),TEMA 1
Un restaurante necesita un programa para administrar la información de los platos que ofrece. Se dispone de una estructura con la 
información de los platos. De cada plato se conoce: nombre, precio, categoría (1: Entrada, 2: Principal, 3: Postre, 4: Minuta), 
cantidad de ingredientes y nombre de cada uno de los ingredientes (a lo sumo 10).

Se pide:

A) Generar una nueva estructura con nombre y precio de cada plato que posea "perejil" entre sus ingredientes.
B) Informar las dos categorías con mayor cantidad de platos ofrecidos.
C) Informar el precio promedio de los platos con más de 5 ingredientes.
}

program parcial;
const
    FIN='R'; //inventado
    DFc=4;
    DFi=10;
type
    cadena15=string[15];
    rango1=1..DFc;
    rango2=1..DFi;
    
    vectorIngredientes = array [rango2] of cadena15;
    plato=record
            nombre:cadena15;
            precio:real;
            cate:rango1;
            cantI:rango2;
            ingre: vectorIngredientes;
          end;
    lista=^nodo; //se dispone
    nodo=record 
            datos:plato;
            sig:lista;
           end;
    
    
    plato2=record
            nombre:cadena15;
            precio:real;
           end;
    lista2=^nodo2; 
    nodo2=record 
            datos:plato2;
            sig:lista2;
           end;
    vectorContador = array [rango1] of integer;
    
//PROCESOS
{SE DISPONE
procedure CargarLista(var l:lista); 
    procedure LeerPlato(var p:plato);
        procedure CargarVector(var v:vectorIngredientes; diml:rango2);
        var 
            i:rango2;
            ingrediente:cadena15;
        begin
            writeln('--CARGANDO VECTOR--');
            writeln('Ingrese ', diml, ' ingredientes');
            for i:= 1 to diml do 
            begin
                readln(ingrediente);
                v[i]:=ingrediente;
            end;
        end;
    var
        v:vectorIngredientes;
    begin
        writeln('--CARGANDO LISTA--');
        with p do
        begin
            writeln('Ingrese el nombre --FIN R--');
            readln(nombre);
            if (nombre <> FIN) then
            begin
                writeln('Ingrese el precio');
                readln(precio);
                writeln('Ingrese la categoría --1 a 4--');
                readln(cate);
                writeln('Ingrese la cantidad de ingredientes --1 a 10--');
                readln(cantI);
                CargarVector(ingre,cantI);
                writeln('---------------------------------------');
            end;
        end;
    end;
    procedure AgregarAdelante (var l:lista; p:plato);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= p;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
    p:plato;
begin
    LeerPlato(p);
    while (p.nombre <> FIN)do
    begin
        AgregarAdelante(l,p);
        LeerPlato(p);
    end;
end;
}
procedure CargarLista2(var l2:lista2; l:lista; var vc:vectorContador);
    procedure AgregarAdelante (var l:lista2; p:plato2);
    var
      nuevo:lista2;
    begin
      new (nuevo);
      nuevo^.datos:= p;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
    procedure Agregar(v:vectorIngredientes;diml:integer;nombre:cadena15;precio:real; var l2:lista2);
    var
        p2:plato2;
        i:rango2;
    begin
        ok:=true;
        i:=1;
        while ( (i <= diml) and (ok) ) do
        begin
            if (v[i] = 'perejil')then 
            begin
                ok:=false;
                p2.nombre:=nombre;
                p2.precio:=precio;
                AgregarAdelante(l2, p2);
            end;
            else i:=i+1;
        end;
    end;
    procedure InicializarVector(var vc:vectorContador);
    var
    i:rango1;
    begin
        for i:=1 to DFc do vc[i]:=0;
    end;
var
    cant:integer;
    precioT:real;
begin
    InicializarVector(vc);
    cant:=0; precioT:=0.0;
    while ( l <> nil) do
    begin
        Agregar( l^.datos.ingre,l^.datos.cantI,l^.datos.nombre,l^.datos.precio,l2);
        vc[l^.datos.cate]:=vc[l^.datos.cate]+1;
        if ( l^.datos.cantI > 5 )then cant:=cant+1;
        precioT:=precioT+l^.datos.precio;
        l:=l^.sig;
    end;
    writeln('El precio promedio de los platos con más de 5 ingredientes: ', precioT/cant:00:00);
end;

procedure ObtenerMaximo(v:vectorContador);
    procedure Maximo(var max1,max2,cat1,cat2:integer; cant,cate:integer);
    begin
        if( max1 < cant )then
        begin
            max2:=max1;
            cat2:=cat1;
            max1:=cant;
            cat1:=cate;
        end
        else
        begin
            if ( max2 < cant )then
            begin
                max2:=cant;
                cat2:=cate;
            end;
        end;
    end;    
var
    i:rango1;
    max1,max2,cat1,cat2:integer;
begin
    max1:=-1; max2:=-1;
    for i:=1 to DFc do Maximo(max1,max2,cat1,cat2,v[i],i);
    writeln('Las dos categorías con mayor cantidad de platos ofrecidos: ', cat1, ' y ', cat2);
end;

{procedure Imprimir(l:lista2);
begin
    writeln('-PROBANDOOO-');
    while (l <> nil )do 
    begin
        writeln('Nombre: ', l^.datos.nombre);
        writeln('Precio: ', l^.datos.precio:00:00);
        l:=l^.sig;
    end;
end;}
//PP
var
    l:lista;
    l2:lista2;
    v:vectorContador;
begin
   // l:=nil;
    CargarLista(l);//se dispone
    CargarLista2(l2,l,v);
    ObtenerMaximo(v);
    //Imprimir(l2);
end.
