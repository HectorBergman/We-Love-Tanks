PAUSE
ds_list_add(pathPoints, [x, y]);
if lifeTime > 5{
	depth = -99
}

// Trim path if too long
if (ds_list_size(pathPoints) > maxPathLength) {
    ds_list_delete(pathPoints, 0); // Remove oldest point
}


if (keyboard_check(vk_space)){
	slowmovin++
}else{
	slowmovin = 0
}
if !(inRange(x,-32,room_width+32) && inRange(y,-32,room_height+32)){
	death();
}
if (slowmovin mod 60 == 0){
	lifeTime++
	if object_index == obj_bullet_player{
		pickupMoney();
		loop_onBulletTravel();
	}
	findTags();
	timeSinceBounce++
	
	if ricochet(movementVector, bulletSpeed){
		bulletBounce();
	}
	
	
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

	prevVector[0] = x
	prevVector[1] = y
	x = x + movementX();
	y = y + movementY();

	
}
hitOpponentBullet(object_index);
hitOpponent(object_index);