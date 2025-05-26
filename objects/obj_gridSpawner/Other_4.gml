xOffset = 0;
yOffset = 0;
object = obj_gridSquare
scale = 1;
base_width = 32*scale;
base_height = 32*scale;
new_width = base_width *image_xscale/scale;
new_height= base_height *image_yscale/scale;

amountWidth = new_width/base_width;
amountHeight = new_height/base_height;

for (var i = 0; i < amountWidth; i += 1){
	
	for (var j = 0; j < amountHeight; j += 1){
		
		/*var found = false;
		for (var k = 0; k < 3; k++){
			for (var g = 0; g < 3; g++){
				if (!(k == 1 && g == 1)){
					var point = collision_circle(x + xOffset+ i*base_width+16*scale+32*(k-1), y + yOffset + j*base_height+16*scale+32*(g-1), 5,obj_wall,false,false)
					if point == noone{
						found = true;
						print("webreak");
						break;
					}
				}
			}
			if found{
				break;
			}
			print("breakfuckedup");
		}*/
		//if !found
		summonObject(obj_gridSquare, 
			[["x",x + xOffset+ i*base_width+16*scale],	
			["y", y + yOffset + j*base_height+16*scale], 
			["depth", -20],  ["image_xscale", scale], 
			["image_yscale", scale], ["squareNo", increase], 
			["isWall", collision_circle(x+i*base_width+16*scale,y+base_height*j+16*scale,5*scale,obj_wall,0,1)]])

		increase++
		
	}
}

instance_destroy();