


for (var i = 0; i < 5; i++){
	for (var j = 0; j < 5; j++){
		var grid = ds_grid_get(roomsToDisplay, i, j)
		print("heregoesgrid");
		print(grid);
		if grid != noone{
			var borderColor = c_black;
			var roomColor = c_white;
			if grid.roomType == "boss"{
				roomColor = c_blue;
			}
			if grid.roomType == "item"{
				roomColor = c_yellow;
			}
			if grid.roomShape[0] != "normal"{
				borderColor = c_blue;
			}
			else if roomDoorCount(currentFloor,grid) == 1{
				borderColor = c_red;
			}
			var _x = x+i*(rectangleWidth+doorWidth)*(1/scale)
			var _y = y+j*(rectangleHeight+doorHeight)*(1/scale)
			_x *= scale;
			_y *= scale;
			draw_rectangle_color(_x,_y,_x+rectangleWidth,_y+rectangleHeight, borderColor,borderColor,borderColor,borderColor, true)
			draw_rectangle_color(_x,_y,_x+rectangleWidth,_y+rectangleHeight, roomColor,roomColor, roomColor, roomColor, false)
			if grid.doors[0] == doorValues.open{
				var specialY = (_y+rectangleHeight/2-doorHeight/2)
				draw_rectangle_color(_x + rectangleWidth,specialY,_x+rectangleWidth+doorWidth ,specialY+doorHeight, c_black,c_black,c_black,c_black, true)
				draw_rectangle(_x + rectangleWidth,specialY,_x+rectangleWidth+doorWidth ,specialY+doorHeight, false)
			}
			if grid.doors[3] == doorValues.open{
				var specialX = (_x + rectangleWidth/2-doorWidth/2)
				draw_rectangle_color(specialX,_y+rectangleHeight,specialX+doorWidth ,_y+rectangleHeight+doorHeight, c_black,c_black,c_black,c_black, true)
				draw_rectangle(specialX,_y+rectangleHeight,specialX+doorWidth ,_y+rectangleHeight+doorHeight, false)
			}
		}
	}
}
/*
var _x = x+2*(rectangleWidth+doorWidth)* 1/scale;
var _y = y+2*(rectangleHeight+doorHeight)* 1/scale;
_x *= scale;
_y *= scale;
draw_rectangle_color(_x+rectangleWidth/2-2,_y+rectangleHeight/2-2,_x+rectangleWidth/2+2,_y+rectangleHeight/2+2, c_red,c_red,c_red,c_red, false)
//35 18