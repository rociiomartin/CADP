{
Una compañía de telefonía celular debe realizar la facturación mensual de sus 9300 clientes con planes de
consumo ilimitados (clientes que pagan por lo que consumen). Para cada cliente se conoce su código de cliente y
cantidad de líneas a su nombre. De cada línea se tiene el número de teléfono, la cantidad de minutos consumidos
y la cantidad de MB consumidos en el mes. Se pide implementar un programa que lea los datos de los clientes de
la compañía e informe el monto total a facturar para cada uno. Para ello, se requiere:

a. Realizar un módulo que lea la información de una línea de teléfono.
b. Realizar un módulo que reciba los datos de un cliente, lea la información de todas sus líneas (utilizando el
módulo desarrollado en el inciso a. ) y retorne la cantidad total de minutos y la cantidad total de MB a facturar
del cliente.

Nota: para realizar los cálculos tener en cuenta que cada minuto cuesta $3,40 y cada MB consumido cuesta $1,35.
}

program ejercicio4;
const 
  DF=9300; MIN=3.40; MB=1.35;
type
   cadena20=string [20];
   clientes=record
            codC: integer;
            cantL:integer; //puede tener muchas a su ombre
           end;
   lineas=record
            num:integer;
            cantMin:integer; //cuesta 3.40 c/m
            cantMB:integer; //consumido 1,35
        end;
//PROCESOS
Procedure Informar();

        Procedure LeerClientes(var c:clientes);
        begin
            writeln('Ingrese un codigo de cliente');
            readln(c.codC);
            writeln('Ingrese la cantidad de lineas a su nombre');
            readln(c.cantL);
        end;
        Procedure LeerLineas(var l:lineas);
        begin
            writeln('Ingrese el numero de telefono');
            readln(l.num);
            writeln('Ingrese la cantidad de minuto');
            readln(l.cantMin);
            writeln('Ingrese la cantidad de MB');
            readln(l.cantMB);
        end;
        Procedure CalcularMonto(var cantTotalM,cantTotalMB:real; var codCli:integer);
        var
          c:clientes;l:lineas;
          j:integer;
        begin
            LeerClientes(c);
            codCli:=c.codC; //para que quede mas lindo
            for j:= 1 to c.cantL do
            begin
                  LeerLineas(l);
                  cantTotalM:=cantTotalM + (l.cantMin*MIN);
                  cantTotalMB:=cantTotalMB+ (l.cantMB*MB)
            end;
        end;

var 
  i,codC:integer;
  montoTotal, cantTotalM,cantTotalMB :real;
begin
    for i:= 1 to 3 do
    begin
        CalcularMonto(cantTotalM,cantTotalMB,codC);
        montoTotal:=cantTotalMB+cantTotalM;
        writeln('El monto total para el cliente ', codC, ' es: ', montoTotal);
    end;
   
end;


//PROGRAMA PRINCIPAL

begin
   Informar();
end.
