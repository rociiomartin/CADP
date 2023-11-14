{
Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de
2020. De cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección de
destino y kilómetros recorridos durante el viaje. Esta información se encuentra ordenada por código
de auto y para un mismo código de auto pueden existir 1 o más viajes. Se pide:

a. Informar los dos códigos de auto que más kilómetros recorrieron.
}

program ejercicio3;
type
  cadena20=string[20];
  
  viaje=record
          numV:integer;
          cod:integer; //ordenada por este campo
          direO:cadena20;
          direD:cadena20;
          km:real;
        end;
  lista=^nodo; //se dispone
  nodo = record 
            datos:viaje;
            sig:lista;
           end;
    
//PROCESOS
{SE DISPONE}
procedure CargarLista(var l : lista);
    procedure LeerViajes(var v:viaje);
    begin
        writeln(' Ingrese el codigo --FIN -1 -- ');
        readln(v.cod);
        if ( v.cod <> -1 )then
        begin
          writeln(' Ingrese el numero --FIN -1 -- ');
          readln(v.numV);
          writeln(' Ingrese la direccion de origen ');
          readln(v.direO);
          writeln(' Ingrese la direccion de destino ');
          readln(v.direD);
          writeln(' Ingrese el km');
          readln(v.km);
          writeln('------------------------------------------------');
        end;
    end;
    procedure InsertarOrdenado(var l: lista; v:viaje);
    var
        aux,ant,act:lista;
    begin
        act:=l;
        ant:=l;
        new(aux);
        aux^.datos:= v;
        while (act<>nil) and (act^.datos.cod < v.cod) do
        begin
            ant:=act;
            act:=l^.sig;
        end;
        if act = l then l:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
var
   v:viaje;
begin
    l:=nil;
    LeerViajes(v);
    while ( v.cod <> -1 )do
    begin
        LeerViajes(v);
        InsertarOrdenado(l,v);
    end;
end;

procedure Recorrer(l:lista);
    procedure Maximo(var max1.,max2:real;var cod1,cod2:integer; km:real;cod:integer);
    begin
        if ( max1 < km ) then
        begin
            max2:=max1;
            cod2:=cod1;
            max1:=km;
            cod1:=cod;
        end
        else
            if ( max2 < km )then
            begin
                max2:=km;
                cod2:=cod;
            end;
    end;
var
    max1,max2:real;
    codActual,cod1,cod2:integer;
begin
    max1:=-1; max2:=-1;
    while ( l <> nil ) do
    begin
        codActual:=l^.datos.cod;
        while ( ( l <> nil ) and (codActual = l^.datos.cod ) )do
        begin
            l:=l^.sig;
        end;
        Maximo(max1,max2,cod1,cod2,l^.datos.km,codActual);
    end;
    writeln('Los dos códigos de auto que más kilómetros recorrieron: ', cod1, ' y ',cod2);
end;
 
//PP
var
  l:lista;
begin
  CargarLista(l);//se dispone
end.
