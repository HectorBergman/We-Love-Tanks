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
coinState = coinStates.flyUp;
dollarState = dollarStates.flyUp;
type = moneyType.dollar;
z = -15;
movementVector = [lengthdir_x(1,dir),lengthdir_y(1,dir)];
scale = 1;
sway = 0;
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
			zSpeed += 0.3
			if zSpeed >= 0{
				zSpeed = 0
				dollarState = dollarStates.descend;
				
			}
		}break;
		case(dollarStates.descend):{
			zSpeed = 0.2
			timer++
			sway = featherDir*sin(timer/30)*featherVelocity*70
			featherVelocity *= 0.999
			if z >= 0{
				scale = 1;
				z = 0;
				zSpeed = 0;
				dollarState = dollarStates.land;
				var momentarySway = featherDir*sin((timer+1)/30)*featherVelocity*70 - sway
				var lerpVal = velocity/abs(momentarySway)
				var blended_x = lerp(movementVector[0], sign(momentarySway), 1-lerpVal);
			    var blended_y = lerp(movementVector[1], 0, 1-lerpVal);
				print(velocity)
				print(momentarySway)
				print(velocity/abs(momentarySway))
				print(movementVector);
				print([blended_x,blended_y])
				movementVector = [blended_x,blended_y]
				velocity += abs(momentarySway)
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
	var collisionAngle = collision_normal(x+movementVector[0]*velocity,y+movementVector[1]*velocity,obj_solid,3,1)
	
	if collisionAngle != -1{
		var dot = movementVector[0] * cos(degtorad(collisionAngle)) + movementVector[1] * sin(degtorad(collisionAngle));
		var reflectedVector = [];
		reflectedVector[0] = movementVector[0] - 2 * dot * cos(degtorad(collisionAngle));
		reflectedVector[1] = movementVector[1] - 2 * dot * sin(degtorad(collisionAngle));
		movementVector[0] = reflectedVector[0]
		movementVector[1] = reflectedVector[1]
	}
}