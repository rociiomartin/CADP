{
Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se ingresa
el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular e informar:

a. Porcentaje de productos con stock actual por debajo de su stock mínimo.

b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.

c. Código de los dos productos más económicos.
}

program ejercicio5;
const
    FIN=-1;
type
    producto= record
                cod:integer; //corte de control
                desc:string[30];
                stockA:integer;
                stockM:integer;
                precio:real;
              end;
    
    lista=  ^nodo;
    nodo = record 
            datos:producto;
            sig:lista;
           end;
           
//PROCESOS
procedure CargarLista(var l : lista);
    
    procedure LeerProducto(var p:producto);
    begin
        writeln(' Ingrese el codigo --FIN -1 -- ');
        readln(p.cod);
        if (p.cod <> FIN) then
        begin
            writeln(' Ingrese la descripción ');
            readln(p.desc);
            writeln(' Ingrese stock actual');
            readln(p.stockA);
            writeln(' Ingrese stock minimo');
            readln(p.stockM);
            writeln(' Ingrese precio');
            readln(p.precio);
        end;
    end;
    procedure AgregarAdelante (var l:lista; p:producto);
    var
       nuevo:lista;
    Begin
       new (nuevo);
       nuevo^.datos:= p;
       nuevo^.sig:=nil; 
       if (l = nil) then l:= nuevo
       else 
       begin
         nuevo^.sig:= l;
         l:=nuevo;
       end;
    end;
var
   p:producto;
begin
    LeerProducto(p);
    while ( p.cod <> FIN ) do
    begin
        AgregarAdelante(l,p);
        LeerProducto(p);
    end;
end;

procedure RecorrerLista(l:lista);

    function Impares(cod:integer):boolean;
    var
     cant:integer;
    begin
        cant:=0;
        while ( cod <> 0) do
        begin
            if ( (cod mod 2 )= 1 )then cant:=cant+1;
            cod:=cod div 10;
        end;
        Impares:=(cant >= 3);
    end;
    procedure Minimo(cod:integer; precio: real; var min1,min2:real ; var cod1,cod2:integer);
    begin
        if (precio < min1)then
        begin
            min2:=min1;
            cod2:=cod1;
            min1:=precio;
            cod1:=cod;
        end
        else
            if( precio < min2 )then
            begin
                min2:=precio;
                cod2:=cod;
            end;
    end;
var
    cantP,cantT,cod1,cod2:integer;
    min1,min2:real;
begin
    cantP:=0; 
    cantT:=0;
    min1:=9999; 
    min2:=9999;
    while (l <> nil) do
    begin
        if ( l^.datos.stockM > l^.datos.stockA) then cantP:=cantP+1;
        if ( Impares (l^.datos.cod) ) then writeln (' Descripción del productos con código compuesto por al menos tres dígitos pares: ', l^.datos.desc);
        Minimo(l^.datos.cod, l^.datos.precio, min1, min2, cod1, cod2);
        cantT:=cantT+1;
        l:=l^.sig;
    end;
    
    writeln(' Porcentaje de productos con stock actual por debajo de su stock mínimo: ', ( (cantP / cantT)*100):00:00 ,'%');
    writeln(' Los códigos de los dos productos más económicos: ', cod1, ' ', cod2);
end;

//PP
var
    l:lista;
begin
    l:=nil;
    CargarLista(l);
    RecorrerLista(l);
end.
