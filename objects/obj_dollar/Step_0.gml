switch (type){
	case(moneyType.dollar):{dollarLogic();}break;
	case(moneyType.coin):{coinLogic();}break;
}
image_xscale = scale;
image_yscale = scale;
fakeX += movementVector[0]*velocity;
fakeY += movementVector[1]*velocity;
z += zSpeed;
if z < -1{
	depth = z
}else{
	depth = -1
}
if z < -15 && value >= 1{
	var tempZ = abs(z)-15
	image_alpha = abs(15/z)
}else{
	image_alpha = 1
}
x = fakeX + swayX;
y = fakeY + swayY;
scale = 1 + -z/100