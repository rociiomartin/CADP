{
Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su
funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
número (que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado por su
número, en cuyo caso sale de la lista de espera. Se pide:

a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.

b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes
en espera. asigna un número al cliente v retorna la lista de espera actualizada.

c. Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera,
y retorna el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe
eliminarse de la lista de espera.

d. Implementar un programa que simule la atención de los clientes. En dicho programa, primero
llegarán todos los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se
los atenderá de a uno por vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no
debe procesarse.
}


program ejercicio10;
const

type
    cliente=record
                dni:integer;
                num:integer;
            end;
    
    lista=record
            datos:cliente;
            sig:lista;
          end;
            
//PROCESOS
procedure Insertar (Var l: lista; c:cliente);
var
   aux,nuevo:lista;
begin
   if (l = nil) then l:= nuevo
   else
   begin
      aux:= l;
      while (aux ^.sig <> nil) do aux:= aux^.sig;
      aux^.sig:=nuevo;       
    end;
end;
    
procedure CargarLista(var l:lista; var diml:integer);
var
    c:cliente;
begin
    diml:=0;
    writeln('Ingrese el dni --FIN 0--');
    readln(c.dni);
    while (c.dni <> FIN)do
    begin
        diml:=diml+1;
        c.num:=diml;
        Insertar(l,c);
    end;
end;

procedure RecibirCliente(var l:lista; var diml:integer; dni:integer);

    procedure eliminar (Var l: lista; c:cliete);
    var
     actual,ant:lista;
    begin
      actual:=l; 
      while (actual <> nil) do begin
        if (actual^.elem <> valor) then begin
         ant:=actual;  actual:= actual^.sig;
        end;
        else begin
          if (actual = l) then 
            l:= l^.sig; 
          else
            ant^.sig:= actual^.sig;
          dispose (actual);
          actual:= ant;
        end;
    end;
var
  c:cliente;
begin
    eliminar(l);
    diml:=diml+1;
    c.num:=diml;
    c.dni:=dni;
    Insertar(l,c);
end;
//pp
var
  l:lista;
  dni,diml:integer;
begin
  l:=nil;
  CargarLista(l);
  writeln('Ingrese ');
  readln(dni);
  RecibirCliente(l,diml,dni);
end.
