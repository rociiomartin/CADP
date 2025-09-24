{
La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a
alumnos de la UNLP. Para ello, esta oficina cuenta con un registro detallado de todos los viajes
realizados por una muestra de 1300 alumnos durante el mes de marzo. De cada viaje se conoce el
código de alumno (entre 1 y 1300), día del mes, Facultad a la que pertenece y medio de transporte (1.
colectivo urbano; 2. colectivo interurbano; 3. tren universitario; 4. tren Roca; 5. bicicleta). Tener en
cuenta que un alumno puede utilizar más de un medio de transporte en un mismo día.
Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una
estructura de datos apropiada. La lectura finaliza al ingresarse el código de alumno -1, que no debe
procesarse.
Una vez finalizada la lectura, informar:
a. La cantidad de alumnos que realizan más de 6 viajes por día
b. La cantidad de alumnos que gastan en transporte más de $80 por día.
c. Los dos medios de transporte más utilizados.
d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.
}

program Hello;

const
    DF = 31;      
    DAlu = 1300;   
    DMed = 5;      
    FIN=-1;
type
    rangoAlumno = 1..DAlu;
    rangoDia    = 1..DF;
    rangoMedio  = 1..DMed;
    cadena30 = string[30];
    
    viaje = record
        codAlumno : rangoAlumno;
        dia       : rangoDia;
        facultad  : cadena30;
        medio     : rangoMedio;  
    end;
    
    nodoLista = record
        dia       : rangoDia;
        facultad  : cadena30;
        medio     : rangoMedio;  
    end;

    { tabla con precios de cada medio de transporte }
    tablaPrecios = array [rangoMedio] of real; 

    { para almacenar los viajes (se puede manejar como lista o vector dinámico) }
    listaViajes = ^nodo;
    nodo = record
        dato : nodoLista;
        sig  : listaViajes;
    end;
    
    vectorListas = array [rangoAlumno] of listaViajes;
//MODULOS
procedure LeerViaje(var v: viaje);
begin
    writeln('Ingrese codigo de alumno (-1 para finalizar): ');
    readln(v.codAlumno);
    if (v.codAlumno <> FIN) then
    begin
        writeln('Ingrese dia del mes (1..31): ');
        readln(v.dia);
        writeln('Ingrese facultad: ');
        readln(v.facultad);
        writeln('Ingrese medio de transporte (1..5): ');
        readln(v.medio);
    end;
end;

procedure InicializarVector(var v: vectorListas);
var
    i: rangoAlumno;
begin
    for i := 1 to DAlu do
        v[i] := nil;
end;

procedure AgregarAdelante(var L: listaViajes; n: nodoLista);
var
    nue: listaViajes;
begin
    new(nue);
    nue^.dato := n;
    nue^.sig := L;
    L := nue;
end;

procedure CargarVectorListas(var VL: vectorListas);
var
    vi: viaje;
    n:nodoLista;
begin
    InicializarVector(VL);
    LeerViaje(vi);
    while (vi.codAlumno <> -1) do
    begin
        
        n.dia:=vi.dia;
        n.facultad:=vi.facultad; {cargo el nuevo registro}
        n.medio:=vi.medio;
        
        AgregarAdelante(VL[vi.codAlumno], n);
        LeerViaje(vi);
    end;
end;

procedure CargarTabla(var v:tablaPrecios); {SE DISPONE}
var
    i:rangoMedio;
    precio:real;
begin
    for i:= 1 to DMed do
    begin
        readln(precio);
        v[i]:=precio;
    end;
end;

//PROGRAMA PRINCIPAL
var
    v:vectorListas;
    t:tablaPrecios;
begin
    CargarVectorListas(v);
    CargarTabla(t); //se dispone
end.
