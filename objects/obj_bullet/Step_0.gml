
timeSinceBounce++
image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
if (x > room_width || x < 0 || y < 0 || y > room_height){
	instance_destroy();
}
movementVector = normalizeVector(movementVector);


newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
				lengthdir_y(sprite_height - sprite_yoffset, image_angle)]

var hit = 0;

if (place_meeting(x+movementX(), y+movementY(), obj_wall)){
	print("lol");
	var _x = x;
	var _y = y;
	while (!place_meeting(x,y,obj_wall)){
		x += movementVector[0]*0.1;
		y += movementVector[1]*0.1;
	}if !(collision_rectangle(x+newCoords[0]-0.5,y+newCoords[1]-0.5,x+newCoords[0]+0.5,y+newCoords[1]+0.5,obj_wall,false,true)){
		x = _x
		y = _y
	}else{
		hit = instance_place_list(x, y, obj_wall, hitList, 1)
	}
}

//todo: add sum shi like this for megafast bullets
var prevhit14 = instance_place(x + (prevVector[0] - x)*0.25, y, obj_wall)
var prevhit24 = instance_place(x + (prevVector[0] - x)*0.50, y, obj_wall)
var prevhit34 = instance_place(x + (prevVector[0] - x)*0.75, y, obj_wall)



if (hit < 0){
	if (hit == 1){
		print("yes!");
		var hitWall = ds_list_find_index(hitList,0);
		// Get the block's boundaries
		var block_left = hitWall.bbox_left;
		var block_right = hitWall.bbox_right;
		var block_top = hitWall.bbox_top;
		var block_bottom = hitWall.bbox_bottom;
	
	
		var xDifferenceLeft = x+newCoords[0] - block_left
		var xDifferenceRight = x+newCoords[0] - block_right
		var yDifferenceTop = y+newCoords[1] - block_top;
		var yDifferenceBottom = y+newCoords[1] - block_bottom;
		var smallest = min(abs(xDifferenceLeft),abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom));
		if (smallest = abs(xDifferenceLeft)) {
			latestWallHit = 2;
			print("left");
			movementVector[0] = -movementVector[0]
			movementVector[1] = movementVector[1]
		}else if (smallest = abs(xDifferenceRight)){
			latestWallHit = 0;
			print("right");
			movementVector[0] = -movementVector[0]
			movementVector[1] = movementVector[1]
		}else if (smallest = abs(yDifferenceTop)) {
			latestWallHit = 1;
			print("top");
			movementVector[0] = movementVector[0]
			movementVector[1] = -movementVector[1]
		}else if (smallest = abs(yDifferenceBottom)){
			latestWallHit = 3;
			print("bot");
			movementVector[0] = movementVector[0]
			movementVector[1] = -movementVector[1]
		}
		fireCoords = [x,y];
	
		lastWallStruck = hitWall;
		if (timeSinceBounce > 9){
			maxBounce--
		}
		timeSinceBounce = 0
	}else{
		print("naurrr");
		movementVector[0] = -movementVector[0]
		movementVector[1] = -movementVector[1]
		if (timeSinceBounce > 9){
			maxBounce--
		}
		timeSinceBounce = 0
	}
}
image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

prevVector[0] = x
prevVector[1] = y
x = x + movementX();
y = y + movementY();
newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
				lengthdir_y(sprite_height - sprite_yoffset, image_angle)]


if (maxBounce <= 0){
	parent.activeBullets = parent.activeBullets - 1
	instance_destroy();
}


