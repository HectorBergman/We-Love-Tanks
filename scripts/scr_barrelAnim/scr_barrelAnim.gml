function barrelAnim_normal(){
	if !ds_queue_empty(barrelQueue){
		animState = animStates.charging;
		sprite_index = spr_player_cannon_firingAnim
	}
}
function barrelAnim_charging(){
	image_index = ds_queue_head(barrelQueue).bulgeNumber;
}
function barrelAnim_releasing(){
	print("swag");
	animInfo.frame += animInfo.frameSpeed;
	image_index = floor(animInfo.frame);
	if animInfo.frame >= 5{
		animInfo.frame = 0;
		animState = animStates.normal;
		sprite_index = spr_player_cannon;
	}
}