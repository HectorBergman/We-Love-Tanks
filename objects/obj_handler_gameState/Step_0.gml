
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
					ingameState = ingameStates.paused
					menuInstance_activate("pause")
				}
				global.pause = true;
			}
			case ingameStates.paused:{
				if listenForInput("escape"){
					ingameState = ingameStates.normal
				}
				global.pause = false;
			}
		}
	}break;
}