{
Utilizando el programa del ejercicio 1, modificar el módulo armarNodo para que los elementos de la lista
queden ordenados de manera ascendente (insertar ordenado).
}

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
