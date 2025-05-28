
if prevFrame != image_index{
	if parent.movementVector[0] == 0 && parent.movementVector[1] == 0 && image_index mod 2 == 0{
		image_index -= 2
	}
}

if parent.invincible{
	if parent.invincibilityFrames mod 15 >= 10{
		image_alpha = 0.2;
		
	}else{
		image_alpha = 1;
	}
}else{
	image_alpha = 1;
}
cannon.image_alpha = image_alpha;