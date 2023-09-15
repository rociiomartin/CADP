{
En astrofísica, una galaxia se identifica por su nombre, su tipo (1. elíptica; 2. espiral; 3. lenticular;
4.irregular), su masa (medida en ke) y la distancia en pársecs (pc) medida desde la Tierra. La Unión
Astronóica Internacional cuenta con datos correspondientes a las 53 galaxias que componen el Grupo
Local. Realizar un programa que lea y almacene estos datos y, una vez finalizada la carga, informe:

a) La cantidad de galaxias de cada tipo.
b) La masa total acumulada de las 3 galaxias principales (la Vía Láctea, Andrómeda y Triángulo) y el
porcentaje que esto representa respecto a la masa de todas las galaxias.
c) La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc.
d) El nombre de las dos galaxias con mayor masa y el de las dos galaxias con menor masa.

}


program ejercicio10;
const
    DF=53;PC=1000;
type
    rango=1..4;
    rango2=1..DF;
    cadena15=string[15];
    galaxia=record
                nombre:cadena15;
                tipo:rango;
                masa:real;
                dist:integer;
            end;
    
    vector= array[rango2] of galaxia;
    vectorContador= array[rango] of integer;

//PROCESOS
Procedure CargarVector(var v:vector);
    Procedure LeerGalaxias(var g:galaxia);
    begin
        writeln('Ingrese el nombre');
        readln(g.nombre);
        writeln('Ingrese el tipo -DE 1 A 4-');
        readln(g.tipo);
        writeln('Ingrese la masa');
        readln(g.masa);
        writeln('Ingrese la distancia');
        readln(g.dist);
    end;
var
    g:galaxia;
    i:rango2;
begin  
    for i:= 1 to DF do
    begin
        LeerGalaxias(g);
        v[i]:=g;
    end;
end;

Procedure Recorrer(v:vector; var vec:vectorContador);
    Procedure Inicializar(var v:vectorContador);
    var 
        i:rango;
    begin
        for i:= 1 to 4 do  v[i]:=0;
    end;
    Procedure Maximo(var g1,g2:cadena15;var max1,max2:real;masa:real;gal:cadena15);
    begin
         if(max1 < masa)then 
            begin
                max2:=max1;
                g2:=g1;
                max1:=masa;
                g1:=gal;
            end
            else
             if(max2 < masa)then 
             begin
                max2:=masa;
                g2:=gal;
             end;
    end;
    Procedure Minimo(var g1,g2:cadena15;var min1,min2:real;masa:real;gal:cadena15);
    begin
        if(min1 > masa)then 
        begin
            min2:=min1;
            g2:=g1;
            min1:=masa;
            g1:=gal;
        end
        else
         if(min2 > masa)then 
         begin
            min2:=masa;
            g2:=gal;
         end;
    end;
var
    i:rango2;
    cant:integer;
    masa,masaT,max1,max2,min1,min2:real;
    g1,g2,g3,g4:cadena15;
begin
    Inicializar(vec);
    masa:=0;masaT:=0;cant:=0; max1:=-1;max2:=-1; min2:=9999;min2:=9999;
    g1:='';g2:='';g3:='';g4:='';
    for i:= 1 to DF do
    begin
        vec[v[i].tipo]:=vec[v[i].tipo] +1;
        if('la Via Lactea'= v[i].nombre)or ('Andromeda' = v[i].nombre ) or ('Triangulo' = v[i].nombre)then masa:=masa+ v[i].masa;
        masaT:=masaT+ v[i].masa;
        if(v[i].dist < PC)then cant:=cant+1;
        Maximo(g1,g2,max1,max2,v[i].masa,v[i].nombre);
        Minimo(g3,g4,min1,min2,v[i].masa,v[i].nombre);
    end;
    writeln('El porcentaje que representa respecto a la masa de todas las galaxias: ', ((masa/masaT)*100) :00:00 , ' %');
    writeln('La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc: ', cant);
    writeln('El nombre de las dos galaxias con mayor masa:', g1,' ',g2);
    writeln('El nombre de las dos galaxias con menor masa:',g3,' ',g4);
end;

Procedure Informar(v:vectorContador);
var 
    i:rango;
begin
    for i:= 1 to 4 do  writeln('La cantidad de galaxias para el tipo ', i, ' es: ', v[i]);
end;
//PROGRAMA PRINCIPAL
var
    v:vector;
    vec:vectorContador;
begin
    CargarVector(v);
    Recorrer(v,vec);
    Informar(vec);
end.
