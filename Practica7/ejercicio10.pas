{
NO ESTA TERMINADO

Una compañía de venta de insumos agrícolas desea procesar la información de las empresas a las que
les provee sus productos. De cada empresa se conoce su código, nombre, si es estatal o privada,
nombre de la ciudad donde está radicada y los cultivos que realiza (a lo sumo 20). Para cada cultivo
de la empresa se registra: tipo de cultivo (trigo, maíz, soja, girasol, etc.), cantidad de hectáreas
dedicadas y la cantidad de meses que lleva el ciclo de cultivo.

a. Realizar un programa que lea la información de las empresas y sus cultivos. Dicha información
se ingresa hasta que llegue una empresa con código -1 (la cual no debe procesarse). Para cada
empresa se leen todos sus cultivos, hasta que se ingrese un cultivo con 0 hectáreas (que no
debe procesarse).

Una vez leída y almacenada la información, calcular e informar:
b. Nombres de las empresas radicadas en “San Miguel del Monte” que cultivan trigo y cuyo código
de empresa posee al menos dos ceros.
c.La cantidad de hectáreas dedicadas al cultivo de soja y qué porcentaje representa con respecto
al total de hectáreas.
d. La empresa que dedica más tiempo al cultivo de maíz
e. Realizar un módulo que incremente en un mes los tiempos de cultivos de girasol de menos de 5
hectáreas de todas las empresas que no son estatales.
}

program ejercicio10;
const
    DF=20;
    FINC=0;
    FINE=-1;
    NOM= 'San Miguel del Monte';
type
    candena15=string[15];
    candena30=string[30];
    rango=1..DF;
    
    cultivo=record
                tipo:candena15;
                cantH:integer; //corte de control
                cantMeses:integer;
             end;
    vectorCultivos= array [rango] of cultivos;
    
    empresa=record
                cod:integer; //corte de control
                nombre:candena15;
                EoP:candena15;
                ciudad:candena30;
                cultivos: vectorCultivos; //a lo sumo 20
                diml:rango;
            end;
    lista= ^nodo;
    nodo = record 
            datos:empresa;
            sig:lista;
           end;
    
//PROCESOS
procedure CargarLista(var l:lista);
    procedure LeerCultivos(var c:cultivo);
    begin
        writeln('--CULTIVOS--');
        writeln(' Ingrese cantidad de hectareas --FIN 0 -- ');
        readln(c.cantH);
        if ( c.cantH <> FINC ) then
        begin
            writeln(' Ingrese el tipo');
            readln(c.tipo);
            writeln(' Ingrese la cantidad de meses');
            readln(c.cantMeses);
        end;
        writeln('------------------------------------------------');
    end;
    procedure LeerEmpresas(var e:empresa);
        procedure CargarVectorCultivos(var v:vectorCultivos; var diml:integer );
        var
            c:cultivo;
        begin
            diml:=0;
            LeerCultivos(c);
            while ( (diml <= DF ) and ( c.cantH <> FINC ) )do
            begin
                diml:=diml+1;
                v[diml]:= c;
                LeerCultivos(c);
            end;
        end;
    var
        v:vectorCultivos;
        diml:integer;
    begin
        writeln('--EMPRESAS--');
        writeln(' Ingrese codigo --FIN -1 -- ');
        readln(e.cod);
        if ( e.cod <> FINE ) then
        begin
            writeln(' Ingrese el nombre');
            readln(e.nombre);
            writeln(' Ingrese si es estatal o privada');
            readln(e.EoP);
            writeln(' Ingrese la ciudad ');
            readln(e.ciudad);
            CargarVectorCultivos(v,diml);
            e.diml:=diml;
        end;
        writeln('------------------------------------------------');
    end;
    procedure AgregarAdelanteC (var l:lista; e:empresa);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= e;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
   e:empresa;
begin
    l:=nil;
    LeerEmpresas(e);
    while ( e.cod <> FINE )do
    begin
        LeerEmpresas(e);
        AgregarAdelante(l,e);
    end;
end;


c.La cantidad de hectáreas dedicadas al cultivo de soja y qué porcentaje representa con respecto
al total de hectáreas.
d. La empresa que dedica más tiempo al cultivo de maíz
e. Realizar un módulo que incremente en un mes los tiempos de cultivos de girasol de menos de 5
hectáreas de todas las empresas que no son estatales.

procedure Recorrer (l:lista);
    function Cero(cod:integer):boolean;
    begin
        cant:=0;
        while( (cod <> FINC) and ( cant >=2 ) )do
        begin   
            if ( cod mod 10 ) = 0 )then cant:=cant+1;
            cod:= cod div 10;
        end;
        Cero:= cant >=2;
    end;
    function Cumple (v:vectorCultivos; diml:integer):boolean;
    var
        ok:boolean;
        i:=rango;
    begin
        ok:=false; i:=1;
        while ( (diml >= i) and (not ok) ) do
        begin
            if ( v[i].tipo = 'trigo' ) then ok:=true
                                       else i:=i+1;
        end;
        Cumple:=ok;
    end;
var

begin
    while ( l <> nil )do
    begin
        if ( (l^.datos.ciudad = NOM) and (Cumple (l^.datos.cultivos, l^.datos.diml)) and (Cero (l^.datos.cod)) ) 
        then writeln (' Nombres de las empresas radicadas en “San Miguel del Monte” que cultivan trigo y cuyo código
de empresa posee al menos dos ceros: ', l^.datos.nombre);
        l:=l^.sig;
    end;
end;

//PP
var
    l:lista;
begin
    CargarLista(l);
    Recorrer(l);
end.
