if point_distance(obj_player.x, 0, obj_crosshair.x, 0) > minDistForLerpX{
	x = obj_player.x + (lerp(obj_player.x,obj_crosshair.x,pointerBodyRatio) 
	  - obj_player.x+sign(obj_player.x-obj_crosshair.x)*(minDistForLerpX*pointerBodyRatio))
}else{
	x = obj_player.x
}

if point_distance(0, obj_player.y, 0, obj_crosshair.y) > minDistForLerpY{
	
	y = obj_player.y + (lerp(obj_player.y,obj_crosshair.y,pointerBodyRatio) 
	  - obj_player.y+sign(obj_player.y-obj_crosshair.y)*(minDistForLerpY*pointerBodyRatio))
}else{

	y = obj_player.y
}

var newX = clamp(x-(camWidth*0.5),0,room_width-(camWidth));
print(newX);
var newY = clamp(y-(camHeight*0.5),0,room_height-(camHeight));


camera_set_view_pos(view_camera[0],newX,newY);