{
El Grupo Intergubernamental de Expertos sobre el Cambio Climático de la ONU (IPCC) realiza todos los
años mediciones de temperatura en 100 puntos diferentes del planeta y, para cada uno de estos lugares,
obtiene un promedio anual. Este relevamiento se viene realizando desde hace 50 años, y con todos los
datos recolectados, el IPCC se encuentra en condiciones de realizar análisis estadísticos. Realizar un
programa que lea y almacene los datos correspondientes a las mediciones de los últimos 50 años (la
información se ingresa ordenada por año). Una vez finalizada la carga de la información, obtener:

a) El año con mayor temperatura promedio a nivel mundial.
b) El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años.
}

{
El Grupo Intergubernamental de Expertos sobre el Cambio Climático de la ONU (IPCC) realiza todos los
años mediciones de temperatura en 100 puntos diferentes del planeta y, para cada uno de estos lugares,
obtiene un promedio anual. Este relevamiento se viene realizando desde hace 50 años, y con todos los
datos recolectados, el IPCC se encuentra en condiciones de realizar análisis estadísticos. Realizar un
programa que lea y almacene los datos correspondientes a las mediciones de los últimos 50 años (la
información se ingresa ordenada por año). Una vez finalizada la carga de la información, obtener:

a) El año con mayor temperatura promedio a nivel mundial.
b) El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años.
}

program ejercicio13;
const
    TEMP=5; DF=3;
type
    rango1=1..TEMP;
    rango2=1..50;//en teoria seria 1973..2023
    temp=record     
            año:integer; //ordenada x este campo
            temp:integer;
         end;
         
    vectorTemp = array[rango1] of temp;
    vectorAño = array[rango2] of vectorTemp;
//PROCESOS
procedure CargarVectorAño(var v:vectorAño; v:vectorTemp);
    LeerTemperatura(var t:temp);
    begin
        writeln('Ingrese el año');
        readln(t.año);
        writeln('Ingrese la temperatura del lugar');
        readln(t.temp);
    end;
var
    t:temperatura;añoActual:integer;
    i:rango1;
begin
    for i:= 1 to DF do
    begin 
        LeerTemperatura(t);
        añoActual:=t.año;
        while(t.año = añoActual)do
        begin
            for i:=1 to TEMP do
            begin
                v[añoActual]
            end;
        end;
    end;
end;
//PP
var
    v:vectorTemp;
    vec:vectorAño;
begin
    CargarVectorTemp(v);
end.
