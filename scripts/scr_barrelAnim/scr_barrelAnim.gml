function barrelAnim_normal(){
	if !ds_queue_empty(barrelQueue){
		animState = animStates.charging;
		sprite_index = spr_player_cannon_firingAnim
	}
}
function barrelAnim_charging(){
	var highestBulgeNo = findFurthestBarrelBullet();
	if highestBulgeNo != -1{
		image_index = highestBulgeNo
	}else{
		animState = animStates.normal;
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

function findFurthestBarrelBullet(){
	for (var i = array_length(barrelBulges)-1; i >= 0; i--){
		print(i);
		var arr = barrelBulges[i]
		if array_length(barrelBulges[i]) != 0{
			return i
		}
	}
	return -1
}