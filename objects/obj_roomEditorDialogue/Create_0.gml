originalMask = mask_index;
dropDownArray = [];
openDropDown = noone;
text = [];
toDraw = [];
largestWidth = 0;
for (var i = 0; i < array_length(editable); i++){
	text[i] = "[$eee7e7][scale,1][fnt_coolFont]" + editable[i][0]; 
	toDraw[i] = scribble(text[i])
	print(toDraw[i])
	if toDraw[i].get_width() > largestWidth{
		largestWidth = toDraw[i].get_width();
	}
}


for (var i = 0; i < array_length(editable); i++){
	if editable[i][1] != "checkbox"{
		dropDownArray[array_length(dropDownArray)] = 
		summonObject(obj_roomEditor_dropdown_click, [["xoffset", 20+largestWidth], ["yoffset", 20*(i+0.5)], 
													["parent", id], ["items",editable[i][1]],
													["depth", depth-1]])
	}
}

totalWidth = largestWidth+20+10+sprite_get_width(object_get_sprite(obj_roomEditor_dropdown_click))+5;

image_xscale = totalWidth/sprite_width;


function openNewDropDown(newDropDown){
	if openDropDown != noone{
		openDropDown.close();
	}
	openDropDown = newDropDown
	openDropDown.open();
}