function currentRoom_doors_request(func){
	SignalSubscribe(id, "currentRoom_doors_request_response", func)
	SignalSend("currentRoom_doors_request");
	SignalUnsubscribe(id, "currentRoom_doors_request_response");
}