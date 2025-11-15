increase = 0;
xOffset = 0;
yOffset = 0;
object = obj_gridSquare
scale = 1;
base_width = 32*scale;
base_height = 32*scale;
new_width = base_width *image_xscale/scale;
new_height= base_height *image_yscale/scale;
gridsGenerated = false;

amountWidth = new_width/base_width;
amountHeight = new_height/base_height;
waitForIt = false;

if obj_handler_gameState.gameState == gameStates.editor{
	waitForIt = true;
}


function generateGridSquares(){
	increase = 0;
	for (var i = 0; i < amountWidth; i += 1){
		for (var j = 0; j < amountHeight; j += 1){
			summonObject(obj_gridSquare, 
				[["x",x + xOffset+ i*base_width+16*scale],	
				["y", y + yOffset + j*base_height+16*scale], 
				["depth", -20],  ["image_xscale", scale], 
				["image_yscale", scale], ["squareNo", increase], 
				["isWall", collision_circle(x+i*base_width+16*scale,y+base_height*j+16*scale,5*scale,obj_impassable,0,1)]])
			increase++
		}
	}
	SignalSend("grid: newGridSpawned");
}

