(* {bar : int * bool, baz : bool * int, foo : int} *)
val x = {bar = (1 + 2, true andalso true),
          foo = 3 + 4, baz = (false, 9)}

val foo_of_x = #foo x


(* tuples are just syntactic sugar of records *)
(* y and z are exactly the same *)
val y = {1 = "A", 2 = "B", 3 = "C"}

val z = ("A", "B", "C")