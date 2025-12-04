function create_helicopter(){
	sprite_index = spr_helicopter
	states_heli = createStates("normal", "relocate");
	state_heli = states_heli.normal;
	
	states_heli_normal = createStates("normal", "dodge");
	state_heli_normal = states_heli_normal.normal;
	
	dir = random_range(0,360);
	movementVector = [lengthdir_x(1,dir),lengthdir_y(1,dir)]
	velocity = 3;
	timer_randomNoise = 0;

	freq_x = 0.04;
	freq_y = 0.02;

	amp_x  = 3;
	amp_y  = 4;
	dodgeDiff = [0,0]
	
	dodgeSpeed = 3;
	moveSpeed_max = 3;
	moveSpeed = 0
	goalCoords = [x,y]
	homeCoords = [irandom_range(50,room_width-50), irandom_range(25,room_height-25)]
	diff = [0,0];
	
	angle = 0;
	
	enum movementStates_heli{
		normal,
		slowing,
		stopped,
	}
	movementState_x = movementStates_heli.normal;
	movementState_y = movementStates_heli.normal;
}
function step_helicopter(){
	exeStateFunc("helicopter_",state_heli);
}

function helicopter_normal(){
	hitbox.image_angle = point_direction(x,y,obj_player.x,obj_player.y);
	timer_randomNoise += ts
	define_movementState()
	//noise_x = amp_x * (sin(freq_x * timer_randomNoise) + sin(pi * freq_x * 0.5 * timer_randomNoise));
	//noise_y = amp_y * (sin(freq_y * timer_randomNoise) + sin(pi * freq_y * 0.5 * timer_randomNoise));
	exeStateFunc("helicopter_normal_",state_heli_normal);
	
	print("goalcoords: ", goalCoords);
	print("angle: ", angle);

	if abs(diff[0]) > moveSpeed {
		x = x + lengthdir_x(moveSpeed, angle)
	}else{
		x = goalCoords[0]
	}
	
	if abs(diff[1]) > moveSpeed {
		y = y + lengthdir_y(moveSpeed, angle)
	}else{
		y = goalCoords[1]
	}
	
}

function helicopter_normal_normal(){
	
	goalCoords = [homeCoords[0], homeCoords[1]]
	
	var bullet = findNearestBullet()
	if !is_undefined(bullet){
		print("bullet found: ", bullet)
		state_heli_normal = states_heli_normal.dodge	
	}
	diff = [goalCoords[0] - x, goalCoords[1] - y]
	angle = (point_direction(x, y, x + diff[0], y + diff[1]) - 180) mod 360;

}

function define_movementState(){
	var movementState_xy = [movementState_x, movementState_y]
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
	
	
	for (var i = 0; i < 2; i++){
		switch (movementState_xy[i]){
			case movementStates_heli.normal:{
					
				var diff = moveSpeed_max*movementVector[i]-moveSpeed
				if sign(moveSpeed) != sign(movementVector[i]) ||
					abs(moveSpeed) < abs(moveSpeed_max*movementVector[i]){
					moveSpeed += 0.1*movementVector[i]*sqrt(abs(diff))
				}
					
			}break;
			case movementStates_heli.slowing:{
				if (abs(moveSpeed) < 1.0) {
			        moveSpeed *= 0.8; 
			    } else {
			        moveSpeed *= 0.95;
			    }
			}break;
			case movementStates_heli.stopped:{
				//x = goalCoords[0];
				//y = goalCoords[1];
				moveSpeed = 0;
			}
		}
	}
}

function helicopter_normal_dodge(){
	var bullet = findNearestBullet()
	if is_undefined(bullet){
		state_heli_normal = states_heli_normal.normal
		return;
	}

	angle = point_direction(x, y, bullet.x, bullet.y)
	var vector = [lengthdir_x(1, angle), lengthdir_y(1, angle)]
	goalCoords = [x + vector[0] * 1000, y + vector[1] * 1000]
	diff = [goalCoords[0] - x, goalCoords[1] - y]


}

function findNearestBullet(radius = 100){
	var list = ds_list_create();
	collision_circle_list(x, y, radius, obj_bullet_player, false, true, list, true);
	var bullet = ds_list_find_value(list,0)
	ds_list_destroy(list)
	return bullet;
}