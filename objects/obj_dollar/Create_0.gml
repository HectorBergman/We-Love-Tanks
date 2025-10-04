matters = false;
if instance_number(obj_moneyHandler) == 1{
	matters = true;
}
enum moneyType{
	coin,
	dollar,
}
enum dollarStates{
	flyUp,
	descend,
	land,
}
enum coinStates{
	flyUp,
	landed,
	stopped,
}
try{
	if oldInstance{
		exit;
	}
}catch(e){}
fakeX = x;
fakeY = y;
coinState = coinStates.flyUp;
dollarState = dollarStates.flyUp;
type = moneyType.dollar;
image_angle = random_range(0,360);
rotation = random_range(-2,2);
z = -15;
movementVector = [lengthdir_x(1,dir),lengthdir_y(1,dir)];
movementVectorSway = [0,0]
scale = 1;
swayX = 0;
swayY = 0;
timer = 0;

if value < 1{
	sprite_index = spr_coin;
	if value == 0.01{
		image_index = 0;
	}else if value == 0.05{
		image_index = 1;
	}else if value == 0.1{
		image_index = 2;
	}else if value == 0.25{
		image_index = 3;
	}
	type = moneyType.coin;
}else{
	velocity *= 0.25
}
featherDir = choose(-1,1)
featherVelocity = random_range(0.8,1.2);

