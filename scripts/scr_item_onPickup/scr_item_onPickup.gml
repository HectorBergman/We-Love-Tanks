//functions that trigger upon picking up a certain item

function caseOfAces_onPickup(){
	triggerAsAll(obj_player, caseOfAces_onPickup_helper)
}
function caseOfAces_onPickup_helper(){
	luck += 4;
}

function fullMetalJacket_onPickup(){
	triggerAsAll(obj_player_cannon, fullMetalJacket_onPickup_helper)
}
function fullMetalJacket_onPickup_helper(){
	bulletInfo.durability += 1;
	fullMetalJacket = true;
}