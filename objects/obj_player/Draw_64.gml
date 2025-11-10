for (var i = 0; i < maxHp; i+=2){
	var tempHp = hp-i;
	var imageIndex = 0;
	if tempHp > 1{
		imageIndex = 0;
	}else if tempHp == 1{
		imageIndex = 1;
	}else{
		imageIndex = 2;
	}
	draw_sprite(spr_heart,imageIndex,i*25,0)
}