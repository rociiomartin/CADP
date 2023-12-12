{
CADP 2023 - Parcial - Segunda Fecha - 25/11/2023 TEMA 1
Un salón de eventos necesita un programa para administrar la información de las reservas de diciembre de 2023. Se dispone de una 
estructura con la información de las reservas. De cada reserva se conoce: número de reserva, DNI del cliente, día del evento 
(1..31), hora de inicio, hora de fin y categoría de servicio (1..4). Además, se dispone de una tabla con el precio por hora de 
reserva de acuerdo a cada categoría de servicio.
Se pide:

A) Generar una nueva estructura con número y precio total de cada reserva. Esta estructura debe generarse ordenada por número de 
reserva.
B) Informar los dos días del mes con mayor cantidad de reservas de clientes con DNI par.
C) Informar el porcentaje de reservas de eventos que inicien antes de las 12 hs y se produzcan en la primera quincena.
}

program Hello;
const   
    DF1=31;
    DF2=4;
type
    rango1=1..DF1;
    rango2=1..24;
    rango3=1..DF2;
    
    reserva=record
                num:integer;
                dni:integer;
                dia:rango1;
                horaI:rango2;
                horaF:rango2;
                cate:rango3;
            end;
    lista=^nodo; //se dispone
    nodo=record
            datos:reserva;
            sig:lista;
         end;
    
    vectorPrecio = array [rango3] of real; //se dispone
    
    nueva=record
            num:integer;
            precio:real;
        end;
    lista2=^nodo2;
    nodo2=record
            datos:nueva;
            sig:lista2;
         end;
         
    vectorContador= array [rango1] of integer;

//PROCESOS

{SE DISPONE
procedure CargarLista(var l:lista);
    procedure LeerReseva(var r:reserva);
    begin
        writeln('Ingrese el numero --FIN 0-- ');
        readln(r.num);
        if ( r.num <> 0 )then
        begin
            writeln('Ingrese el dni');
            readln(r.dni);
            writeln('Ingrese el dia  --1 a 31--');
            readln(r.dia);
            writeln('Ingrese la hora inicio --1 a 24--');
            readln(r.horaI);
            writeln('Ingrese la hora fin ');
            readln(r.horaF);
            writeln('Ingrese la categoría --1 a 4--');
            readln(r.cate);
            writeln('----------------------------------------');
        end;
    end;
    procedure AgregarAdelante (var l:lista; r:reserva);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= r;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
    r:reserva;
begin
    writeln('CARGANDO LISTA');
    l:=nil;
    LeerReseva(r);
    while ( r.num <>  0 ) do
    begin
        AgregarAdelante(l,r);
        LeerReseva(r);
    end;
end;

procedure CargarVector(var v:vectorPrecio);
var
    i:rango3;
    precio:real;
begin
    writeln('CARGANDO VECTOR');
    writeln('Ingrese 4 precios');
    for i:= 1 to DF2 do
    begin
        readln(precio);
        v[i]:=precio;
    end;
end;
}

procedure RecorrerLista(l:lista; v:vectorPrecio; var l2:lista2; var v2:vectorContador);
    procedure InsertarOrdenado(var l2:lista2; n:nueva);
    var
        aux,ant,act:lista2;
    begin
        act:=l2;
        ant:=l2;
        new(aux);
        aux^.datos:= n;
        while (act<>nil) and (act^.datos.num < aux^.datos.num) do
        begin
            ant:=act;
            act:=act^.sig;
        end;
        if act = l2 then l2:=aux
                   else ant^.sig:=aux;
        aux^.sig:=act;
    end;
    function CalcularPrecio(horaI,horaF:rango2; precio:real):real;
    begin
        CalcularPrecio:= (horaF - horaI) * precio;
    end;
    function Par(dni:integer):boolean;
    begin
        if ( (dni mod 2) = 0 ) then Par:=true
                               else Par:=false;
    end;
    procedure InicializarVector(var v2:vectorContador);
    var
        i:rango1;
    begin
        for i:=1 to DF1 do v2[i]:=0;
    end;
var
    cantTotal,cant,porcentaje:integer;
    precioTotal:real;
    n:nueva;
begin
    cantTotal:=0; cant:=0; l2:=nil; InicializarVector(v2);
    while ( l <> nil )do
    begin
        cantTotal:=cantTotal+1;
        
        precioTotal:= CalcularPrecio(l^.datos.horaI,l^.datos.horaF, v[l^.datos.cate]);
        n.num:=l^.datos.num; n.precio:=precioTotal;
        InsertarOrdenado(l2,n);
        
        if ( Par(l^.datos.dni) ) then v2[l^.datos.dia]:= v2[l^.datos.dia]+1;
        
        if ( (l^.datos.horaI < 12) and (l^.datos.dia <=15) ) then cant:=cant+1;
        
        l:=l^.sig;
    end;
    porcentaje:= (cant*100) div cantTotal;
    write ('El porcentaje de reservas de eventos que inicien antes de las 12 hs y se produzcan ');
    writeln ('en la primera quincena:', porcentaje,'%');
end;

procedure ObtenerMaximo(v:vectorContador);
    procedure Maximo(var max1,max2:integer;var dia1,dia2:rango1; cant:integer; d:rango1);
    begin
        if( max1 < cant )then
        begin
            max2:=max1;
            dia2:=dia1;
            max1:=cant;
            dia1:=d;
        end
        else
            if ( max2 < cant )then
            begin
                max2:=cant;
                dia2:=d;
            end;
    end;
var
    i,dia1,dia2:rango1;
    max1,max2:integer;
begin
    max1:=-1;max2:=-1;
    for i:=1 to DF1 do Maximo(max1,max2,dia1,dia2,v[i],i);
    writeln('Los dos días del mes con mayor cantidad de reservas de clientes con DNI par: ', dia1 ,' ',dia2);
end;

//PP
var
    l:lista; l2:lista2;
    v:vectorPrecio; v2:vectorContador;
begin
    CargarLista(l);//se dispone
    CargarVector(v);//se dispone 
    RecorrerLista(l,v,l2,v2);
    ObtenerMaximo(v2);
end.
