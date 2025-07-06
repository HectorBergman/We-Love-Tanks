function hitOpponent(ownObject){
	var target = noone;
	if ownObject == obj_bullet_player{
		target = [obj_enemy_hitbox, obj_boss_hitbox]
	}else if ownObject == obj_bullet_enemy{
		target = obj_player_visual
	}
	var enemyHit = instance_place(x,y,target)
	if enemyHit != noone {
		collide(enemyHit, false);
	}
}
function hitOpponentBullet(ownObject){
	
	var target = noone
	if ownObject == obj_bullet_player{
		target = [obj_bullet_enemy]//, obj_bullet_boss]
	}else if ownObject == obj_bullet_enemy{
		target = obj_bullet_player;	
	}
	var bulletHit = instance_place(x,y,target)
	if bulletHit != noone{
		collide(bulletHit, true);
	}
}
