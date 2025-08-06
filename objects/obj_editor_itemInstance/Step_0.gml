switch (held){
	case true:{
		var rounded_x = ceil((mouse_x+heldOffset[0])/16)*16;
		var rounded_y = ceil((mouse_y+heldOffset[1])/16)*16;
		x = rounded_x;
		y = rounded_y;
	}break;
	case false:{
	}break;
}
if highlight != noone{
	if obj_inputHandler.copy{
		SignalSend("itemInstance: unhighlight");
		print("a copy of a copy of a copy");
		var iAC = [];
		var hOffset = [];
		array_copy(iAC, 0, instanceArgumentsChoices, 0, array_length(instanceArgumentsChoices))
		array_copy(hOffset, 0, heldOffset, 0, array_length(heldOffset))
		var summonStruct = [
			["sprite_index", sprite_index], 
			["heldOffset", hOffset], 
			["depth", depth], 
			["canResize", canResize], 
			["x", clamp(x + 32, 0, room_width)], 
			["y", clamp(y + 32, 0, room_height)],
			["image_xscale", image_xscale], 
			["image_yscale", image_yscale], 
			["held", false], 
			["instanceArgumentsChoices", iAC]
		]
		addObjectVariablesToSummonStruct(summonStruct, false);
		var obj = summonObject(obj_editor_itemInstance, summonStruct);
		with obj{
			dropped();
		}
		dropped();
	}
}