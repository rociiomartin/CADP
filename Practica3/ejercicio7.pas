{
Realizar un programa que lea información de centros de investigación de Universidades Nacionales. De cada
centro se lee su nombre abreviado (ej. LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de
investigadores y la cantidad de becarios que poseen. La información se lee de forma consecutiva por universidad y
la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse. Informar:

-Cantidad total de centros para cada universidad.
-Universidad con mayor cantidad de investigadores en sus centros.
-Los dos centros con menor cantidad de becarios.
}

program ejercicio7;
const 
 FIN=0; MAX =-1; MIN=9999;
type
  cadena6=string[6];
  cadena20=string[20];
  centro = record
            nombre:cadena6;
            uni:cadena20;
            cantI:integer;
            cantB:integer;
           end;
//PROCESOS
Procedure Informar();

        Procedure LeerCentro(var c:centro);
        begin
            writeln('Ingrese la cantidad de investigadores que posee  -FINALIZA SI INGRESA 0-');
            readln(c.cantI);
            if(c.cantI <> FIN) then
            begin
                writeln('Ingrese el nombre del centro');
                readln(c.nombre);
                writeln('Ingrese la universidad que pertenece');
                readln(c.uni);
                writeln('Ingrese un cantidad de becarios que posee');
                readln(c.cantB);
            end;
        end;
        Procedure Maximo (maxInves:integer; uni:cadena20; var maxUni:cadena20; var max:integer);
        begin
            if(max < maxInves) then
            begin
                max:= maxInves;
                maxUni:=uni
            end;
        end;
        Procedure Minimo (var minBec1, minBec2:integer; var centro1,centro2: cadena6; cantB:integer; centro: cadena6);
        begin
            if(minBec1 > cantB) then
            begin
                minBec2:=minBec1;
                centro2:=centro1;
                minBec1:= cantB;
                centro1:= centro;
            end
            else
              if(minBec2 > cantB)then 
              begin
                minBec2:=cantB;
                centro2:=centro;
              end;
        end;

var 
  c:centro;
  Uniactual,maxUni:cadena20;
  centro1,centro2:cadena6;
  cantUni,maxInves, max,minBec1, minBec2:integer;
begin
    max:=MAX; minBec1:= MIN; minBec2:= MIN;centro1:=''; centro2:='';
    LeerCentro(c);
    while(c.cantI <> FIN) do
    begin
        cantUni:=0; maxInves:=0;
        Uniactual:=c.uni;
        while(c.cantI <> FIN) and (c.uni = Uniactual)do
        begin
            cantUni:=cantUni+1;
            maxInves:=maxInves+ c.cantI;
            LeerCentro(c);
            Minimo(minBec1,minBec2,centro1,centro2,c.cantB,c.nombre);
        end;
        Maximo(maxInves,c.uni, maxUni, max);
        writeln('La cantidad total de centros para la universidad ', Uniactual,' es: ' , cantUni);
    end;
    writeln('Universidad con mayor cantidad de investigadores en sus centros es: ', maxUni);
    writeln('Los dos centros con menor cantidad de becarios son: ', centro1, ' ',centro2 );
end;


//PROGRAMA PRINCIPAL

begin
   Informar();
end.
