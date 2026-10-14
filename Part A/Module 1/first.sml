(* This is a comment. This is our first program. *)

val x = 34;
(* static environment: x : int *)
(* dynamic environment: x --> 34 *)

val y = 17;
(* static environment: x : int, y : int *)
(* dynamic environment: x --> 34, y --> 17 *)

val z = (x + y) + (y + 2);
(* static environment: x : int, y : int, z : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70 *)

val q = z + 1;
(* static environment: x : int, y : int, z : int, q : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70, q --> 71 *)

val abs_of_z = if z < 0 then 0 - z else z; (* bool *) (* int*)
(* abs_of_z : int *)
(* dynamic environment : ..., abs_of_z --> 70 *)

(* build-in function called abs
   can be called like : abs(z) but you can omit the parentheses *)
val abs_of_z_simpler = abs z;


val bool = true;

(* minus is allowed only in subtracting, use ~ "tilde" to type negative numbers*)
val neg = ~5;

(* to divide integers use div, and for reals "floats" use / *)
val d = 5 div 2 (* 2 not 2.5 because its integers *)

val d2 = 5.0 / 2.0 (* 2.5 because they are reals "floats" *)
