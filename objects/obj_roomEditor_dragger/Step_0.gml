x = mouse_x
y = mouse_y;

if mouse_check_button(mb_left){
	image_index = 1;
	var instance = instance_place(x,y,obj_roomEditor_dragable);
	if held == noone && instance != noone{
		print(global.potentialObjects[$ instance._name].object);
		held = summonObject(obj_roomEditor_instanceRep,[["x", instance.x], ["y", instance.y], ["object", global.potentialObjects[$ instance._name].object], ["depth", depth+1],["editable",global.potentialObjects[$ instance._name].editable]]);
	}else{
		var instance_rep = instance_place(x,y,obj_roomEditor_instanceRep);
		
		if held == noone && instance_rep != noone{
			held = instance_rep;
			instance_rep.held = true;
			prevDepth = instance_rep.depth;
			instance_rep.depth = depth+1
		}
	}
}else{
	if held != noone{
		held.drop();
		held.depth = prevDepth;
		held = noone;
	}
	image_index = 0;
}