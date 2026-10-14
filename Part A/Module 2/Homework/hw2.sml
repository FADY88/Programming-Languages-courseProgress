(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
    string), then you avoid several of the functions in problem 1 having
    polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* (a) all_except_option *)
fun search (e, list) =
    case list of 
        [] => false
      | elm::rest =>  if e = elm
                      then true
                      else search(e, rest)

fun remove (e, list) =
    case list of
        [] => []
      | elm::rest =>  if elm = e
                      then remove(e, rest)
                      else elm::remove(e, rest)

fun all_except_option (str, los) =
    if search (str, los)
    then SOME (remove(str, los))
    else NONE


(* (b) get_substitutions1 *)
fun get_substitutions1(lolos, s) =
    case lolos of
        [] => []
      | los::lolos' => case all_except_option(s, los) of
                            NONE => get_substitutions1(lolos', s)
                          | SOME i => i @ get_substitutions1(lolos', s)


(* (c) get_substitutions2 (tail recursive) *)
fun get_substitutions2(lolos, s) =
    (* acc is the resulting list so far *)
    let
        fun helper(lolos, acc) =
        case lolos of
            [] => acc
          | los::lolos' => case all_except_option(s, los) of
                                NONE => helper(lolos', acc)
                              | SOME i => helper(lolos', acc @ i)
    in  helper(lolos, [])
    end


(* (d) similar_names *)
fun similar_names(lolos, name) =
    let
        val {first = f, middle = m, last = l} = name
        fun get_names(los) =
            case los of
                [] => []
              | e::los' => {first = e, middle = m, last = l}::get_names(los')
    in name::get_names(get_substitutions2 (lolos, f))
    end


(* you may assume that Num is always used with values 2, 3, ..., 10
    though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)
(* (a) card_color *)
fun card_color(s, r) =
    case (s, r) of
        (Clubs, _) => Black
      | (Spades, _) => Black
      | (Diamonds, _) => Red
      | (Hearts, _) => Red


(* (b) card_value *)
fun card_value(s, r) =
    case (s, r) of
        (_, Ace) => 11
      | (_, Num n) => n
      | (_, _) => 10


(* (c) remove_card *)
fun remove_card(cs, c, e) =
    case cs of
        [] => raise e
      | cr::cs' =>  if c = cr
                    then cs'
                    else cr::remove_card(cs', c, e)


(* (d) all_same_color *)
fun all_same_color(cs) =
    case cs of
        [] => true
      | c::[] => true
      | c1::c2::cs' =>  if card_color(c1) = card_color(c2)
                        then all_same_color(c2::cs')
                        else false


(* (e) sum_cards *)
fun sum_cards(cs) =
    (* sum: the sum of the value of cards so far *)
    let
        fun helper(cs, sum) =
            case cs of
                [] => sum
              | c::cs' => helper(cs', sum + card_value(c))
    in
        helper(cs, 0)
    end


(* (f) score *)
fun score(cs, goal) =
    let 
        val sum = sum_cards(cs)
    in
        (if sum >= goal then 3 * (sum - goal) else (goal - sum))
          div (if all_same_color(cs) then 2 else 1)
    end


(* (g) officiate *)
fun officiate(cs, moves, goal) =
    let
        fun get_held_cards(cs, moves , held) =
            if sum_cards(held) > goal
            then held
            else
            case (cs, moves) of
                (_, []) => held
              | ([], Draw::moves') => get_held_cards([] ,moves', held)
              | ([], Discard i::moves') => get_held_cards([], moves' , remove_card(held, i, IllegalMove))
              | (c::cs', Draw::moves') => get_held_cards(cs',moves', c::held)
              | (c::cs', Discard i::moves') => get_held_cards(c::cs', moves' , remove_card(held, i, IllegalMove))
    in
        score(get_held_cards(cs, moves, []), goal)
    end


(* score_challenge *)
fun ace_count(cs) =
    case cs of
        [] => 0
        | c::cs' => 1 + ace_count(cs')

fun score_challenge(cs, goal) =
    let 
        fun cal(s) =
            if s > goal 
            then 3 * (s - goal) div (if all_same_color(cs) then 2 else 1)
            else (goal - s) div (if all_same_color(cs) then 2 else 1)
        
        val sum11 = sum_cards(cs)
        val sum1  = sum11 - ace_count(cs) * 10
        val cal_sum11 = cal(sum11)
        val cal_sum1 = cal(sum1)
    in
        if cal_sum11 < cal_sum1
        then cal_sum11
        else cal_sum1
    end


fun officiate_challenge(cs, moves, goal) =
    let
        fun get_held_cards(cs, moves , held) =
            if sum_cards(held) > goal andalso sum_cards(held) - ace_count(held) * 10 > goal
            then held
            else
            case (cs, moves) of
                (_, []) => held
              | ([], Draw::moves') => get_held_cards([] ,moves', held)
              | ([], Discard i::moves') => get_held_cards([], moves' , remove_card(held, i, IllegalMove))
              | (c::cs', Draw::moves') => get_held_cards(cs',moves', c::held)
              | (c::cs', Discard i::moves') => get_held_cards(c::cs', moves' , remove_card(held, i, IllegalMove))
    in
        score(get_held_cards(cs, moves, []), goal)
    end