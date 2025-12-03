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
	if !checkIfVisited || !obj_handler_room.currentRoom.visited {
		walls_summon()
	}
}catch(e){
	summon_objIndex = obj_wall_forgetmenot
	walls_summon()
		
}

function walls_summon(){
	for (var i = 0; i < amountWidth; i += 1){
		var widthCheck = amountWidth - i
		var width = 1;
		if widthCheck < 1{
			width = round(widthCheck*64)/64
		}
	
		for (var j = 0; j < amountHeight; j += 1){
			var heightCheck = amountHeight - j
			var height = 1;
			if heightCheck < 1{
				height = round(heightCheck*64)/64
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