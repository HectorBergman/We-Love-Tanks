
enum collide_type{
	hard,
	soft,
	none,//always last!!!
}
function player_handleWallCollision(){
	var collideTypes_list = [[obj_wall, obj_wall_breakable, obj_enemy, obj_wall_forgetmenot, obj_lock], 
							 [obj_wall_breakable_bits]]
	var collideTypes_list_full = [obj_impassable, obj_enemy, obj_frail]
	var moveX_list = ds_list_create()
	instance_place_list(x + horizontalMoveSpeed, y, collideTypes_list_full, moveX_list, false)
	var lenX = ds_list_size(moveX_list)
	
	
	for (var i = 0; i < lenX; i++){
		var moveX = ds_list_find_value(moveX_list,0)
		var type = collideType_find(moveX, collideTypes_list);
		if player_collision(type, moveX, collideTypes_list, false){break}
	}
	var moveY_list = ds_list_create()
	instance_place_list(x, y + verticalMoveSpeed, collideTypes_list_full, moveY_list, false)
	var lenY = ds_list_size(moveY_list)
	
	for (var i = 0; i < lenY; i++){
		var moveY = ds_list_find_value(moveY_list,0)
		var type = collideType_find(moveY, collideTypes_list);
		if player_collision(type, moveY, collideTypes_list, true){break}
	}
	ds_list_destroy(moveX_list)
	ds_list_destroy(moveY_list)
	
}

function collideType_find(instance, list){
	var type = collide_type.none
	if array_contains(list[0], instance.object_index){
		type = collide_type.hard
	}else if array_contains(list[1], instance.object_index){
		type = collide_type.soft
	}
	return type;
}

function player_collision(type, collision_instance, collideTypes_list, isYMovement){
	switch (type){
		case collide_type.none: return false;
			
		case collide_type.hard:{
			if (collision_instance.collideable && !gothruwalls){
				var _step = sign(horizontalMoveSpeed*!isYMovement + verticalMoveSpeed*isYMovement);
				stepCollisionWhileWithFailCon(collideTypes_list[type], _step, true)
				switch isYMovement{
					case false:{
						if abs(horizontalMoveSpeed) > 0.5{
							horizontalMoveSpeed *= -0.7
							wallBonkCooldown = wallBonkCooldownTime;
						}else{
							horizontalMoveSpeed = 0
						}
					}break;
					case true:{
						if abs(verticalMoveSpeed) > 0.5{
							verticalMoveSpeed *= -0.7
							wallBonkCooldown = wallBonkCooldownTime;
						}else{
							verticalMoveSpeed = 0
						}
					}break;
				}
			}
		}break;
		
		case collide_type.soft:{
			if (collision_instance.collideable && !gothruwalls){
				instance_destroy(collision_instance)
				switch isYMovement{
					case false:{
						horizontalMoveSpeed *= 0.7
					}break;
					case true:{
						verticalMoveSpeed *= 0.7
					}break;
				}
			}
		}break;
	}
	return true
}