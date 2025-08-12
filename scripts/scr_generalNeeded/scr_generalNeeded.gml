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
	jankfix
}

function allObjectVariables(isParent){
	var newArr = [];
	switch (isParent){
		case true:{
			var action =  createActions();
			print(currentDisplayObject);
			if variable_struct_exists(currentDisplayObject, "actions"){
				action = currentDisplayObject.actions
			}
			newArr = 
				[["DOindex", currentDisplayObject.DOindex]]
			print(newArr);
		}break;
		case false:{
			newArr = 
				[["DOindex", DOindex]]
		}break;
		case childTypes.jankfix:{
		}break;
	}
	return newArr;
}


function getActualInstanceSummonArr(itemInstance){
	var summonArr = []
	var objArgArrLen = array_length(itemInstance.objectArguments)
	for (var i = 0; i < objArgArrLen; i++){
		summonArr[i] = [itemInstance.objectArguments[i].argumentName, itemInstance.instanceArgumentsChoices[i]];
	}//add all the variables we've added to the itemInstance to the instance itself in testing (and in-game)
	var extraArguments = 
		[["x", itemInstance.x],["y", itemInstance.y],
		["image_xscale", itemInstance.image_xscale],
		["image_yscale", itemInstance.image_yscale]];
	//addToSummonStruct(summonArr,extraArguments)
	summonArr = {objectIndex : itemInstance.object, objectName : itemInstance.objectName, instanceArguments : summonArr, additionalSummonArgs : extraArguments};
	return summonArr;
}