
if !ds_list_empty(delayNewRoom){
	//activates when we switch rooms, not at transition end
	signalList(delayNewRoom, "roomEntered");
}
