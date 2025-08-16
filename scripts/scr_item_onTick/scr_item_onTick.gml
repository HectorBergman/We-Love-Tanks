function backJack_onTick(){
	for (var i = 0; i < ds_list_size(backJackList); i++){
		var index = ds_list_find_value(backJackList,i);
		if index[0] != 0{
			index[0]--;
		}else{
			with cannon{
				fireBullet(index[1].obj,index[1].bulletSpeed,index[1].bulletBounces,index[1].bulletDamage,
				image_angle,global.playerBarrelLength,false, index[1].bulletDurability, index[1].extraInfo);
			}
			ds_list_delete(backJackList,i)
		}
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