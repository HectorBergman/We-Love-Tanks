originalMask = mask_index;
dropDownArray = [];
openDropDown = noone;
text = [];
toDraw = [];
largestWidth = 0;
editable= [["roomName", [""]], ["type", global.roomTypes], ["difficulty", [""]]];
ownEditable = [["roomName", ""], ["type", "standard"], ["difficulty", ""]]
/*"roomName": "rm_room_test",
   "type": "standard",
   "difficulty": "1"
  */
  spriteWidth = sprite_width;

var longestLongest = noone;
longestLongestLength = 0;
var _text = "";
var _toDraw = 0;
var _length = 0;
for (var i = 0; i < array_length(editable); i++){
	if editable[i][1][0]!= ""{
		var longest = noone;
		var longestLength = 0;
		var str = "";
		for (var j = 0; j < array_length(editable[i][1]); j++;){
			str = editable[i][1][j];
			
			_text = "[$eee7e7][scale,1][fnt_coolFont]" + str; 
			_toDraw = scribble(_text)
			_length = _toDraw.get_width();
			
			if _length > longestLength{
				longest = str;
				longestLength = _length;
			}
		}
		if longestLength > longestLongestLength{
			longestLongestLength = longestLength
			longestLongest = longest;
		}

	}
}

for (var i = 0; i < array_length(editable); i++){
	if editable[i][0] != ""{
		text[i] = "[$eee7e7][scale,1][fnt_coolFont]" + editable[i][0]; 
		toDraw[i] = scribble(text[i])
		if toDraw[i].get_width() > largestWidth{
			largestWidth = toDraw[i].get_width();
		}
	}else if editable[i][0] == ""{
		text[i] = "[$eee7e7][scale,1][fnt_coolFont]" + ownEditable[i]; 
		toDraw[i] = scribble(text[i])
		if toDraw[i].get_width() > largestWidth{
			largestWidth = toDraw[i].get_width();
		}
	}
}
for (var i = 0; i < array_length(editable); i++){

	if editable[i][1][0] != ""{
		dropDownArray[array_length(dropDownArray)] = 
		summonObject(obj_roomEditor_dropdown_click, [["xoffset", 20+largestWidth], ["yoffset", 20*(i+0.5)], 
													["parent", id], ["items",editable[i][1]], ["index", i],
													["depth", depth-1], ["paddingNeeded", longestLongestLength], ["specil", true]])
	}else{
		dropDownArray[array_length(dropDownArray)] = 
		summonObject(obj_roomEditor_dropdown_type, [["xoffset", 20+largestWidth], ["yoffset", 20*(i+0.5)], 
												["parent", id], ["items",editable[i][1]], ["index", i],
												["depth", depth-1], ["paddingNeeded", longestLongestLength]])
	}
}
summonObject(obj_roomEditorDialogue_prompt_confirm, 
[["parent", id], ["xoffset", 20+largestWidth], ["paddingNeeded", longestLongestLength],
["yoffset", sprite_height-40]]);



totalWidth = largestWidth+20+10+sprite_get_width(object_get_sprite(obj_roomEditor_dropdown_click))+5;

function saveRoom(){
	obj_roomEditorHandler.saveRoom(ownEditable[0][1],ownEditable[1][1],ownEditable[2][1]);
}




function openNewDropDown(newDropDown){
	if openDropDown != noone{
		openDropDown.close();
	}
	openDropDown = newDropDown
	openDropDown.open();
}