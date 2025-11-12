
if obj_handler_gameState.gameState == gameStates.regular{
	summonAllFromStruct(alwaysSummon);
	summonAllFromStruct(inGame);
	dismantle_instanceStruct(editor)
}else if 
	obj_handler_gameState.gameState == gameStates.editor{
		summonAllFromStruct(alwaysSummon);
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
		dismantle_instanceStruct(inGame)
}

