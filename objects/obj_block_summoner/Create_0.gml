base_width  = 32;
base_height = 32;
new_width  = base_width  * image_xscale/scale;
new_height = base_height * image_yscale/scale;

amountWidth  = new_width/base_width;
amountHeight = new_height/base_height;
currentRoom_doors_request(function(currentRoom_doors){
	var summon_objIndex = obj_wall
	switch (currentRoom_doors[roomNo][doorNo]){
		case doorValues.open:{
			summon_objIndex = obj_wall_breakable
		}break;
	}
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
})

