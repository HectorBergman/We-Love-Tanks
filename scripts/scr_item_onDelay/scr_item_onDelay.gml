//functions that trigger upon a certain delay

function backJack_onDelay(fireInfo){
	var bulletInfo = fireInfo.bulletInfo
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05,
		boostMultiplier: 0.8,
		boostDecay: 0.99,
		bounceFrameCount : 8,
		bulgeAmount : array_length(barrelBulges),
		bulgeNumber : 0,
	}
	var args = 
	fireBullet_defaultSummonStruct(
		bulletInfo.speed,
		bulletInfo.bounces,
		bulletInfo.damage,
		global.playerBarrelLength, 
		bulletInfo.durability,
		extraInfo
	)
	
	fireBullet(fireInfo.id, obj_bullet_player,fireInfo.id.image_angle,args,false)
	sprite_index = spr_player_cannon_firingAnim
}
