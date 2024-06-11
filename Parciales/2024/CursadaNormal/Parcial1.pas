{
TEMA 2
}

program parcial;
const
    DF=130;
    UNO=100;
type
    rango=1..DF;
    cadena15=string[15];
    
    repuesto=record
                  cod:integer;
                  precio:real;
                  codM:rango;
                  nomP:cadena15; //ordenada por este campo
             end;
    lista=^nodo; //se dispone
    nodo=record
            datos: repuesto;
            sig: lista;
          end;
      
    marca=record
            cod:rango;
            nombre:cadena15;
          end;
    vectorMarcas = array [rango] of string;
    
    vectorPrecios = array [rango] of real;

//PROCESOS
{SE DISPONE
procedure CargarLista(var l:lista); 
    procedure LeerRepuesto(var r:repuesto);
    begin
        with r do 
        begin
            writeln('Ingrese el codigo');
            readln(cod);
            if ( cod <> -1)then
            begin
            writeln('Ingrese el precio ');
            readln(precio);  
            writeln('Ingrese el codigo de marca --1 a 130--');
            readln(codM);
            writeln('Ingrese el pais');
            readln(nomP);
            end;
        end;
    end;
    procedure InsertarOrdenado(var l: lista; r:repuesto);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= r;
        while (act<>nil) and (act^.datos.nomP < aux^.datos.nomP) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
    r:repuesto;
begin
    l:=nil;
    LeerRepuesto(r);
    while ( r.cod <> -1 )do
    begin
        InsertarOrdenado(l,r);
        LeerRepuesto(r);
    end;
end;
}

procedure CargarVector(var v:vectorMarcas);
    procedure LeerMarca(var m:marca);
    begin
        with m do 
        begin
            writeln('Ingrese el codigo');
            readln(cod);
            writeln('Ingrese el nombre');
            readln(nombre);
        end;
    end;
var
    m:marca;
    i:rango;
begin
    for i:= 1 to DF do 
    begin
        LeerMarca(m);
        v[m.cod]:=m.nombre;
    end;
end;

procedure Recorrer(l:lista;var vec:vectorPrecios;var cantP,cantR:integer);
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
var
    actualPais:cadena15; 
    cant:integer;
begin
    cantP:=0; cantR:=0;
    InicializarVector(vec);
    while ( l <> nil)do
    begin
        actualPais:=l^.datos.nomP;
        cant:=0; //cuenta la cantidad de repuestos
        while ( ( l <> nil) and (actualPais = l^.datos.nomP) )do
        begin
            cant:=cant+1;
            if ( EsMinimo(l^.datos.precio,vec[l^.datos.codM]) )then vec[l^.datos.codM]:= l^.datos.precio;
            if ( Cumple ( l^.datos.cod) )then cantR:=cantR+1;
            l:=l^.sig;
        end;
        if ( cant > UNO)then cantP:=cantP+1;
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
    cantP,cantR:integer;
    vec:vectorPrecios;
begin
    CargarLista(l); //se dispone
    CargarVector(v);
    Recorrer(l,vec,cantP,cantR);
    writeln('La cantidad de paises a los que se le compro mas de 100 repuestos: ', cantP);
    InformarMinimos(vec,v);
    writeln('La cantidad de repuestos que no poseen ningun cero en su codigo: ',cantR);//Para el completo
end.
