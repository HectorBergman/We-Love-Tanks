

image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
if (x > room_width || x < 0 || y < 0 || y > room_height){
	instance_destroy();
}
movementVector = normalizeVector(movementVector);


newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
			 lengthdir_y(sprite_height - sprite_yoffset, image_angle)]
while !place_meeting(x+movementX(), y+movementY(), obj_wall){
	timeSinceBounce++;
	//print("x; " + string(x) + "y: " + string(y));
	var distance = point_distance(x+newCoords[0],y+newCoords[1], playerTank.x,playerTank.y)
	closestDistanceToPlayer = min(closestDistanceToPlayer,distance);
	x += movementX();
	y += movementY();
}

var hit = 0;


while (!place_meeting(x,y,obj_wall)){
	x += movementVector[0]*0.1;
	y += movementVector[1]*0.1;
}
hit = instance_place_list(x, y, obj_wall, hitList, 1)

if (hit > 0){
	hitInARow++
	var hitWall = ds_list_find_value(hitList,0);
	// Get the block's boundaries
	var whichWall = findWallSideHit(hitWall);
	if (hit > 2){
		var walls = filterOutIntersections([ds_list_find_value(hitList,0),ds_list_find_value(hitList,1),ds_list_find_value(hitList,2)])
		if findWallSideHit(walls[0]) == findWallSideHit(walls[1]){
			hit = 1;
		}else{
			hit = 2;
		}
	}else if (hit > 1){
		if (ds_list_find_value(hitList,1).object_index == obj_intersection || 
			ds_list_find_value(hitList,0).object_index == obj_intersection){
			var wall1 = findWallSideHitDeluxe(ds_list_find_value(hitList,0));
			var wall2 = findWallSideHitDeluxe(ds_list_find_value(hitList,1));
			var result = minIndex(wall1[1]+wall2[1], wall1[2]+wall2[2], wall1[3]+wall2[3], wall1[4]+wall2[4]);
			whichWall = result[1];

			print(whichWall);
			hit = 1;
			
		}else if whichWall == findWallSideHit(ds_list_find_value(hitList,1)){
			hit = 1;
		}
	}
	if (hit == 1){
		if (whichWall == 2) {
			
			//print("left");
			movementVector[0] = -movementVector[0]
			movementVector[1] = movementVector[1]
		}else if (whichWall == 0){
			//print("right");
			movementVector[0] = -movementVector[0]
			movementVector[1] = movementVector[1]
		}else if (whichWall == 1) {

			//print("top");
			movementVector[0] = movementVector[0]
			movementVector[1] = -movementVector[1]
		}else if (whichWall == 3){

			//print("bot");
			movementVector[0] = movementVector[0]
			movementVector[1] = -movementVector[1]
		}
			
	}else{
		movementVector[0] = -movementVector[0]
		movementVector[1] = -movementVector[1]
	}
	fireCoords = [x,y];
	
	lastWallStruck = hitWall;
	if (timeSinceBounce > 9){
		maxBounce--
	}
	timeSinceBounce = 0
}else{
	hitInARow = 0;
}
image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
//erm actually this is a prevCoord

prevVector[0] = x
prevVector[1] = y
x = x + movementX();
y = y + movementY();
newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
				 lengthdir_y(sprite_height - sprite_yoffset, image_angle)]

if (maxBounce <= 0){
	print("-------------");
	print(closestDistanceToPlayer);
	print(originalAngle);
	parent.ricochetArray[originalAngle] = closestDistanceToPlayer
	instance_destroy();
}

ds_list_clear(hitList);