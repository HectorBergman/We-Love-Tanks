depth = -250
enum editorMenuStates2 {
	active,
	inactive,
	transitionToActive,
	transitionToInactive
}
currentDisplayObject = noone //because var scopes suck dickkk!!!
state = editorMenuStates2.inactive;
regularHitbox = mask_index;
initiateToggleSignal(deactivateMenu, function(){});
actionsOrder = ds_queue_create();
function tweeningVariables(){
	notActiveX = 960;
	x = notActiveX
	activeX = 660;
	baseX = notActiveX;
	tween = noone;
	tweenTime = 30;
	transitionDestination = -1; //going to active state or inactive state?
	baseY = 0;
}
tweeningVariables();
//editor_pointer sends this signal out when it has clicked the item menu button

SignalSubscribe(id, "itemInstance: dropped", function(arg){purgeInstances(arg[0])});
initiateDisplayObjInfo(); //initialize the info saying which objects we have available to place
initiateDisplayObjects(); //initialize the instances used to display the objects available to the user
searchForClick(transitionQueue);

function transitionMenu(){
	switch (state){
		case editorMenuStates2.inactive:{
			popActionsQueue();
		}break;
		case editorMenuStates2.active:{
			popActionsQueue();
		}break;
		default:{
		}break;
	}
}


function waitForTransitionEnd(){
	if !TweenIsActive(tween){
		state = transitionDestination;
		if transitionDestination == editorMenuStates2.active{
			activateDisplayObjects()
		}
	}
}
function popActionsQueue(){
	//deactivate and activate cancel eachother out, so if queue exceeds two entries, only keep the head for simplicity
	if !ds_queue_empty(actionsOrder){
		var dq = ds_queue_dequeue(actionsOrder)
		dq()
	}
}

function transitionQueue(){
	if ds_queue_size(actionsOrder) <= 1{
		switch (state){
			case editorMenuStates2.active:{ds_queue_enqueue(actionsOrder, deactivateMenu);
			}break;
			case editorMenuStates2.inactive:{ds_queue_enqueue(actionsOrder, activateMenu);
			}break;
		}
	}else{
		//Since an activate and a deactivate cancel eachother out, if queue has more than 2 entries,
		//just keep the head
		var head = ds_queue_head(actionsOrder);
		ds_queue_clear(actionsOrder);
		ds_queue_enqueue(actionsOrder, head);
	}
}
function deactivateMenu(){
	tween = TweenFire(id,EaseOutQuad,0,false,0,tweenTime,"baseX",x,notActiveX);
	state = editorMenuStates2.transitionToInactive;
	//deactivateDisplayObjects();
	transitionDestination = editorMenuStates2.inactive;
}
function activateMenu(){
	tween = TweenFire(id,EaseOutQuad,0,false,0,tweenTime,"baseX",x,activeX);
	state = editorMenuStates2.transitionToActive;
	transitionDestination = editorMenuStates2.active;
}

function initiateDisplayObjects(){
	for (var i = 0; i < ds_list_size(displayObjList); i++) {
	    currentDisplayObject = ds_list_find_value(displayObjList,i);
	
		var summonStruct = 
			[["coordsOffset", [32+(i mod 4)*64,64+(floor(i/4)*64)]], 
			["depth", depth-1],
			["parent", id], 
			["canResize", currentDisplayObject.canResize]]
		addObjectVariablesToSummonStruct(summonStruct, true);
		summonObject(obj_editor_displayObjects, summonStruct
		);
	}
}

function activateDisplayObjects(){
	SignalSend("editorMenu: displayObjects_activate");
}

function deactivateDisplayObjects(){
	SignalSend("editorMenu: displayObjects_deactivate");
}


function purgeInstances(_id){
	mask_index = spr_roomEditor_menu_hitbox;
	if place_meeting(x,y,_id){
		with _id{closeMenu();dismantle(self);};
		
	}
	mask_index = regularHitbox
}
