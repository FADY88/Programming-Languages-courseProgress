(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use "hw2.sml";
(* tests for problem 1 here *)
val test1 = all_except_option ("string", ["string"]) = SOME []
val test2 = all_except_option ("string", ["string", "hi"]) = SOME ["hi"]
val test3 = all_except_option ("string", ["s", "hi", ""]) = NONE
val test4 = all_except_option ("f", ["a", "b", "c", "f"]) = SOME ["a", "b", "c"]

val test5 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test6 = get_substitutions1 ([["Fred","Fredrick"],
                                ["Elizabeth","Betty"],
                                ["Freddie","Fred","F"]], "Fred")
            = ["Fredrick","Freddie","F"]
val test7 = get_substitutions1 ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],
"Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val test8 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test9 = get_substitutions2 ([["Fred","Fredrick"],
                                ["Elizabeth","Betty"],
                                ["Freddie","Fred","F"]], "Fred")
            = ["Fredrick","Freddie","F"]
val test10 = get_substitutions2 ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],
"Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val test11 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
        [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
        {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test12 = similar_names ([["Fred","Fredrick", "Fady"],["Elizabeth","Betty", "Fady"],["Freddie","Fred","F", "Fady"]], {first="Fred", middle="W", last="Smith"}) =
        [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
        {first="Fady", last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"},
        {first="F", last="Smith", middle="W"}, {first="Fady", last="Smith", middle="W"}]


(* tests for problem 2 here *)
(* (a) card_color *)
val test13 = card_color (Clubs, Num 2) = Black
val test14 = card_color (Spades, Num 2) = Black
val test15 = card_color (Diamonds, Num 2) = Red
val test16 = card_color (Hearts, Num 2) = Red

val test17 = card_value (Clubs, Num 2) = 2
val test18 = card_value (Clubs, Jack) = 10
val test19 = card_value (Clubs, Queen) = 10
val test20 = card_value (Clubs, King) = 10
val test21 = card_value (Clubs, Ace) = 11

val test22 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test23 = remove_card ([(Hearts, Ace), (Clubs, Num 5)], (Hearts, Ace), IllegalMove) = [(Clubs, Num 5)]
val test24 = remove_card ([(Clubs, Num 5), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Clubs, Num 5)]
val test25 = (remove_card ([], (Hearts, Ace), IllegalMove) handle IllegalMove => []) = []
val test26 = (remove_card ([(Hearts, Ace)], (Hearts, Jack), IllegalMove) handle IllegalMove => []) = []

val test27 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test28 = all_same_color [(Hearts, Ace), (Hearts, Ace), (Diamonds, Ace)] = true
val test29 = all_same_color [(Hearts, Ace), (Hearts, Ace), (Clubs, Num 3)] = false
val test30 = all_same_color [(Hearts, Ace)] = true
val test31 = all_same_color [] = true

val test32 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test33 = sum_cards [] = 0
val test34 = sum_cards [(Clubs, Num 9),(Clubs, Ace)] = 20
val test35 = sum_cards [(Clubs, Queen),(Clubs, Jack)] = 20
val test36 = sum_cards [(Clubs, Num 1),(Clubs, Jack), (Spades, Num 5)] = 16

val test37 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test38 = score ([(Hearts, Num 2),(Clubs, Num 9)],10) = 3
val test39 = score ([(Hearts, Num 2),(Hearts, Num 4)],10) = 2

val test40 = officiate ([],[], 15) = 7
val test41 = officiate ([(Clubs, Num 2),(Spades, Num 2),(Clubs, Num 2),(Spades, Num 2)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42) = 17
val test42 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw, Discard(Hearts, Num 2)], 15) = 5

val test43 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test44 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
              = 3
val test45 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                          [Draw,Discard(Hearts,Jack)],
                          42);
                false) 
              handle IllegalMove => true)