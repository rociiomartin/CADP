{
El Programa Horizonte 2020 (H2020) de la Unión Europea ha publicado los criterios para financiar
proyectos de investigación avanzada. Para los proyectos de sondas espaciales vistos en el ejercicio anterior, se
han determinado los siguientes criterios:

- sólo se financiarán proyectos cuyo costo de mantenimiento no supere el costo de construcción
- no se financiarán proyectos espaciales que analicen ondas de radio, ya que esto puede realizarse desde la
superficie terrestre con grandes antenas.

A partir de la información disponible de las sondas espaciales (la lista generada en ejercicio 6), implementar
un programa que:

a. Invoque un módulo que reciba la información de una sonda espacial, y retorne si cumple o no con los
nuevos criterios H2020.

b. Utilizando el módulo desarrollado en a) implemente un módulo que procese la lista de sondas de la ESA y
retorne dos listados, uno con los proyectos que cumplen con los nuevos criterios y otro con aquellos que no
los cumplen.

}


program ejercicio6;
const
    FIN='GAIA';
    DF=7;
type
    cadena20=string[20];
    rango=1..DF;
    sonda= record
                nombre:cadena20; //corte de control
                duracion:integer;
                costoC:real;
                costoM:real;
                rangoE:rango;
              end;
    
    lista=  ^nodo;
    nodo = record 
            datos:sonda;
            sig:lista;
           end;
           
    vectorContador = array [rango] of integer; 
           
//PROCESOS
procedure AgregarAdelante (var l:lista; s:sonda);
    var
       nuevo:lista;
    Begin
       new (nuevo);
       nuevo^.datos:= s;
       nuevo^.sig:=nil; 
       if (l = nil) then l:= nuevo
       else 
       begin
         nuevo^.sig:= l;
         l:=nuevo;
       end;
    end;
    
procedure CargarLista(var l : lista);
    
    procedure LeerSondas(var s:sonda);
    begin
        writeln(' Ingrese el nombre --FIN GAIA -- ');
        readln(s.nombre);
        writeln(' Ingrese la duracion ');
        readln(s.duracion);
        writeln(' Ingrese el costo de construccion');
        readln(s.costoC);
        writeln(' Ingrese el costo de mantenimiento mensual');
        readln(s.costoM);
        writeln(' Ingrese el rango');
        readln(s.rangoE);
        writeln('------------------------------------------------');
    end;
var
   s:sonda;
begin
    repeat
        LeerSondas(s);
        AgregarAdelante(l,s);
    until s.nombre = FIN
end;

procedure RecorrerListayVector (l:lista; var v:vectorContador; var promeDur:real; var promeCosto:real);

    procedure Maximo(costoT:real; nom:cadena20; var max:real; var nomMax:cadena20);
    begin
        if(costoT > max )then
        begin
            max:=costoT;
            nomMax:=nom;
        end;
    end;
    procedure InicializarVector(var v:vectorContador);
    var
        i:rango;
    begin
        for i:=1 to DF do v[i]:=0;
    end;
var
    auxCosto,max, costoProme:real; nomCostoMax:cadena20;
    durProme,cant:integer; 
begin
    max:=-1; costoProme:=0; durProme:=0;cant:=0;
    InicializarVector(v);
    while(l<> nil)do
    begin
        auxCosto:=l^.datos.costoM+l^.datos.costoC;
        Maximo(auxCosto, l^.datos.nombre,max,nomCostoMax);
        v[l^.datos.rangoE]:=v[l^.datos.rangoE]+1;
        costoProme:=costoProme+l^.datos.costoC;
        durProme:=durProme+l^.datos.duracion;
        cant:=cant+1;
        l:=l^.sig;
    end;
    writeln('El nombre de la sonda más costosa es: ', nomCostoMax);
    promeDur:= durProme/cant;
    promeCosto:= costoProme/cant ;
end;

procedure Imprimir(v:vectorContador);
var
    i:rango;
begin
    for i:=1 to DF do writeln ('Rango ', i , ' tiene: ', v[i]);
end;

{
procedure ImprimirLista(l:lista);
begin
    while (l <> nil)do
    begin
        writeln('------------------------------');
        writeln(' Nombre: ', l^.datos.nombre);
        writeln(' Duracion: ', l^.datos.duracion);
        writeln(' Costo de construccion: ', l^.datos.costoC:00:00);
        writeln(' Costo de mantenimiento mensual: ', l^.datos.costoM:00:00);
        writeln(' Rango: ' , l^.datos.rangoE);
        l:=l^.sig;
    end;
end;
}
    
procedure RecorrerLista(l:lista; promeDur:real; promeCosto:real);
var 
    cantD:integer;
begin
    cantD:=0; 
    while ( l<> nil )do
    begin
        if ( l^.datos.duracion > promeDur ) then cantD:=cantD+1;
        if (l^.datos.costoC > promeCosto) then writeln (' El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sonda: ',l^.datos.nombre );
        l:=l^.sig;
    end;
    writeln(' La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas: ', cantD);
end;

procedure ProcesarLista(l:lista; var l2,l3:lista);

    function Cumple (s:sonda):boolean;
    begin
        if (s.costoC > s.costoM) and (s.rangoE <> 1)then Cumple:=true
                                                   else Cumple:=false;
    end;
begin
    while ( l<> nil ) do
    begin
        if ( Cumple(l^.datos) ) then AgregarAdelante(l2,l^.datos)
                                else AgregarAdelante(l3,l^.datos);
        l:=l^.sig;
    end;
end;

//PP
var
    l,l2,l3:lista;
    v:vectorContador;
    promeDur,promeCosto:real;
begin
    l:=nil;
    CargarLista(l);
    RecorrerListayVector(l,v, promeDur, promeCosto);
   // ImprimirLista(l); 
    writeln ('La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético: ');
    Imprimir(v);
    RecorrerLista(l,promeDur, promeCosto);
    
    //EJERCICIO 7
    l2:=nil;l3:=nil;
    ProcesarLista(l,l2,l3);
   // writeln ('LISTA CUMPLE');ImprimirLista(l2);
   // writeln;
    //writeln ('LISTA NO CUMPLE');ImprimirLista(l3);
end.
