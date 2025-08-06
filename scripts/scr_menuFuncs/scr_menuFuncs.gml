function offsetCoordsFromParents(parent,offset){
	x = parent.x + offset[0];
	y = parent.y + offset[1];
}

function toggleMenu(){
	if menu == noone{
		openMenu();
	}else{
		closeMenu();
	}
}

function openMenu(){
	menu = summonObject(obj_editor_instanceMenu, [["coordsOffset", [sprite_width+menuOffset[0],menuOffset[1]]], 
	["depth", depth-1], ["instanceId", id],
	["instanceArgumentsChoices", instanceArgumentsChoices],
	["objectArguments", objectArguments]]);
	
}
function closeMenu(){
	with menu{
		close()
	}
}

function updateInstanceArgumentChoices(argumentType,instanceIndex,choiceInfo){
	switch (argumentType){
		case argumentTypes.options:{ //choiceInfo is the number of the argument
			instanceArgumentsChoices[instanceIndex] = objectArguments[instanceIndex].argumentChoices[choiceInfo];
		}break;
		case argumentTypes.checkbox:{ //choiceInfo ignored
			print("letsgo");
			instanceArgumentsChoices[instanceIndex] = !instanceArgumentsChoices[instanceIndex];
		}break;
		case argumentTypes.freetext:{ //choiceInfo is free text
			instanceArgumentsChoices[instanceIndex] = choiceInfo;
		}break;
	}
	
}
