
switch gameState{
	case gameStates.regular:{
		switch (ingameState){
			case ingameStates.dead:{
				if listenForInput("space"){
					print("dub");
					returnToMainMenu()
				}
			}break;
			case ingameStates.normal:{
				if listenForInput("escape"){
					menu_pause()
				}
				
			}break;
			case ingameStates.paused:{
				if listenForInput("escape"){
					menu_unpause()
				}
				
			}break;
		}
	}break;
}