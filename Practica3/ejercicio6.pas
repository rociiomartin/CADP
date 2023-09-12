{
Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la
información de los productos que mantiene actualmente en stock. Para ello, se conoce la siguiente información de
los microprocesadores: marca (Intel, AMD, NVidia, etc), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.
cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y tamaño en
nanómetros (nm) de los transistores (14, 22, 32, 45, etc.). La información de los microprocesadores se lee de
forma consecutiva por marca de procesador y la lectura finaliza al ingresar un procesador con O cores (que no
debe procesarse). Se pide implementar un programa que lea información de los microprocesadores de la empresa
importadora e informe:

-Marca y línea de todos los procesadores de más de 2 cores con transistores de a lo sumo 22 nm.
-Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.
-Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de
al menos 2 Ghz.
}


program ejercicio6;
const 
  FIN=0; NM=22; MAYOR=14;
type
   cadena10=string [10];
   microprocesadores=record
            marca: cadena10; //consecutivamente x este campo
            linea: cadena10;
            cantCore: integer;
            velReloj: integer;
            nm:integer;
           end;
  
//PROCESOS
Procedure Informar();

        Procedure LeerMicropocesadores(var m:microprocesadores);
        begin
            writeln('Ingrese la cantidad de cores  -FINALIZA CON  0-');
            readln(m.cantCore);
            if (m.cantCore <> FIN)then
            begin
                writeln('Ingrese la marca del microprocesadores');
                readln(m.marca);
                writeln('Ingrese la linea del microprocesadores');
                readln(m.linea);
                writeln('Ingrese la velocidad del reloj en Ghz');
                readln(m.velReloj);
                writeln('Ingrese la tamaño en nanómetros de los transistores');
                readln(m.nm);
            end;
        end;
        Procedure Maximo(var m1,m2:cadena10; var max1,max2:integer; marca:cadena10; cant:integer);
        begin
            if( max1 < cant)then
            begin
                max2:=max1;
                m2:=m1; 
                max1:= cant;
                m1:= marca; 
            end
            else
              if(max2 < cant)then 
              begin
                max2:=cant;
                m2:=marca; 
              end;
        end;
var 
 marcaActual,m1,m2:cadena10;
 m:microprocesadores;
 max1,max2,cant,cantProc:integer;
begin
    m1:=''; m2:=''; max1:=-1; max2:=-1; cant:=0;
    LeerMicropocesadores(m);
    while (m.cantCore <> FIN)do
    begin
        marcaActual:=m.marca; cantProc:=0;
        while (m.cantCore <> FIN) and (m.marca = marcaActual)do
        begin
            if(m.cantCore > 2) and (m.nm <= NM)then 
                writeln('La marca y linea del procesador de más de 2 cores con transistor de a lo sumo 22 nm: ', m.marca, ' ', m.linea);
            if (m.nm = MAYOR) then cantProc:=cantProc+1;
            if ( (m.cantCore >= 2) and ( (m.marca = 'Intel') or (m.marca = 'AMD') ) )then if(m.velReloj >= 2) then cant:=cant+1;
            LeerMicropocesadores(m);
        end;
        Maximo(m1,m2,max1,max2,marcaActual,cantProc);
    end;
   writeln('Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm: ', m1,' ',m2);
   writeln('Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de al menos 2 Ghz: ', cant);
end;

//PROGRAMA PRINCIPAL

begin
   Informar();
end.
