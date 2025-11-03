function stiffRicochet_cannon_normal(){
	print(shotCooldown);
	shotCooldown += ts
	//var timeFromCalculationToFire = (scanInfo.angleCap-scanInfo.startAngle)/(scanInfo.scansPerTick*scanInfo.angleInterval)
	if (shotCooldown >= shotCooldownTime){
		shotCooldown = 0
		state = states.findRicochet //calculates the angle which will get a bullet closest to the player
	}
}

function stiffRicochet_cannon_findRicochet(){
	var maxAngle = scanInfo.lastAngle+scanInfo.angleInterval*scanInfo.scansPerTick
	for (var angle = scanInfo.lastAngle; angle <= maxAngle; angle = angle+scanInfo.angleInterval){
		if angle >= scanInfo.angleCap{
			state = states.turning;
			scanInfo.lastAngle = 0;
			exit;
		}
		var extraInfo = {
			x : x+20*dcos(angle),
			y : y+20*-dsin(angle),
			originalAngle:angle,
			parentCoords : [x,y],
		}
		
	
		var args = 
		fireBullet_defaultSummonStruct(
			bulletInfo.speed,
			bulletInfo.bounces,
			bulletInfo.damage,
			enemyBarrelLength, 
			bulletInfo.durability,
			extraInfo
		)
		
		fireBullet(id, obj_bullet_findRicochet_test, angle,args,false)
		scanInfo.lastAngle = angle;
	}
}

function stiffRicochet_cannon_turning(){
	if (abs(angle_difference(image_angle, scanInfo.chosenAngle)) < (scanInfo.stepAngle+1)*ts){
		image_angle = scanInfo.chosenAngle
		state = states.firing;
	}else{
		var angleDirection = -sign(angle_difference(image_angle,scanInfo.chosenAngle))
		image_angle += angleDirection*scanInfo.stepAngle*ts;
	}
}
	
function stiffRicochet_cannon_firing(){
	if scanInfo.closestDistanceToPlayer != distanceNotFound{
		image_angle = scanInfo.chosenAngle;
		var extraInfo = {
			bulletGrowthStart: 0.3, 
			bulletGrowthEnd: 1, 
			bulletGrowthRate: 0.05,
		}
		
		var args = 
		fireBullet_defaultSummonStruct(
			bulletInfo.speed,
			bulletInfo.bounces,
			bulletInfo.damage,
			enemyBarrelLength, 
			bulletInfo.durability,
			extraInfo
		)
		fireBullet(id,obj_bullet_enemy,image_angle,args)
	}
	scanInfo.chosenAngle = -1;
	scanInfo.closestDistanceToPlayer = distanceNotFound;
	state = states.normal;
}