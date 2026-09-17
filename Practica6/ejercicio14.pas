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
    FIN= -1;
type
    rangoAlumno = 1..DAlu;
    rangoDia    = 1..DF;
    rangoMedio  = 1..DMed;
    cadena30 = string[30];
    
    viaje = record
        codAlumno : integer; //rangoAlumno
        dia       : rangoDia;
        facultad  : cadena30;
        medio     : rangoMedio;  
    end;
    
    { tabla con precios de cada medio de transporte }
    tablaPrecios = array [rangoMedio] of real; 

    { para almacenar los viajes (se puede manejar como lista o vector dinámico) }
    listaViajes = ^nodo;
    nodo = record
        dato : viaje;
        sig  : listaViajes;
    end;
    
    registro = record
        cant:integer;
        monto:real;
    end;
    
    vectorDias = array [rangoDia] of registro;
    vectorMedios = array [rangoMedio] of integer;
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

procedure InsertarOrdenado(var L:listaViajes; v:viaje);
var
    nue, act, ant: listaViajes;
begin
    new (nue); 
    nue^.dato := v; 
    act := L; 
    ant := L;
    while( act <> nil)and(v.codAlumno > act^.dato.codAlumno)do 
    begin
        ant := act;
        act:= act^.sig;
    end;
    if (act = ant) then 
        L:= nue
    else 
        ant^.sig:= nue;
    nue^.sig:= act; 
end;

procedure CargarLista(var l:listaViajes);
var
    v: viaje;
begin
    LeerViaje(v);
    while (v.codAlumno <> FIN) do
    begin
        InsertarOrdenado(l,v);
        LeerViaje(v);
    end;
end;

procedure CargarTabla(var v:tablaPrecios); {SE DISPONE}
var
    i:rangoMedio;
    precio:real;
begin
    writeln ('Ingrese los precios');
    for i:= 1 to DMed do
    begin
        read(precio);
        v[i]:=precio;
    end;
end;

procedure InicializarVector(var v:vectorDias); 
var
    i:rangoDia;
begin
    for i:= 1 to DF do
    begin
        v[i].cant:=0;
        v[i].monto:=0.0;
    end;
end;

procedure RecorrerVector(v:vectorDias; var cantD,cantG:integer); 
var
    i:rangoDia;
begin
    cantD:=0; cantG:=0;
    for i:= 1 to DF do
    begin
        if ( v[i].cant > 6 )then cantD:=cantD+1;
        if ( v[i].monto > 80 )then cantG:=cantG+1;
    end;
end;

procedure InicializarVectorMedio(var v:vectorMedios); 
var
    i:rangoMedio;
begin
    for i:= 1 to DMed do v[i]:=0;
end;

procedure Maximos (v:vectorMedios;var m1,m2: rangoMedio);
var
    i:rangoMedio;
    max1,max2:integer;
begin
    max1:=-1;
    for i:=1 to DMed do
    begin
        if ( max1 > v[i] )then
        begin
            max1:= v[i];
            m1:= i;
            max2:= max1;
            m2:= m1;
        end
        else
          if ( max2 > v[i] )then
          begin
            max2:= v[i];
            m2:= i;
          end;
    end;
end;

procedure RecorrerLista (l:listaViajes; t: tablaPrecios; var v:vectorMedios;var cantD,cantG,cantB:integer);
var
    aluAct:rangoAlumno;
    ve:vectorDias;
begin
    cantB:=0;
    while ( l <> nil)do
    begin
        aluAct:=l^.dato.codAlumno;
        InicializarVector(ve); //inciso A
        while ( l <> nil) and ( aluAct = l^.dato.codAlumno )do
        begin
            ve[l^.dato.dia].cant:=ve[l^.dato.dia].cant+1;
            ve[l^.dato.dia].monto:=ve[l^.dato.dia].monto + t[l^.dato.medio];
            v[l^.dato.medio]:=v[l^.dato.medio]+1;
            l:=l^.sig;
        end;
        RecorrerVector(ve,cantD,cantG);
        if (v[5] <> 0) and ( (v[1] <> 0) or (v[2] <> 0) or (v[3] <> 0) or (v[4] <> 0))then cantB:=cantB+1;
    end;
end;

//PROGRAMA PRINCIPAL
var
    l:listaViajes;
    t:tablaPrecios;
    cantD,cantG,cantB:integer;
    v:vectorMedios;
    m1,m2:rangoMedio;
begin
    l:=nil; m1:=-1;
    CargarLista(l);
    CargarTabla(t); //se dispone
    InicializarVectorMedio(v);
    RecorrerLista (l,t,v,cantD,cantG,cantB);
    writeln( 'La cantidad de alumnos que realizan más de 6 viajes por día ', cantD);
    writeln ( 'La cantidad de alumnos que gastan en transporte más de $80 por día ', cantG);
    Maximos (v, m1,m2);
    writeln ('Los dos medios de transporte más utilizados ', m1,' y ',m2);
    writeln ( 'La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte ', cantB);
end.
