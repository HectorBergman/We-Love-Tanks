enum gameStates {
	menu,
	regular,
	editorBuilding,
	editorTesting
}
gameState = gameStates.menu
SignalSubscribe(id, "changeGameState", function(state){
	gameState = state
})