function initializeEnums(){
	//im thinking of having cannonEnemyStates and bodyEnemyStates be enemy types
	//like stillRicochet, prowling, stillNormal, etc
	//and then each type being an enum..... maybe.... yeah....
	enum cannonEnemyStates{
		normal,
		scanning,
		spotted,
	}
	enum enemyStates{
		normal,
		scanning,
		spotted,
	}
	enum bodyEnemyStates{
		normal,
		spotted,
		approaching,
		prowling
	}//i think all above this comment is decommissioned.
	
	enum enemyTypes{
		stiffNormal,		//Doesn't move, only shoots when it has a direct path to player
		braveheartNormal,	//Drives around when player not close, approaches when close, shoots normally
		stiffRicochet,		//Doesn't move, ricochets bullets off walls to hit player
	}
	
	//body
	
	enum stiffNormal{
		normal,
	}
	enum braveheartNormal{
		approaching, //breadcrumb seen, player not seen
		patrolling,	 //neither breadcrumb nor player seen
		spotted,	 //player seen
	}
	enum stiffRicochet{
		normal,
	}
	
	//cannon
	
	enum stiffNormal_cannon{
		firing,
		scanning,
		spotted,
	}
	enum braveheartNormal_cannon{
		firing,
		scanning,
		spotted,
	}
	enum stiffRicochet_cannon{
		ricochet,
	}
}


function stringToEnum(str) {
    switch (str) {
        case "stiffNormal": return enemyTypes.stiffNormal;
        case "braveheartNormal": return enemyTypes.braveheartNormal;
        case "stiffRicochet":   return enemyTypes.stiffRicochet;
        default: exception_unhandled_handler(str + " is not an existing enemy type!")
    }
}