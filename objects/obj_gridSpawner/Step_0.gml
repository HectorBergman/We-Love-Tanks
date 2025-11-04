if waitForIt && obj_handler_gameSetting.gameState == gameStates.editorTesting{
	waitForIt = false;
	generateGridSquares();
}else if (!gridsGenerated && obj_handler_gameSetting.gameState == gameStates.regular){
	generateGridSquares();
	gridsGenerated = true;
}

