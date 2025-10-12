function cactus_onHit(info){
	triggerAsInstance(info.cannonId, cactus_onHit_helper)
}


function cactus_onHit_helper(){
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05
	}
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
	
	fireBullet(id,obj_bullet_player,i, args, false)
	}
}