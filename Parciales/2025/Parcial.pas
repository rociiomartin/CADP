{
Una escuela primaria necesita un programa para administrar la información de preinscripciones al ciclo
lectivo 2025. De cada preinscripción se lee: DNI del alumno, apellido y nombre del alumno, fecha de
nacimiento del alumno (día, mes y año), teléfono de contacto y horario de preferencia (1: Mañana, 2:
Tarde, 3: Jornada extendida, 4: Jornada completa). La lectura finaliza cuando se lee el DNI -1 (que no
debe procesarse).
Se pide:
A) Leer y almacenar la información de las preinscripciones en una estructura de datos adecuada.
La información debe quedar almacenada en el mismo orden en que fue leída
B) A partir de la estructura de datos generada en A), calcular e informar:
1. Los dos horarios más requeridos por alumnos nacidos entre enero y junio.
2. Apellido, nombre y teléfono de aquellos alumnos con DNI compuesto solamente por
dígitos impares
3. Porcentaje de preinscripciones al horario Jornada completa.
}

program parcialito;
const 
  FIN=-1;
  DF=4;
type 
  cadena30=string[30];
  rangoD=1..31;
  rangoM=1..12;
  rangoH=1..DF;
  
  fecha=record
          dia:rangoD;
          mes:rangoM;
          anio:integer;
        end;
  preinscripcion=record
                  dni:integer;
                  aYn:cadena30;
                  fe:fecha;
                  tel:integer;
                  horaP:rangoH;
                end;

  lista=^nodo; 
  nodo=record
        datos: preinscripcion;
        sig: lista;
       end;
       
  vectorHorarios=Array[rangoH]of integer;
  
//MODULOS
procedure LeerFecha(var f:fecha);
begin
  with f do
  begin
    writeln('Ingrese dia,');
    readln(dia);
    writeln('Mes');
    readln(mes);
    writeln('Y año');
    readln(anio);
  end;
end;
procedure LeerPreinscripcion (var p:preinscripcion);
begin
  with p do
  begin
    writeln('Ingrese un DNI --fin -1 --');
    readln(dni);
    if (dni <> FIN)then
    begin
      writeln('Ingrese apellido y nombre');
      readln(aYn);
      write('Ingrese la fecha');
      LeerFecha(fe);
      writeln('Ingrese telefono');
      readln(tel);
      writeln('Ingrese hora de preferencia');
      readln(horaP);
    end;
  end;
end;
procedure AgregarAlFinal (var l:lista; p:preinscripcion);
var
 nuevo,aux:lista;
begin
   new (nuevo); 
   nuevo^.datos:= p; 
   nuevo^.sig:=nil; 
   if (l = nil) then l:= nuevo
   else 
   begin
      aux:= l;
      while (aux^.sig <> nil) do aux:= aux^.sig;
      aux^.sig:=nuevo;       
   end;
end;
procedure CargarLista(var l:lista);
var
  p:preinscripcion;
begin
  l:=nil;
  LeerPreinscripcion(p);
  while (p.dni <> FIN )do
  begin
    AgregarAlFinal(l,p);
    LeerPreinscripcion(p);
  end;
end;
procedure InicializarVector(var v:vectorHorarios);
var
  i:rangoH;
begin
  for i:=1 to DF do v[i]:=0;
end;

function CumplePar(dni:integer):boolean;
begin
  while ( dni <> 0)  do
  begin
    if ( (dni mod 2) = 0 ) then CumplePar:= false
    else
      dni:=dni div 10;
  end;
  CumplePar:=true;
end;
procedure RecorrerLista(l:lista; var v:vectorHorarios; var cant:integer);
begin
  while ( l <> nil )do
  begin
    if (l^.datos.fe.mes = 1 ) or (l^.datos.fe.mes = 6) then v[l^.datos.horaP]:=v[l^.datos.horaP]+1;
    if ( CumplePar (l^.datos.dni) ) then writeln ('Cumple, sus datos son:', l^.datos.aYn, l^.datos.tel);
    cant:=cant+1;
    l:=l^.sig;
  end;
end;
procedure CalcularMaximos (v:vectorHorarios; var h1,h2:rangoH);
var
  i:rangoH;
  max1,max2:integer;
begin
  max1:=-1; max2:=-1;
  for i:=1 to DF do 
  begin
    if (max1 < v[i])then
    begin
      max2:=max1; h2:=h1;
      max1:= v[i]; h1:=i;
    end
    else if (max2 < v[i])then
    begin
      max2:=v[i]; h2:=i;
    end;
  end;
end;

//PROGRAMA PRINCIPAL
var
  l:lista;
  v:vectorHorarios;
  h1,h2:rangoH;
  Porcentaje,cant:integer;
begin
  CargarLista(l);
  InicializarVector(v);
  cant:=0;
  RecorrerLista(l,v,cant);
  CalcularMaximos(v,h1,h2);
  writeln('Los dos horarios más requeridos por alumnos nacidos entre enero y junio son:', h1, ' y ', h2);
  Porcentaje:= (cant div v[4])*100;
  writeln('Porcentaje de preinscripciones al horario Jornada completa: ', Porcentaje, '%' );
end.
