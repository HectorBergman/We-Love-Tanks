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

function dollarLogic(){
	switch (dollarState){
		case(dollarStates.flyUp):{
			image_angle += rotation
			zSpeed += 0.3
			if zSpeed >= 0{
				zSpeed = 0
				dollarState = dollarStates.descend;
				movementVectorSway = [lengthdir_x(1,image_angle),lengthdir_y(1,image_angle)];
				
			}
		}break;
		case(dollarStates.descend):{
			zSpeed = 0.2
			timer++
			swayX = featherDir*sin(timer/30)*featherVelocity*70*movementVectorSway[0]
			swayY = featherDir*sin(timer/30)*featherVelocity*70*movementVectorSway[1]
			featherVelocity *= 0.999
			if z >= 0{
				scale = 1;
				z = 0;
				zSpeed = 0;
				dollarState = dollarStates.land;
				var momentarySwayX = featherDir*sin((timer+1)/30)*featherVelocity*70*movementVectorSway[0] - swayX
				var momentarySwayY = featherDir*sin((timer+1)/30)*featherVelocity*70*movementVectorSway[1] - swayY
				var lerpValX = velocity/abs(momentarySwayX)
				var lerpValY = velocity/abs(momentarySwayY)
				var blended_x = lerp(movementVector[0], sign(momentarySwayX), 1-lerpValX);
			    var blended_y = lerp(movementVector[1], sign(momentarySwayY), 1-lerpValY);
				movementVector = [blended_x,blended_y]
				velocity += abs(momentarySwayX)
			}
		}break;
		case(dollarStates.land):{
			velocity *= 0.96;
		}break;
	}
}
function coinLogic(){
	switch (coinState){
		case(coinStates.flyUp):{
			zSpeed += 0.3
			if z >= 0{
				scale = 1;
				zSpeed = 0;
				z = 0;
				coinState = coinStates.landed;
			}
		}break;
		case(coinStates.landed):{
			velocity *= 0.988;
			if abs(velocity) <= 0.05{
				velocity = 0;
			}
			
			if velocity == 0{
				coinState = coinStates.stopped;
			}
		}break;
		case(coinStates.stopped):{}break;
	}
	ricochet(movementVector, velocity);
}