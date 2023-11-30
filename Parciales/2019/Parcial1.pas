{

CADP 2019. Segundo recuperatorio - COMPLETO
19/7/2019
Una editorial vende libros de apoyo escolar para varias materias, codificadas de la siguiente forma: 1) Historia; 2) Geografía; 
3) Matemática; 4) Biología; 5) Física; 6) Química y 7) Lengua. El catálogo de la editorial consta de 5000 libros con la siguiente 
información: código de libro (entre 1 y 5000), código de materia (entre 1 y 7), título, año de edición, precio de venta y apellido
del autor. 
La editorial dispone de una estructura de datos con información de todas las ventas realizadas. De cada venta se conoce el código
del libro, el DNI del cliente y el mes y año de la venta.
Realizar un programa que:

1. Lea y almacene la información de los todos los libros del catálogo de la editorial. Los libros son ingresados sin ningún 
orden particular.

2. Una vez leído y almacenado el catálogo de libros, procese la información de las ventas (que dispone la editorial), 
calcule e informe: 
a. Las dos materias con mayor cantidad de libros vendidos.
b. Para las ventas a clientes con DNI sin dígitos pares, en las cuales el libro vendido fue editado entre los años 2011 y 2017,
informar el año de la venta y el título del libro vendido.
c. El porcentaje de ventas en las que el precio del libro vendido superó los $2000.
}



program parcial;
const 
    DFl=5000;
    DFm=7;
type
    rangoM=1..DFm;
    rangoL=1..DFl;
    rangoMes=1..12;
    cadena15=string[15];
    cadena30=string[30];
    
    libro=record 
            codL:rangoL;
            codM:rangoM;
            titulo:cadena30;
            anioE:integer;
            precio:real;
            apeAutor:cadena15;
           end;
    vector = array [rangoL] of libro;
    
           
    venta=record
            codL:rangoL;
            dni:integer;
            mes:rangoMes;
            anio:integer;
           end;
    
    lista=^nodo;
    nodo=record 
            datos:venta;
            sig:lista;
          end;
    
    vectorContador= array [rangoM] of integer;
   
//PROCESOS
procedure CargarVector(var v:vector);
    procedure LeerLibro(var l:libro);
    begin
        with l do 
        begin
            writeln('Ingrese el codigo de libro ');
            readln(codL);
            writeln('Ingrese el codigo de materia');
            readln(codM);
            writeln('Ingrese el titulo');
            readln(titulo);
            writeln('Ingrese el año de edición');
            readln(anioE);
            writeln('Ingrese el precio ');
            readln(precio);
            writeln('Ingrese el apellido del autor');
            readln(apeAutor);
            writeln('-------------------------------------------------')
        end;
    end;
var
    l:libro;
    i:rangoL;
begin
    for i:=1 to 3 do //cambiar a 5000
    begin
        LeerLibro(l);
        v[l.codL]:=l;
    end;
end;

{se dispone
procedure CargarLista(var l:lista);  
    procedure LeerVenta(var v:venta);
    begin
        with v do 
            begin
                writeln('Ingrese el codigo de libro ');
                readln(codL);
                if (codL <> DFl)then 
                begin
                    writeln('Ingrese el dni ');
                    readln(dni);
                    writeln('Ingrese el mes ');
                    readln(mes);
                    writeln('Ingrese el año ');
                    readln(anio);
                    writeln('-------------------------------------------------')
                end;
            end;
    end;
    procedure AgregarAdelante (var l:lista; v:venta);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= v;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
    v:venta;
begin
    writeln ('----LEER LISTA---');
    LeerVenta(v);
    while (v.codL <> DFl )do
    begin
        AgregarAdelante(l,v);
        LeerVenta(v);
    end;
end;
}
procedure Recorrer (v:vector; l:lista; var vc:vectorContador );
    procedure InicialiarVector (var vc:vectorContador); 
    var
        i:rangoM;
    begin
        for i:=1 to DFm do vc[i]:=0;
    end;
    function Impares(dni:integer):boolean;
    var 
        ok:boolean;
    begin
        ok:=true;
        while (dni <> 0) and (ok) do
        begin
            if ( (dni mod 2)= 0) then ok:=false;
            dni:=dni div 10;
        end;
        Impares:=ok;
    end;
var
    cantT,cant:integer;
    porcentaje:real;
begin
    InicialiarVector(vc);
    cantT:=0; cant:=0;
    while (l <> nil) do
    begin 
        vC[ v[l^.datos.codL].codM ] := vC[ v[l^.datos.codL].codM ] +1;
        if ( Impares (l^.datos.dni) ) and ( (v[l^.datos.codL].anioE >= 2011 ) and (v[l^.datos.codL].anioE <= 2017) )then write (' las ventas a clientes con DNI sin dígitos pares, en las cuales el libro vendido fue editado entre los años 2011 y 2017 : ');
        writeln( l^.datos.anio, ' ', v[l^.datos.codL].titulo );
        if ( v[l^.datos.codL].precio > 2000 )then cant:=cant+1;
        cantT:=cantT+1;
        l:=l^.sig;
    end;
    porcentaje:=(cant/cantT)*100;
    writeln (' El porcentaje de ventas en las que el precio del libro vendido superó los $2000: ', porcentaje:00:00, '%');
end;

procedure ObtenerMaximo (v:vectorContador);
     procedure Maximo(var m1,m2,max1,max2:integer; materia,cant:integer);
        begin
            if ( cant > max1 )then
            begin
                max2:= max1;
                m2:= m1;
                max1:= cant;
                m1:= materia;
            end
            else
            if ( cant > max2 )then
            begin
                max2:=cant;
                m2:=materia;
            end;
            
        end;
var
    i:rangoM;
    max1,max2,m1,m2:integer;
begin
    max1:=-1; max2:=-1; 
    m1:= 0; m2:=0; //no es necesario
    for i:=1 to DFm do Maximo (m1,m2,max1,max2, i, v[i]);
    writeln (' Las dos materias con mayor cantidad de libros vendidos: ', m1, ' ', m2);
end;
//PP
var
    v:vector;
    l:lista;
    vc:vectorContador;
begin
  CargarVector(v);
  CargarLista(l); //se dispone
  Recorrer(v,l,vc);
  ObtenerMaximo(vc);
end.
