Enunciado:
{Una agencia de motocicletas necesita un programa para administrar la información de las reservas de turnos para realizar los servicios de mantenimiento durante el mes de noviembre de 2025. Se dispone de una estructura con la información de las reservas de turnos. De cada reserva de turno se conoce: código de reserva, DNI del cliente, día en el cual deberá realizar el servicio (1.30), hora de inicio (7..19), hora de fin (7..19) y tipo de servicio (1..5). Además, se dispone de otra estructura con el precio por hora que deberá abonar el cliente de acuerdo al tipo de servicio.
Se pide:
a. Generar una nueva estructura con código de reserva y precio total de cada reserva. Esta estructura debe generarse ordenada de manera descendente por el código de reserva de turno.
b. Informar los dos días del mes con mayor cantidad de reservas de clientes con DNI que contenga al menos 3 dígitos impares.
c. Realizar un módulo que reciba la estructura generada en a. y retorne el promedio de precio total que están pagando los clientes en noviembre de
2025.}

const
    DIAS = 30;
    SERVICIOS = 5;

type
    rangoDia = 1..DIAS;
    rangoHora = 7..19;
    rangoServicio = 1..SERVICIOS;

    reserva = record
        codigo: integer;
        dni: integer;
        dia: rangoDia;
        horaInicio: rangoHora;
        horaFin: rangoHora;
        servicio: rangoServicio;
    end;

    lista = ^nodo;
    nodo = record
        dato: reserva;
        sig: lista;
    end;

     reservaPrecio = record
        codigo: integer;
        precioTotal: real;
    end;

    listaPrecio = ^nodoPrecio;
    nodoPrecio = record
        dato: reservaPrecio;
        sig: listaPrecio;
    end;

    vectorPrecios = array[rangoServicio] of real;
    vectorDias = array[rangoDia] of integer;

//MODULOS

function calcularPrecio(horaFin, horaInicio: rangoHora; precio: real): real;
begin
    calcularPrecio := (horaFin - horaInicio) *
                      precio;
end;

procedure insertarOrdenado(var l: listaPrecio; aux: reservaPrecio);
var
    nuevo, actual, anterior: listaPrecio;
begin
    new(nuevo);
    nuevo^.dato := aux;
    nuevo^.sig := nil;

    actual := l;
    anterior :=l;

    while (actual <> nil) and
          (actual^.dato.codigo > aux.codigo) do
    begin
        anterior := actual;
        actual := actual^.sig;
    end;

    if (anterior = actual) then
        l := nuevo;
    else
        anterior^.sig := nuevo;
     nuevo^.sig := actual;
end;

procedure inicializarVector(var v: vectorDias);
var
    i: rangoDia;
begin
    for i := 1 to DIAS do
        v[i] := 0;
end;

function contarImpares(dni: integer): boolean;
var
    digito: integer;
    cant: integer;
begin
    cant := 0;
    while (dni <> 0) and (cant <=3) do
    begin
        digito := dni mod 10;
        if ( (digito mod 2 )<> 0) then
            cant := cant + 1;
        dni := dni div 10;
    end;
    contarImpares := (cant <=3);
end;

//inciso A
procedure generarLista(l: lista;
                       precios: vectorPrecios;
                       var nL: listaPrecio;
                       var v: vectorDias);
var
    aux: reservaPrecio;
begin
    while (l <> nil) do
    begin
        aux.codigo := l^.dato.codigo;
        aux.precioTotal := calcularPrecio(l^.dato.horaFin, l^.dato.horaInicio, precios[l^.dato.servicio]);
        insertarOrdenado(nL, aux);
        if ( contarImpares(l^.dato.dni) ) then
         v[l^.dato.dia] := v[l^.dato.dia] + 1;
        l := l^.sig;
    end;
end;

procedure CalcularMaximo(var mayor1, mayor2: integer; var dia1,dia2: rangoDia; cant:integer; dia:rangoDia);
begin
      if (cant > mayor1) then
        begin
            mayor2 := mayor1;
            dia2 := dia1;
            mayor1 := cant;
            dia1 := dia;
        end
        else
            if (cant > mayor2) then
            begin
                mayor2 := cant;
                dia2 := dia;
            end;
end;

procedure dosMayores(v: vectorDias;
                     var dia1, dia2: rangoDia);
var
    i: rangoDia;
    mayor1, mayor2: integer;
begin
    mayor1 := -1;
    mayor2 := -1;
    dia1 := 0; 
    dia2 := 0;

    for i := 1 to DIAS do
       CalcularMaximo(mayor1,mayor2,dia1,dia2, v[i], i);
end;

Procedure calcularPromedio(l: listaPrecio; var promedio:real);
var
    suma: real;
    cant: integer;
begin
    suma := 0;
    cant := 0;
    while (l <> nil) do
    begin
        suma := suma + l^.dato.precioTotal;
        cant := cant + 1;
        l := l^.sig;
    end;

    if (cant > 0) then
        promedio := suma / cant
    else
        promedio := 0;
end;

//PROGRAMA PRINCIPAL

var
    l: lista;
    nL: listaPrecio;
    precios: vectorPrecios;
    v: vectorDias;
    dia1, dia2: integer;
    prom: real;

begin
    l:=nil; //se dispone
    CargarLista(l); //se dispone
    CargarVector(precios); //se dispone

    nL:=nil;
    inicializarVector(v);
    generarLista(l, precios, nL, v); //inciso A

    dosMayores(v, dia1, dia2); //inciso B
    writeln('Los dos dias con mas reservas son: ',
            dia1, ' y ', dia2);

    calcularPromedio(nL, prom); //inciso C
    writeln('El promedio del precio de las reservas es: ', prom);
end.