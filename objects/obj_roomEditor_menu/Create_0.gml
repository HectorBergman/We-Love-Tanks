global.enemyTypes = ["stiffNormal","braveheartNormal","stiffRicochet","tinyman","stiffBuckshot"]
global.roomTypes = ["standard","item"]; 
global.itemPools = ["itemRoom", "bossItem"];
global.potentialObjects = {
	Wall :  {object: obj_wall,  _name: "Wall",   editable:[]},
	CrumblingWall: {object: obj_wall_crumble, _name: "CrumblingWall", editable:[]},
	Hole :  {object: obj_hole,  _name: "Hole",   editable:[]},
	Enemy : {object: obj_enemySpawner, _name: "Enemy",  editable:[["enemyType",global.enemyTypes]]},
	Item : {object: obj_itemSpawner, _name: "Item",  editable:[["itemPool",global.itemPools]]},
}
depth = -195
enum editorMenuStates {
	active,
	notActive,
	transition,
}

regularMask = mask_index;
activating = false;
notActiveX = 960;
x = notActiveX
activeX = 660;
baseX = notActiveX;
baseY = y;
tween = noone;
state = editorMenuStates.notActive

function activateDisplayObjects(){
	var keys = variable_struct_get_names(global.potentialObjects);
	for (var i = array_length(keys)-1; i >= 0; --i) {
	    var k = keys[i];
	    var v = global.potentialObjects[$ k];
		summonObject(obj_roomEditor_dragable, 
		[["x", x-activeX+700+(i mod 3)*64+sprite_get_xoffset(object_get_sprite(v.object))], 
		["y", y+100+(floor(i/3))*64+sprite_get_yoffset(object_get_sprite(v.object))], 
		["object", v.object], ["depth", depth-1], ["_name", v._name], ["editable", v.editable],
		["parent", id]]);
		
	    /* Use k and v here */
	}
}
function deactivateDisplayObjects(){
	with (obj_roomEditor_dragable) {instance_destroy();} 
}
