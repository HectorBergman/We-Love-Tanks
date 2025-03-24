xOffset = 0;
yOffset = 0;
object = obj_gridSquare
scale = 1;
base_width = 32;
base_height = 32;
new_width = base_width *image_xscale/scale;
new_height= base_height *image_yscale/scale;

amountWidth = new_width/base_width;
amountHeight = new_height/base_height;

for (var i = 0; i < amountWidth; i += 1){
	for (var j = 0; j < amountHeight; j += 1){
		blockStruct = {
			image_xscale: scale,
			image_yscale: scale,
		}
		var slave = summonObject(obj_positionCheckerSlave, [["x", self.x + xOffset + i*base_width*scale],["y",  self.y + yOffset + j*base_height*scale, obj_wall]]) 
		var wallThere = false;
		with (slave){
			if (place_meeting(x,y,obj_wall)){
				print("moneY!");
				wallThere = true
			}
		}
		if (!wallThere){
			instance_create_depth(self.x + xOffset + i*base_width*scale, self.y + yOffset + j*base_height*scale, -20, object, blockStruct)
		}
	}
}

instance_destroy();