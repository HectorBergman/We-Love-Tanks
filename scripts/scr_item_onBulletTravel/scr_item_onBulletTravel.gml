//functions that trigger each bullet tick

function spinnyBullet_onBulletTravel(bulletInfo){
	triggerAsInstance(bulletInfo.id,spinnyBullet_onBulletTravel_helper);

}
function spinnyBullet_onBulletTravel_helper(){
	if lifeTime > 3{
		// Golden Ratio (φ ≈ 1.618) and Golden Angle (≈137.508°)
		var _phi = (1 + sqrt(5)) / 2;
		var _golden_angle = 360 / ((_phi * _phi)*10); // ≈137.508°

		// Initial angle calculation
		var _angle = radtodeg(arctan2(-movementVector[1], movementVector[0]));

		var _radius = 50/(power(lifeTime,1.2)+30) // Increase radius over time
		// Apply Golden Angle increment per frame
		_angle = (_angle + _golden_angle*_radius) mod 360;

		// Update movement vector (preserve speed)
		damage += (0.005*bulletSpeed);
		baseBulletSpeed *= 0.9999
		
		// Update movement vector
		movementVector[0] = dcos(_angle);
		movementVector[1] = -dsin(_angle);
	}
}
/*// Golden Ratio (φ ≈ 1.618) and Golden Angle (≈137.508°)
		var _phi = (1 + sqrt(5)) / 2;
		var _golden_angle = 360 / ((_phi * _phi)*10); // ≈137.508°

		// Initial angle calculation
		var _angle = radtodeg(arctan2(-movementVector[1], movementVector[0]));

		var _radius = lifeTime/5; // Increase radius over time
		// Apply Golden Angle increment per frame
		_angle = (_angle + _golden_angle*_radius) mod 360;

		// Update movement vector (preserve speed)
	
		bulletSpeed -= 0.02
		
		// Update movement vector
		movementVector[0] = dcos(_angle);
		movementVector[1] = -dsin(_angle);*/