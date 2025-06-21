enum enemyPhase {
	startingUp,
	active
}
color = c_white;
phase = enemyPhase.startingUp
startUpTimer = 90;
angle = 0;
hit = -99;
collideable = true;
valueRange = [1.5,3];

//customizable probably
createCannon = true;
movementSpeed = 1;
type = stringToEnum(enemyType);
pointInMoveDir = true;
hp = 3;
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
movementVector = [0,0];


switch(type){
	case enemyTypes.stiffNormal: stiffNormal_create(); break;
	case enemyTypes.braveheartNormal: braveheartNormal_create(); break;
	case enemyTypes.stiffRicochet: stiffRicochet_create(); break; 
	case enemyTypes.stiffBuckshot: stiffBuckshot_create(); break; 
	case enemyTypes.tinyman: tinyman_create(); break;
}
if createCannon{
	cannon = summonObject(obj_enemy_cannon, [["parent", id], ["depth", depth-1]]);
}
print(hp);
hitbox = summonObject(obj_enemy_hitbox, [["parent", id]]);
//todo: add code for selecting a sprite according to enemy type

function death(){
	dropMoney(valueRange);
	if createCannon{
		with cannon{
			id.death();
		}
	}
	with hitbox{
		id.death();
	}
	instance_destroy();
}

function decreaseHealth(amount){
	if phase != enemyPhase.startingUp{
		hp -= amount;
	}
	color = c_red;
	hit = 20;
}

function checkForDeath(){
	
	if hp < 1{
		death();
	}
}

function dropMoney(valueRange){
	var valueDropped = random_range(valueRange[0],valueRange[1]);
	valueDropped = round(valueDropped*100)/100
	var dollarAmt = floor(valueDropped);
	valueDropped = valueDropped-dollarAmt
	var quarterAmt = floor(valueDropped/0.25)
	valueDropped = valueDropped-quarterAmt*0.25
	var dimeAmt = floor(valueDropped/0.1);
	valueDropped = valueDropped-dimeAmt*0.1;
	var nickelAmt = floor(valueDropped/0.05);
	valueDropped = valueDropped-nickelAmt*0.05;
	var pennyAmt = floor(valueDropped/0.01);
	valueDropped = valueDropped-pennyAmt*0.01;
	if valueDropped == 0{
		print("dropped money successfully");
	}else{
		print("dropped money unsuccessfully");
	}
	print(valueDropped);
	var moneyValueArr = [1,0.25,0.1,0.05,0.01];
	var amtArr = [dollarAmt,quarterAmt,dimeAmt,nickelAmt,pennyAmt];
	print(amtArr);
	for (var i = 0; i < 5; i++){
		print("newLoop");
		print(i);
		var val = moneyValueArr[i];
		print(val)
		print(amtArr[i])
		for (var j = 0; j < (amtArr[i]); j++){
			print("are we in");
			var zSpeed = 0;
			if val >= 1{
				zSpeed = random_range(-3,-6);
			}else{
				zSpeed = random_range(-4,-8);
			}
			summonObject(obj_dollar, [["x", x], ["y", y], 
			["dir", random_range(0,360)],["value", val],
			["zSpeed", zSpeed], ["velocity", random_range(0.1,1.5)]]);
		}
	}
}