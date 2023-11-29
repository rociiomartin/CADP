{
REDICTADO CADP 2023 (31/10),TEMA 1
Una juguetería necesita un programa para administrar la información de los productos que comercializa. De cada producto se lee
código, descripción, categoría (1: Primera infancia, 2: Didácticos, 3: De mesa, 4: Otros), marca y precio. La lectura finaliza 
cuando se lee el código -1, que no debe procesarse. La información se lee ordenada por marca.
Se pide:
A) Generar una estructura que contenga, para cada marca, la cantidad de productos comercializados. 
B) Informar las dos categorías con menor cantidad de productos comercializados.
C) Informar el precio promedio de los productos con código múltiplo de 3.
}

program parcial;
const
    DF=4;
    FIN=-1;
type
    cadena15=string[15];
    rango1=1..DF;
    
    producto=record
                cod:integer; //corte de control
                descrip:cadena15;
                cate:rango1;
                marca:cadena15; //ordenada por este campo
                precio:real;
            end;
    
    nuevoR=record
                marca:cadena15;
                cant:integer;
            end;
    lista=^nodo;
    nodo=record
            datos:nuevoR;
            sig:lista;
         end;
         
    vectorContador = array [rango1] of integer;    
//PROCESOS

//PP
procedure CargarLista(var l:lista;var v:vectorContador);
    procedure LeerProducto(var p:producto);
    begin
        writeln('Ingrese el codigo --FIN -1-- ');
        readln(p.cod);
        if ( p.cod <> FIN )then
        begin
            writeln('Ingrese la descripcion');
            readln(p.descrip);
            writeln('Ingrese la categoría --1 a 4--');
            readln(p.cate);
            writeln('Ingrese la marca ');
            readln(p.marca);
            writeln('Ingrese el precio');
            readln(p.precio);
        end;
    end;
    procedure AgregarAdelante (var l:lista; n:nuevoR);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= n;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
    procedure InicializarVector(var v:vectorContador);
    var
        i:rango1;
    begin
        for i:=1 to DF do v[i]:=0;
    end;
    function EsMultiplo(cod:integer):boolean;
    begin
        if ( (cod mod 3) = 0 ) then EsMultiplo:=true
                               else EsMultiplo:=false;
    end;
var
    p:producto; n:nuevoR;
    marcaActual:cadena15; cant:integer; 
    cantPrecio:integer; precioPro:real;
begin
    l:=nil; InicializarVector(v); cantPrecio:=0; precioPro:=0.0;
    LeerProducto(p);
    while ( p.cod <> FIN )do
    begin
        marcaActual:=p.marca; cant:=0;
        while( ( p.cod <> FIN ) and (p.marca = marcaActual) )do
        begin
            cant:=cant+1;
            v[p.cate]:= v[p.cate]+1;
            if ( EsMultiplo(p.cod) ) then
            begin
                precioPro:=precioPro+p.precio;
                cantPrecio:=cantPrecio+1;
            end;
            LeerProducto(p);
        end;
        n.marca:=marcaActual;
        n.cant:=cant;
        AgregarAdelante(l,n);
    end;
    writeln ('El precio promedio de los productos con código múltiplo de 3:', precioPro/cantPrecio:00:00);
end;

procedure CalcularMinimo(v:vectorContador);
    procedure Minimo(var min1,min2,cat1,cat2:integer;cant,categoria:integer);
    begin
        if( min1 > cant )then
        begin
            min2:=min1;
            cat2:=cat1;
            min1:=cant;
            cat1:=categoria;
        end
        else
            if( min2 > cant )then
            begin
                min2:=cant;
                cat2:=categoria;
            end;
    end;
var
    i:rango1;
    min1,min2,cat1,cat2:integer;
begin
    min1:=999;min2:=999; 
    for i:=1 to DF do Minimo(min1,min2,cat1,cat2,v[i],i);
    writeln ('Las dos categorías con menor cantidad de productos comercializados: ', cat1, ' y ', cat2);
end;

//PP
var
    l:lista; v:vectorContador;
begin
    CargarLista(l,v);
    CalcularMinimo(v);
end.
