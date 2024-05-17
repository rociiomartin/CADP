Dado el siguiente código que lee información de personas hasta que se ingresa la persona con dni 0 y
luego imprime dicha información en el orden inverso al que fue leída, identificar los 9 errores.

program ejercicio2;
type
  lista = ^nodo;
  persona = record
    dni: integer;
    nombre: string;
    apellido: string;
  end;
  nodo = record
    dato: persona;
    sig: lista;
  end;

procedure leerPersona(p: persona); //ERROR 1:deberia ser por referencia
begin
  read(p.dni);
  if (p.dni <> 0)then begin
  read(p.nombre);
  read(p.apellido);
  end;
end;

{Carga la lista hasta que llega el dni 0}
procedure generarLista(var l:lista);
var
  p:nodo; //ERROR 2:tiene que ser tipo persona
begin
  leerPersona(p);
  while (p.dni <> 0) do begin
  agregarAdelante(l,p);
  //ERROR 3:no vuelve a leer
  end;
end;

procedure imprimirInformacion(var l:lista); //ERROR 4:no se pasa por referencia
begin
  while (l <> nil) do begin
    writeln('DNI: ', l^.dato.dni, 'Nombre:',
    l^.nombre, 'Apellido:', l^.apellido); //ERROR 5,6: le falta "dato"
    l:= l^.sig;
  end;
end;

{Agrega un nodo a la lista}
procedure agregarAdelante(l:lista;p:persona); //ERROR 7: lista se tiene que pasar como referencia
var
  aux: lista;
begin
  //ERROR 8: tiene que reservar un espacio en memoria
  aux^.dato:= p;
  aux^.sig:= l;
  l:= aux;
end;
{Programa principal}
var
l:lista;
begin
  //ERROR 9: falta inicializar l en nil
  generarLista(l);
  imprimirInformacion(l);
end.
