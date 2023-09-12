{
La Comisión Provincial por la Memoria desea analizar la información de los proyectos presentados en el programa
Jóvenes y Memoria durante la convocatoria 2020. Cada proyecto posee un código único, un título, el docente
coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el nombre de la
escuela y la localidad a la que pertenecen. Cada escuela puede presentar más de un proyecto. La información se
ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. Realizar un programa que
lea la información de los proyectos hasta que se ingrese el proyecto con código -1 (que no debe procesarse), e
informe:

-Cantidad total de escuelas que participan en la convocatoria 2018 y cantidad de escuelas por cada localidad.
-Nombres de las dos escuelas con mayor cantidad de alumnos participantes.
-Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares.
}

program ejercicio8;
const 
  FIN=-1; 
type
   cadena10=string [10];
   cadena20=string [20];
   cadena40=string [40];
   
   docente=record
                dni:integer;
                nombre:cadena10;
                apellido:cadena10;
                email:cadena40;
            end;
   
   //Puede haber mas de un proyecto x escuela
   proyecto=record
                cod:integer;
                titulo:cadena20;
                doc:docente;
                cantA:integer;
                nomE:cadena20;
                localidad:cadena20; //consecutivamente x este campo/x escuela
           end;
  
//PROCESOS
Procedure Informar();
        Procedure LeerDocentes(var d:docente);
        begin
            writeln('Ingrese el dni');
            readln(d.dni);
            writeln('Ingrese el nombre');
            readln(d.nombre);
            writeln('Ingrese el apellido');
            readln(d.apellido);
            writeln('Ingrese el email');
            readln(d.email);
            writeln('Docente  -Termina registro- ');
        end;
        Procedure LeerProyectos(var p:proyecto);
        begin
            writeln('Ingrese el codigo  -FINALIZA CON  -1 -');
            readln(p.cod);
            if (p.cod <> FIN)then
            begin
                writeln('Ingrese el titulo');
                readln(p.titulo);
                writeln('Docente  -Inicia registro- ');
                LeerDocentes(p.doc);
                writeln('Ingrese la cantidad de alumnos');
                readln(p.cantA);
                writeln('Ingrese el nombre de la escuela');
                readln(p.nomE);
                writeln('Ingrese la localidad');
                readln(p.localidad);
            end;
        end;
        Procedure Maximo(var nom1,nom2:cadena10; var max1,max2:integer; nombre:cadena20; cant:integer);
        begin
            if( max1 < cant)then
            begin
                max2:=max1;
                nom2:=nom1; 
                max1:= cant;
                nom1:= nombre; 
            end
            else
              if(max2 < cant)then 
              begin
                max2:=cant;
                nom2:=nombre; 
              end;
        end;
        Function Cumple(cod:integer):boolean;
        var
            cantP,cantI:integer;
        begin
            cantI:=0; cantP:=0;
            while(cod <> 0)do
            begin
                if ( (cod mod 2) = 0)then cantP:=cantP+1
                                    else cantI:=cantI+1;
                cod:= cod div 10;
            end;
            Cumple:= cantI = cantP;
        end;
var 
    p:proyecto;
    localActual,nomEscActual,nom1,nom2:cadena20;
    cantL,cantE,cantAl,max1,max2:integer;
begin
    cantE:=0; max1:=FIN; max2:=FIN;
    LeerProyectos(p);
    while (p.cod <> FIN)do
    begin
       localActual:=p.localidad; cantL:=0;
       while (p.cod <> FIN) and (localActual = p.localidad)do
       begin
            nomEscActual:=p.nomE; cantAl:=0;
            while (p.cod <> FIN) and (localActual = p.localidad) and (nomEscActual = p.nomE )do
            begin
                cantAl:=cantAl+p.cantA;
                LeerProyectos(p);
            end;
            cantL:=cantL+1;
            cantE:=cantE+1;
            Maximo(nom1,nom2,max1,max2,nomEscActual,cantAl);
       end;
       if( (p.localidad = 'Daireaux') and (Cumple(p.cod)) )then writeln('Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares: ', p.titulo);
       writeln('Cantidad de escuelas para la localidad ', localActual, ' es: ', cantL);
    end;
    writeln('Cantidad de escuelas en la convocatoria: ', cantE);
    writeln('Nombres de las dos escuelas con mayor cantidad de alumnos participantes: ', nom1, ' ',nom2);
end;

//PROGRAMA PRINCIPAL

begin
   Informar();
end.
