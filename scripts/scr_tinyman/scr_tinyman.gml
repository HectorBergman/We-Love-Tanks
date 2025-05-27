function tinyman_create(){
	createCannon = false;
	movementSpeed = 3;
	hp = 1;

	state = tinyman.walking;
	
	pointInMoveDir = false;
	
	basemoveTime = 120;
	moveTime = basemoveTime
	moveTimer = moveTime+1;
	
	waitTime = 30;
	waitTimer = waitTime;

	
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
		moveTime = basemoveTime + irandom_range(-50,50);
		moveTimer = moveTime+1;
		state = tinyman.walking;
	}
}

function tinyman_walking(){
	moveTimer--
	if moveTimer == moveTime{
		tinyman_decideMove();
	}
	var moveX = place_meeting(x + movementX(), y, [obj_impassable, obj_player, obj_enemy])
	var moveY = place_meeting(x, y + movementY(), [obj_impassable, obj_player, obj_enemy])
	if (moveX){
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _hStep, true)
		
		movementVector[0] = 0;
	}
	if (moveY){
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
		moveDir = point_direction(x,y,playerTank.x,playerTank.y) + irandom_range(-15,15);
	}else{
		moveDir = irandom(360);
	}
	movementVector = [dcos(moveDir), -dsin(moveDir)]
		
	
}