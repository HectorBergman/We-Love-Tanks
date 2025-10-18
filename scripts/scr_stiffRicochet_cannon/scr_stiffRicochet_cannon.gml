function stiffRicochet_create_cannon(){
	//todo: have a second less precise (to be less performance-heavy) ricochet calculation
	//that is purely so the cannon can turn into position before firing.

	type = parent.type;
	shotCooldownTime = 300;
	shotCooldown = irandom_range(1,60);
	maxBounces = 2;
	bulletInfo = bulletInfo_create(
		1,
		maxBounces,
		3,
		4,
	)
	SignalSubscribe(id, "ricochetAngle", function(ricochetInfo){
		var closestDistance = ricochetInfo.distance 
		var angle = ricochetInfo.angle
		if closestDistance < closestDistanceToPlayer{
			chosenAngle = angle
			closestDistanceToPlayer = closestDistance
		}
	})
	x = parent.x
	y = parent.y
	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 30;
	fire = false;
	state = stiffRicochet.normal;

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,obj_player.x,obj_player.y));

	stepTilSwitchWhole = 200;
	stepsTilSwitch = stepTilSwitchWhole/2;
	image_angle = radtodeg(scanningPoint);
	playerSeenLastStep = false;
	scanningDirection = 1;
	closestDistanceToPlayer = 999999;
	chosenAngle = -1;
	ricochetArray = [];
	ricochetArray[360] = 99999

	timeFromCalculationToFire = 40; //to make tanks "sharper", decrease this. Minimum: 10
									//if you want lower, you have to edit the magic
									//+10 that appears in steps. Not recommended but doable
									//it allows for some time to let the tank turn to it's chosen
									//direction of shooting. Instead of just snapping.

	stepAngle = 0;

	startAngle = 150;
	angleInterval = 999; //increase this for less precise but faster calculations //recommended: 5

	
}

function stiffRicochet_step_cannon(){
	x = parent.x
	y = parent.y
	shotCooldown++
	if (shotCooldown mod shotCooldownTime == shotCooldownTime-maxBounces-timeFromCalculationToFire){
		findBestRicochetAngle(); //calculates the angle which will get a bullet closest to the player
	}else if shotCooldown mod shotCooldownTime == shotCooldownTime-timeFromCalculationToFire+10{
		searchRicochetArray();	//finds angle in array
		stepAngle = gradualPointOverTime(chosenAngle, timeFromCalculationToFire-10) //no instant snap
	}else if (shotCooldown mod shotCooldownTime == 0){
		image_angle = chosenAngle;
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
		chosenAngle = -1;
		closestDistanceToPlayer = 999999;
	}else if(shotCooldown mod shotCooldownTime > shotCooldownTime-timeFromCalculationToFire+10){
		if (abs(angle_difference(image_angle, chosenAngle)) < 3){
			image_angle = chosenAngle
		}else{
			image_angle += stepAngle;
		}
	}
}

function findBestRicochetAngle(){
	for (var i = startAngle; i < 360; i = i+angleInterval){
		
		var angle = i
		var extraInfo = {
			x : x+20*dcos(angle),
			y : y+20*-dsin(angle),
			originalAngle:i,
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
		
	}
}
function searchRicochetArray(){
	
	for (var i = startAngle; i < 360; i = i+angleInterval){

		if ricochetArray[i] < closestDistanceToPlayer{
			chosenAngle = i
			closestDistanceToPlayer = ricochetArray[i]
		}
	}
	/*print("itsdecided");
	print(chosenAngle)
	print(closestDistanceToPlayer)*/
}