function searchForClick(clickFunction){
	SignalSubscribe(id, "editor_clicked: " + string(id), clickFunction);
}
function searchForRightClick(rightClickFunction){
	SignalSubscribe(id, "editor_rightClicked: " + string(id), rightClickFunction);
}
function searchForRelease(releaseFunction){
	SignalSubscribe(id, "editor_released", releaseFunction);
}

function cleanUpSearchForClick(){
	SignalUnsubscribe(id, "editor_clicked: " + string(id));
}
function cleanUpSearchForRightClick(){
	SignalUnsubscribe(id, "editor_rigthClicked: " + string(id));
}
function cleanUpSearchForRelease(){
	SignalUnsubscribe(id, "editor_released");
}
function initiateToggleSignal(toggleOn,toggleOff){
	tOn = toggleOn
	tOff = toggleOff
	SignalSubscribe(id,"editorMode: testing_start", function(){awaitToggleOffSignal()})
}
function awaitToggleOnSignal(){
	tOff();
	SignalSubscribe(id,"editorMode: testing_start", function(){awaitToggleOffSignal()})
	SignalUnsubscribe(id, "editorMode: editing_start");
}
function awaitToggleOffSignal(){
	tOn();
	SignalSubscribe(id,"editorMode: editing_start", function(){awaitToggleOnSignal()})
	SignalUnsubscribe(id, "editorMode: testing_start");
}
function cleanUpAwaitToggle(){
	SignalUnsubscribe(id,"editorMode: testing_start")
	SignalUnsubscribe(id,"editorMode: editing_start")
}