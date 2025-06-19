sprite_index = object_get_sprite(object);
offset = [x-mouse_x,y-mouse_y];
held = false;

justDropped = 0;
selected = false;

corners = [noone,noone,noone,noone]
if array_length(ownEditable) == 0{
	for (var i = 0; i < array_length(editable); i++){
		ownEditable[i] = [];
		if editable[i][1] != "checkbox"{
			ownEditable[i][0] = editable[i][0]; 
			ownEditable[i][1] = editable[i][1][0];
		}else{
			ownEditable[i][0] = editable[i][0]; 
			ownEditable[i][1] = false;
		}
	}
}

openDialogue = false;
function drop(){
	held = false;
	justDropped = 2;
	depth = truDepth;
}
function destroyCorners(){
	for (var i = 0; i < 4; i++){
		instance_destroy(corners[i]);
		corners[i] = noone;
	}
}
function createCorners(){
	for (var i = 0; i < 4; i++){
		var xscale = 1;
		var yscale = 1;
		if i == 1{
			xscale = -1;
		}
		if i == 2{
			xscale = -1;
			yscale = -1;
		}
		if i == 3{
			yscale = -1;
		}
		corners[i] = summonObject(obj_roomEditor_instanceRep_highlightCorners, [["x", x+sprite_width/2] ,["y", y+sprite_height/2], ["xscale", xscale], ["yscale", yscale], ["index",i], ["depth", depth-1], ["parent", id]])
	}
}

dialogue = summonObject(obj_roomEditorDialogue, [["visible", false], ["parent", id], ["editable", editable], ["ownEditable", ownEditable]]);