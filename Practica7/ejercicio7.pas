{
La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de
Analista Programador Universitario. Para ello se deberá leer la información de cada alumno, a saber:
número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso
y las notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).

1. Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el
alumno con número de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a
cada alumno deben quedar ordenadas de forma descendente.
2. Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar:

a. El promedio de notas obtenido por cada alumno.
b. La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto
únicamente por dígitos impares.
c. El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido
se recibieron (o sea, que tardaron menos años)

3. Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de
la estructura generada en el inciso 1. El alumno puede no existir. FALTAAAA
}


program ejercicio7;
const
    FIN=-1;
    DF=24;
type
    cadena15=string[15];
    cadena30=string[30];
    rango=1..DF;
    
    vectorNotas= array [rango] of integer;
    
    alumno=record
            num:integer;
            ape:cadena15;
            nom:cadena15;
            dire:cadena30;
            anioI:integer;
            anioE:integer;
            notas: vectorNotas;//los aplazos no se registran, forma descendente(mayor a menor)
            diml:integer;
           end;
           
    lista=  ^nodo;
    nodo = record 
            datos:alumno;
            sig:lista;
           end;
//PROCESOS
procedure CargarLista(var l : lista);
    procedure InsertarVector(var v:vectorNotas;diml:integer;n:integer);
    var 
        i,j:rango;
        ok:boolean;
    begin
        i:=1; 
        ok:=true;
        while ( diml >= i) and (ok) do
        begin
            if ( v[i] < n)then ok:=false
                          else i:=i+1;
        end;
        for j:=diml downto i do v[j]:=v[j-1];
        v[i]:=n;
    end;
    procedure CargarVector(var v:vectorNotas;var diml:integer);
    var 
        i:rango;
        nota:integer;
    begin
        writeln('Ingrese las 24 notas');
        diml:=0;
        for i:=1 to DF do 
        begin
            readln(nota);
            if (nota >= 4)then
            begin
                diml:=diml+1;
                InsertarVector(v,diml,nota);
            end;
        end;
    end;
    procedure LeerAlumno(var a:alumno);
    begin
        with a do
        begin
            writeln(' Ingrese el numero --FIN -1 -- ');
            readln(num);
            if ( num <> FIN ) then
            begin
                writeln(' Ingrese el apellido');
                readln(ape);
                writeln(' Ingrese el nombre');
                readln(nom);
                writeln(' Ingrese la dirección de correo electrónico');
                readln(dire);
                writeln(' Ingrese el año de ingreso');
                readln(anioI);
                writeln(' Ingrese el año de egreso');
                readln(anioE);
                CargarVector(notas, diml);
            end;
        end;
        writeln('------------------------------------------------');
    end;
    procedure AgregarAdelante (var l:lista; a:alumno);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= a;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   a:alumno;
begin
    LeerAlumno(a);
    while ( a.num <> FIN )do 
    begin
        AgregarAdelante(l,a);
        LeerAlumno(a);
    end;
end;

procedure RecorrerLista(l:lista;var cant:integer; var ape1,ape2,nom1,nom2:cadena15;var dire1,dire2:cadena30);
    function Promedio(v:vectorNotas;diml:integer):real;
    var 
        i:rango;
        suma:integer;
    begin
        suma:=0;
        for i:=1 to diml do suma:=suma+v[i];
        Promedio:= suma / diml;
    end;
    function Cumple(num:integer):boolean;
    begin
        while ( num <> 0 )do begin
            if ( (num mod 10) = 1)then num:=num div 10
                                  else Cumple:=false;
        end;
        Cumple:=true;
    end;
    procedure Minimo(var min1,min2:integer;var ape1,ape2,nom1,nom2:cadena15; var dire1,dire2: cadena30;aux:integer;nom,ape:cadena15;dire:cadena30);
    begin
        if ( aux < min1 )then
        begin
            min2:=min1; ape2:=ape1; nom2:=nom1; dire2:=dire1;
            min1:=aux; ape1:=ape; nom1:=nom; dire1:=dire;
        end
        else if ( aux < min2)then
        begin
            min2:=aux; ape2:=ape;
            nom2:=nom; dire2:=dire1;
        end;
    end;
var
    aux,min1,min2:integer;
begin
    cant:=0;
    min1:=999; min2:=999;
    while ( l <> nil)do
    begin
        writeln(' El promedio del alumno', l^.datos.num, ' es: ', Promedio(l^.datos.notas,l^.datos.diml) );
        if ( (l^.datos.anioI = 2012) and (Cumple (l^.datos.num)) )then cant:=cant+1;
        aux:=l^.datos.anioE - l^.datos.anioI;
        Minimo (min1,min2,ape1,ape2,nom1,nom2,dire1,dire2,aux,l^.datos.nom,l^.datos.ape,l^.datos.dire);
        l:=l^.sig;
    end;
end;
//PROGRAMA PRINCIPAL
var
    l:lista;
    cant:integer;
    ape1,ape2,nom1,nom2:cadena15;
    dire1,dire2:cadena30;
begin
    CargarLista(l);
    RecorrerLista(l,cant,ape1,ape2,nom1,nom2,dire1,dire2);
    writeln ('La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto únicamente por dígitos impares es: ', cant);
    writeln('El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido se recibieron son', ape1,ape2,nom1,nom2,dire1,dire2);
end.
