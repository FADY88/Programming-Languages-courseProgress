(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw3.sml";

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test2 = only_capitals [] = []
val test3 = only_capitals ["Apple","Banana","Coconut","r"] = ["Apple","Banana","Coconut"]
val test4 = only_capitals ["apple","Banana","Coconut","r"] = ["Banana","Coconut"]
val test5 = only_capitals_2 ["A", "B", ""] = ["A", "B"]

val test6 = longest_string1 ["A","bc","C"] = "bc"
val test7 = longest_string1 [] = ""
val test8 = longest_string1 ["A","bc","Cd"] = "bc"

val test9  = longest_string2 ["A","bc","Cd"] = "Cd"
val test10 = longest_string2 ["A","blue","Cd", "fady"] = "fady"

val test11 = longest_string3 ["A","bc","C"] = "bc"
val test12 = longest_string3 [] = ""
val test13 = longest_string3 ["A","bc","Cd"] = "bc"
val test14 = longest_string4 ["A","bc","Cd"] = "Cd"
val test15 = longest_string4 ["A","blue","Cd", "fady"] = "fady"
val test16 = longest_string4 ["A","B","C"] = "C"

val test17 = longest_capitalized ["A","bc","C"] = "A"
val test18 = longest_capitalized ["a","bc","c"] = ""
val test19 = longest_capitalized ["AAA","bc","CCC"] = "AAA"
val test20 = longest_capitalized_2 ["AAA","","CCC"] = "AAA"

val test21 = rev_string "abc" = "cba"
val test22 = rev_string "fady" = "ydaf"

val test23 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test24 = (first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5] handle NoAnswer => 0) = 0

val test25 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test26 = all_answers (fn x => if x < 9 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]
val test27 = all_answers (fn x => if x < 6 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a1 = count_wildcards Wildcard = 1
val test9a2 = count_wildcards (TupleP [Wildcard, Wildcard, UnitP, ConstructorP ("a", Wildcard)]) = 3

val test9b1 = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b2 = count_wild_and_variable_lengths (TupleP [Wildcard, Variable("fady"), Variable("ab"), ConstructorP ("a", Wildcard)]) = 8

val test9c1 = count_some_var ("x", Variable("x")) = 1
val test9c2 = count_some_var ("fady", TupleP [Wildcard, Variable("fady"), Variable("fady"), ConstructorP ("fady", Wildcard)]) = 2

val test28 = check_pat (TupleP [Wildcard, Variable("fady"), Variable("fady"), ConstructorP ("fady", Wildcard)]) = false
val test29 = check_pat (TupleP [Wildcard, Variable("fady"), Variable("batman"), ConstructorP ("fady", Wildcard)]) = true

val test30 = match (Const(1), UnitP) = NONE
val test31 = match (Tuple  [Constructor ("fady", Unit), Const (9), Const (4)],
                    TupleP [ConstructorP ("fady", Wildcard), Variable("fady"), Variable("batman")]) = SOME [("fady", Const 9), ("batman", Const 4)]
val test32 = match (Tuple  [Constructor ("Fady", Unit), Const (9), Const (4)],
                    TupleP [ConstructorP ("fady", Wildcard), Variable("fady"), Variable("batman")]) = NONE

val test33 = first_match Unit [UnitP] = SOME []
val test34 = first_match (Tuple[Constructor ("fady", Unit), Const (9), Const (4)])
                        [ConstP 9, UnitP, TupleP [ConstructorP ("fady", Wildcard), Variable("fady"), Variable("batman")]] = SOME [("fady", Const 9), ("batman", Const 4)]
val test35 = first_match Unit [ConstP 9, ConstP 5, TupleP[Variable "x"]] = NONE