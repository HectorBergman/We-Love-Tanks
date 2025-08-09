function initiateDisplayObjInfo(){
	displayObjList = ds_list_create();
	var objs = [{
		name : "Wall",
		objectIndex : obj_wall,
		additionalGraphics : noone,
		canResize: true,
		arguments : []
	},
	{
		name : "Crumbling wall",
		objectIndex : obj_wall_crumble,
		additionalGraphics : noone,
		canResize: true,
		arguments : []
	},
	{
		name : "Hole",
		objectIndex : obj_hole,
		additionalGraphics : noone,
		canResize: true,
		arguments : []
		
	},
	{
		name : "Item",
		objectIndex : obj_itemSpawner,
		additionalGraphics : [spr_item_caseOfAces,{}],
		canResize: false,
		arguments : 
		[createArgument("itemPool",argumentTypes.options,global.itemPools)],
		actions : createActions(function(){},function(){}, function(){savedAction_addRandom(1)})
	},
	{
		name : "Enemy",
		objectIndex : obj_enemySpawner,
		additionalGraphics : [],
		canResize: false,
		arguments : 
		[createArgument("enemyType",argumentTypes.options,global.enemyTypes)],
		actions : createActions(function(){},function(){}, function(){savedAction_addRandom(1)})
		
	},
	{
		name : "Boss",
		objectIndex : obj_bossSpawner,
		additionalGraphics : [],
		canResize: false,
		arguments : 
		[createArgument("bossType",argumentTypes.options,global.bossTypes)],
		actions : createActions(function(){},function(){}, function(){savedAction_addRandom(1)})
	}
	
	]
	for (var i = 0; i < array_length(objs); i++){
		ds_list_add(displayObjList,objs[i]);
	}
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

	/*Wall :  {object: obj_wall,  _name: "Wall",   editable:[]},
	CrumblingWall: {object: obj_wall_crumble, _name: "CrumblingWall", editable:[]},
	Hole :  {object: obj_hole,  _name: "Hole",   editable:[]},
	Enemy : {object: obj_enemySpawner, _name: "Enemy",  editable:[["enemyType",global.enemyTypes]]},
	Item : {object: obj_itemSpawner, _name: "Item",  editable:[["itemPool",global.itemPools]]},
	Boss : {object: obj_bossSpawner, _name: "Boss",  editable:[["bossType",global.bossTypes]]},