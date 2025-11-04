function create_cannon_stiffRicochet(){
	//todo: have a second less precise (to be less performance-heavy) ricochet calculation
	//that is purely so the cannon can turn into position before firing.

	type = parent.type;
	shotCooldownTime = 300;
	shotCooldown = irandom_range(1,120);
	maxBounces = 3;
	bulletInfo = bulletInfo_create(
		1,
		maxBounces,
		3,
		4,
	)

	x = parent.x
	y = parent.y
	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 30;
	fire = false;
	states = createStates("normal","findRicochet","turning","firing") 
	state = states.normal;
	scanInfo = {
		lastAngle : 0,
		scansPerTick : 2,
		startAngle : 0,
		angleInterval : 5, //increase this for less precise but faster calculations //recommended: 5
		angleCap : 360,
		stepAngle : 10, //turning speed, degrees per frame
		chosenAngle : -1,
		closestDistanceToPlayer : 999999,
		
	}
	SignalSubscribe(id, "ricochetAngle: " + string(id), function(ricochetInfo){
		var closestDistance = ricochetInfo.distance 
		var angle = ricochetInfo.angle
		if closestDistance < scanInfo.closestDistanceToPlayer{
			scanInfo.chosenAngle = angle
			scanInfo.closestDistanceToPlayer = closestDistance
		}
	})

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,obj_player.x,obj_player.y));

	stepTilSwitchWhole = 200;
	stepsTilSwitch = stepTilSwitchWhole/2;
	image_angle = radtodeg(scanningPoint);
	playerSeenLastStep = false;
	scanningDirection = 1;
	
}

function step_cannon_stiffRicochet(){
	exeStateFunc("stiffRicochet_cannon_",state)
}


function findBestRicochetAngle(){
	for (var i = startAngle; i < 360; i = i+angleInterval){
		
		var angle = i
		var extraInfo = {
			x : x+20*dcos(angle),
			y : y+20*-dsin(angle),
			originalAngle:i,
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
		
	}
}
