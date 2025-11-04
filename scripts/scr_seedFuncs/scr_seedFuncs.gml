function storeSeed(globalVarName){
	variable_global_set(globalVarName, irandom_range(0, 4294967295));
}
function useSeed(globalVarName){
	random_set_seed(variable_global_get(globalVarName));
}

function getPreRandom(){
	SignalSubscribe(id, "preRandomResponse:", function(arg){
		preRandoms = arg
	})
	SignalSend("preRandomRequest:", 1);
	SignalUnsubscribe(id, "preRandomResponse:")
}

function usePreRandom(preRandomsArr){
	var use = preRandomsArr[0];
	array_delete(preRandomsArr,0,1);
	return use;
}