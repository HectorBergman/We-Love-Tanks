x = parent.x+parent.sprite_width/2
y = parent.y+parent.sprite_height/2
image_xscale = parent.image_xscale;
image_yscale = parent.image_yscale;

if grabbed{
	var rounded_xSc = ceil((mouse_x-origin[0])/32)+1;
	var rounded_ySc = ceil((mouse_y-origin[1])/32)+1;
	parent.image_xscale = rounded_xSc;
	parent.image_yscale = rounded_ySc;
	print(rounded_xSc)
	print(rounded_ySc)
	print("lxd");
}