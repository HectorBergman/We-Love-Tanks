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

var longestLongest = noone;
longestLongestLength = 0;
var _text = "";
var _toDraw = 0;
var _length = 0;
for (var i = 0; i < array_length(editable); i++){
	if editable[i][1] != "checkbox"{
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
	if editable[i][1] != "checkbox"{
		dropDownArray[array_length(dropDownArray)] = 
		summonObject(obj_roomEditor_dropdown_click, [["xoffset", 20+largestWidth], ["yoffset", 20*(i+0.5)], 
													["parent", id], ["items",editable[i][1]], ["index", i],
													["depth", depth-1], ["paddingNeeded", longestLongestLength]])
	}else{
		dropDownArray[array_length(dropDownArray)] = 
		summonObject(obj_roomEditor_checkbox, [["xoffset", 20+largestWidth], ["yoffset", 20*(i+0.5)], 
												["parent", id], ["items",editable[i][1]], ["index", i],
												["depth", depth-1], ["paddingNeeded", longestLongestLength]])
	}
}


totalWidth = largestWidth+20+10+sprite_get_width(object_get_sprite(obj_roomEditor_dropdown_click))+5+longestLongestLength;



image_xscale = totalWidth/sprite_width;


function openNewDropDown(newDropDown){
	if openDropDown != noone{
		openDropDown.close();
	}
	openDropDown = newDropDown
	openDropDown.open();
}