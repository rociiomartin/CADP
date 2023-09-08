{
El Ministerio de Educación desea realizar un relevamiento de las 2400 escuelas primarias de la provincia de Bs. As, 
con el objetivo de evaluar si se cumple la proporción de alumnos por docente calculada por la UNESCO para el año
2015 (1 docente cada 23,435 alumnos). Para ello, se cuenta con información de: CUE (código único de establecimiento), 
nombre del establecimiento, cantidad de docentes, cantidad de alumnos, localidad. Se pide implementar un programa que
procese la información y determine:

-Cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por UNESCO.
-CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos.

El programa debe utilizar:
a) Un módulo para la lectura de la información de la escuela.
b) Un módulo para determinar la relación docente-alumno (esa relación se obtiene del cociente entre la cantidad
de alumnos y la cantidad de docentes).
}

program ejercicio3;
const 
  DF=2400; PROME=23.435; MIN=9999;
type
   cadena20=string [20];
   escuela=record
            CUE: integer;
            nombreE:cadena20;
            cantD:integer;
            cantA:integer;
            localidad:cadena20;
           end;
//PROCESOS
Procedure Informar();

        Procedure LeerEscuela(var e:escuela);
        begin
            writeln('Ingrese un CUE -');
            readln(e.CUE);
            writeln('Ingrese el nombre del establecimiento');
            readln(e.nombreE);
            writeln('Ingrese la cantidad de docentes');
            readln(e.cantD);
            writeln('Ingrese la cantidad de alumnos');
            readln(e.cantA);
            writeln('Ingrese la localidad');
            readln(e.localidad);
        end;
        Function Relacion(cantA,cantD:integer):real;
        begin
            Relacion:=cantA/cantD;
        end;
        Procedure Minimo(var cue1,cue2:integer; var nom1,nom2:cadena20; var min1,min2:real; cue:integer; nom:cadena20; prome:real);
        begin
            if( min1 > prome)then
            begin
                min2:=min1;
                cue2:=cue1; nom2:=nom1;
                min1:= prome;
                cue1:= cue; nom1:=nom;
            end
            else
              if(min2 > prome)then 
              begin
                min2:=prome;
                cue2:=cue; nom2:=nom;
              end;
        end;

var 
  e:escuela;
  i,cantLP,cue1,cue2:integer;
  aux, min1,min2:real;
  nom1,nom2:cadena20;
begin
    cantLP:=0; min1:=MIN; min2:=MIN; nom1:=''; nom2:='';
    for i:= 1 to DF do
    begin
        LeerEscuela(e);
        aux:= Relacion(e.cantA,e.cantD); 
        if (e.localidad = 'La Plata') and ( aux > PROME ) then cantLP:=cantLP+1;
        Minimo(cue1,cue2,nom1,nom2,min1,min2,e.CUE,e.nombreE,aux);
    end;
    writeln('La cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por UNESCO es: ', cantLP);
    writeln('CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos son: ', cue1, ' ', nom1, ' y ', cue2, ' ', nom2);
end;


//PROGRAMA PRINCIPAL

begin
   Informar();
end.
