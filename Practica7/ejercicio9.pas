{
Un cine posee la lista de películas que proyectará durante el mes de Febrero. De cada película se
tiene: código de película, título de la película, código de género (1: acción, 2: aventura, 3: drama, 4:
suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las
críticas. Dicha estructura no posee orden alguno.

Se pide:

a) Actualizar (en la lista que se dispone) el puntaje promedio otorgado por las críticas. Para ello se
debe leer desde teclado las críticas que han realizado críticos de cine, de cada crítica se lee: DNI
del crítico, apellido y nombre del crítico, código de película y el puntaje otorgado. La lectura
finaliza cuando se lee el código de película -1 y la información viene ordenada por código de
película.
b) Informar el código de género que más puntaje obtuvo entre todas las críticas.
c) Informar el apellido y nombre de aquellos críticos que posean la misma cantidad de dígitos pares
que impares en su DNI.
d) Realizar un módulo que elimine de la lista que se dispone una película cuyo código se recibe
como parámetro (el mismo puede no existir).
}

program ejercicio9;
const 
    FIN=-1;
type
    rango=1..8;
    cadena30=string[30];
    
    pelicula = record
                cod:integer; //ordenada por este campo
                titulo:cadena30;
                codG:rango;
                puntaje:real;
              end;
    lista=^nodo; //se dispone
    nodo = record 
            datos:pelicula;
            sig:lista;
           end;
           
    critica = record
                dni:integer;
                NomApe:cadena30;
                cod:integer; //corte de control
                pun:real;
              end;
    
//PROCESOS
{SE DISPONE}
procedure CargarLista(var l:lista);
    procedure LeerPeliculas(var p:pelicula);
    begin
        writeln(' Ingrese el codigo de pelicula --FIN -1 -- ');
        readln(p.cod);
        if ( p.cod <> FIN )then
        begin
            writeln(' Ingrese el titulo');
            readln(v.titulo);
            writeln(' Ingrese codigo de genero');
            readln(p.codG);
            writeln(' Ingrese el puntaje ');
            readln(p.puntaje);
            writeln('------------------------------------------------');
        end;
    end;
    procedure InsertarOrdenado(var l: lista; p:pelicula);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= p;
        while (act<>nil) and (act^.datos.cod < aux^.datos.cod) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
   p:pelicula;
begin
    l:=nil;
    writeln('--CARGANDO LISTA--');
    LeerPeliculas(p);
    while ( p.cod <> FIN )do
    begin
        InsertarOrdenado(l,p);
        LeerPeliculas(p);
    end;
end;

 procedure LeerCriticas(var c:critica);
    begin
        writeln(' Ingrese el codigo de pelicula --FIN -1 -- ');
        readln(c.cod);
        if ( c.cod <> FIN )then
        begin
            writeln(' Ingrese el dni');
            readln(c.dni);
            writeln(' Ingrese el nombre y apellido');
            readln(c.NomApe);
            writeln(' Ingrese el puntaje ');
            readln(c.pun);
            writeln('------------------------------------------------');
        end;
    end;
a) Actualizar (en la lista que se dispone) el puntaje promedio otorgado por las críticas. Para ello se
debe leer desde teclado las críticas que han realizado críticos de cine, de cada crítica se lee: DNI
del crítico, apellido y nombre del crítico, código de película y el puntaje otorgado. La lectura
finaliza cuando se lee el código de película -1 y la información viene ordenada por código de
película.
b) Informar el código de género que más puntaje obtuvo entre todas las críticas.
c) Informar el apellido y nombre de aquellos críticos que posean la misma cantidad de dígitos pares
que impares en su DNI.
d) Realizar un módulo que elimine de la lista que se dispone una película cuyo código se recibe
como parámetro (el mismo puede no existir).

procedure Actualizar(var l:lista);

var

begin
    while ( l <> nil ) do 
    begin
        codActual:= l^.datos.cod;
        while( ( l <> nil ) and (codActual = l^.datos.cod) )do 
        begin
            l:=l^.sig;
        end;
        
    end;
end;
//pp
var
    l:lista;
begin
    CargarLista(l); //se dispone
end.
