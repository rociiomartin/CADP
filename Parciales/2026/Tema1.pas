{
TEMA 1 -CADP 2026
4/7/2026
la biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información de los préstamos realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de socio al que se prestó el libro, día del préstamo (1..31). La información de los préstamos se lee de manera ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse). Se pide:
a) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado. Esta estructura debe
quedar ordenada por ISBN de libro.
Calcular el día del mes en que se realizaron menos préstamos.
c) Calcular el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.
NOTA: Una vez completados los incisos, imprimir la estructura generada en el inciso A y los datos obtenidos en los incisos B y C.
}


program Biblioteca;
const 
    FIN=-1;
type
    rangoD=1..31;

    prestamo = record
        nroPrestamo: integer;
        isbn: integer;
        nroSocio: integer;
        dia: rangoD;
    end;

    nuevoR=record
        isbn: integer;
        cantidad: integer;
    end;
    
    estructura = ^nodo;

    nodo = record
        datos: nuevoR;
        sig: estructura;
    end;

    vectorDias = array[rangoD] of integer;


procedure leerPrestamo(var p: prestamo);
begin
    writeln('Ingrese numero de prestamo: ');
    readln(p.nroPrestamo);

    writeln('Ingrese ISBN: ');
    readln(p.isbn);

    if (p.isbn <> -1) then
    begin
        writeln('Ingrese numero de socio: ');
        readln(p.nroSocio);

        writeln('Ingrese dia: ');
        readln(p.dia);
    end;
end;


procedure inicializarDias(var v: vectorDias);
var
    i: integer;
begin
    for i := 1 to 31 do
        v[i] := 0;
end;


procedure agregarAtras(var l, ult: estructura; n: nuevoR);
var
    nuevo: estructura;
begin
    new(nuevo);
    nuevo^.datos := n;
    nuevo^.sig := nil;

    if (l = nil) then
        l := nuevo
    else
        ult^.sig := nuevo;

    ult := nuevo;
end;

procedure generarEstructura(var l: estructura; 
                            var cantDias: vectorDias;
                            var cantEspeciales, cantTotal: integer);
var
    ult: estructura;
    n:nuevoR;
    p:prestamo;
begin
    l := nil;
    ult := nil;
    
    cantEspeciales := 0;
    cantTotal := 0;
    
    leerPrestamo(p);
    while (p.isbn <> -1) do
    begin
        n.isbn := p.isbn;
        n.cantidad := 0;

        { Corte de control por ISBN }
        while (p.isbn <> FIN) and (p.isbn = n.isbn) do
        begin
            n.cantidad := n.cantidad + 1;
            cantDias[p.dia] := cantDias[p.dia] + 1;  { Inciso B }
            { Inciso C }
            if ((p.nroPrestamo mod 2 <> 0) and (p.nroSocio mod 2 = 0)) then
                cantEspeciales := cantEspeciales + 1;
                
            cantTotal := cantTotal + 1;
            leerPrestamo(p);
        end;
        { Generamos la estructura pedida en A }
        agregarAtras(l, ult, n);
    end;
end;


function diaConMenosPrestamos(cantDias: vectorDias): integer;
var
    i: rangoD;
    minimo: integer;
begin
    minimo := 1;

    for i := 2 to 31 do
    begin
        if (cantDias[i] < cantDias[minimo]) then
            minimo := i;
    end;

    diaConMenosPrestamos := minimo;
end;


function calcularPorcentaje(cantEspeciales, cantTotal: integer): real;
begin
    if (cantTotal > 0) then
        calcularPorcentaje := (cantEspeciales * 100) / cantTotal
    else
        calcularPorcentaje := 0;
end;


procedure imprimirEstructura(l: estructura);
begin
    writeln;
    writeln('--- INCISO A ---');

    while (l <> nil) do
    begin
        writeln('ISBN: ', l^.datos.isbn,
                ' - Cantidad de prestamos: ', l^.datos.cantidad);

        l := l^.sig;
    end;
end;


var
    l: estructura;
    cantDias: vectorDias;
    cantEspeciales, cantTotal: integer;
    diaMin: integer;
    porcentaje: real;

begin

    inicializarDias(cantDias);

    generarEstructura(l, cantDias, cantEspeciales, cantTotal);

    { Inciso A }
    imprimirEstructura(l);

    { Inciso B }
    diaMin := diaConMenosPrestamos(cantDias);

    writeln;
    writeln('--- INCISO B ---');
    writeln('Dia con menos prestamos: ', diaMin);

    { Inciso C }
    porcentaje := calcularPorcentaje(cantEspeciales, cantTotal);

    writeln;
    writeln('--- INCISO C ---');
    writeln('Porcentaje de prestamos: ', porcentaje:0:2, '%');

end.
