function hitOpponent(ownObject){
	var target = noone;
	if ownObject == obj_bullet{
		target = obj_enemy
	}else if ownObject == obj_bullet_enemy{
		target = obj_player
	}
	var enemyHit = instance_place(x,y,target)
	if enemyHit != noone {
		with enemyHit{
			death();
		}
		death();
	}
}
function hitOpponentBullet(ownObject){
	var target = noone
	if ownObject == obj_bullet{
		target = obj_bullet_enemy;
	}else if ownObject == obj_bullet_enemy{
		target = obj_bullet;	
	}
	var bulletHit = instance_place(x,y,obj_bullet)
	if bulletHit != noone{
		instance_destroy(bulletHit);
		instance_destroy();
	}
}
