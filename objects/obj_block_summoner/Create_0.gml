base_width  = 32;
base_height = 32;
new_width  = base_width  * image_xscale/scale;
new_height = base_height * image_yscale/scale;

amountWidth  = new_width/base_width;
amountHeight = new_height/base_height;

summon_objIndex = obj_wall_breakable
currentRoom_neighbours_request(function(currentRoom_neighbours){
	
	print(currentRoom_neighbours[roomNo][doorNo])
	if !is_undefined(currentRoom_neighbours[roomNo][doorNo]){
		var type = currentRoom_neighbours[roomNo][doorNo].roomType
		print(type)
		switch (currentRoom_neighbours[roomNo][doorNo].roomType){
			case "none":
			case "boss":{
				summon_objIndex = obj_wall_forgetmenot
			}break;
		}
	}else{
		summon_objIndex = obj_wall_forgetmenot
	}
	

})
try{
	print("blocksummonchecks: ", checkIfVisited, ", ", obj_handler_room.currentRoom.visited);
	print("should be 1, 0")
}catch(e){
	print("flop");
	print(e);
}
print("juj");
if !checkIfVisited || !obj_handler_room.currentRoom.visited {
	for (var i = 0; i < amountWidth; i += 1){
		var widthCheck = amountWidth - i
		var width = 1;
		if widthCheck < 1{
			width = widthCheck
		}
	
		for (var j = 0; j < amountHeight; j += 1){
			var heightCheck = amountHeight - j
			var height = 1;
			if heightCheck < 1{
				height = heightCheck
			}
			summonObject(summon_objIndex, 
				[["x", x + i*base_width*scale], 
				["y", y + j*base_height*scale],
				["image_xscale", scale*width],
				["image_yscale", scale*height]]
			)
		}
	}
}

try{
	print(obj_handler_room.currentRoom.visited)
}catch(e){print("swag");}
print("sus");
