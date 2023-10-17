program JugamosConListas;
type
lista = ^nodo;
        nodo = record
        n : integer;
        sig : lista;
end;

procedure armarNodo(var L: lista; v: integer);
var
        aux, ant, act : lista;
begin
        act:=L;
        ant:=L;
        new(aux);

        aux^.n := v;
        while (act<>nil) AND (act^.n > v) do begin
                ant:=act;
                act:=L^.sig;
        end;
        if act = L then L:=aux
        else ant^.sig:=aux;
        aux^.sig:=act;
end;

procedure cargarLista(var pri : lista);
var
valor:integer;
begin
        writeln('Ingrese un numero');
        read(valor);
        while ( valor <> 0 )  do begin
                armarNodo(pri, valor);
                //writeln('Ingrese un numero');
                read(valor);
        end;
end;

function estaOrdenada (L:lista) : boolean;
var
        ant:lista;
begin
        ant:= L;
        L:=L^.sig;
        while (L<>nil) and (L^.n < ant^.n)do begin
                ant:=L;
                L:=L^.sig;
        end;
        estaOrdenada:= (L=nil);
end;


var
        pri : lista;
begin
        pri := nil;
        cargarLista(pri);
        if (estaOrdenada(pri)) then writeln('Lista ordenada')
        else writeln('no esta ordenada');

        while(pri<>nil) do begin
                writeln(pri^.n);
                pri:=pri^.sig;
        end;
end.
