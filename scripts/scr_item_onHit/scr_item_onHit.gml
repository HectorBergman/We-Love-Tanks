function cactus_onHit(info){
	var func = method({
		info: info
	}, function() {
		cactus_onHit_helper(info)
	});
	triggerAsInstance(info.cannonId, func)
}


function cactus_onHit_helper(info){
	var bulletInfo = info.bulletInfo
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05,
	}
	struct_addArgs(extraInfo,getBasicInfo(info.cannonId))
	for (var i = 0; i < 360; i += 30){
		var args = 
		fireBullet_defaultSummonStruct(
			bulletInfo.speed,
			bulletInfo.bounces,
			bulletInfo.damage,
			0, 
			bulletInfo.durability,
			extraInfo
		)
	
	fireBullet(info.cannonId,obj_bullet_player,i, args, false)
	}
}

function getBasicInfo(basicInfoGiver, depthDifference = 1){
	return {x: basicInfoGiver.x, y: basicInfoGiver.y, depth: basicInfoGiver.depth+depthDifference}
}