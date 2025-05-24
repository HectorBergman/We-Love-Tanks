usedPool = variable_global_get(pool + "Pool");


var chosenIndex = irandom(array_length(usedPool)-1)
var chosenOption = usedPool[chosenIndex]

summonObject(obj_item,[["itemId", chosenOption], ["x",x],["y",y]]);
//array_delete(options, chosen_index, 1)