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
    lista=  ^nodo;
    nodo = record 
            datos:sonda;
            sig:lista;
           end;
           
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
        end;
    end;
var
    l:libro;
    i:rangoL;
begin
    for i:=1 to 4 do
    begin
        LeerLibro(l);
        v[i]:=l;
    end;
end;

{}
procedure CargarLista(var l:lista); //se dispone 
    procedure LeerVenta(var v:venta);
    begin
        with v do 
            begin
                writeln('Ingrese el codigo de libro ');
                readln(codL;
    
    end;
//PP
var
    v:vector;
    l:lista;
begin
  CargarVector(v);
  CargarLista(l); //se dispone
end.

