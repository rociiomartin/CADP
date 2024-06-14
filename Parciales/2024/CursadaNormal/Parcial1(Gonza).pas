{
TEMA 2
}

program parcial;
const
    DF=130;
type
    rango=1..DF;
    cadena15=string[15];
    
    repuesto=record
                  cod:integer;
                  precio:real;
                  codM:rango;
                  nomP:cadena15; 
             end;
    lista=^nodo; 
    nodo=record
            datos: repuesto;
            sig: lista;
          end;
      
    vectorMarcas = array [rango] of string;
    
    vectorPrecios = array [rango] of real;

procedure CargarLista(var l:lista); //se dispone

procedure LeerMarca(var cod:integer;var nombre:cadena15);
begin
   readln(cod);
   readln(nombre);  
end;
procedure CargarVector(var v:vectorMarcas);
var
    i:rango;
    cod:integer;
    nombre:cadena15;
begin
    for i:= 1 to DF do 
    begin
        LeerMarca(cod,nombre);
        v[cod]:=nombre;
    end;
end;

function Cumple(cod:integer):boolean;
var
   dig:integer;
begin
        while ( cod <> 0)do
        begin
            dig:= cod mod 10;
            if ( dig = 0 )then Cumple:=false
                                else cod:=cod div 10;
        end;
    end;
    procedure InicializarVector(var vec:vectorPrecios);
    var
        i:rango;
    begin
        for i:= 1 to DF do vec[i]:=9999;
end;
function EsMinimo(precio,min:real):boolean;
 begin
        if ( precio < min)then EsMinimo:=true
                          else EsMinimo:=false;
end;

procedure Recorrer(l:lista;var vec:vectorPrecios;var cantMas100,cantSinCeros:integer);
var
    actualPais:cadena15; 
    repuestosPorPais:integer;
begin
    cantSinCeros:=0;
    cantMas100:=0; 
    InicializarVector(vec);
    while ( l <> nil) do
    begin
        actualPais:=l^.datos.nomP;
        repuestosPorPais:=0; 
        while ( ( l <> nil) and (actualPais = l^.datos.nomP) )do
        begin
            repuestosPorPais:=repuestosPorPais+1;
            if ( EsMinimo(l^.datos.precio,vec[l^.datos.codM]) )then vec[l^.datos.codM]:= l^.datos.precio;
            if ( Cumple ( l^.datos.cod) )then cantSinCeros:=cantSinCeros+1;
            l:=l^.sig;
        end;
        if ( cant > UNO)then cantMas100:=cantMas100+1;
    end;
end;

procedure InformarMinimos(vec:vectorPrecios;v:vectorMarcas);
var
    i:rango;
begin
    for i:= 1 to DF do  writeln('Para la marca ', v[i], ' el precio mas barato fue ', vec[i]);
end;

//PP
var
    l:lista;
    v:vectorMarcas;
    cantMas100,cantSinCeros:integer;
    vec:vectorPrecios;
begin
    CargarLista(l); //se dispone
    CargarVector(v);
    Recorrer(l,vec,cantP,cantR);
    writeln('La cantidad de paises a los que se le compro mas de 100 repuestos: ', cantMas100);
    InformarMinimos(vec,v);
    writeln('La cantidad de repuestos que no poseen ningun cero en su codigo: ',cantSinCeros);
end.
