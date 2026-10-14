fun sum_list (xs : int list) =
    if null xs
    then 0
    else hd xs + sum_list (tl xs)

val x = sum_list [1, 2 ,3 ,4 ,5 ,6]		

fun list_product (xs : int list) =
    if null xs
    then 1
    else hd xs * list_product (tl xs)		 

val y = list_product [1, 2, 3, 4]			  


fun countdown (x : int) = (* [7, 6, 5, 4, 3, 2, 1] *)
    if x = 1
    then [1]
    else x :: countdown (x - 1)


fun append (xs : int list, ys : int list) =
    if null xs
    then ys
    else (hd xs) :: append ((tl xs), ys)


fun sum_pair_list (xs : (int * int) list) =
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list (tl xs)
