x = parent.x;
y = parent.y;


if parent.invincible{
	if parent.invincibilityFrames mod 15 >= 10{
		image_alpha = 0;
		
	}else{
		image_alpha = 1;
	}
}else{
	image_alpha = 1;
}
cannon.image_alpha = image_alpha;