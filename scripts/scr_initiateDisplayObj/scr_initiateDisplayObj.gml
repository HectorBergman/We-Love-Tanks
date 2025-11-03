function initiateDisplayObjInfo(){
	global.displayObjects = ds_list_create();
	addDisplayObjs(
		[
		{
			name : "Wall",
			objectIndex : obj_wall,
			additionalGraphics : noone,
			canResize: true,
			arguments : [],
			actions : createActions()
		},
		{
			name : "Crumbling wall",
			objectIndex : obj_wall_crumble,
			additionalGraphics : noone,
			canResize: true,
			arguments : [],
			actions : createActions()
		},
		{
			name : "Hole",
			objectIndex : obj_hole,
			additionalGraphics : noone,
			canResize: true,
			arguments : [],
			actions : createActions()
		},
		{
			name : "Item",
			objectIndex : obj_itemSpawner,
			additionalGraphics : [spr_item_caseOfAces,{}],
			canResize: false,
			arguments : 
			[createArgument("itemPool",argumentTypes.options,global.itemPools)],
			actions : createActions(function(){},function(){}, function(){savedAction_addRandom(1)}),
		},
		{
			name : "Enemy",
			objectIndex : obj_enemySpawner,
			additionalGraphics : [],
			canResize: false,
			arguments : 
			[createArgument("enemyType",argumentTypes.options,global.enemyTypes)],
			actions : createActions(function(){},function(){}, function(){savedAction_addRandom(1)}),
		
		},
		{
			name : "Boss",
			objectIndex : obj_bossSpawner,
			additionalGraphics : [],
			canResize: false,
			arguments : 
			[createArgument("bossType",argumentTypes.options,global.bossTypes)],
			actions : createActions(function(){},function(){}, function(){savedAction_addRandom(1)}),
		}
		]
	)
}

function getSummonArrFromChoices(DOindex, instanceArgChoices){
	var obj = ds_list_find_value(global.displayObjects,DOindex);
	var newArr = [];
	for (var i = 0; i < array_length(obj.arguments); i++){
		newArr[i] = [obj.arguments[i].argumentName, instanceArgChoices[i]];
	}
	return newArr
}
function getDisplayObjectInfo(DOindex){
	var obj = ds_list_find_value(global.displayObjects,DOindex);
	object = obj.objectIndex
	objectActions = obj.actions
	objectArguments = obj.arguments;
	objectName = obj.name
	
}
function addDisplayObjs(arr){
	if ds_list_empty(global.displayObjects){
		var index = 0;
	}else{
		var index = ds_list_find_value(global.displayObjects, ds_list_size(global.displayObjects)).DOindex;
	}
	for (var i = 0; i < array_length(arr); i++){
		arr[i].DOindex = index
		ds_list_add(global.displayObjects, arr[i]);
		index++
	}
}
function findDisplayObj(index){
	return ds_map_find_value(global.displayObjects.map,index)
}
enum argumentTypes{
	options,
	checkbox,
	freetext,
	button
}

enum appearanceTypes{
	appear,
	disappear,
}

function createArgument(name,type,choices = [""]){
	return {argumentName: name, argumentType: type, argumentChoices: choices}
}

function randomized_appearanceAction(randomAmt){
	SignalSend("editor_handler: +random", randomAmt);
		
}
function randomized_disappearanceAction(randomAmt){
	SignalSend("editor_handler: -random", randomAmt);	
}

function savedAction_addRandom(randomAmt){
	SignalSend("saved: addRandom", randomAmt);
}


function createActions(appearanceAction = function(arg){}, disappearanceAction = function(arg){}, savedAction = function(arg){}){
	return  {appearanceAction : appearanceAction, disappearanceAction : disappearanceAction, savedAction : savedAction}
}