if (place_meeting(x,y,playerTank)){
	if !colliding{
		//RoomLoader.unload(
		if orientation == 0{
			with roomHandler{
				roomCreate(rm_test, 1,0)
			}
		}else if orientation == 1{
			with roomHandler{
				roomCreate(rm_test,0,-1)
			}
		}else if orientation == 2{
			with roomHandler{
				roomCreate(rm_test,-1,0)
			}
		}else if orientation == 3{
			with roomHandler{
				roomCreate(rm_test,0,1)
			}
		}
		orientation = (orientation + 2) mod 4
		colliding = true;
	}
}else{
	colliding = false;
}