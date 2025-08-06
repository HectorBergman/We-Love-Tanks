function addToSummonStruct(summonStruct, arrayToAdd){
	var startPoint = array_length(summonStruct);
	for (var i = 0; i < array_length(arrayToAdd); i++){
		summonStruct[i + startPoint] = arrayToAdd[i];
	}
}

function addObjectVariablesToSummonStruct(summonStruct, isItemMenu){
	var objVar = allObjectVariables(isItemMenu);

	var struct = addToSummonStruct(summonStruct,objVar)
	
}
enum childTypes{
	child,
	parent,
	grandchild
}
function allObjectVariables(childType){
	var newArr = [];
	switch (childType){
		case true:{
			var action = function(){};
			if variable_struct_exists(currentDisplayObject, "appearanceAction"){
				action = currentDisplayObject.appearanceAction
			}
			newArr = 
				[["object", currentDisplayObject.objectIndex],
				["objectName", currentDisplayObject.name], 
				["objectArguments", currentDisplayObject.arguments],
				["objectActions", action]]
			print(newArr);
		}break;
		case false:{
			newArr = 
				[["object", object],
				["objectName", objectName], 
				["objectArguments", objectArguments],
				["objectActions", objectActions]]
		}break;
	}
	return newArr;
}