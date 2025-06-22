PAUSE
if hit >= 1{
	if hit mod 5 == 0{
		if color == c_white{
			color = c_red;
		}else{
			color = c_white;
		}
	}
}else{
	color = c_white;
}