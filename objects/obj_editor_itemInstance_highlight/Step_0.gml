if resizing{
	var coordDifference = [mouse_x-originalCoords[0],mouse_y-originalCoords[1]];
	var roundedX = ceil(coordDifference[0]/32)*32
	var roundedY = ceil(coordDifference[1]/32)*32
	var rounded_xSc = ceil(coordDifference[0]/32)+originalScale[0];
	var rounded_ySc = ceil(coordDifference[1]/32)+originalScale[1];
	if rounded_xSc != 0{
		parent.image_xscale = rounded_xSc;
	}
	if rounded_ySc != 0{
		parent.image_yscale = rounded_ySc;
	}

}