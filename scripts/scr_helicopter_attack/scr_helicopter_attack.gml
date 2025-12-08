function helicopter_attack_idle(){
	attackInfo.timer += ts;
	if attackInfo.timer >= attackInfo.timerMax{
		var keys = variable_struct_get_names(states_heli_attack);
		print(keys)
		var key = keys[irandom(array_length(keys) - 2) + 1];

		var value = variable_struct_get(states_heli_attack, key);

		state_heli_attack = value;
	}
}

function helicopter_attack_spread(){
	print("spread");
}

function helicopter_attack_rockets(){
	print("rockets")
}