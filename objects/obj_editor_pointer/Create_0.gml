isActive = true;
depth = -300;

	
enum clickTypes{
	click,
	rClick,
	release
}
function sendClickSignal(clickType, instanceClicked){
	print("signaling!:");
	print(clickType);
	print(instanceClicked);
	switch (clickType){
		case clickTypes.click:{SignalSend("editor_clicked: " + string(instanceClicked))
							   SignalSend("editor_clicked: general")}break;
		case clickTypes.rClick:{SignalSend("editor_rightClicked: " + string(instanceClicked))}break;
		case clickTypes.release:{SignalSend("editor_released: " + string(instanceClicked))}break;
	}
}
function activate(){
	visible = true;
	isActive = true;
}
function deactivate(){
	visible = false;
	isActive = false;
}
SignalSubscribe(id, "editorMode: editing_start", function(){activate()});
SignalSubscribe(id, "editorMode: testing_start", function(){deactivate()});


function createPriorityOrder(arr){
	for (var i = 0; i < array_length(arr); i++){
		arr[i][1] = instance_place(x,y,arr[i][1]);
	}
	return arr
}
function clickingLogic(){
	/*priority:
		clicking in-menu for instances
		clicking on and off menu
		right-clicking instances
		clicking menu argument (dropdown)
		clicking menu argument
		size-dragging instances
		dragging instances
	*/
	var click = obj_inputHandler.click
	var rClick = obj_inputHandler.rightClick
	var release = obj_inputHandler.clickRelease;
	var priorityOrder = createPriorityOrder([
		[clickTypes.click, obj_editor_saveRoomButton],
		[clickTypes.click, obj_editor_displayObjects],
		[clickTypes.click, obj_editor_itemMenu],
		[clickTypes.rClick, obj_editor_itemInstance],
		[clickTypes.click, obj_editor_instanceMenu],
		[clickTypes.click, obj_editor_itemInstance_highlight],
		[clickTypes.click, obj_editor_menu_argumentForm_dropdown],
		[clickTypes.click, obj_editor_menu_argumentForm], 
		[clickTypes.click, obj_editor_player_standIn],
		[clickTypes.click, obj_editor_itemInstance]
	]);
	for (var i = 0; i < array_length(priorityOrder); i++){
		var isInputted = false;
		switch (priorityOrder[i][0]){
			case clickTypes.click:{isInputted = click;}break;
			case clickTypes.rClick:{isInputted = rClick;}break;
			case clickTypes.release:{isInputted = release;}break;
		}
		if isInputted && priorityOrder[i][1]{
			sendClickSignal(priorityOrder[i][0],priorityOrder[i][1])
			break;
		}
	}
	if obj_inputHandler.clickRelease{
		SignalSend("editor_released");
	}
}

