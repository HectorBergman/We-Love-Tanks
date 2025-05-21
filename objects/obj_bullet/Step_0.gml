if (keyboard_check(vk_space)){
	slowmovin++
}else{
	slowmovin = 0
}
if !(inRange(x,-32,room_width+32) && inRange(y,-32,room_height+32)){
	instance_destroy()
}
if (slowmovin mod 60 == 0){
	timeSinceBounce++
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
	//if (x > room_width || x < 0 || y < 0 || y > room_height){
		//instance_destroy();
	//}
	movementVector = normalizeVector(movementVector);


	newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
					lengthdir_y(sprite_height - sprite_yoffset, image_angle)]

	var hit = 0;

	if (place_meeting(x+movementX(), y+movementY(), obj_wall)){

		
		while (!place_meeting(x,y,obj_wall)){
			x += movementVector[0]*0.1;
			y += movementVector[1]*0.1;
		}
		hit = instance_place_list(x, y, obj_wall, hitList, 1)

	}

	//todo: add sum shi like this for megafast bullets
	var prevhit14 = instance_place(x + (prevVector[0] - x)*0.25, y, obj_wall)
	var prevhit24 = instance_place(x + (prevVector[0] - x)*0.50, y, obj_wall)
	var prevhit34 = instance_place(x + (prevVector[0] - x)*0.75, y, obj_wall)


	if (hit > 0){
		hitInARow++
		var hitWall = ds_list_find_value(hitList,0);
		// Get the block's boundaries
		var whichWall = findWallSideHit(hitWall);
		if (hit > 2){
			var walls = filterOutIntersections([ds_list_find_value(hitList,0),ds_list_find_value(hitList,1),ds_list_find_value(hitList,2)])
			if findWallSideHit(walls[0]) == findWallSideHit(walls[1]){
				hit = 1;
			}else{
				hit = 2;
			}
		}else if (hit > 1){
			if (ds_list_find_value(hitList,1).object_index == obj_intersection || 
				ds_list_find_value(hitList,0).object_index == obj_intersection){
				var wall1 = findWallSideHitDeluxe(ds_list_find_value(hitList,0));
				var wall2 = findWallSideHitDeluxe(ds_list_find_value(hitList,1));
				var result = minIndex(wall1[1]+wall2[1], wall1[2]+wall2[2], wall1[3]+wall2[3], wall1[4]+wall2[4]);
				whichWall = result[1];

				
				hit = 1;
			
			}else if whichWall == findWallSideHit(ds_list_find_value(hitList,1)){
				hit = 1;
			}
		}
		if (hit == 1){
			if (whichWall == 2) {
			
				//print("left");
				movementVector[0] = -movementVector[0]
				movementVector[1] = movementVector[1]
			}else if (whichWall == 0){
				//print("right");
				movementVector[0] = -movementVector[0]
				movementVector[1] = movementVector[1]
			}else if (whichWall == 1) {

				//print("top");
				movementVector[0] = movementVector[0]
				movementVector[1] = -movementVector[1]
			}else if (whichWall == 3){

				//print("bot");
				movementVector[0] = movementVector[0]
				movementVector[1] = -movementVector[1]
			}
			
		}else{
			movementVector[0] = -movementVector[0]
			movementVector[1] = -movementVector[1]
		}
		fireCoords = [x,y];
	
		lastWallStruck = hitWall;
		if (timeSinceBounce > 3){
			maxBounce--
		}
		timeSinceBounce = 0
	}else{
		hitInARow = 0;
	}
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

	prevVector[0] = x
	prevVector[1] = y
	x = x + movementX();
	y = y + movementY();
	newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
					lengthdir_y(sprite_height - sprite_yoffset, image_angle)]

	if (hitInARow == 3){
		/*print(firedAngle);
		print(string(firedFrom[0]) + " " + string(firedFrom[1]));*/
		instance_destroy()
	
	}
	if (maxBounce <= 0){
		parent.activeBullets = parent.activeBullets - 1
		instance_destroy();
	}

	ds_list_clear(hitList);
}
