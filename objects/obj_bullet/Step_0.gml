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
			if !instance_exists(id){
				death();
				exit;
			}
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
			bullet_checkForRico();
			bullet_travel();
			findTags();
		break;
		case bulletState.bounce: 
			switch(bInfo.state){
				case bounceState.start:   
				bInfo.state = bounceState.mid
				
				break;
				case bounceState.mid: 
					bInfo.bounceTimer--;

					var progress = 1 - (bInfo.bounceTimer / bInfo.bounceTime);
					var easedProgress = progress * progress;
					var totalAngleDiff = angle_difference(bInfo.angle, bInfo.angleAtBounce);
					var angDiff = totalAngleDiff * (easedProgress - bInfo.lastEasedProgress);
					bInfo.lastEasedProgress = easedProgress;
					image_angle += angDiff;
					if bInfo.bounceTimer == 0{
						bInfo.state = bounceState.finish
						bInfo.bounceTimer = bInfo.bounceTime
						image_angle = bInfo.angle;
						bInfo.lastEasedProgress = 0;
					}
				break;
				case bounceState.finish:
					bInfo.bounceTimer--
					var t = clamp((bulletSpeed - baseBulletSpeed) / (capBulletSpeed - baseBulletSpeed), 0, 1);
					var scaledBoost = power(1-t,2) // quadratic ease-out
					bulletSpeed += baseBulletSpeed * bInfo.boostMultiplier * scaledBoost;
					print("-----");
					print("bulletSpeed: ", bulletSpeed)
					print("scaledBoost: ", scaledBoost);
					bInfo.state = bounceState.start;
					state = bulletState.travel
					bInfo.bounceTimer = bInfo.bounceTime
					bInfo.timeSinceBounce = 0;
					movementVector = getMovementVector(image_angle);
					x += movementVector[0]*bulletSpeed;
					y += movementVector[1]*bulletSpeed;
					state = bulletState.travel;
				break;
			}
		break;
		case bulletState.dying: 
			death();
			//add delay here,
			//maybe create a delay handler that takes id and pauseMode,
			//then ticks down if pauseMode isnt paused
		break;
		
	}
	image_xscale = scale;
	image_yscale = scale;
	
	
	
	
}


if object_index == obj_bullet_player{
	hitOpponentBullet(object_index);
}
hitOpponent(object_index);

