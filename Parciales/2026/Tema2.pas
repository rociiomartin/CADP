{
CADP 2026 - Parcial 1 - Fecha 1 - 13-06-2025 - Tema 2

La Universidad de Buenos Aires (UBA) dispone de información de todos sus alumnos. De cada alumno posee el DNI, nombre de la 
carrera que estudia, año de ingreso y nota promedio que posee. La información se encuentra ordenada por nombre de carrera. 
Realizar un módulo que procese la información que se dispone y retorne: 

1. Una nueva estructura que tenga para cada carrera, el nombre de la carrera, la cantidad de alumnos y el DNI del alumno con 
promedio más alto de la carrera. 

2. La cantidad de alumnos de la UBA por año de ingreso, considerando los años entre 2005 y 2025 inclusive. 

3. El DNI del alumno con promedio más alto de toda la UBA. Implementar el programa principal que invoque a dicho módulo e 
imprima la información retornada por este. 

Nota: la estructura que se dispone se debe recorrer una vez. 
}
program ParcialCADP;

const
  DF = 2025;

type

  rangoAnios = 2005..DF;

  alumno = record
    dni: integer;
    carrera: string;
    anioIngreso: integer;
    promedio: real;
  end;


  lista = ^nodo;
  nodo = record
    datos: alumno;
    sig: lista;
  end;


  infoCarrera = record
    carrera: string;
    cantAlumnos: integer;
    dniMejorPromedio: integer;
  end;


  lista2 = ^nodo2;
  nodo2 = record
    datos: infoCarrera;
    sig: lista2;
  end;


  vectorAlumnos = array[rangoAnios] of integer;



procedure inicializarVectorAnio(var v: vectorAlumnos);
var
  i: rangoAnios;
begin
  for i := 2005 to DF do
    v[i] := 0;
end;



procedure Maximo(var max: real; valor: real; dni: integer; var dniMax: integer);
begin
  if valor > max then
  begin
    max := valor;
    dniMax := dni;
  end;
end;



procedure MaximoTotal(var max: real; valor: real; dni: integer; var dniMax: integer);
begin
  if valor > max then
  begin
    max := valor;
    dniMax := dni;
  end;
end;



procedure AgregarAdelante(var l: lista2; info: infoCarrera);
var
  nue: lista2;
begin
  new(nue);
  nue^.datos := info;
  nue^.sig := l;
  l := nue;
end;



procedure procesar(l: lista; var l2: lista2;
                   var v: vectorAlumnos;
                   var dniT: integer);

var
  info: infoCarrera;
  maxCarrera: real;
  maxTotal: real;

begin

  maxTotal := -1;
  dniT := 0;


  while (l <> nil) do
  begin

    info.carrera := l^.datos.carrera;
    info.cantAlumnos := 0;

    maxCarrera := -1;
    info.dniMejorPromedio := 0;


    while (l <> nil) and
          (l^.datos.carrera = info.carrera) do
    begin

      info.cantAlumnos := info.cantAlumnos + 1;


      Maximo(maxCarrera,
             l^.datos.promedio,
             l^.datos.dni,
             info.dniMejorPromedio);



      if (l^.datos.anioIngreso >= 2005) and
         (l^.datos.anioIngreso <= 2025) then
        v[l^.datos.anioIngreso] :=
        v[l^.datos.anioIngreso] + 1;


      Maximo(maxTotal,
             l^.datos.promedio,
             l^.datos.dni,
             dniT);


      l := l^.sig;

    end;


    AgregarAdelante(l2, info);

  end;

end;



var
  l: lista;
  l2: lista2;
  v: vectorAlumnos;
  dniT: integer;

begin

  l := nil;
  l2 := nil;

  CargarLista(l); // se dispone

  inicializarVectorAnio(v);

  procesar(l, l2, v, dniT);

  writeln('DNI mejor UBA: ', dniT);

  ImprimirVector(v); // se dispone

end.
