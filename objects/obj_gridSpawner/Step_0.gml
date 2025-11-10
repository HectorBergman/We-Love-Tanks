if waitForIt && obj_handler_handler.gameState == gameStates.editor{
	waitForIt = false;
	generateGridSquares();
}else if (!gridsGenerated && obj_handler_handler.gameState == gameStates.regular){
	generateGridSquares();
	gridsGenerated = true;
}

