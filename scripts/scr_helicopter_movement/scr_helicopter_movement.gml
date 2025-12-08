
function helicopter_basic(){
	hitbox.image_angle = point_direction(x,y,obj_player.x,obj_player.y);
	timer_randomNoise += ts
	noise[0] = amp[0] * (sin(freq[0] * timer_randomNoise) + sin(pi * freq[0] * 0.5 * timer_randomNoise));
	noise[1] = amp[1] * (sin(freq[1] * timer_randomNoise) + sin(pi * freq[1] * 0.5 * timer_randomNoise));
	define_movementState()

	exeStateFunc("helicopter_normal_",state_heli_movement);
	

	if abs(diff[0]) > moveSpeed[0] {
		coords[0] = coords[0] + moveSpeed[0]
	}else{
		coords[0] = goalCoords[0]
	}
	
	if abs(diff[1]) > moveSpeed[1] {
		coords[1] = coords[1] + moveSpeed[1]
	}else{
		coords[1] = goalCoords[1]
	}
	
	x = coords[0] + noise[0]
	y = coords[1] + noise[1]

}

function helicopter_normal(){
	
	if point_distance(x,y,obj_player.x,obj_player.y) < 100{
		state_heli = states_heli.relocate
		while point_distance(x,y,homeCoords[0],homeCoords[1]) < 200{
			homeCoords = [irandom_range(100,room_width-100), irandom_range(50,room_height-50)]
		}
	}
}
function helicopter_relocate(){
	
	if point_distance(x,y,homeCoords[0],homeCoords[1]) < 10{
		state_heli = states_heli.normal
	}
}

function helicopter_normal_normal(){
	
	goalCoords = [homeCoords[0], homeCoords[1]]
	
	var bullet = findNearestBullet()
	if !is_undefined(bullet){
		targetBullet = bullet;
		print("bullet found: ", bullet)
		state_heli_movement = states_heli_movement.dodge
		var test = [room_width/2, room_height/2]
		var closestPoint = closestPointOfLine(bullet)
		
		var counterClockwise = point_direction(0, 0, -bullet.movementVector[1], bullet.movementVector[0])
		var clockwise = point_direction(0, 0, bullet.movementVector[1], -bullet.movementVector[0])
		
		var lol1 = point_distance(x + -bullet.movementVector[1], 
								  y + bullet.movementVector[0],
								  closestPoint[0], closestPoint[1]
		)
		var lol2 = point_distance(x + bullet.movementVector[1], 
								  y + -bullet.movementVector[0],
								  closestPoint[0], closestPoint[1]
		)
		if lol1 < lol2{
			angle = counterClockwise
		}else{
			angle = clockwise
		}
		diff = [goalCoords[0] - x, goalCoords[1] - y]
		return;
	}
	diff = [goalCoords[0] - x, goalCoords[1] - y]
	angle = (point_direction(x, y, x + diff[0], y + diff[1])) mod 360;
	print(angle)

}

function define_movementState(){
	var movementState_xy = [movementState_x, movementState_y]
	var _angle = point_direction(x,y,goalCoords[0],goalCoords[1])
	movementVector = [lengthdir_x(1,_angle), lengthdir_y(1,_angle)]
	print("goalCoords: ", goalCoords);
	print("trucoords: ", [x,y]);
	for (var i = 0; i < 2; i++){
		if point_distance(x * (i == 0), y * (i == 1), 
						  goalCoords[0] * (i == 0), goalCoords[1] * (i == 1)) < 1{
			movementState_xy[i] = movementStates_heli.stopped;
			print("stopped");
		}else if point_distance(x * (i == 0), y * (i == 1), 
							    goalCoords[0] * (i == 0), goalCoords[1] * (i == 1)) < 20{
			movementState_xy[i] = movementStates_heli.slowing;
			print("slowing")
		}else{
			movementState_xy[i] = movementStates_heli.normal;
			print("normal");
		}
	}
	
	var mI = variable_struct_get(moveInfo, state_heli_movement);
	for (var i = 0; i < 2; i++){
		switch (movementState_xy[i]){
			case movementStates_heli.normal:{
					
				var diff = mI.moveSpeed_max*movementVector[i] - moveSpeed[i]
				if sign(moveSpeed[i]) != sign(movementVector[i]) ||
					abs(moveSpeed[i]) < abs(mI.moveSpeed_max*movementVector[i]){
					print("isY : ", i, " movementVector[i]: ", movementVector[i]);
					moveSpeed[i] += mI.acceleration*movementVector[i]*sqrt(abs(diff))*ts
				}
					
			}break;
			case movementStates_heli.slowing:{
				if (abs(moveSpeed[i]) < 1.0) {
			        moveSpeed[i] *= mI.decceleration2*ts; 
			    } else {
			        moveSpeed[i] *= mI.decceleration1*ts;
			    }
			}break;
			case movementStates_heli.stopped:{

				moveSpeed[i] = 0;
			}
		}
	}
}

function helicopter_normal_dodge(){
	print("dodge");
	var bullet = findNearestBullet()
	if is_undefined(bullet){
		state_heli_movement = states_heli_movement.normal
		return;
	}else if bullet != targetBullet{
		angle = (point_direction(x, y, bullet.x, bullet.y) - 90) mod 360
	}

	
	var vector = [lengthdir_x(1, angle), lengthdir_y(1, angle)]
	goalCoords = [x + vector[0] * 1000, y + vector[1] * 1000]

	diff = [goalCoords[0] - x, goalCoords[1] - y]


}


function findNearestBullet(radius = 90){
	var list = ds_list_create();
	collision_circle_list(x, y, radius, obj_bullet_player, false, true, list, true);
	var bullet = ds_list_find_value(list,0)
	ds_list_destroy(list)
	return bullet;
}

function closestPointOfLine(bullet){
	var diff = [x - bullet.x, y - bullet.y];

	// dot products
	var dot_wv = diff[0]*bullet.movementVector[0] + diff[1]*bullet.movementVector[1];
	var dot_vv = bullet.movementVector[0]*bullet.movementVector[0] + 
				 bullet.movementVector[1]*bullet.movementVector[1];

	var t = dot_wv / dot_vv;

	// closest point
	var closest = [
	    bullet.x + diff[0] * t,
	    bullet.y + diff[1] * t
	];
	
	return closest;
}