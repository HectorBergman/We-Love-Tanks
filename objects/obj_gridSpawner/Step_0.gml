if waitForIt && obj_gameSettingHandler.gameState == gameStates.editorTesting{
	waitForIt = false;
	generateGridSquares();
}else if (!gridsGenerated && obj_gameSettingHandler.gameState == gameStates.regular){
	generateGridSquares();
	gridsGenerated = true;
}

