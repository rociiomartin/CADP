{
 La tienda de libros Amazon Books está analizando información de algunas editoriales. Para ello, Amazon
cuenta con una tabla con las 35 áreas temáticas utilizadas para clasificar los libros (Arte y Cultura, Historia,
Literatura, etc.).
De cada libro se conoce su título, nombre de la editorial, cantidad de páginas, año de edición, cantidad de veces
que fue vendido y código del área temática (1..35).
Realizar un programa que:
A) Invoque a un módulo que lea la información de los libros hasta ingresar el título “Relato de un
náufrago” (que debe procesarse) y devuelva en una estructura de datos adecuada para la editorial
“Planeta Libros”, con la siguiente información:
- Nombre de la editorial
- Año de edición del libro más antiguo
- Cantidad de libros editados
- Cantidad total de ventas entre todos los libros
- Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con más
de 250 ventas.
B) Invoque a un módulo que reciba la estructura generada en A) e imprima el nombre de la editorial y el
título de cada libro con más de 250 ventas.
}


program ejercicio12;
const
    DF=35;
    FIN='Relato de un náufrago';
type
    cadena30=string[30];
    rango=1..DF;
    
    vectorTemas = array [rango] of cadena30; //se dispone
    
    libro = record
                titulo:cadena30;
                nom:cadena30;
                cantP:integer;
                anio:integer;
                cantV:integer;
                cod:rango;
            end;
            
    detalle = record
                titulo:cadena30;
                nomT:cadena30;
                cantP:integer;
              end;
              
    listaDetalle =  ^nodo2;
    nodo2 = record
            datos:detalle;
            sig:listaDetalle;
         end;      
         
    nuevo = record
                nom:cadena30;
                anio:integer;
                cantD:integer;
                cantT:integer;
                de: listaDetalle;
    lista = ^nodo;
    nodo = record
            datos:nuevo;
            sig:lista;
         end;

//PROCESOS Y FUNCIONES
{SE DISPONE}
procedure CargarVectorTematicas(var v:vectorTemas);
var 
    i:rango;
    tema:cadena30;
begin
    writeln('Ingrese las 35 tematicas');
    for i:=1 to DF do 
    begin
        readln(tema);
        v[i]:=tema;
    end;
end;
//}

procedure CargarListaA(var l : lista);
    procedure LeerLibro(var l:libro);
    begin
        with l do
        begin
            writeln(' Ingrese el titulo del libro');
            readln(titulo);
            writeln(' Ingrese el nombre del libro -- ');
            readln(nom);
            writeln(' Ingrese la cantidad de paginas');
            readln(cantP);
            writeln(' Ingrese el año');
            readln(anio);
            writeln(' Ingrese la cantidad de paginas vendidas');
            readln(cantV);
            writeln(' Ingrese la tematica --1 a 35 -- ');
            readln(cod);
        end;
    end;
    procedure AgregarAdelante (var l:lista; n:nuevo);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= n;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
    funcion obtenerMinimo(min,anio:integer):boolean;
    begin
        if ( min > anio )then Minimo:=true
                         else Minimo:= false; 
    end;
{
- Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con más
de 250 ventas.
}
var
   li:libro;
   n:nuevo;
   cantVendida,cant:integer;
begin
    l:=nil;
    cant:=0; cantVendida:=0; min:=999;
    repeat
        LeerLibro(li);
        cantVendida:= cantVendida + li.cantV;
        cant:=cant+1;
        if ( obtenerMinimo(min,li.anio) )then min:=li.anio;
        //n.de -->lista cargarLista (n.de:listaDetalle)
        AgregarAdelante(l,n)
    until ( li.titulo = FIN);
    n.nom:='Planeta Libros';
    n.cantT:= cantVendida;
    n.anio:=min;
    n.cantD=cant;
    AgregarAdelante(l,n)
end;


//PROGRAMA PRINCIPAL
var
    v:vectorTemas;
    l:lista;
begin
    CargarVectorTematicas(v);//se dispone
    CargarLista(l);
end.
