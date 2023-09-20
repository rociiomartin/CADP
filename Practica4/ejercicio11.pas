{
El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales. Para
ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente
información: título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de
comentarios de usuarios. Realizar un programa que lea y almacene esta información. Una vez finalizada la
lectura, el programa debe procesar los datos e informar:

a) Título de la foto más vista (la que posee mayor cantidad de clics).
b) Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay”.
c) Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.
}

{
El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales. Para
ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente
información: título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de
comentarios de usuarios. Realizar un programa que lea y almacene esta información. Una vez finalizada la
lectura, el programa debe procesar los datos e informar:

a) Título de la foto más vista (la que posee mayor cantidad de clics).
b) Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay”.
c) Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.
}


program ejercicio11;
const
    DF=200; AUTOR= 'Art Vandelay';
type
    rango=1..DF;
    cadena15=string[15];
    
    foto=record
            titulo:cadena15;
            autor:cadena15;
            cantMG:integer;
            cantC:integer;
            cantCom:integer;
          end;
          
    vector= array [rango] of foto;
//PROCESOS
procedure CargarVector(var v:vector);
    procedure LeerFotos(var f:foto);
    begin
        writeln('Ingrese el titulo');
        readln(f.titulo);
        writeln('Ingrese el autor');
        readln(f.autor);
        writeln('Ingrese la cantidad de me gustas');
        readln(f.cantMG);
        writeln('Ingrese la cantidad de clicks');
        readln(f.cantC);
        writeln('Ingrese la cantidad de comentarios');
        readln(f.cantCom);
    end;
var
    f:foto;
    i:rango;
begin
    for i:=1 to DF do
    begin
        LeerFotos(f);
        v[i]:=f;
    end;
end;

procedure RecorrerVector(v:vector);
    procedure Maximo(var titulo:cadena15; var max:integer;tit:cadena15;cant:integer);
    begin
        if(max < cant)then
        begin
            max:=cant;
            titulo:=tit;
        end;
    end;
var
    i,max,cant:integer;
    titulo:cadena15;
begin
    max:=-1; cant:=0; titulo:='';
    writeln('Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página: ');
    for i:=1 to DF do
    begin
        Maximo(titulo,max,v[i].titulo,v[i].cantC);
        if(AUTOR = v[i].autor) then cant:=cant+v[i].cantMG;
        writeln('-->Para la foto ', v[i].titulo, ' fueron: ', v[i].cantCom);
    end;
    writeln('Título de la foto más vista ', titulo);
    writeln('Cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo “Art Vandelay” : ', cant);
end;
//PP
var
    v:vector;
begin
    CargarVector(v);
    RecorrerVector(v);
end.
