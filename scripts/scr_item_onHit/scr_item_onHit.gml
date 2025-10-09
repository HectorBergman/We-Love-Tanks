function cactus_onHit(info){
	triggerAsInstance(info.cannonId, cactus_onHit_helper)
}


function cactus_onHit_helper(){
	print("test");
	for (var i = 0; i < 360; i += 30){
		fireBullet(obj_bullet_player,4,2,1,i,0,true, 1);
	}
}