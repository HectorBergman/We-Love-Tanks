function hitOpponent(ownObject){
	var target = noone;
	if ownObject == obj_bullet_player{
		target = obj_enemy
	}else if ownObject == obj_bullet_enemy{
		target = obj_player
	}
	var enemyHit = instance_place(x,y,target)
	if enemyHit != noone {
		var dmg = damage;
		with enemyHit{
			decreaseHealth(dmg);
		}
		death();
	}
}
function hitOpponentBullet(ownObject){
	var target = noone
	if ownObject == obj_bullet_player{
		target = obj_bullet_enemy;
	}else if ownObject == obj_bullet_enemy{
		target = obj_bullet_player;	
	}
	var bulletHit = instance_place(x,y,target)
	if bulletHit != noone{
		with bulletHit{
			death();
		}
		death();
	}
}
