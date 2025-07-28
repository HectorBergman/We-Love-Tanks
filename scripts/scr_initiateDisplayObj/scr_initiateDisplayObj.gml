function initiateDisplayObjInfo(){
	displayObjList = ds_list_create();
	var objs = [{
		name : "Wall",
		objectIndex : obj_wall,
		additionalGraphics : noone,
		arguments : []
	},
	{
		name : "Item",
		objectIndex : obj_itemSpawner,
		additionalGraphics : [spr_item_caseOfAces,{}],
		arguments : 
		[{argumentName: "itemPool", argumentType: "options", argumentChoices: ["itemPool", "bossRoom", "lolMode", "testguy"]},//global.itemPools},
		 {argumentName: "itemPoolCheckbox", argumentType: "checkbox", argumentChoices: [false]},
		 {argumentName: "itemPoolText", argumentType: "freeText", argumentChoices: [""]}]
	}
	]
	for (var i = 0; i < array_length(objs); i++){
		ds_list_add(displayObjList,objs[i]);
	}
}

	/*Wall :  {object: obj_wall,  _name: "Wall",   editable:[]},
	CrumblingWall: {object: obj_wall_crumble, _name: "CrumblingWall", editable:[]},
	Hole :  {object: obj_hole,  _name: "Hole",   editable:[]},
	Enemy : {object: obj_enemySpawner, _name: "Enemy",  editable:[["enemyType",global.enemyTypes]]},
	Item : {object: obj_itemSpawner, _name: "Item",  editable:[["itemPool",global.itemPools]]},
	Boss : {object: obj_bossSpawner, _name: "Boss",  editable:[["bossType",global.bossTypes]]},