function helicopter_attack_idle(){
	attackInfo.timer += ts;
	if attackInfo.timer >= attackInfo.timerMax{
		var keys = variable_struct_get_names(states_heli_attacksOnly);
		print(keys)
		var key = keys[irandom(array_length(keys) - 1)];

		var value = variable_struct_get(states_heli_attacksOnly, key);
		print(value)
		state_heli_attack = value;
		attackInfo.timer = 0;
	}
}

function helicopter_attack_spread(){
	state_heli_attack = states_heli_attack.idle
}

function helicopter_attack_rockets(){

	var extraInfo = 
	{
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05,
		boostMultiplier: 0.8,
		boostDecay: 0.99,
		bounceFrameCount : 8,
		enemyTriggers_death : [helicopter_rocket_explode],
	}
	var angle = point_direction(x,y,obj_player.x,obj_player.y)
	print(angle)
	var args =
	fireBullet_defaultSummonStruct(
			4,
			0,
			0,
			0, 
			999,
			extraInfo
	)
	fireBullet(id, obj_bullet_enemy, angle, args, false)
	state_heli_attack = states_heli_attack.idle
}

function helicopter_rocket_explode(){
	summonObject(obj_explosion_enemy, [["x", x], ["y", y]])
}