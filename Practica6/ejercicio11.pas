{
SIN TERMINAR

La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les
entregará el premio Joaquín V. González. De cada egresado se conoce su número de alumno, apellido y
el promedio obtenido durante toda su carrera.
Implementar un programa que:
a. Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
b. Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los
egresados que recibirán el premio. La información debe imprimirse ordenada según el promedio
del egresado (de mayor a menor).
}


program ejer11;
const   
    DF=10;
    FIN=0;
type 
    cadena15=string[15];
    rango=1..DF;
    
    egresado=record
                num:integer;
                ape:cadena15;
                prome:real;
            end;
            
    vector=array [rango]  of egresado;
//PROCESOS 
procedure LeerEgresado(var e:egresado);
begin
    writeln('Ingrese ');
    readln(e.num);
    if (e.num <> FIN)then
    begin
        writeln('Ingrese ');
        readln(e.ape);
        writeln('Ingrese ');
        readln(e.prome);
    end;    
end;

//PP
var
    v:vector;
begin

end.
