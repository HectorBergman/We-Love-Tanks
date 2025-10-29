function bullet_inBarrel(){
	if !instance_exists(parent){
		death();
		exit;
	}
	if parent.object_index == obj_player_cannon{
		if 1-followCannon/timeWhenExitBarrel > (bulgeNumber+1)/bulgeAmount{
			SignalSend("barrelBulletExitBulge",bulgeNumber)
			bulgeNumber++
		}
	}
	followCannon--
	image_angle = parent.image_angle;
	movementVector = getMovementVector(image_angle);
	extraMovement += bulletSpeed
		
	x = parent.x+extraMovement*movementVector[0]
	y = parent.y+extraMovement*movementVector[1]
	if followCannon == 0{
		if parent.object_index == obj_player_cannon{
			SignalSend("barrelBulletExitBulge",bulgeNumber)
		}
		SignalSend("exitBarrel: " + string(parent), ceil(barrelLength/bulletSpeed)+1);
		state = states.travel;
	}
}

function bullet_travel(){
	bullet_checkForRico();
	bullet_tick();
	findTags();
}

function bullet_bounce(){
	exeStateFunc("bounce_", bInfo.state);
}

function bounce_start(){
	bInfo.state = bounceStates.mid
}
function bounce_mid(){
	bInfo.bounceTimer--;
	var progress = 1 - (bInfo.bounceTimer / bInfo.bounceTime);
	var easedProgress = progress * progress;
	var totalAngleDiff = angle_difference(bInfo.angle, bInfo.angleAtBounce);
	var angDiff = totalAngleDiff * (easedProgress - bInfo.lastEasedProgress);
	bInfo.lastEasedProgress = easedProgress;
	image_angle += angDiff;
	if bInfo.bounceTimer == 0{
		bInfo.state = bounceStates.finish
		bInfo.bounceTimer = bInfo.bounceTime
		image_angle = bInfo.angle;
		bInfo.lastEasedProgress = 0;
	}
}
function bounce_finish(){
	bInfo.bounceTimer--
	var t = clamp((bulletSpeed - baseBulletSpeed) / (capBulletSpeed - baseBulletSpeed), 0, 1);
	var scaledBoost = power(1-t,2) // quadratic ease-out
	bulletSpeed += baseBulletSpeed * bInfo.boostMultiplier * scaledBoost;
	print("-----");
	print("bulletSpeed: ", bulletSpeed)
	print("scaledBoost: ", scaledBoost);
	bInfo.state = bounceStates.start;
	state = states.travel
	bInfo.bounceTimer = bInfo.bounceTime
	bInfo.timeSinceBounce = 0;
	movementVector = getMovementVector(image_angle);
	x += movementVector[0]*bulletSpeed;
	y += movementVector[1]*bulletSpeed;
	state = states.travel;
}

function growth_growing(){
	scale += bulletGrowthRate;
	if sign(bulletGrowthRate)*scale >= bulletGrowthEnd{
		scale = bulletGrowthEnd;
		growthState = growthStates.grown;
	}
}
function growth_grown(){
}
	
function bullet_dying(){
	death();
	//add delay here,
	//maybe create a delay handler that takes id and pauseMode,
	//then ticks down if pauseMode isnt paused
}