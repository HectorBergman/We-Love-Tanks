draw_self()
if selected{
	var xscale = image_xscale;
	var yscale = image_yscale
	if image_xscale == 0{
		xscale = 0.2;
	}
	if image_yscale == 0{
		yscale = 0.2;
	}
		
	draw_sprite_ext(spr_roomEditor_highlight,0,x,y,xscale,yscale,image_angle,c_white,image_alpha);
}