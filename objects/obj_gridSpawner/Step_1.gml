if obj_gameSettingHandler.gameState == gameStates.editorBuilding{
	waitForIt = true;
	instance_destroy(obj_gridSquare);
}