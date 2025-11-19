switch (state){
	case crumbleWallState.normal: {
		mask_index = spr_wall_crumblebox;
		var bullet = instance_place(x,y,obj_bullet);
		mask_index = spr_wall;
		if bullet != noone && is_undefined(ds_map_find_value(rememberBullets,bullet)){
			state = crumbleWallState.crumble;
			ds_map_add(rememberBullets,bullet,4);
		}
	}break;
	case crumbleWallState.crumble: {
		crumbleTimer--;
		if crumbleTimerIncoming != 0{
			crumbleTimer -= crumbleTimerIncoming;
			crumbleTimerIncoming = 0;
		}
		mask_index = spr_wall_crumblebox;
		var bullet = instance_place(x,y,obj_bullet);
		mask_index = spr_wall;
		if bullet != noone && is_undefined(ds_map_find_value(rememberBullets,bullet)){
			ds_map_add(rememberBullets,bullet,4);
			crumbleTimerIncoming = 40;
		}
		processDsMapValues(rememberBullets);
		if crumbleTimer < 1{
			instance_destroy();
		}
		image_alpha = crumbleTimer/crumbleTime;
	}break;
}