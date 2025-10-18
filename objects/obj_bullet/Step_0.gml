PAUSE
ds_list_add(pathPoints, [x, y]);
if lifeTime > timeWhenExitBarrel{
	depth = -99
}




// Trim path if too long
if (ds_list_size(pathPoints) > maxPathLength) {
    ds_list_delete(pathPoints, 0); // Remove oldest point
}
var index = 0;
for (var i = 0; i < ds_list_size(ignoreList); i++){
	var entity = ds_list_find_value(ignoreList,index);
	if !place_meeting(x,y,entity){
		ds_list_delete(ignoreList,index);
	}else{
		index++
	}
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
	switch (growth){
		case growthState.growing:
			scale += bulletGrowthRate;
			if sign(bulletGrowthRate)*scale >= bulletGrowthEnd{
				scale = bulletGrowthEnd;
				growth = growthState.grown;
			}
		break;
		case growthState.grown: break;
	}
	switch (state){
		case bulletState.inBarrel: 
			followCannon--
			image_angle = parent.image_angle;
			movementVector = getMovementVector(image_angle);
			extraMovement += bulletSpeed
		
			x = parent.x+extraMovement*movementVector[0]
			y = parent.y+extraMovement*movementVector[1]
			if followCannon == 0{
				state = bulletState.travel;
			}
		
		break;
		case bulletState.travel: 
			bullet_travel();
			bullet_checkForRico();
			if object_index == obj_bullet_player{
				pickupMoney();
				SignalSend("onBulletTravel", {id : id});
			}
	findTags();
		break;
		case bulletState.bounce: 
			switch(bInfo.state){
				case bounceState.start:
				print(bInfo);      
				bInfo.state = bounceState.mid
				
				break;
				case bounceState.mid: 
					bInfo.bounceTimer--
					image_angle += angle_difference(bInfo.angle,bInfo.angleAtBounce)/(bInfo.bounceTime+1)
					if bInfo.bounceTimer == 0{
						bInfo.state = bounceState.finish
						bInfo.bounceTimer = bInfo.bounceTime
						image_angle = bInfo.angle;
					}
				break;
				case bounceState.finish:
					bInfo.bounceTimer--
					bulletSpeed += baseBulletSpeed*0.6;
					bInfo.state = bounceState.start;
					state = bulletState.travel
					bInfo.bounceTimer = bInfo.bounceTime
					movementVector = getMovementVector(image_angle);
					x += movementVector[0]*bulletSpeed;
					y += movementVector[1]*bulletSpeed;
					state = bulletState.travel;
				break;
			}
		break;
		case bulletState.dying: 
			instance_destroy();
			//add delay here,
			//maybe create a delay handler that takes id and pauseMode,
			//then ticks down if pauseMode isnt paused
		break;
		
	}
	image_xscale = scale;
	image_yscale = scale;
	
	
	timeSinceBounce++
	
}


if object_index == obj_bullet_player{
	hitOpponentBullet(object_index);
}
hitOpponent(object_index);

