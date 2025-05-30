x = mouse_x
y = mouse_y;
//all this code sucks lol i should have used states

switch (state){
	case draggerState.enlargeningCorner:{
	}break;
	case draggerState.grabbingInstance:{}break;
	case draggerState.highlighting:{}break;
	case draggerState.none:{
	
	}break;
}


var firstgrab = instance_place(x,y,obj_roomEditor_instanceRep_highlightCorners);
	var highlight = instance_place(x,y,obj_roomEditor_instanceRep);

if firstgrab != noone && mouse_check_button(mb_left){
	if firstgrab != noone && firstgrab != grabbedCorner{
		if grabbedCorner != noone{
				
		}
		firstgrab.grabbed = true;
		firstgrab.origin = [ceil(x*16)/16,ceil(y*16)/16];
		grabbedCorner = firstgrab;
	}
}else{
	if grabbedCorner != noone && instance_exists(grabbedCorner){
		grabbedCorner.grabbed = false;
		grabbedCorner = noone;
	}
	if mouse_check_button_pressed(mb_left) && held == noone{
		if highlight != noone && highlight != highlighted{
			highlight.selected = true;
			if highlighted != noone && instance_exists(highlighted){
				highlighted.selected = false;
				highlighted.destroyCorners();
			}
			highlight.createCorners();
			highlighted = highlight;
		}
	}
}
if mouse_check_button(mb_left){
	image_index = 1;
	var instance = instance_place(x,y,obj_roomEditor_dragable);
	if held == noone && instance != noone{
		held = summonObject(obj_roomEditor_instanceRep,[["x", instance.x], ["y", instance.y], ["object", global.potentialObjects[$ instance._name].object], ["depth", depth+1],["editable",global.potentialObjects[$ instance._name].editable]]);
	}else{
		var instance_rep = instance_place(x,y,obj_roomEditor_instanceRep);
		
		if held == noone && instance_rep != noone && firstgrab == noone{
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
