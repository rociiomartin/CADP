{
Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100
camiones. De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en
toneladas que puede transportar).

Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. De
cada viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros
recorrida, ciudad de destino, año en que se realizó el viaje y DNI del chofer. La lectura finaliza cuando
se lee el código de viaje -1.

Una vez leída y almacenada la información, se pide:

1. Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que
menos kilómetros recorridos posee.
2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5
toneladas y que posean una antigiiedad mayor a 5 años al momento de realizar el viaje (año en
que se realizó el viaje).
3. Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
NOTA:los codigos de viaje no se repiten
}

program ejercicio4;
const
    DF=2;//DF=100; 
    FIN=-1;
type
  rango=1..DF;
  cadena20=string[20];
  
  camion=record
            patente:integer;
            anioF:integer;
            cap:integer;
         end;
  vectorCamiones = array [rango] of camion; //se dispone
  
  viaje=record
            codV:integer; //corte de control, no se repiten.
            codC:rango;
            dist:integer;
            ciudad:cadena20;
            anioV:integer;
            dni:integer;
        end;
  lista=^nodo; 
  nodo = record 
            datos:viaje;
            sig:lista;
           end;
//PROCESOS
{SE DISPONE}
procedure CargarVector(var v:vectorCamiones);
    procedure LeerCamiones(var c:camion);
    begin
        writeln(' Ingrese el patente --FIN vacio -- ');
        readln(c.patente);
        if ( c.patente <> ' ' )then
        begin
          writeln('Ingrese el año de fabricacion');
          readln(c.anioF);
          writeln('Ingrese la capacidad');
          readln(c.cap);
        end;
    end;
var
   i:rango;
   c:camion;
begin
    writeln('--CARGANDO VECTOR--');
    for i:=1 to DF do
    begin
        LeerCamiones(c);
        v[i]:= c;
    end;
end;
{}
procedure CargarLista(var l:lista);
    procedure LeerViajes(var v:viaje);
    begin
        writeln(' Ingrese el codigo de viaje --FIN -1 -- ');
        readln(v.codV);
        if ( v.codV <> FIN )then
        begin
            writeln(' Ingrese el codigo de camion');
            readln(v.codC);
            writeln(' Ingrese la distancia');
            readln(v.dist);
            writeln(' Ingrese la ciudad ');
            readln(v.ciudad);
            writeln(' Ingrese el año del viaje');
            readln(v.anioV);
            writeln(' Ingrese el dni');
            readln(v.dni);
            writeln('------------------------------------------------');
        end;
    end;
    procedure AgregarAdelante(var l:lista; v:viaje);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= v;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   v:viaje;
begin
    l:=nil;
    writeln('--CARGANDO LISTA--');
    LeerViajes(v);
    while ( v.codV <> FIN )do
    begin
        AgregarAdelante(l,v);
        LeerViajes(v);
    end;
end;

//PP
var 
    v:vectorCamiones;
begin
    CargarVector(v);//se dispone
    CargarLista(l);
end;
