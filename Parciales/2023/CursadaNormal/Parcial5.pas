{
CADP 2023 - Parcial Segunda Fecha - 01/07/2023 - TEMA 2 - 8:00 AM
 
El productor musical Bizarrap organiza sesiones musicales con diferentes artistas. Se dispone de una estructura de datos con la
información de las sesiones de Bizarrap. De cada sesión se conoce: título, nombre del artista, género musical (1: Trap Latino, 
2: Reggaeton 3: Urban, 4: Electrónica, 5: Pop Rap), año de estreno y cantidad de reproducciones en Spotify. La información no 
posee un orden específico.Procesar la información anterior, para:

A. Informar los dos códigos de género musical con menor cantidad de reproducciones en Spotify.
B. Generar una lista ordenada por año que contenga las sesiones del género "Trap Latino" y "Urban" cuya suma de los dígitos
de la cantidad de reproducciones sea múltiplo de 5.
C. COMPLETO: Realizar un módulo que reciba la lista generada en el punto anterior e informe para cada año, la cantidad de 
sesiones realizadas junto al total de reproducciones de Spotify de esas sesiones.
}

program parcial;
const
    DF=5;
    FIN= 'Peso Pluma';
type
    cadena15=string[15];
    rango=1..DF;
    
    sesion=record
            tit:cadena15; 
            nom:cadena15; 
            genero:rango;
            anio:integer;
            cantR:integer;
           end;
    lista=^nodo; //se dispone
    nodo=record
            datos:sesion;
            sig:lista;
          end;
    
    vectorContador = array [rango] of integer;

//PROCESOS
procedure CargarLista(var l:lista);
    procedure LeerSesiones(var s:sesion);
    begin
        with s do
        begin
            writeln('Ingrese el nombre --FIN PP--');
            readln(nom);
            writeln('Ingrese titulo');
            readln(tit);
            writeln('Ingrese el genero --1 a 5--');
            readln(genero);
            writeln('Ingrese el año');
            readln(anio);
            writeln('Ingrese la cantidad de visualizaciones');
            readln(cantR);
        end;
    end;
    procedure InsertarOrdenado(var l: lista; s:sesion);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= s; 
        while (act<>nil) and (act^.datos.tit > aux^.datos.tit) do //ascendente
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
    s:sesion;
begin
    l:=nil;
    repeat
        LeerSesiones(s);
        InsertarOrdenado(l,s);
    until (s.nom = FIN); 
end;

{}

procedure Recorrer(l:lista; var v:vectorContador; var l2:lista);
    procedure InsertarOrdenado(var l: lista; s:sesion);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= s; 
        while (act<>nil) and (act^.datos.anio < aux^.datos.anio) do //ascendente
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
    procedure InicializarVector(var v:vectorContador);
    var
        i:rango;
    begin
        for i:=1 to DF do v[i]:=0;
    end;
    function Cumple (cant:integer):boolean;
    var 
        suma:integer;
    begin
        suma:=0;
        while ( cant <> 0)do
        begin
            suma:= suma + (cant mod 10);
            cant:=cant div 10;
        end;
        if ( (suma mod 5) = 0) then Cumple:=true
                               else Cumple:=false;
    end;
begin
    InicializarVector(v);
    l2:=nil;
    while ( l <> nil) do
    begin
        v[l^.datos.genero]:= v[l^.datos.genero] + l^.datos.cantR;
        if ( ( (l^.datos.genero = 1) or (l^.datos.genero = 3) ) and (Cumple(l^.datos.cantR)) )then InsertarOrdenado(l2,l^.datos);
        l:=l^.sig;
    end;
    
end;

procedure ObtenerMaximo(v:vectorContador;var cod1,cod2:rango);
    procedure Maximo(cant:integer;codigo:rango; var cod1,cod2:rango;var max1,max2:integer);
    begin
        if ( max1 < cant) then
        begin
            max2:=max1;
            cod2:=cod1;
            max1:=cant;
            cod1:=codigo;
        end
        else
            if ( max2 < cant) then
            begin   
                max2:=cant;
                cod2:=codigo;
            end;
    end;
var 
    i:rango;
    max1,max2:integer;
begin
    max1:=-1; max2:=-1; 
    //cod1:=0;cod2:=0;
    for i:= 1 to DF do Maximo(v[i],i,cod1,cod2,max1,max2);
end;


procedure RecorrerNueva(var l:lista);
var
    actualAnio,cant,total:integer;
begin
    while (l <> nil)do
    begin
        actualAnio:= l^.datos.anio;
        cant:=0; total:=0;
        while (l <> nil) and (actualAnio = l^.datos.anio) do
        begin
            cant:=cant+1;
            total:= total + l^.datos.cantR;
            l:=l^.sig;
        end;
        writeln ('la cantidad de sesiones realizadas junto al total de reproducciones de Spotify son:', cant, ' y ', total );
    end;
end;


//PP
var
    l,l2:lista; 
    v:vectorContador;
    cod1,cod2:rango;
    
begin
    CargarLista(l); //se dispone
    Recorrer(l,v,l2);
    ObtenerMaximo(v,cod1,cod2);
    writeln('Los dos códigos de género musical con mayor cantidad de reproducciones son: ', cod1, ' y ',cod2);
    RecorrerNueva(l2);
end.
