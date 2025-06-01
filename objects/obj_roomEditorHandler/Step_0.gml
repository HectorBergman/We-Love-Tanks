if obj_inputHandler.escape{
	if global.editorPause{
		obj_gameSettingHandler.gameState = gameStates.editorTesting
		global.editorPause = false;
		for (var i = 0; i < instance_number(obj_roomEditor_instanceRep); i++){
			var instanceRep = instance_find(obj_roomEditor_instanceRep, i);
			summonObjectArray = [];
			var len = array_length(instanceRep.ownEditable)
			array_copy(summonObjectArray,0,instanceRep.ownEditable,0,len)
			
			summonObjectArray[len] = ["x", instanceRep.x]
			summonObjectArray[len+1] = ["y", instanceRep.y]
			summonObjectArray[len+2] = ["image_xscale", instanceRep.image_xscale]
			summonObjectArray[len+3] = ["image_yscale", instanceRep.image_yscale]
			print(summonObjectArray);
			print(instanceRep.ownEditable);
			print(instanceRep.object);
			print("pen15");
			var realBoy = summonObject(asset_get_index(instanceRep.object), summonObjectArray);
			print(instanceRep);
			print(asset_get_index(instanceRep.object));
			print(realBoy);
			ds_list_add(instanceRepRealBoyList, realBoy);
		}
	}else{
		obj_gameSettingHandler.gameState = gameStates.editorBuilding
		global.editorPause = true;
		for (var i = 0; i < ds_list_size(instanceRepRealBoyList); i++){
			var inst = ds_list_find_value(instanceRepRealBoyList,0)
			instance_destroy(inst);
			ds_list_delete(instanceRepRealBoyList,0);
		}
		instance_destroy(obj_bullet);
		instance_destroy(obj_enemy)
		instance_destroy(obj_enemy_cannon);
		instance_destroy(obj_enemy_hitbox);
	}
}

if !global.editorPause{
	print("fugeXD");
}