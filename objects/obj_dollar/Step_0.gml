switch (type){
	case(moneyType.dollar):{dollarLogic();}break;
	case(moneyType.coin):{coinLogic();}break;
}
image_xscale = scale;
image_yscale = scale;

fakeX += movementVector[0]*velocity;
y += movementVector[1]*velocity;
z += zSpeed;
if z < -1{
	depth = z
}else{
	depth = -1
}
x = fakeX + sway;
scale = 1 + -z/100