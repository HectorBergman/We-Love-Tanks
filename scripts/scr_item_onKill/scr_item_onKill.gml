function getDeceasedInfo(deceased){
	return {
		_x : deceased.x,
		_y : deceased.y,
		deadId: deceased.id,
		player: obj_player.id,
	}
}

function fanfare_onKill(info){
	print(info)
	triggerAsInstance(info.player.cannon, fanfare_onKill_helper)
}
function fanfare_onKill_helper(info){
	print(info);
	for (var i = 0; i < 360; i += 90){
		fireBullet(obj_bullet_player,4,2,bulletDamage,i,0,true ,1, [["x", info._x], ["y", info._y], ["parent", id]]);
	}
}


