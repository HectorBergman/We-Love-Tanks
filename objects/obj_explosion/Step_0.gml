PAUSE
lifespan -= ts

collision_circle_list(x,y,
	radius,
	allObjects, 
	true, true, 
	collision_list, 
	false
)

switch (explosionState){
	case explosionStates.beginning:{
		
		if lifespan <= beginningLifespan{
			explosionState = explosionStates.ending;
		}
		if !ds_list_empty(collision_list){
			print("notempty");
			var _listSize = ds_list_size(collision_list);
			print(_listSize);
			for (var i = 0; i < _listSize; i++){
				collide(ds_list_find_value(collision_list, 0));
				ds_list_delete(collision_list,0);
			}
		}
	}break;
	case explosionStates.ending:{
		
		if lifespan <= 0{
			instance_destroy();
		}
		
	}break;
}
if ds_exists(collision_list,ds_type_list){
	ds_list_clear(collision_list)
}
