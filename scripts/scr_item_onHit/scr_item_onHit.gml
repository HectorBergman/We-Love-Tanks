function cactus_onHit(){
	var _angle = radtodeg(arctan2(-movementVector[1], movementVector[0]))

	if lifeTime < 200{
		_angle = (_angle + 3) mod 360;
	}else{
		_angle = (_angle + 3*sqrt(200)/sqrt(lifeTime)) mod 360;
		print("iminit");
	}

	movementVector[0] = dcos(_angle);
	movementVector[1] = -dsin(_angle);

}