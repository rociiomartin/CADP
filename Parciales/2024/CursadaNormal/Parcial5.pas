{Tercera Fecha 13/7}
program parcial;
const
    DFP=22;
    DFI=5;
type
    cadena20 = string[20];
    rangoP = 1..DFP;
    rangoI = 1..DFI;

    part = record
        anio: integer;
        instancia: rangoI;
    end;
    detalleP = array [rangoP] of part;
    pais = record
        nombre: cadena20;
        cantCopas: integer;
        cantPart: rangoP;
        participacion: detalleP;
    end;

    listaPaises = ^nodo;
    nodo = record
        dato:pais;
        sig:listaPaises;
    end;

procedure CargarVectorParticipacion (var detPart:detalleP;diml:integer);
    procedure LeerParticipacion(var p:part);
    begin
        writeln('Ingrese el año');
        readln(p.anio);
        writeln('Ingrese la instacia --1 a 5--');
        readln(p.instancia);
    end;
var
    i: rangoP; 
    p:part;
begin
    for i:= 1 to diml do begin
        LeerParticipacion(p);
        detPart[i]:=p;
    end;
end;

procedure LeerPais (var p:pais);
begin
    writeln('Ingrese el nombre ');
    read(p.nombre);
    if ( p.nombre <> ' ')then //corte trucho
    begin
        writeln('Ingrese la cantidad de copas');
        read(p.cantCopas);
        writeln('Ingrese la cantidad de participaciones --a lo sumo 20--');
        read(p.cantPart);
        CargarVectorParticipacion(p.participacion,p.cantPart);  
    end;  
end;
procedure AgregarPais(var l:listaPaises;p:pais);
var 
    nue:listaPaises;
begin
    new(nue);
    nue^.dato:=p;
    nue^.sig:=l;
    l:=nue;
end;

procedure CargarLista(var l:listaPaises);
var 
    p:pais;
begin
    writeln('---------LISTA-------');
    l:=nil;
    LeerPais(p);
    while ( p.nombre <> ' ') do //corte de control de carga en caso de que haya
    begin
        LeerPais(p);
        AgregarPais(l,p);
    end;
end;

procedure InicisoA(var l:listaPaises);
var 
    p:pais;
begin
    writeln('--Inciso A--');
    LeerPais(p);
    AgregarPais(l,p);
end;

procedure RecorrerLista(l:listaPaises;var nombMax1,nombMax2:cadena20;var prome:real);
    procedure RecorrerVector (v:detalleP;diml:rangoP;var totalPart,cantFinal:integer);
    var
        i:rangoP;
    begin
        for i:= 1 to diml do 
        begin
            if( (v[i].anio < 1998) and (v[i].instancia > 2) ) then totalPart:= totalPart + 1;
            if(v[i].instancia = 5) then cantFinal:= cantFinal + 1;
        end;
    end;
    procedure ActualizarMaximos(var max1,max2:integer;var nombMax1,nombMax2:cadena20;cantFinal:integer;nom:cadena20);
    begin
        if (cantFinal > max1) then
        begin
            max2:=max1; nombMax2:=nombMax1;
            max1:=cantFinal;nombMax1:=nom;
        end
        else    
            if (cantFinal > max2)then
            begin
                max2:=cantFinal; nombMax2:=nom;
            end;
    end;
    function Promedio(cantT,cantP:integer):real;
    begin
        Promedio:=cantT/cantP;
    end;
var
    totalPart,cantT,cantP:integer;
    max1,max2:integer; cantFinal:integer;
begin
    max1:=-1;max2:=-1; nombMax1:=' ';nombMax2:=' '; cantT:=0; cantT:=0; cantP:=0;
    while (l <> nil) do
    begin
        totalPart:=0; cantFinal:=0;
        RecorrerVector(l^.dato.participacion, l^.dato.cantPart,totalPart,cantFinal);
        writeln('Inciso b)1: ', totalPart); //inciso b1
        ActualizarMaximos(max1,max2,nombMax1,nombMax2,cantFinal,l^.dato.nombre);
        cantT:=cantT + l^.dato.cantPart;
        cantP:=cantP+1;
        l:=l^.sig;
    end;
    prome:= Promedio (cantT,cantP);
end;

var
    l:listaPaises;
    nombMax1,nombMax2:cadena20; //inciso b2
    promedio:real; //inciso b3
begin
    CargarLista(l); //se dispone
    InicisoA(l);
    RecorrerLista(l,nombMax1,nombMax2,promedio);
    writeln('Inciso b2: ', nombMax1, ' y ' ,nombMax2);
    writeln('Inciso b3: ', promedio);
end.
