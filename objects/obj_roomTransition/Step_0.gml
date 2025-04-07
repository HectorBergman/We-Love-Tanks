if (place_meeting(x,y,playerTank)){
	if !colliding{
		print("test");
		//RoomLoader.unload(
		if orientation == 0{
		
		
			roomCreate(rm_test, 1,0)
		
		
		}else if orientation == 1{
			
			roomCreate(rm_test,0,-1)
		
		
		}else if orientation == 2{
			
			roomCreate(rm_test,-1,0)
		
		
		}else if orientation == 3{
			
			roomCreate(rm_test,0,1)
		
		
		}
		print(orientation)
		orientation = (orientation + 2) mod 4
		print(orientation);
		colliding = true;
	}
}else{
	colliding = false;
}