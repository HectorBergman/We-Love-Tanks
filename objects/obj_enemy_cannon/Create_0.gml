type = parent.type

switch(type){
	case enemyTypes.stiffNormal: stiffNormal_create_cannon(); break;
	case enemyTypes.braveheartNormal: braveheartNormal_create_cannon(); break;
	case enemyTypes.stiffRicochet: stiffRicochet_create_cannon(); break;
	case enemyTypes.stiffBuckshot: stiffBuckshot_create_cannon(); break; 
	
}

