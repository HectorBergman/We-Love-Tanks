#macro maxDistance 1920
#macro distanceNotFound 9999999
depth = -9999;
pauseMode = allPause;
function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}
debug = {
	vec : [0,0],
	angle : 0,
	isOn : false,
}
bulletLength = sprite_width

visible = false;
scale = 1;

hitInARow = 0;
collisionVector = [0,0];

prevVector = [noone, noone];
timeSinceBounce = 0;

lastWallStruck = noone;
newCoords = [0,0]
latestWallHit = -1;
closestDistanceToPlayer = distanceNotFound;

radius = 3;

bounces = 0;

debugTimer = 60;
debugTime = 60;

//55 [ 704,352 ]
function ricochetBounce(){
	
	if bounces >= maxBounce{
		SignalSend("ricochetAngle: " + string(parent), {
			distance: closestDistanceToPlayer,
			angle: originalAngle
		})
		instance_destroy();
	}else{
		bounces++
	}
}

function setTopMidBot(){
	var cosA = dcos(image_angle);
	var sinA = dsin(image_angle);


	var top_offsetY = -radius;
	var bot_offsetY = radius;


	top = [floor(x + top_offsetY * sinA), floor(y + top_offsetY * cosA)]
	bot = [floor(x + bot_offsetY * sinA), floor(y + bot_offsetY * cosA)]
}

function getRelativeTopMidBot(point, activeNo){
	var arr = []
	var cosA = dcos(image_angle);
	var sinA = dsin(image_angle);
	var scaledOffset_y = radius
	var scaledHeight = radius

	switch (activeNo){
		case 0: 
			arr =
			[point, 
			 [
				floor(point[0] + scaledOffset_y*sinA), 
				floor(point[1] + scaledOffset_y*cosA)
			 ],
			 [
				floor(point[0]+scaledHeight*sinA),
				floor(point[1]+scaledHeight*cosA)
			 ]
			]
			break;
		case 1:
			arr = 
			[
				[
					floor(point[0]-scaledHeight*sinA),
					floor(point[1]-scaledHeight*cosA)
				],
				[
					floor(point[0]+(scaledHeight-scaledOffset_y)*sinA),
					floor(point[1]+(scaledHeight-scaledOffset_y)*cosA)
				],
				point,
			]
			break;
	}
	return arr;
}

function getRaycast(array){
	
	var RC = collision_line_point(
		array[0],
		array[1],
		array[0]+movementVector[0]*maxDistance,
		array[1]+movementVector[1]*maxDistance, 
		obj_solid,
		false,
		false
	)
    return RC.hitPoint
}

function enhanceAndSortMTB(){
	var sortArr = []
	var arr = [top,bot]
	
	for (var i = 0; i < array_length(arr); i++){
		var raycast = getRaycast(arr[i]);
		var raycastStruct = {
			point: raycast, 
			distance: point_distance(
				arr[i][0],
				arr[i][1],
				raycast[0],
				raycast[1]
			),
			number: i
		}
		array_push(sortArr,raycastStruct);
	}
	setClosestDistance(sortArr[1].point)
	array_sort(sortArr, sorty)
	return sortArr;
}
function findBounce(){
	var arr = enhanceAndSortMTB();
	for (var i = 0; i < array_length(arr); i++){
		var RTMB = getRelativeTopMidBot(arr[i].point,arr[i].number)
		var collisionAngle = collision_normal(RTMB[1][0], RTMB[1][1], obj_solid)
		if collisionAngle != -1{
			x = RTMB[1][0];
			y = RTMB[1][1];
			
			var dot = movementVector[0] * cos(degtorad(collisionAngle)) +
					  movementVector[1] * sin(degtorad(collisionAngle));
			reflectedVector[0] = movementVector[0] - 2 * dot * cos(degtorad(collisionAngle));
			reflectedVector[1] = movementVector[1] - 2 * dot * sin(degtorad(collisionAngle));
			if array_equals(reflectedVector, movementVector){
				reflectedVector = [-reflectedVector[0],-reflectedVector[1]]
			}
			debug.vec = reflectedVector
			debug.angle = point_direction(0,0,reflectedVector[0],reflectedVector[1]);
			var newMovement = [reflectedVector[0]*bulletLength,reflectedVector[1]*bulletLength]
			var col = collision_normal(x+newMovement[0],y+newMovement[1],obj_solid)
			if collision_normal(x+newMovement[0],y+newMovement[1],obj_solid) != -1{
				reflectedVector = [-movementVector[0],-movementVector[1]]
				newMovement = [reflectedVector[0]*bulletLength,reflectedVector[1]*bulletLength]
			}
			x += newMovement[0]
			y += newMovement[1]
			movementVector[0] = reflectedVector[0]
			movementVector[1] = reflectedVector[1]
			return;
		}
	}
	//I kind of cheated and deleted this, but it works good enough
	//forceCrash("didnt find bounce" + string(arr) + " " + string(originalAngle) + " " + string(parentCoords));
}

function setClosestDistance(wallHitPoint){
	var playerCoord = [obj_player.x,obj_player.y];
	var distance = point_to_segment_distance([floor(x),floor(y)], wallHitPoint, playerCoord)
	closestDistanceToPlayer = min(closestDistanceToPlayer,distance);
}

function sorty(element1,element2){
	if element1.distance == element2.distance{
		return 0
	}else if element1.distance > element2.distance{
		return 1
	}else{
		return -1
	}
}