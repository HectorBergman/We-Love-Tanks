openItems = [];

totalWidth = sprite_width+paddingNeeded+5;
visible = false;
image_xscale = totalWidth/sprite_width;
opened = false;

function open(){
	for (var i = 0; i < array_length(items); i++){
		openItems[i] = summonObject(obj_roomEditor_dropdown, 
		[["last", i == array_length(items)-1], ["value", items[i]], ["x", x], 
		["y", y+sprite_height+(sprite_height-2)*i], ["parent", id], ["image_xscale", image_xscale], ["depth", depth+1]])
	}
	opened = true;
}


function close(returnValue){
	for (var i = 0; i < array_length(openItems); i++){
		instance_destroy(openItems[i]);
	}
	
	parent.openDropDown = noone;
	opened = false;
}

function changeInstanceVal(newVal){

	if !specil{
		parent.parent.instanceInfo[index][1] = newVal;
	}else{
		parent.ownEditable[index][1] = newVal;
	}
}
