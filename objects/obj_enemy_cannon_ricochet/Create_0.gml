
shotCooldownTime = 300;
shotCooldown = 1;

x = parent.x
y = parent.y
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 120;
fire = false;
state = cannonEnemyStates.scanning;

scanningArea = pi/2
scanningStep = (pi/2)/100
scanningPoint = degtorad(point_direction(x,y,playerTank.x,playerTank.y));

stepTilSwitchWhole = 200;
stepsTilSwitch = stepTilSwitchWhole/2;
image_angle = radtodeg(scanningPoint);
playerSeenLastStep = false;
scanningDirection = 1;
closestDistanceToPlayer = 999999;
chosenAngle = -1;
ricochetArray = [];
ricochetArray[360] = 99999
bulletSpeed = 9;
maxBounces = 3;

startAngle = 0;
angleInterval = 5;

function findBestRicochetAngle(){
	for (var i = startAngle; i < 360; i = i+angleInterval){
		var angle = degtorad(i)+pi/2;
		summonObject(obj_bullet_findRicochet, [["movementVector", [sin(angle), cos(angle)]], 
		["bulletSpeed", bulletSpeed], ["x", x+20*sin(angle)], ["y", y+20*cos(angle)], ["maxBounce", maxBounces], 
		["parent", id], ["originalAngle", i], ["firedFrom", [x,y]], ["firedAngle", image_angle]])
	}
}
function searchRicochetArray(){
	
	for (var i = startAngle; i < 360; i = i+angleInterval){
		print("====____====")
		print(i)
		print(ricochetArray[i])
		if ricochetArray[i] < closestDistanceToPlayer{
			chosenAngle = i
			closestDistanceToPlayer = ricochetArray[i]
		}
	}
}