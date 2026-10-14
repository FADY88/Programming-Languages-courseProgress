(* date is (year, month[1, 12], day[1, 31]) *)



(* (int * int * int) * (int * int * int) -> boolean *)
(* return true if the first date in before the second one, otherwise fasle *)

fun is_older (d1 : int*int*int, d2 : int*int*int) = 
		(#1 d1 * 365) + (#2 d1 * 30) + #3 d1 < (#1 d2 * 365) + (#2 d2 * 30) + #3 d2



fun is_older_v2 (d1 : int*int*int, d2 : int*int*int) = 
		let 
				val y1 = #1 date1
				val m1 = #2 date1
				val d1 = #3 date1
				val y2 = #1 date2
				val m2 = #2 date2
				val d2 = #3 date2
		in
				y1 < y2 orelse (y1 = y2 andalso m1 < m2)
								orelse (y1 = y2 andalso m1 = m2 andalso d1 < d2)
		end


(* (int * int * int) list * int -> int *)
(* return hou many dates have the same given month*)

fun number_in_month (lod : (int * int * int) list, month : int) =
		let
			fun number_in_month_ (lod : (int * int * int) list, count : int) =
				if null lod
				then count
				else if #2 (hd lod) = month
				then number_in_month_ (tl lod, count + 1)
				else number_in_month_ (tl lod, count)
		in
			number_in_month_ (lod, 0)
		end


(* (int * int * int) list * int list -> int *)
(* return how many dates have any month in list of months *)
(* ASSUME: no repeated months in list of months *)

fun number_in_months (lod : (int * int * int) list, lom : int list) =
		if null lom orelse null lod
		then 0
		else number_in_month (lod, hd lom) + number_in_months (lod, tl lom)


(* (int * int * int) list * int -> (int * int * int) list *)
(* return list of dates that have the same given month *)

fun dates_in_month (lod : (int * int * int) list, month : int) =
		if null lod
		then []
		else if #2 (hd lod) = month
		then hd lod::dates_in_month (tl lod, month)
		else dates_in_month (tl lod, month)


(* (int * int * int) list * int list -> (int * int * int) list *)
(* return list of dates have any month in list of months *)
(* ASSUME: no repeated months in list of months *)

fun dates_in_months (lod : (int * int * int) list, lom : int list) =
		if null lom orelse null lod
		then []
		else dates_in_month (lod, hd lom) @ dates_in_months (lod, tl lom)


(* string list * int -> string *)
(* return nth element is the list, 1-based indexing *)

fun get_nth (los : string list, n : int) =
		if null los
		then ""
		else if n = 1
		then hd los
		else get_nth (tl los, n - 1)


(* int * int * int -> string *)
(* produce a formated date (month day, year) as a string *)
val MONTHS = ["January", "February", "March", "April", "May", "June",
							"July", "August", "September", "October", "November", "December"]

fun date_to_string (y: int, m : int, d : int) =
		get_nth (MONTHS, m) ^ " " ^ Int.toString d ^ ", " ^ Int.toString y


(* int * int list -> int *)
(* produce how many number can be added before reaching the given sum *)
(* ASSUME: the entire list sums to more than the passed in value *)
fun number_before_reaching_sum (sum : int, lon : int list) =
		(* count : count of number so far *)
		(* sum_2 : sum   of number so far *)
		let
				fun foo (lon : int list, count : int, sum_2 : int) =
						if sum_2 + hd lon < sum
						then foo (tl lon, count + 1, sum_2 + hd lon)
						else count
		in
				foo (lon, 0, 0)
		end


(* int -> int *)
(* takes a day int[1, 365] and returns what month that day is in*)
val DAYS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

fun what_month (d : int) =
		number_before_reaching_sum(d, DAYS) + 1


(* int * int -> int list *)
(* return list from month of day1 to month of day2 *)

fun month_range (d1 : int, d2 : int) =
		if d1 > d2
		then []
		else what_month d1 :: month_range (d1 + 1, d2)


(* (int * int * int) list -> (int * int * int) *)
(* return some of oldest date in the list, return NONE if the list is empty *)

fun oldest (lod : (int * int * int) list) =
		if null lod
		then NONE
		else if null (tl lod)
		then SOME (hd lod)
		else
				let val ans = oldest (tl lod)
				in
						if isSome ans andalso is_older (hd lod, valOf ans)
						then SOME (hd lod)
						else ans
				end
