{
TEMA 1
}

program parcial;
const
    DF=200;
    FIN=-1;
type
    rango=1..DF;
    cadena15=string[15];
    
    repuesto=record
                  cod:integer;
                  precio:real;
                  codP:rango;
             end;
    lista=^nodo; 
    nodo=record
            datos: repuesto;
            sig: lista;
          end;
      
    vectorPaises = array [rango] of string; //se dispone
    
    vectorPrecios = array [rango] of real;
    
    vectorCantRepuestos = array [rango] of integer;

//PROCESOS Y FUNCIONES
{SE DISPONE
procedure CargarVector(var v:vectorPaises);
    procedure LeerPais(var cod:integer;var nombre:cadena15);
    begin
        writeln('Ingrese el codigo');
        readln(cod);
        writeln('Ingrese el nombre');
        readln(nombre);  
    end;
var
    i:rango;
    cod:integer;
    nombre:cadena15;
begin
    for i:= 1 to DF do 
    begin
        LeerPais(cod,nombre);
        v[cod]:=nombre;
    end;
end;
}
procedure CargarVector(var v:vectorPaises); //se dispone

procedure CargarLista(var l:lista); 
    procedure LeerRepuesto(var r:repuesto);
    begin
        with r do 
        begin
            writeln('Ingrese el codigo --FIN -1--');
            readln(cod);
            if ( cod <> FIN )then
            begin
                writeln('Ingrese el precio');;
                readln(precio);
                writeln('Ingrese el codigo del pais --1 a 200');
                readln(codP);
            end;
        end;
    end;
    procedure AgregarAdelante(var l:lista;r:repuesto);
    var
        nue:lista;
    begin
        new(nue);
        nue^.datos:=r;
        nue^.sig:=l;
        l:=nue;
    end;
var
    r:repuesto;
begin
    LeerRepuesto(r);
    while ( r.cod <> FIN )do
    begin
        AgregarAdelante(l,r);
        LeerRepuesto(r);
    end;
end;


procedure Recorrer(l:lista; var v:vectorCantRepuestos; var vec:vectorPrecios;var canTotal,cantAL3Ceros:integer);
    procedure InicializarVectorContador(var v:vectorCantRepuestos);
    var
      i:rango;
    begin
        for i:= 1 to DF do v[i]:=0;
    end;
    procedure InicializarVector(var vec:vectorPrecios);
    var
      i:rango;
    begin
        for i:= 1 to DF do vec[i]:=-1;
    end;
    procedure actualizarMaximo(var maximo:real;nuevoValor:real);
    begin
        if ( nuevoValor > maximo) then maximo:=nuevoValor;
    end;
    function AlMenosTresCeros (cod:integer):boolean;
    var
       cant:integer;
    begin
    	cant:=0;
        while( (cod <> 0) and (cant >=3) )do
        begin
            if ( (cod mod 10) = 0 )then cant:=cant+1;
            cod:=cod div 10;
        end;
    	AlMenosTresCeros:= (cant >= 3);
    end;
begin
    canTotal:=0;
    cantAL3Ceros:=0;
    InicializarVector(vec);
    InicializarVectorContador(v);
    while ( l <> nil) do
    begin
        canTotal=canTotal+1;
        v[l^.datos.codP]:=v[l^.datos.codP]+1;
        actualizarMaximo(vec[l^.datos.codP],l^.datos.precio);
        if ( SinCeros ( l^.datos.cod) )then cantSinCeros:=cantSinCeros+1;
        l:=l^.sig;
    end;
end;

procedure InformarMaximos(vec:vectorPrecios;v:vectorPaises);
var
    i:rango;
begin
    for i:= 1 to DF do  writeln('Para el pai ', v[i], ' el precio mas caro fue ', vec[i]);
end;


var
    l:lista;
    v:vectorPaises;
    vec:vectorPrecios;
    cantAL3Ceros:integer;
begin
    CargarVector(v); //se dispone
    CargarLista(l);
    Recorrer(l,vec,cantAL3Ceros);
    writeln(' ');
    InformarMaximos(vec,v);
    writeln('La cantidad de repuestos que poseen al menos 3 ceros en su codigo son: ', cantAL3Ceros);
end.
