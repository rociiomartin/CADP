
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


program ejer12;
const
    DF=4;
type
    rango1=1..4; 
    rango2=1..DF;
    cadena15=string[15];
    
    galaxia=record  
                nom:string;
                tipo:rango1;
                masa:integer;
                parsecs:real;
            end;
            
    vectorGalaxia =array [1..53 ] of galaxia;
    
    vectorContador =array [rango1] of integer;

//PROCESOS
procedure LeerGalaxias(var g:galaxia);
begin
    writeln('Ingrese el nombre');
    readln(g.nom);
    writeln('Ingrese el tipo -DE 1 A 4-');
    readln(g.tipo);
    writeln('Ingrese la masa');
    readln(g.masa);
    writeln('Ingrese la distancia');
    readln(g.parsecs);
end;

procedure CargarVG(var vgl:vectorGalaxia);
var
    i:rango2;
    g:galaxia;
begin
    for i:=1 to DF do 
    begin
        LeerGalaxias(g);
        vgl[i]:=g;
    end;
end;


procedure Minimo(var min1,min2:integer;var nom1,nom2:string; masa:integer; nom:string);
begin  
    if ( masa < min1 )then
    begin
        min2:=min1;
        nom2:=nom1;
        min1:=masa;
        nom1:=nom;
    end
    else
        if ( masa < min2)then
        begin
            min2:=masa;
            nom2:=nom;
        end;
end;

procedure Maximo(var max1,max2:integer;var nom1,nom2:string; masa:integer; nom:string);
begin
    if ( max1 < masa)then
    begin
        max2:=max1;
        nom2:=nom1;
        max1:=masa;
        nom1:=nom;
    end
    else
        if ( masa > max2 )then
        begin
            max2:=masa;
            nom2:=nom;
        end;
end; 

procedure InicializarVector(var v:vectorContador);
var
    i:rango1;
begin
    for i:= 1 to 4 do v[i]:=0;
end;

procedure RecorrerVector(vgl:vectorGalaxia; var v:vectorContador);
var
    i:rango2;
    masa3g, masaTotal,porcentaje,cant,max2,max1,min1,min2:integer;
    nom1,nom2,nom3,nom4:string;
begin
    //Inicializar todas las variables
    InicializarVector(v);
    masa3g:=0; masaTotal:=0; cant:=0;
    max1:=-1;max2:=-1;min2:=9999;min1:=9999;
    
    for i:=1 to DF do
    begin
        v[ vgl[i].tipo] := v[ vgl[i].tipo] + 1; //cuenta por cada tipo  
        
        masaTotal:=masaTotal+vgl[i].masa; //inciso b (porcentaje)
        if ( (vgl[i].nom = 'Via Lactea') or ( vgl[i].nom = 'Andromeda') or (vgl[i].nom = 'Triangulo') )then masa3g:=masa3g + vgl[i].masa;
        
        if ( (vgl[i].tipo <> 4) and ( vgl[i].parsecs < 1000) )then cant:=cant+1; //inciso c
        
        Maximo(max1,max2,nom1,nom2,vgl[i].masa,vgl[i].nom); 
        Minimo(min1,min2,nom3,nom4,vgl[i].masa,vgl[i].nom);         
        
    end;
    porcentaje:= (masa3g*100) div masaTotal;
    writeln('porcentaje: ', porcentaje, '%');
    
    writeln('El nombre de las dos galaxias con mayor masa' , nom1, ' ' ,nom2); 
    writeln ('El de las dos galaxias con menor masa ', nom3,' ', nom4);
end;


procedure ImprimirVectorContador (v:vectorContador);
var
    i:rango1;
begin
    for i:= 1 to 4 do writeln('El tipo ', i, ' tiene ', v[i]);
end;


//PROGRAMA PRINCIPAL 

var
    vgl:vectorGalaxia;
    v:vectorContador;
begin
    CargarVG(vgl);
    RecorrerVector(vgl,v);
    ImprimirVectorContador(v);
end.
