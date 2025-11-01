function barrelAnim_normal(){
	if !ds_queue_empty(barrelQueue){
		animState = animStates.charging;
		sprite_index = spr_player_cannon_firingAnim
	}
}
function barrelAnim_charging(){
	var instance = ds_queue_head(barrelQueue)
	if instance_exists(instance){
		image_index = instance.bulgeNumber;
	}else{
		ds_queue_dequeue(barrelQueue);
		if !ds_queue_empty(barrelQueue){
			barrelAnim_charging()
		}
	}
}
function barrelAnim_releasing(){
	animInfo.frame += animInfo.frameSpeed;
	image_index = floor(animInfo.frame);
	if animInfo.frame >= 5{
		animInfo.frame = 0;
		animState = animStates.normal;
		sprite_index = spr_player_cannon;
	}
}