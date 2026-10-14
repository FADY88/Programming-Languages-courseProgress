(* Pairs and tuples *)
val x = (2, 4);
#1 x;
#2 x;
 

fun swap (pr : int*bool) =
    (#2 pr, #1 pr)

(* (int * int) * (int * int) -> int *)
fun sum_two_paris (pr1 : int * int, pr2 : int * int) =
    (#1 pr1) + (#2 pr1) + (#1 pr2) + (# pr2)

(* int * int -> int * int *)
fun div_mod (pr : int * int) =
    if (#1 pr) < (#2 pr)
    then pr
    else (#2 pr, #1 pr)
