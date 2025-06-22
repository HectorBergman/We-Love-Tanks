/// @function getWallCoords(wall, quadrant)
/// @description Returns the coordinate of a corner of a wall instance
/// @param {instance} wall The wall instance to check (obj_wall or compatible)
/// @param {int} quadrant Which corner to get (0-3, counter-clockwise from top-right)
/// @returns {array<int>} [x,y] coordinates of the requested corner
/// @example
/// var corner = getWallCoords(wall_instance, 2); // Gets bottom-left corner

function getWallCoords(wall, quadrant){
	var xScale = wall.image_xscale;
	var yScale = wall.image_yscale;
	var _x = wall.x;
	var _y = wall.y;
	if quadrant == 0{
		return [_x + 32*xScale,_y]
	}
	if quadrant == 1{
		return [_x,_y]
	}
	if quadrant == 2{
		return [_x, _y + 32*yScale];
	}
	if quadrant == 3{
		return [_x + 32*xScale, _y + 32*yScale];
	}
}

/// @function determineIfWithinBoxCone(wall, quadrant, objectCoords, acceptableAngleDifference)
/// @description Checks if an object's coordinates fall within a directional cone extending from a specified box corner.
/// @param {instance} wall       The wall instance to check from
/// @param {int} quadrant        Which corner to use (0-3):
///                              0 = Bottom-left (45°)
///                              1 = Top-left (135°)
///                              2 = Top-right (225°)
///                              3 = Bottom-right (315°)
/// @param {array} objectCoords  [x,y] coordinates to check
/// @param {float} acceptableAngleDifference  Angular tolerance in degrees (half of total cone angle)
///								 i.e. an acceptableAngleDifference of 20 means a cone of angle 40 degrees
/// @returns {bool}              Returns true if object is within the cone, false otherwise
///
/// @example
/// var wall = instance_nearest(x, y, obj_wall);
/// var target = [obj_player.x, obj_player.y];
/// if (determineIfWithinBoxCone(wall, 1, target, 15)) {
///     // Player is in 30° cone from top-left corner
/// }
function determineIfWithinBoxCone(wall, quadrant, objectCoords, acceptableAngleDifference){
	var wallCoords = getWallCoords(wall,quadrant);
	var pointDirection = point_direction(wallCoords[0],wallCoords[1], objectCoords[0],objectCoords[1]);
	var directionalAngle = 0;
	if quadrant == 0{
		directionalAngle = 45;
	}else if quadrant == 1{
		directionalAngle = 135;
	}else if quadrant == 2{
		directionalAngle = 225;
	}else if quadrant == 3{
		directionalAngle = 315;
	}
	if abs(angle_difference(pointDirection, directionalAngle)) < acceptableAngleDifference{
		return true;
	}else{
		return false
	}
}


function fireBullet(bulletObj, bulletSpeed, maxBounce, damage, angle, barrelLength, increaseCount, extraArgs = []){
	var summonArray = [ ["movementVector", [dcos(angle), -dsin(angle)]], 
	["bulletSpeed", bulletSpeed], ["x", x+barrelLength*dcos(angle)], ["y", y+barrelLength*-dsin(angle)], 
	["maxBounce", maxBounce], ["parent", id], ["firedFrom", [x,y]], ["firedAngle", angle],
	["image_angle", angle], ["depth", depth+1], ["damage", damage], ["increaseCount",increaseCount]];
	
	var length = array_length(extraArgs)
	var summonLength = array_length(summonArray)
	for (var i = 0; i < length; i++){
		array_insert(summonArray, summonLength+i, extraArgs[i])
		
	}
	var bullet = summonObject(bulletObj, summonArray);
	if increaseCount{
		activeBullets++;
		firingCooldown = firingCooldownTime;
	}
	return bullet;
}


/// @function findWallSideHit(wall)
/// @description Returns the quadrant of the wall that was hit by the bullet
/// @param {instance} wall The obj_wall that is checked
/// @returns {real} number from 0,3, representing right,top,left, and bottom respectively.


function findWallSideHit(wall){
	
	// Get the block's boundaries
	var block_left = wall.bbox_left;
	var block_right = wall.bbox_right;
	var block_top = wall.bbox_top;
	var block_bottom = wall.bbox_bottom;
	
	
	var xDifferenceLeft = x+newCoords[0] - block_left
	var xDifferenceRight = x+newCoords[0] - block_right
	var yDifferenceTop = y+newCoords[1] - block_top;
	var yDifferenceBottom = y+newCoords[1] - block_bottom;
	var smallest = min(abs(xDifferenceLeft),abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom));
	if (smallest = abs(xDifferenceLeft)) {
		return 2;
	}else if (smallest = abs(xDifferenceRight)){
		return 0;
	}else if (smallest = abs(yDifferenceTop)) {
		return 1;
	}else if (smallest = abs(yDifferenceBottom)){
		return 3;
	}
}

