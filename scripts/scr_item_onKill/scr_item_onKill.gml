function fanfare_onKill(enemyDead){
	for (var i = 0; i < 360; i += 90){
		with cannon{
			fireBullet(obj_bullet_player,4,2,bulletDamage,i,0,true ,1, [["x", enemyDead._x], ["y", enemyDead._y]]);
		}
	}
}

function getDeceasedInfo(deceased){
	return {
		_x : deceased.x,
		_y : deceased.y,
	}
}