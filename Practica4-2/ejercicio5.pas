{
FALTA TERMINAR

La empresa Amazon Web Services (AWS) dispone de la información de sus 500 clientes monotributistas más
grandes del país. De cada cliente conoce la fecha de firma del contrato con AWS, la categoría del
monotributo (entre la A y la F), el código de la ciudad donde se encuentran las oficinales (entre 1 y 2400) y
el monto mensual acordado en el contrato. La información se ingresa ordenada por fecha de firma de
contrato (los más antiguos primero, los más recientes últimos).
Realizar un programa que lea y almacene la información de los clientes en una estructura de tipo vector.
Una vez almacenados los datos, procesar dicha estructura para obtener:
a. Cantidad de contratos por cada mes y cada año, y año en que se firmó la mayor cantidad de contratos
b. Cantidad de clientes para cada categoría de monotributo
c. Código de las 10 ciudades con mayor cantidad de clientes
d. Cantidad de clientes que superan mensualmente el monto promedio entre todos los clientes.
}

program ejercicio5;
const
    DF=5; COD=2400;
type
    rangod=1..31;
    rango2=1..12;
    rango1='A'..'F';
    rango2=1..DF;
    rango3=1..COD;
    
    fecha=record
            dia:rangod;
            mes:rangom;
            anio:integer;
    cliente= record
                f:fecha;  //ordena x fecha, los más antiguos primero, los más recientes últimos
                cate:rango1;
                cod:rango3;
                monto:real;
             end;
             
    vector=array [rango2] of cliente; //se dispone
    vectorC=array [rango1] of integer;
//PROCESOS
procedure CargarVector(var v:vector); //SE DISPONE
    
    procedure LeerClientes(var c:cliente);
        procedure LeerFechas(var f:fecha);
        begin
            writeln('Ingrese el dia');
            readln(f.dia);
            writeln('Ingrese el mes');
            readln(f.mes);
            writeln('Ingrese el año');
            readln(f.anio);
        end;
    var 
     f:fecha;
    begin
        writeln('Ingrese FECHA:');
        LeerFechas(f);
        writeln('Ingrese el codigo');
        readln(c.cod);
        writeln('Ingrese el monto');
        readln(c.monto);
    end;
var
    i:rango2;
    c:cliente;
begin
    for i:=1 to DF do
    begin
        LeerClientes(c);
        v[i]:=c;
    end;
end;

procedure RecorrerVector(v:vector);

    procedure Inicializar(var vec:vectorC);
    var
        i:rango1;
    begin
        for i:=1 to 12 do vec[i]:=0;
    end;
    procedure ImprimirCategorias(vec: vectorC);
    var
        i:rango1;
    begin
        for i:=1 to 12 do writeln('Cantidad de clientes para la categoria ', i , ' es: ', vec[i]);
    end;
var
    i:rango2;
    vC:vectorC;
begin
    Inicializar(vC);
    for i:=1 to DF do
    begin
        vC[v[i].cate]:=vC[v[i].cate]+1;
    end;
end;

//PP
var
    v:vector;
begin
    CargarVector(v);
    RecorrerVector(v);
end.
