//functions that trigger upon a certain delay

function backJack_onDelay(fireInfo){
	var bulletInfo = fireInfo.bulletInfo
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05,
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
}
