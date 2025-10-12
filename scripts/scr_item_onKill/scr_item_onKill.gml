function getInfo_onKill(){
	var dinfo = getDeceasedInfo(id)
	var playerInfo = {player: obj_player.id}
	var info = {deceased: dinfo, player: playerInfo}
	return info
}

function getDeceasedInfo(deceased){
	return {
		_x : deceased.x,
		_y : deceased.y,
		deadId: deceased.id
	}
}



function fanfare_onKill(info){
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
		var extraInfo = {
			bulletGrowthStart: 0.3, 
			bulletGrowthEnd: 1, 
			bulletGrowthRate: 0.05,
			x:info.deceased._x,
			y:info.deceased._y,
		}
		var args = 
		fireBullet_defaultSummonStruct(
			bulletInfo.speed,
			bulletInfo.bounces,
			bulletInfo.damage,
			0, 
			bulletInfo.durability,
			extraInfo
		)
		fireBullet(info.player.cannon.id,obj_bullet_player,i,args,false)
	}
}


