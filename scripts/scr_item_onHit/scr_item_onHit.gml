function cactus_onHit(){
	for (var i = 0; i < 360; i += 30){
		with cannon{
			print("lol");
			fireBullet(obj_bullet,4,2,1,i,false);
		}
	}
}