draw_self();
for (var i = 0; i < array_length(barrelBulges); i++){
	if !(array_length(barrelBulges[i]) == 0){
		draw_sprite_ext(spr_player_cannon_firingAnim_1_bulge,i,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
	}
}