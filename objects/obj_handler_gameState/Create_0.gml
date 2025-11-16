enum menuStates{
	active,
	inactive,
}
enum gameStates {
	other,
	regular,
	editor,
}
enum editorStates{
	building,
	testing,
}

enum ingameStates {
	normal,
	cutscene,
	paused,
	dead,
}
gameState = gameStates.other
menuState = menuStates.active
editorState = editorStates.building;
ingameState = ingameStates.normal;
SignalSubscribe(id, "changeIngameState", function(state){
	print("changingStatee");
	ingameState = state;
})
SignalSubscribe(id, "changeGameState", function(state){
	gameState = state
})
SignalSubscribe(id, "toggleMenuState", function(state){
	menuState = !menuState
})
SignalSubscribe(id, "changeEditorState", function(state){
	editorState = state
})




text = "[$eee7e7][scale,4]" + "You died!"; 
toDraw = scribble(text).align(fa_center,fa_middle);

function returnToMainMenu(){
	ingameState = ingameStates.normal;
	gameState = gameStates.other;
	menuState = menuStates.active
	SignalSend("handler_handler: clear");
	room_goto(rm_menuBum);
	SignalSend("activateMenuInstance", "main");
}