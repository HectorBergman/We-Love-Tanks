function getDeceasedInfo(deceased){
	return {
		_x : deceased.x,
		_y : deceased.y,
		deadId: deceased.id,
		player: obj_player.id,
		bulletDamage: obj_player_cannon.bulletDamage
	}
}

function fanfare_onKill(info){
	print(info)
	var func = method({
		info: info
	}, function() {
		fanfare_onKill_helper(info)
	});
	triggerAsInstance(info.player.cannon, func)
}
function fanfare_onKill_helper(info){
	print(info);
	for (var i = 0; i < 360; i += 90){
		fireBullet(obj_bullet_player,4,2,info.bulletDamage,i,0,true ,1, [["x", info._x], ["y", info._y], ["parent", info.player]]);
	}
}


