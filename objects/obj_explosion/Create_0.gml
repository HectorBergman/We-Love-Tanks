pauseMode = allPause;
enum explosionStates{
	beginning,
	ending,
}
explosionState = explosionStates.beginning

beginningLifespan = lifespan*0.2
 
image_xscale = radius/32
image_yscale = radius/32

collision_list = ds_list_create()
ignore_array = [];

enum bomb_collisions {
    walls,
    enemies,
	player
}

objIndex_types = [
    [obj_wall_breakable, obj_wall_breakable_bits],
    [obj_enemy_hitbox, obj_boss_hitbox],
	[obj_player_hitbox]
];
allObjects = []

for (var i = 0; i < array_length(objIndex_types); i++){
	allObjects = array_concat(allObjects, objIndex_types[i]);
}

print(allObjects);

isPlayer = object_index == obj_explosion_player

/// @function bomb_get_collision_type(obj_index)
/// @return bomb_collisions enum value

function bomb_get_collision_type(obj_index) {
    for (var i = 0; i < array_length(objIndex_types); i++) {
        var arr = objIndex_types[i];

        // Check if obj_index is in this group
        if (array_contains(arr, obj_index)) {
            return i; // This matches the enum order
        }
    }

    // Optional: default if not found
    return -1;
}
function collide(collideEntity){
	if array_contains(ignore_array, collideEntity){
		return;
	}
	var objIndex = collideEntity.object_index
	var collType = bomb_get_collision_type(objIndex)
	switch (collType){
		case (bomb_collisions.walls):{
			SignalSend("bomb_found: " + string(collideEntity));
		}break;
		case(bomb_collisions.enemies):{
			print("decreasingHealth");
			var dmg = damage;
			with collideEntity.parent{
				decreaseHealth(dmg);
			}
		}break;
		case(bomb_collisions.player):{
			var dmg = 2;
			with collideEntity.parent{
				decreaseHealth(dmg);
			}
		}break;
	}
	array_insert(ignore_array, array_length(ignore_array), collideEntity)
}

