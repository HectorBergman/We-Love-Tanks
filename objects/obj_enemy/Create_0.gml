type = stringToEnum(enemyType);
switch(type){
	case enemyTypes.stiffNormal: stiffNormal_create(); break;
	case enemyTypes.braveheartNormal: braveheartNormal_create(); break;
	case enemyTypes.stiffRicochet: stiffRicochet_create(); break; 
}

debugStep = 0;
//todo: add code for selecting a sprite according to enemy type


