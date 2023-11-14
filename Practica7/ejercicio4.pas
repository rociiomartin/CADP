{

Una maternidad dispone información sobre sus pacientes. De cada una se conoce: nombre, apellido y
peso registrado el primer día de cada semana de embarazo (a lo sumo 42). La maternidad necesita un
programa que analice esta información, determine e informe:
a. Para cada embarazada, la semana con mayor aumento de peso.
b. El aumento de peso total de cada embarazada durante el embarazo.
}

program ejercicio4;
const
    DF=42;
type
  rango=1..DF;
  cadena20=string[20];
  
  vectorSemanas= array [rango] of real; //se dispone
  paciente=record
              nom:cadena20;
              ape:cadena20;
              peso: vectorSemanas;
              diml:integer; //a lo sumo 42
           end;
  lista=^nodo; //se dispone
  nodo = record 
            datos:paciente;
            sig:lista;
           end;
    
//PROCESOS
{SE DISPONE}
procedure CargarLista(var l : lista);
    procedure CargarVector(var v:vectorSemanas; var diml:integer );
    var
        peso:real;
    begin
        diml:=0;
        writeln('--CARGANDO VECTOR--');
        writeln('Ingrese los pesos --no mas de 42--');
        readln(peso);
        while ( (diml < DF ) and ( peso <> -1 ) )do
        begin
            diml:=diml+1;
            v[diml]:= peso;
            readln(peso);
        end;
   end;
    procedure LeerPacientes(var p:paciente);
    var
        v:vectorSemanas;
    begin
        writeln(' Ingrese el nom --FIN vacio -- ');
        readln(p.nom);
        if ( p.nom <> ' ' )then
        begin
          writeln('Ingrese el apellido');
          readln(p.ape);
          CargarVector(v,p.diml);
          writeln('------------------------------------------------');
        end;
    end;
    procedure AgregarAdelante(var l:lista; p:paciente);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= p;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   p:paciente;
begin
    l:=nil;
    writeln('--CARGANDO LISTA--');
    LeerPacientes(p);
    while ( p.nom <> ' ' )do
    begin
        LeerPacientes(p);
        AgregarAdelante(l,p);
    end;
end;

procedure Recorrer(l:lista);
    procedure Maximo(var max:real;var sem:integer; km:real; i:integer);
    begin
        if ( max < km ) then
        begin
            max:=km;
            sem:=i;
        end;
    end;
    procedure RecorrerVector(var max,pesoT:real;var sem:integer; v:vectorSemanas; diml:integer);
    var
       peso:real;
       i:rango;
    begin
        pesoT:=0;
        for i:= 1 to diml-1 do
        begin
            peso:= v[i+1]-v[i];
            pesoT:=pesoT+peso;
            Maximo(max,sem,peso,i);
        end;
    end;
var
    max,peso:real;
    semana:integer;
begin
    max:=-1;
    while ( l <> nil ) do
    begin
        peso:=0.0;
        RecorrerVector(max,peso,semana,l^.datos.peso,l^.datos.diml);
        writeln('--Embarazada: ', l^.datos.nom, '---');
        writeln('  La semana con mayor aumento de peso fue: ', semana);
        writeln('  Su aumento de peso total fue: ', peso:00:00);
        l:=l^.sig;
    end;
end;
 
//PP
var
  l:lista;
begin
  CargarLista(l);//se dispone
  Recorrer(l);
end.
