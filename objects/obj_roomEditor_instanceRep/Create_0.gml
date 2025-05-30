sprite_index = object_get_sprite(object);
offset = [x-mouse_x,y-mouse_y];
held = true;
print(sprite_index);

openDialogue = false;
function drop(){
	held = false;
	
}

dialogue = summonObject(obj_roomEditorDialogue, [["visible", false], ["parent", id]]);