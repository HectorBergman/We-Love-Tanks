isActive = true;
depth = -300;
enum clickTypes{
	click,
	rClick,
	release
}
function sendClickSignal(clickType, instanceClicked){
	switch (clickType){
		case clickTypes.click:{SignalSend("editor_clicked: " + string(instanceClicked))}break;
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

canGrabDisplayObjects = false;
heldObject = noone;

SignalSubscribe(id, "editorMenu: displayObjects_activate", function(){canGrabDisplayObjects = true})
SignalSubscribe(id, "editorMenu: displayObjects_deactivate", function(){canGrabDisplayObjects = false})

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
		[clickTypes.click, obj_editor_displayObjects],
		[clickTypes.click, obj_editor_itemMenu],
		[clickTypes.rClick, obj_editor_itemInstance],
		[clickTypes.click, obj_editor_menu_argumentForm_dropdown],
		[clickTypes.click, obj_editor_menu_argumentForm], 
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
		}
	}
	
	/*if obj_inputHandler.fire{
		if heldObject == noone{
			if obj_inputHandler.click{ //fire essentially checks for if mb1 is pushed down, click checks if it
									  // started being held down this frame
									  
				if !clickItemMenu(){  // if not hovering over item menu <
					grabDisplayObject();
				}
			}
		}
	}else{
		dropDisplayObject();
	}
	if obj_inputHandler.rightClick && heldObject == noone{
		var itemInst = instance_place(x,y,obj_editor_itemInstance)
		if itemInst != noone{
			with itemInst{
				toggleMenu();
			}
		}
	}*/
}

function clickItemMenu(){
	if place_meeting(x,y,obj_editor_itemMenu){
		SignalSend("editor_pointer: clicked itemMenu");
		return true
	}
	return false
}
function grabDisplayObject(){
	if heldObject == noone{
		print("hello");
		var grabbed = grabDisplayOrInstance(obj_editor_displayObjects, spawnItemInstance);
		if grabbed == noone{
			grabbed = grabDisplayOrInstance(obj_editor_itemInstance, drag);
		}
		heldObject = grabbed;
	}
}

function grabDisplayOrInstance(obj, func){
	var dObj = instance_place(x,y,obj);
	var grabbed = noone;
	if dObj != noone{
		with dObj{
			grabbed = func();
		}
	}
	if grabbed != noone{
		grabbed.offset = [grabbed.x-mouse_x,grabbed.y-mouse_y];
	}
	return grabbed
}
function dropDisplayObject(){
	if heldObject != noone{
		with heldObject{
			dropped();
		}
		heldObject = noone;
	}
}