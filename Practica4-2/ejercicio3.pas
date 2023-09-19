{Una empresa de transporte de caudales desea optimizar el servicio que brinda a sus clientes. Para ello,
cuenta con información sobre todos los viajes realizados durante el mes de marzo. De cada viaje se cuenta
con la siguiente información: día del mes (de 1 a 31), monto de dinero transportado y distancia recorrida
por el camión (medida en kilómetros).
a. Realizar un programa que lea y almacene la información de los viajes (a lo sumo 200). La lectura finaliza
cuando se ingresa una distancia recorrida igual a 0 km, que no debe procesarse.
b. Realizar un módulo que reciba el vector generado en a) e informe:
- El monto promedio transportado de los viajes realizados
- La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero.
- La cantidad de viajes realizados cada día del mes.
c. Realizar un módulo que reciba el vector generado en a) y elimine todos los viajes cuya distancia
recorrida sea igual a 100 km.
Nota: para realizar el inciso b, el vector debe recorrerse una única vez
}
program ejercicio3;
const
    FIN=0; DF=200;//a lo sumo
type
    rd=1..31;
    rango=1..DF;
    
    viaje=record 
            dia:rd;
            montoT:real;
            disXC:integer; //corte con dis=0
          end;
          
    vector=array[rango]of viaje;   
    veContador=array[rd] of integer;
//PROCESOS  
procedure CargarVector(var v:vector; var diml:integer);
    procedure LeerViajes(var v:viaje);
    begin
        writeln('Ingrese la distancia recorrida por camion --FIN 0--');
        readln(v.disXC);
        if(v.disXC <> FIN)then
        begin
            writeln('Ingrese el dia');
            readln(v.dia);
            writeln('Ingrese el monto de dinero transportado');
            readln(v.montoT);
        end;
    end;
var
    vi:viaje;
begin
    diml:=0;
    LeerViajes(vi);
    while( (vi.disXC <> FIN) and (diml < DF) )do
    begin
        diml:=diml+1;
        v[diml]:=vi;
        LeerViajes(vi);
    end;
end;
procedure RecorrerVector(v:vector;diml:integer;var vec:veContador);
    procedure Inicializar(var v:veContador);
    var
        i:rd;
    begin
        for i:= 1 to 31 do v[i]:=0;
    end;
    procedure ImprimirContador( v:veContador);
    var
        i:rd;
    begin
        for i:= 1 to 31 do writeln('La cantidad de viajes para el dia ', i,  ' es: ', v[i]);
    end;
    procedure Minimo(var min:real;var dist:integer; var dia:rd; monto:real; dis:integer; d:rd);
    begin
        if( min > monto)then
        begin
            min:=monto;
            dist:=dis;
            dia:=d;
        end;
    end;
var 
    i,dist,cant:integer;
    min,montoT,prome:real;
    dia:rd;
begin
    Inicializar(vec); min:=9999; cant:=0; montoT:=0;
    i:=1;
    while(i<=diml)do
    begin
        Minimo(min,dist,dia,v[i].montoT,v[i].disXC,v[i].dia);
        vec[v[i].dia]:=vec[v[i].dia]+1;
        montoT:=montoT+v[i].montoT;
        cant:=cant+1;
        i:=i+1;
    end;
    writeln('La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero ', dist,' ', dia);
    prome:= montoT / cant;
    ImprimirContador(vec);
    writeln('El monto promedio transportado de los viajes realizados ', prome:0:2);
end;
procedure ModuloC(var v:vector; var diml:integer);
var
    i,j:integer;
begin
    i:=1;
    while(i <=diml)do
    begin
        if( v[i].disXC = 100)then
        begin
          for j:= i to (diml-1) do v[j]:= v[j+1]; 
          diml:= diml - 1;
        end;
        i:=i+1;
   end;
end;
//PP
var
    v:vector;vec:veContador;
    diml:integer;
begin
    CargarVector(v,diml);
    RecorrerVector(v,diml,vec);
    ModuloC(v,diml);
end.
