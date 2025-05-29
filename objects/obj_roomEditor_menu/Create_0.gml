global.potentialObjects = {
	Wall :  {object: obj_wall, _name: "Wall"},
	Hole :  {object: obj_hole, _name: "Hole"},
	Enemy : {object: obj_enemy, _name: "Enemy"},
}

enum editorMenuStates {
	active,
	notActive,
	transition,
}
activating = false;
notActiveX = 960;
x = notActiveX
activeX = 660;
tween = noone;
state = editorMenuStates.notActive

function activateDisplayObjects(){
	var keys = variable_struct_get_names(global.potentialObjects);
	for (var i = array_length(keys)-1; i >= 0; --i) {
	    var k = keys[i];
	    var v = global.potentialObjects[$ k];
		summonObject(obj_roomEditor_dragable, [["x", 700+(i mod 3)*64], ["y", 100+(floor(i/3))*64], ["object", v.object], ["depth", depth-1], ["_name", v._name]]);
	    /* Use k and v here */
	}
}
function deactivateDisplayObjects(){
	for (var i = 0; i < instance_number(obj_roomEditor_dragable); i++){
		instance_destroy(instance_find(obj_roomEditor_dragable,0))
	}
}
