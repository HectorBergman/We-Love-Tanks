global.editorPause = true;

instanceRepRealBoyList = ds_list_create();

function saveRoom(){
	var allInstances = [];
	for (var i = 0; i < instance_number(obj_roomEditor_instanceRep); i++){
		var cInstance = instance_find(obj_roomEditor_instanceRep, i);
		allInstances[i][0] = ["x", cInstance.x];
		allInstances[i][1] = ["y", cInstance.y];
		allInstances[i][2] = ["image_xscale", cInstance.image_xscale];
		allInstances[i][3] = ["image_yscale", cInstance.image_yscale];
		for (var j = 0; j < array_length(cInstance.ownEditable); j++){
			allInstances[i][j+4] = cInstance.ownEditable[j]
		}
		
		
	}
	print(allInstances);
}