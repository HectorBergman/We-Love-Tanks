if waitForIt && obj_handler_gameState.gameState == gameStates.editor{
	waitForIt = false;
	generateGridSquares();
}else if (!gridsGenerated && obj_handler_gameState.gameState == gameStates.regular){
	generateGridSquares();
	gridsGenerated = true;
}

