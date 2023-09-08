{
Dado el siguiente programa:

program sumador;
type
  vnums=array[1..10] of integer;
var
 numeros:vnums;
 i:integer;
begin
 for i:=1 to 10 do //primerbloquefor
  numeros[i]:=i;
 for i:=2 to 10 do //segundobloquefor
     numeros[i]:=numeros[i]+numeros[i-1]
end.

}

a)La variable num es un vector. 
Cuando finaliza el primer for termina en las 10 posiciones con el contenido de su posición:
1. 1
2. 2
3. 3
4. 4
5. 5
6. 6 
7. 7
8. 8
9. 9
10. 10
b)Cuando finaliza el programa tiene:
1. 1
2. 3
3. 6
4. 10
5. 15
6. 21
7. 28
8. 36
9. 45
10. 55
