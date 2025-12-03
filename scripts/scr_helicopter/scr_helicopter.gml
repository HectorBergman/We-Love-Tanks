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
	chosenCoordinates = [irandom_range(50,room_width-50), irandom_range(25,room_height-25)]
	freq_x = 0.04;
	freq_y = 0.02;

	amp_x  = 3;
	amp_y  = 4;
	dodgeDiff = [0,0]
	
	dodgeSpeed = 3;
	moveSpeed = 3
}
function step_helicopter(){
	exeStateFunc("helicopter_",state_heli);
}

function helicopter_normal(){
	hitbox.image_angle = point_direction(x,y,obj_player.x,obj_player.y);
	timer_randomNoise += ts
	
	noise_x = amp_x * (sin(freq_x * timer_randomNoise) + sin(pi * freq_x * 0.5 * timer_randomNoise));
	noise_y = amp_y * (sin(freq_y * timer_randomNoise) + sin(pi * freq_y * 0.5 * timer_randomNoise));
	exeStateFunc("helicopter_normal_",state_heli_normal);
	
	
}

function helicopter_normal_normal(){
	var goal_x = (chosenCoordinates[0] + noise_x)
	var goal_y = (chosenCoordinates[1] + noise_y)
	var x_diff = goal_x - x
	var y_diff = goal_y - y
	var angle = point_direction(x, y, x + x_diff, y + y_diff);
	

	if abs(x_diff) > moveSpeed {
		x = x + lengthdir_x(moveSpeed, angle)
	}else{
		x = goal_x
	}
	
	if abs(y_diff) > moveSpeed {
		y = y + lengthdir_y(moveSpeed, angle)
	}else{
		y = goal_y
	}
	
	
	
	var bullet = findNearestBullet()
	if !is_undefined(bullet){
		print("bullet found: ", bullet)
		state_heli_normal = states_heli_normal.dodge	
	}
}

function helicopter_normal_dodge(){
	var bullet = findNearestBullet()
	if is_undefined(bullet){
		state_heli_normal = states_heli_normal.normal
		dodgeDiff = [0,0]
		return
	}
	var angle = (point_direction(x, y, bullet.x, bullet.y) - 180) mod 360
	var vector = [lengthdir_x(1, angle), lengthdir_y(1, angle)]
	
	dodgeDiff = [dodgeDiff[0] + vector[0] * dodgeSpeed, dodgeDiff[1] + vector[1] * dodgeSpeed]
	
	x = chosenCoordinates[0] + noise_x + dodgeDiff[0]
	y = chosenCoordinates[1] + noise_y + dodgeDiff[1]
}

function findNearestBullet(radius = 100){
	var list = ds_list_create();
	collision_circle_list(x, y, radius, obj_bullet_player, false, true, list, true);
	var bullet = ds_list_find_value(list,0)
	ds_list_destroy(list)
	return bullet;
}