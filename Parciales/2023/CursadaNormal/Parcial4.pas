{
﻿CADP 2023- Parcial Segunda Fecha - 01/07/2023 - TEMA 1 - 8:00 AM
 
El productor musical Bizarrap organiza sesiones musicales con diferentes artistas. Implementar un programa que lea y almacene 
información de dichas sesiones. De cada sesión se lee: título de sesión, nombre del artista, género musical (1: Trap Latino, 2: 
Reggaeton 3: Urban, 4: Electrónica, 5: Pop Rap) y cantidad de visualizaciones en YouTube. La lectura finaliza cuando se lee la 
sesión del artista con nombre "Peso Pluma", la cual debe procesarse. La información debe quedar almacenada en una estructura de 
datos ordenada por título de sesión de forma ascendente.
Una vez leída y almacenada la información, se pide:

A. Informar los dos códigos de género musical con mayor cantidad de visualizaciones en YouTube.
B. Informar la cantidad de sesiones del género "Reggaeton" cuya cantidad de visualizaciones contiene la misma cantidad de dígitos
pares que impares.
C. COMPLETO: Realizar un módulo que reciba un título de sesión y elimine dicha sesión de la estructura. El título de sesión puede 
no existir. Invocar el módulo desarrollado en el programa principal con un título leído por teclado.
}

program parcial;
const
    DF=5;
    FIN= 'Peso Pluma';
type
    cadena15=string[15];
    rango=1..DF;
    
    sesion=record
            tit:cadena15; //ordenada
            nom:cadena15; //corte de control
            genero:rango;
            cantV:integer;
           end;
    lista=^nodo;
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
            writeln('Ingrese el nombre --FIN Peso Pluma--');
            readln(nom);
            writeln('Ingrese titulo');
            readln(tit);
            writeln('Ingrese el genero --1 a 5--');
            readln(genero);
            writeln('Ingrese la cantidad de visualizaciones');
            readln(cantV);
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

procedure Recorrer(l:lista; var v:vectorContador;var cant:integer);
    procedure InicializarVector(var v:vectorContador);
    var
        i:rango;
    begin
        for i:=1 to DF do v[i]:=0;
    end;
    function Cumple (cant:integer):boolean;
    var
        cantP,cantI:integer;
    begin
        cantP:=0; cantI:=0;
        while ( cant <> 0)do
        begin
            if ( (cant mod 2) = 0) then cantP:=cantP+1
                                   else cantI:=cantI+1;
            cant:=cant div 10;
        end;
        if ( cantP = cantI)then Cumple:=true
                           else Cumple:=false;
    end;
begin
    InicializarVector(v);
    cant:=0;
    while ( l <> nil) do
    begin
        v[l^.datos.genero]:= v[l^.datos.genero] + l^.datos.cantV;
        if ( (l^.datos.genero = 2) and ( Cumple(l^.datos.cantV) ) )then cant:=cant+1; 
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


procedure Eliminar(var l:lista; tit:cadena15);
var
 actual,ant:lista;
begin
  actual:=l; 
  while (actual <> nil) and (actual^.datos.tit < tit) do begin
    ant:=actual; 
    actual:= actual^.sig;
  end;
  if (actual^.datos.tit = tit) then 
    if (actual = l) then l:= l^.sig
                    else ant^.sig:= actual^.sig;
    dispose (actual);
end;


//PP
var
    l:lista;
    v:vectorContador;
    cod1,cod2:rango;
    cant:integer;
    tit:cadena15;
begin
    CargarLista(l);
    Recorrer(l,v,cant);
    ObtenerMaximo(v,cod1,cod2);
    writeln('Los dos códigos de género musical con mayor cantidad de visualizaciones en YouTube son: ', cod1, ' y ',cod2);
    writeln('la cantidad de sesiones del género "Reggaeton" cuya cantidad de visualizaciones contiene la misma cantidad de dígitos pares que impares: ', cant);
    writeln('Ingrese un titulo a eliminar');
    readln(tit);
    Eliminar(l,tit);
end.

