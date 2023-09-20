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
    rango2=1..DF;//en teoria seria 1973..2023

    vectorTemp = array [rango1] of real;
    vectorAnio = array [rango2] of vectorTemp;
//PROCESOS
procedure CargarVectorAnio(var v:vectorAnio);
    procedure CargarVectorTemp(var v:vectorTemp);
    var
        i:rango1;
        t:real;
    begin
        writeln('---Ingrese temperaturas---');
        for i:= 1 to TEMP do
        begin
            readln(t); 
            v[i]:=t;
        end;
    end;
var
    vec:vectorTemp;
    i:rango2;
begin
    for i:= 1 to DF do
    begin 
        CargarVectorTemp(vec);
        v[i]:= vec;
    end;
end;
procedure RecorrerVectores(v:vectorAnio);
    procedure Maximo(var i:rango2; var max:real;cant:real;anio:rango2);
    begin
        if(cant > max)then
        begin
            max:=cant;
            i:=anio;
        end;
    end;
    procedure TempPromedio(v:vectorTemp;a:rango2; var anio:rango2; var max,tempPro:real);
    var
        i:rango1;
        prome:real;
    begin
        prome:=0;
        for i:=1 to TEMP do 
        begin
            prome:=prome+v[i];
            Maximo(anio,max,v[i],a);
        end;
        tempPro:=prome/TEMP;
    end;
var
    i,anio1,anio2:rango2;
    max1,max2,tempPro:real;
begin
    max1:=-1;max2:=-1;
    for i:=1 to DF do
    begin
        TempPromedio(v[i],i,anio1,max1,tempPro);
        Maximo(anio2,max2,tempPro,i);
    end;
    writeln('El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años: ', anio1);
    writeln('El año con mayor temperatura promedio a nivel mundial: ', anio2);
end;
//PP
var
    vec:vectorAnio;
begin
    CargarVectorAnio(vec);
    RecorrerVectores(vec);
end.
