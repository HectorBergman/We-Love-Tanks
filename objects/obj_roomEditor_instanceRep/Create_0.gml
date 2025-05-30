sprite_index = object_get_sprite(object);
offset = [x-mouse_x,y-mouse_y];
held = true;
print(sprite_index);
ownEditable = [];
justDropped = 0;
for (var i = 0; i < array_length(editable); i++){
	ownEditable[i] = [];
	if editable[i][1] != "checkbox"{
		ownEditable[i][0] = editable[i][0]; 
		ownEditable[i][1] = editable[i][2];
	}else{
	}
}
openDialogue = false;
function drop(){
	held = false;
	justDropped = 2;
	
}

dialogue = summonObject(obj_roomEditorDialogue, [["visible", false], ["parent", id], ["editable", editable]]);