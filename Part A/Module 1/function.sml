val x = 7

(* works only if y >= 0 *)
fun pow(x : int, y : int) =
    if y = 0
    then 1
    else x * pow(x, y - 1)

fun cube(x : int) =
    pow(x, 3)


val t = cube(5);

(* type of x here is int * int *)
val x = (2,3);

val ans = pow x;

	    
	
	     
