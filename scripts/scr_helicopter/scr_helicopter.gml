function create_helicopter(){
	depth = -999

	sprite_index = spr_helicopter
	states_heli = createStates("normal", "relocate");
	state_heli = states_heli.normal;
	
	states_heli_attack = createStates("idle", "rockets", "spread");
	state_heli_attack = states_heli_attack.idle;
	
	states_heli_movement = createStates("normal", "dodge");
	state_heli_movement = states_heli_movement.normal;
	
	movementVector = [0,0]
	velocity = 3;
	timer_randomNoise = 0;

	freq = [0.04,0.02];

	amp	 = [3,4];
	dodgeDiff = [0,0]
	
	moveInfo = {
		normal:{
			moveSpeed_max : 4,
			acceleration : 0.1,
			decceleration1 : 0.95,
			decceleration2 : 0.8,
		},
		dodge:{
			moveSpeed_max : 6,
			acceleration : 0.4,
			decceleration1 : 0.8,
			decceleration2: 0.5,
		},
	}
	
	attackInfo = {
		timer : 0,
		timerMax : 300,
	}
	moveSpeed = [0,0]
	goalCoords = [x,y]
	homeCoords = [irandom_range(100,room_width-100), irandom_range(50,room_height-50)]
	diff = [0,0];
	
	angle = 0;
	
	noise = [0,0]
	
	coords = [x,y];
	
	targetBullet = noone;
	
	enum movementStates_heli{
		normal,
		slowing,
		stopped,
	}
	movementState_x = movementStates_heli.normal;
	movementState_y = movementStates_heli.normal;
	

}
function step_helicopter(){
	helicopter_basic();
	exeStateFunc("helicopter_",state_heli);
	exeStateFunc("helicopter_attack_", state_heli_attack)
}



function stateQueue_enqueue(queue, state){
	ds_queue_enqueue(queue, state);
}

function stateQueue_next(queue, newState = undefined){
	if !is_undefined(newState){
		ds_queue_enqueue(queue, newState)
	}
	return ds_queue_dequeue(queue)
}
