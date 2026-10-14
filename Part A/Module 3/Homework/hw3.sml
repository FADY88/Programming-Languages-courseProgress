(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern =  Wildcard
                  | Variable of string
                  | UnitP
                  | ConstP of int
                  | TupleP of pattern list
                  | ConstructorP of string * pattern

datatype valu = Const of int
              | Unit
              | Tuple of valu list
              | Constructor of string * valu

fun g f1 f2 p =
    let
        val r = g f1 f2 
    in
        case p of
            Wildcard          => f1 ()
          | Variable x        => f2 x
          | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
          | ConstructorP(_,p) => r p
          | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ =  Anything
              | UnitT
              | IntT
              | TupleT of typ list
              | Datatype of string

(**** you can put all your code here ****)
(* 1 *)
fun only_capitals los =
    List.filter (fn s => Char.isUpper(String.sub(s, 0))) los
(* version that can handle empty stirngs *)
fun only_capitals_2 los =
    List.filter (fn s => Char.isUpper(String.sub(s, 0) handle Subscript => #"a")) los


(* 2 *)
fun longest_string1 los =
    foldl (fn (a, b) => if String.size(a) > String.size(b) 
                        then a
                        else b) "" los


(* 3 *)
fun longest_string2 los =
    foldl (fn (b, a) => if String.size(a) > String.size(b) 
                        then a
                        else b) "" los


(* 4 *)
fun longest_string_helper pred los =
    foldl (fn (a, b) => if pred (String.size(a), String.size(b))
                        then a
                        else b) "" los

val longest_string3 = longest_string_helper (fn (a, b) => a > b)
val longest_string4 = longest_string_helper (fn (a, b) => a >= b)


(* 5 *)
val longest_capitalized = longest_string1 o only_capitals
(* for handling empty strings *)
val longest_capitalized_2 = longest_string1 o only_capitals_2


(* 6 *)
val rev_string = String.implode o rev o String.explode


(* 7 *)
fun first_answer f lst =
    case lst of
        [] => raise NoAnswer
      | e::lst' => case f e of
                      NONE => first_answer f lst'
                    | SOME v => v


(* 8 *)
fun all_answers f lst =
    let fun helper (l, acc) =
        case l of
            [] => SOME acc
          | e::l' => case f e of
                          NONE => NONE
                        | SOME v => helper(l', acc @ v)
    in
        helper(lst, [])
    end


(* 9a *)
fun count_wildcards p =
    g (fn () => 1) (fn s => 0) p


(* 9b *)
fun count_wild_and_variable_lengths p =
    g (fn () => 1) (fn s => String.size s) p


(* 9c *)
fun count_some_var (str, p) =
    g (fn () => 0) (fn s => if str = s then 1 else 0) p


(* 10 *)
fun check_pat p =
    let
        fun names_list p =
            case p of
                Variable x => [x]
              | TupleP ps  => List.foldl (fn (p,i) => (names_list p) @ i) [] ps
              | ConstructorP(_, p) => names_list p
              | _          => []
        fun no_repeats l =
            case l of
                [] => true
              | x::l' =>  if (List.foldl (fn (s, i) => not (x = s) andalso i) true l')
                          then no_repeats l'
                          else false
    in
        no_repeats(names_list p)
    end


(* 11 *)
fun match (v, p) =
    case (v, p) of
        (_, Wildcard)   => SOME []
      | (_, Variable s) => SOME [(s, v)]
      | (Unit, UnitP)   => SOME []
      | (Const n2, ConstP n1) => if n1 = n2 then SOME [] else NONE
      | (Tuple lov, TupleP lop) =>  if length lov = length lop
                                    then all_answers match (ListPair.zip(lov, lop))
                                    else NONE
      | (Constructor (s2, value), ConstructorP (s1, ptn)) => if s1 = s2 then match(value, ptn) else NONE
      | _ => NONE


(* 12 *)
fun first_match v lop =
    SOME (first_answer (fn p => match(v, p)) lop) handle NoAnswer => NONE
