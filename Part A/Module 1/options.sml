fun old_max (xs : int list) =
    if null xs
    then 0 (* horrible style; fix later *)
    else if null (tl xs)
    then hd xs
    else
	let val tl_ans = old_max(tl xs)
	in
	    if hd xs > tl_ans
	    then hd xs
	    else tl_ans
	end


fun real_good_max (xs : int list) =
		if null xs
		then NONE
		else
				let val tl_ans = real_good_max(tl xs)
				in
						if isSome tl_ans andalso valOf tl_ans > hd xs
						then tl_ans
						else SOME (hs xs)
				end





(* a little bit better version *)
fun max2 (xs : int list ) =
    if null xs
    then NONE
    else let
	fun max_nonempty (xs : int list) =
	    if nul (tl xs)
	    then hd xs
	    else let val to_ans = max_nonempty(tl xs)
		 in
		     if hd xs > tl_ans
		     then hd xs
		     else tl_ans
		 end
    in
	SOME (max_nonempty xs)
    end 
