#macro maxDistance 1920
depth = -9999;
pauseMode = allPause;
function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}
scale = 1;

hitInARow = 0;
collisionVector = [0,0];

prevVector = [noone, noone];
timeSinceBounce = 0;

lastWallStruck = noone;
newCoords = [0,0]
latestWallHit = -1;
closestDistanceToPlayer = 9999999;

bounces = 0;

debugTimer = 60;
debugTime = 60;

print("movVec0: ", movementVector[0], " movVec1: ", movementVector[1]);
print(x, " ", y);

function ricochetBounce(){
	
	if bounces >= maxBounce{
		SignalSend("ricochetAngle", {
			distance: closestDistanceToPlayer,
			angle: originalAngle
		})
		print(closestDistanceToPlayer);
		print(originalAngle);
		print("-----");
		instance_destroy();
	}else{
		bounces++
	}
}

function setTopMidBot(){
	var cosA = dcos(image_angle);
	var sinA = dsin(image_angle);


	var top_offsetX = -sprite_get_xoffset(sprite_index)*scale;
	var top_offsetY = -sprite_get_yoffset(sprite_index)*scale;
	var bot_offsetX = sprite_height - sprite_get_xoffset(sprite_index)*scale;
	var bot_offsetY = sprite_height - sprite_get_yoffset(sprite_index)*scale;


	top = [floor(x + top_offsetY * sinA), floor(y + top_offsetY * cosA)]
	mid = [floor(x), floor(y)]
	bot = [floor(x + bot_offsetY * sinA), floor(y + bot_offsetY * cosA)]
}

function getRelativeTopMidBot(point, activeNo){
	var arr = []
	var cosA = dcos(image_angle);
	var sinA = dsin(image_angle);
	var scaledOffset_y = sprite_get_yoffset(sprite_index)*scale
	var scaledHeight = sprite_height*scale

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
			arr =[
				  [floor(x + -scaledOffset_y * sinA), floor(y + -scaledOffset_y * cosA)],
				 point,
				  [
					  floor(x + (scaledHeight-scaledOffset_y) * sinA), 
					  floor(y + (scaledHeight-scaledOffset_y) * cosA)
				  ]
				 ]
			break;
		case 2:
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
	
	print("RC: ", array[0], " ",
		array[1], " ",
		array[0]+movementVector[0]*maxDistance, " ",
		array[1]+movementVector[1]*maxDistance)
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
	var arr = [top,mid,bot]
	
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
	for (var i = 0 ; i < 3; i++){
		print("distance for ", i, ": ",  sortArr[i].distance)
	}
	return sortArr;
}
function findBounce(){
	var arr = enhanceAndSortMTB();
	print(arr);
	for (var i = 0; i < array_length(arr); i++){
		var RTMB = getRelativeTopMidBot(arr[i].point,arr[i].number)
		summonObject(obj_dummy, [["x",RTMB[1][0]],["y",RTMB[1][1]]]);
		var collisionAngle = collision_normal(RTMB[1][0], RTMB[1][1], obj_solid)
		if collisionAngle != -1{
			x = RTMB[1][0];
			y = RTMB[1][1];
			var dot = movementVector[0] * cos(degtorad(collisionAngle)) +
					  movementVector[1] * sin(degtorad(collisionAngle));
			reflectedVector[0] = movementVector[0] - 2 * dot * cos(degtorad(collisionAngle));
			reflectedVector[1] = movementVector[1] - 2 * dot * sin(degtorad(collisionAngle));
			movementVector[0] = reflectedVector[0]
			movementVector[1] = reflectedVector[1]
			return;
		}
	}
	forceCrash("didnt find bounce" + string(arr) + " " + string(originalAngle));
}

function setClosestDistance(wallHitPoint){
	var playerCoord = [obj_player.x,obj_player.y];
	var distance = point_to_segment_distance(mid, wallHitPoint, playerCoord)
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