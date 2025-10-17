if (slowmovin mod 60 == 0){
	if canGrow && scale != bulletGrowthEnd{
		scale += bulletGrowthRate;
		if sign(bulletGrowthRate)*scale >= bulletGrowthEnd{
			scale = bulletGrowthEnd;
		}
	}
	lifeTime++
	if object_index == obj_bullet_player{
		pickupMoney();
		SignalSend("onBulletTravel", {id : id});
	}
	findTags();
	timeSinceBounce++
	
	if ricochet(movementVector, bulletSpeed){
		bulletBounce();
	}
	
	if followCannon == 0{
		image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
		x = x + movementX();
		y = y + movementY();
	}else{
		followCannon--;
		image_angle = parent.image_angle;
		movementVector = [cos(degtorad(image_angle)), -sin(degtorad(image_angle))]
		extraMovement += bulletSpeed
		
		x = parent.x+extraMovement*movementVector[0]
		y = parent.y+extraMovement*movementVector[1]
	}
	
	
	
}
image_xscale = scale;
image_yscale = scale;

if object_index == obj_bullet_player{
	hitOpponentBullet(object_index);
}
hitOpponent(object_index);