/// @function findWallSideHit(wall)
/// @description Returns the quadrant of the wall that was hit by the bullet, plus the distance of the bullet from each side
/// @param {instance} wall The obj_wall that is checked
/// @returns {array<real>} index 0 is number from 0,3, representing right,top,left, and bottom respectively,
///						   index 1-4 is the distance from the bullet for each side, in the same order as earlier.


function findWallSideHitDeluxe(wall){
	
	// Get the block's boundaries
	var block_left = wall.bbox_left;
	var block_right = wall.bbox_right;
	var block_top = wall.bbox_top;
	var block_bottom = wall.bbox_bottom;
	
	
	var xDifferenceLeft = x+newCoords[0] - block_left
	var xDifferenceRight = x+newCoords[0] - block_right
	var yDifferenceTop = y+newCoords[1] - block_top;
	var yDifferenceBottom = y+newCoords[1] - block_bottom;
	var smallest = min(abs(xDifferenceLeft),abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom));
	if (smallest = abs(xDifferenceLeft)) {
		return [2,abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom),abs(xDifferenceLeft)];
	}else if (smallest = abs(xDifferenceRight)){
		return [0,abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom),abs(xDifferenceLeft)];
	}else if (smallest = abs(yDifferenceTop)) {
		return [1,abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom),abs(xDifferenceLeft)];
	}else if (smallest = abs(yDifferenceBottom)){
		return [3,abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom),abs(xDifferenceLeft)];
	}
}


/// @function filterOutIntersections(inst_array)
/// @description Returns array of instances where object_index != obj_intersection
/// @param {array} inst_array Array of instances to filter
/// @returns {array} Filtered array of instances (max 2 elements)

function filterOutIntersections(inst_array) {
    var filtered = [];
    
    for (var i = 0; i < array_length(inst_array); i++) {
        var inst = inst_array[i];
        if (inst.object_index != obj_intersection) {
            array_push(filtered, inst);
            
            // Early exit if we already found 2
            if (array_length(filtered) >= 2) {
                break;
            }
        }
    }
    
    return filtered;
}

function findTags(){
	if variable_instance_exists(id,"tags"){
		for (var i = 0; i <array_length(tags); i++){
			var tag = tags[i]
			engageTag(tag);
		}
	}
}

function engageTag(tag){
	if tag == "buckshot"{
		buckshotTime--
		if buckshotTime < 1{
			for (var i = 0; i < buckshotCount; i++){
				var firedBullet =  fireBullet(object_index,bulletSpeed*1.6,0,damage,image_angle-buckshotSpread/2+buckshotSpread/buckshotCount*i,0,false,[["image_xscale",0.75],["image_yscale",0.75]])
				if instance_exists(parent){
					parent.buckshotBullets[i] = firedBullet
				}
			}
			death();
		}
		
	}
}

function pickupMoney(){
	var list = ds_list_create();
	instance_place_list(x,y,obj_dollar, list, false)
	if !ds_list_empty(list){
		for (var i = 0; i < ds_list_size(list); i++){
			var dollar = ds_list_find_value(list,i)
			if dollar.z >= -10{
				if instance_exists(obj_moneyHandler){
					obj_moneyHandler.money += dollar.value
					obj_moneyHandler.bounceSize += dollar.value
				}
				instance_destroy(dollar);
			}
			//AddSoundHere
		}
	}
	ds_list_destroy(list);
}

function ricochet(movementVector, velocity, radius = 3, spacing = 1){
	var collisionAngle = collision_normal(x+movementVector[0]*velocity,y+movementVector[1]*velocity,obj_solid,radius,spacing)
	
	if collisionAngle != -1{
		var dot = movementVector[0] * cos(degtorad(collisionAngle)) + movementVector[1] * sin(degtorad(collisionAngle));
		var reflectedVector = [];
		reflectedVector[0] = movementVector[0] - 2 * dot * cos(degtorad(collisionAngle));
		reflectedVector[1] = movementVector[1] - 2 * dot * sin(degtorad(collisionAngle));
		movementVector[0] = reflectedVector[0]
		movementVector[1] = reflectedVector[1]
		return true;
	}
	return false;
}