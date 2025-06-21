function playerInput(){
	if keyboard_check(ord("W"))
	{
		moveUp = true;
	}
	if keyboard_check(ord("S"))
	{
		moveDown = true;
	}
	if keyboard_check(ord("A"))
	{
		moveLeft = true;
	}
	if keyboard_check(ord("D"))
	{
		moveRight = true;
	}
	if mouse_check_button(mb_left)
	{
		fire = true;
	}
	if keyboard_check(vk_shift){
		run = true;
	}
	if keyboard_check(ord("T")){
		debugUnlockAndKill = true;
	}
	if keyboard_check(ord("G")){
		debugUnlock = true;
	}
	if keyboard_check_pressed(vk_escape){
		escape = true;
	}
	if keyboard_check(vk_control){
		control = true;
	}
	if keyboard_check(ord("C")){
		cKey = true;
	}
	if keyboard_check_pressed(vk_up){
		pressUp = true;
	}
	if keyboard_check_pressed(vk_down){
		pressDown = true;
	}
	if keyboard_check_pressed(vk_enter){
		confirm = true;
	}
	if keyboard_check_pressed(vk_space){
		space = true;
	}
	if keyboard_check_pressed(vk_delete){
		del = true;
	}
}

function resetInputs(){
	moveUp = false;
	moveDown = false;
	moveLeft = false;
	moveRight = false;
	fire = false;
	run = false;
	debugUnlockAndKill = false;
	debugUnlock = false;
	escape = false;
	control = false;
	cKey = false;
	copy = false;
	pressUp = false;
	pressDown = false;
	confirm = false;
	space = false;
	del = false;
}