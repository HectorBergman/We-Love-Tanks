x = mouse_x
y = mouse_y;
//all this code sucks lol i should have used states
if mouse_check_button(mb_left){
	image_index = 1;
}else{
	image_index = 0;
}
switch (state){
	case draggerState.enlargeningCorner:{
		if !mouse_check_button(mb_left){
			grabbedCorner.grabbed = false;
			grabbedCorner = noone;
			state = draggerState.none;
		}else{
			
		}
	}break;
	case draggerState.grabbingInstance:{
		if !mouse_check_button(mb_left){
			held.drop();
			held.depth = prevDepth;
			held = noone;
			state = draggerState.none;
		}else{
		}
	}break;
	case draggerState.none:{
		var firstgrab = instance_place(x,y,obj_roomEditor_instanceRep_highlightCorners);
		var highlight = instance_place(x,y,[obj_roomEditor_instanceRep,obj_roomEditor_dragable]);
		if mouse_check_button(mb_left){
			if firstgrab != noone{
				grabbedCorner = firstgrab;
				grabbedCorner.grabbed = true;
				grabbedCorner.origin = [ceil(x*16)/16,ceil(y*16)/16];
				
				state = draggerState.enlargeningCorner;
			}else if highlight != noone{
				if highlight.object_index == obj_roomEditor_dragable{
					held = summonObject(obj_roomEditor_instanceRep,[["x", highlight.x], ["y", highlight.y], ["object", global.potentialObjects[$ highlight._name].object], ["depth", depth+1],["editable",global.potentialObjects[$ highlight._name].editable]]);
				}else{
					held = highlight
					held.offset = [held.x-mouse_x,held.y-mouse_y];
				}
				if highlighted != noone && instance_exists(highlighted){
					highlighted.selected = false;
					highlighted.destroyCorners();
				}
				if held != highlighted{
					held.selected = true;
			
					held.createCorners();
					highlighted = held;
				}
				held.held = true;
				prevDepth = held.depth;
				held.depth = depth+1
				state = draggerState.grabbingInstance;
				
			}
		}
	}break;
}







