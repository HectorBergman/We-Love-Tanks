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

SignalSubscribe(id, "pauseMenu", function(){
	if global.pause{
		menu_unpause()
	}else{
		menu_pause()
	}
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

function menu_pause(){
	ingameState = ingameStates.paused
	menuInstance_activate("pause")
	pause(pM.pauseMenu)
}
function menu_unpause(){
	ingameState = ingameStates.normal
	menuInstance_deactivate("pause")
	pause(pM.pauseMenu)
}