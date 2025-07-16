program Hello;
const   
    DF=5;
    FIN=33444555;
type
    cadena30=string[30];
    rango=1..DF;
    
    f=record
        dia,mes,anio:integer;
        end;
    cliente=record
              num:integer;
              dni:integer;
              apeYnom:cadena30;
              fecha:f;
              nivel:rango;
              punt:real;
            end;
    lista=^nodo;
    nodo=record
            datos:cliente;
            sig:lista;
          end;
    
    nueva=record
              num:integer;
              apeYnom:cadena30;
            end;
    lista2=^nodo2;
    nodo2=record
            datos:nueva;
            sig:lista2;
          end;        
          
    vectorContador = array [rango] of real;
//PROCESOS

procedure LeerCliente(var c:cliente);
    procedure LeerFecha(var fe:f);
    begin
        with fe do
        begin
            readln(dia);
            readln(mes);
            readln(anio);
        end;
    end;
begin
    with c do
    begin
        readln(num);
        readln(dni);
        readln(apeYnom);
        LeerFecha(fecha);
        readln(nivel);
        readln(punt);
    end;
end;

procedure CargarLista(var l:lista);
    procedure AgregarAdelante (var l:lista; c:cliente);
    var
      nuevo:lista;
    begin
      new (nuevo);
      nuevo^.datos:= c;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
var
    c:cliente;
begin
    repeat
        LeerCliente(c);
        AgregarAdelante(l,c);
    until(c.dni = FIN);
end;

procedure Recorrer(l:lista; var l2:lista2; var v:vectorContador);
    procedure AgregarAdelante (var l:lista2; n:nueva);
    var
      nuevo:lista2;
    begin
      new (nuevo);
      nuevo^.datos:= n;
      nuevo^.sig:=l; 
      l:=nuevo;
    end;
    function Impar(num:integer):boolean;
    var
        ok:boolean;
    begin
        ok:=false;
        while ( num <>0 ) and (not ok) do
        begin
            if ( (num mod 2) <> 1) then ok:=false;
            num:=num div 10;
        end;
        Impar:=ok;
    end;    
var
    n:nueva;
begin
    while ( l<> nil) do
    begin
        if ( Impar(l^.datos.dni) )then 
        begin
            n.num:=l^.datos.num;
            n.apeYnom:=l^.datos.apeYnom;
            AgregarAdelante(l2,n);
        end;
        if ( l^.datos.fecha.anio < 2000 )then v[l^.datos.nivel]:=v[l^.datos.nivel]+l^.datos.punt;
        l:=l^.sig;
    end;
end;
procedure InicializarVector (var v:vectorContador);
var
    i:rango;
begin
    for i:= 1 to DF do
    begin
        v[i]:=0;
    end;
end;
procedure IncisoB (v:vectorContador);
    procedure Maximo(puntaje:real; n:rango; var max:real; var nM:rango);
    begin
        if ( max < puntaje )then
        begin
            max:=puntaje;
            nM:=n;
        end;
    end;
    procedure Minimo(puntaje:real; n:rango; var min:real; var nM:rango);
    begin
        if ( min > puntaje )then
        begin
            min:=puntaje;
            nM:=n;
        end;
    end;
var
    i,nMax,nMin:rango;
    max,min:real;
begin
    max:=-1; min:=999;
    for i:= 1 to DF do
    begin
        Maximo(v[i],i,max,nMax);
        Minimo(v[i],i,min,nMin);
    end;
    writeln(nMax);
    writeln(nMin);
end;
//PP
var
    l:lista; l2:lista2;
    v:vectorContador;
begin
    l:=nil; l2:=nil;
    CargarLista(l);
    InicializarVector(v);
    Recorrer(l,l2,v);
    IncisoB(v);
end.
