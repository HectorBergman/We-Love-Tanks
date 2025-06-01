function tinyman_create(){
	createCannon = false;
	movementSpeed = 3;
	hp = 1;

	state = tinyman.walking;
	
	pointInMoveDir = false;
	
	basemoveTime = 60;
	moveTime = basemoveTime
	moveTimer = moveTime+1;
	
	waitTime = 20;
	waitTimer = waitTime;
	
	hitThisCycle = false;

	
	sprite_index = spr_tinyman

}

function tinyman_step(){
	switch (state){
		case tinyman.walking: tinyman_walking(); break;
		case tinyman.waiting: tinyman_waiting(); break;

	}

	

}
function tinyman_waiting(){
	waitTimer--;
	if waitTimer == 0{
		moveTime = basemoveTime + irandom_range(-40,40);
		moveTimer = moveTime+1;
		state = tinyman.walking;
		hitThisCycle = false;
		collideable = false;
	}
}

function tinyman_walking(){
	moveTimer--
	if moveTimer == moveTime{
		tinyman_decideMove();
	}
	var moveX = instance_place(x + movementX(), y, [obj_impassable, obj_player, obj_enemy])
	var moveY = instance_place(x, y + movementY(), [obj_impassable, obj_player, obj_enemy])
	if (moveX != noone){
		if moveX == obj_player && !hitThisCycle{
			with obj_player{
				decreaseHealth(1);
			}
			hitThisCycle = true;
		}
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _hStep, true)
		
		movementVector[0] = 0;
	}
	if (moveY != noone){
		if moveY == obj_player && !hitThisCycle{
			with obj_player{
				decreaseHealth(1);
			}
			hitThisCycle = true;
		}
		var _vStep = sign(movementY());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _vStep, false)
		
		movementVector[1] = 0;
	}
	if moveTimer == 0{
		state = tinyman.waiting;
		waitTimer = waitTime + irandom_range(-10,10);
		movementVector = [0,0];
	}
}

function tinyman_decideMove(){
	var moveDir = 0;
	if random(1) < 0.5{ //bias more towards the player, but slightly unpredictable
		moveDir = point_direction(x,y,obj_player.x,obj_player.y) + irandom_range(-15,15);
	}else{
		moveDir = irandom(360);
	}
	movementVector = [dcos(moveDir), -dsin(moveDir)]
		
	
}