//functions that trigger every tick

function redPill_onTick(tickInfo){
	var closestDist = 99999;
	var chosenBullet = noone;
	for (var i = 0; i < instance_number(obj_bullet_enemy); i++){
		var bullet = instance_find(obj_bullet_enemy,i);
		var dist = point_distance(tickInfo.id.x,tickInfo.id.y,bullet.x,bullet.y);
		if dist < closestDist{
			chosenBullet = bullet
			closestDist = dist;
		}
	}
	if closestDist < 50{
		global.timeSpeed = sqrt(closestDist/50);
	}else{
		global.timeSpeed = 1;
	}
}
