matters = false;
if instance_number(obj_moneyHandler) == 1{
	matters = true;
}
function checkPickup(){
	if place_meeting(x,y,obj_player){
		if matters{
			obj_moneyHandler.money += value
		}
		//AddSoundHere
		instance_destroy();
	}
}