function searchForClick(clickFunction){
	SignalSubscribe(id, "editor_clicked: " + string(id), function(){clickFunction()});
}
function searchForRightClick(rightClickFunction){
	SignalSubscribe(id, "editor_rightClicked: " + string(id), function(){rightClickFunction()});
}
function searchForRelease(releaseFunction){
	SignalSubscribe(id, "editor_released", function(){releaseFunction()});
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