
if obj_handler_gameSetting.gameState == gameStates.regular{
	summonAllFromStruct(alwaysSummon);
	summonAllFromStruct(inGame);
	dismantle_instanceStruct(editor)
}else if 
	obj_handler_gameSetting.gameState == gameStates.editorBuilding ||
	obj_handler_gameSetting.gameState == gameStates.editorTesting{
		summonAllFromStruct(alwaysSummon);
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
}

