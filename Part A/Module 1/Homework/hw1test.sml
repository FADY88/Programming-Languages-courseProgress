(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

val t1 = is_older ((1,2,3),(2,3,4)) = true

val t2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1

val t3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val t4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val t5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val t6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val t7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val t8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val t9 = what_month 70 = 3

val t10 = month_range (31, 34) = [1,2,2,2]

val t11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

(* My own tests *)
val test1 = is_older ((1,2,3),(2,3,4)) = true
val test2 = is_older ((2000, 5, 7), (2012, 7, 21)) = true
val test3 = is_older ((2012, 7, 21), (2003, 1, 31)) = false
val test4 = is_older ((2012, 7, 21), (2012, 8, 21)) = true
val test5 = is_older ((2012, 7, 21), (2012, 7, 31)) = true
val test6 = is_older ((2012, 7, 21), (2012, 7, 21)) = false
val test7 = is_older ((2012, 7, 30), (2012, 7, 31)) = true

val test8 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test9 = number_in_month ([(2012,2,28),(2013,12,1),(2000,2,4),(1999,3,5),(2003,2,9)],2) = 3

val test10 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test11 = number_in_months ([(2012,2,28),(2013,4,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 4

val test13 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test14 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]
val test15 = dates_in_month ([(2012,4,28),(2013,12,1),(2000,4,3)],4) = [(2012,4,28),(2000,4,3)]

val test16 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test17 = dates_in_months ([(2012,2,28),(2013,4,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2013,4,1),(2011,4,28)]

val test18 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test19 = get_nth (["hi", "there", "how", "are", "you"], 4) = "are"
val test20 = get_nth (["hi", "there", "how", "are", "you"], 19) = ""
val test21 = get_nth (["hi", "there", "how", "are", "you"], ~19) = ""

val test22 = date_to_string (2003, 1, 31) = "January 31, 2003"
val test23 = date_to_string (2007, 7, 15) = "July 15, 2007"
val test24 = date_to_string (1950, 10, 12) = "October 12, 1950"
val test25 = date_to_string (1970, 2, 19) = "February 19, 1970"
val test26 = date_to_string (2022, 3, 17) = "March 17, 2022"

val test27 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test28 = number_before_reaching_sum (10, [10,2,3,4,5]) = 0
val test29 = number_before_reaching_sum (11, [1,2,3,4,5]) = 4

val test30 = what_month 70 = 3
val test31 = what_month 121 = 5
val test32 = what_month 243 = 8
val test33 = what_month 334 = 11
val test34 = what_month 365 = 12

val test35 = month_range (31, 34) = [1,2,2,2]
val test36 = month_range (334, 365) = [11,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12]

val test37 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test38 = oldest([(2012,2,28),(2011,3,31),(2000,4,28)]) = SOME (2000,4,28)
val test39 = oldest([]) = NONE
val test40 = oldest([(2012,2,28),(2000,4,27),(2000,4,28)]) = SOME (2000,4,27)