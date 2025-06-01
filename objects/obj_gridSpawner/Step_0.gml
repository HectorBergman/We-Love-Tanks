if waitForIt && obj_gameSettingHandler.gameState == gameStates.editorTesting{
	waitForIt = false;
	generateGridSquares();
}

