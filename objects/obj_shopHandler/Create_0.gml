prevRoomInfo = {
	coords: [0,0],
	dirExit: [0,0],
	doorExit: 0,
	roomExit: 0
}
SignalSubscribe(id, "shop: prevRoomInfo",function(arg){
	arg[1] = [-arg[0],-arg[1]];
	arg[2] = (arg[2]+2)mod 4
	arg[3] = (arg[3]+2)mod 4
	prevRoomInfo = {
		coords: arg[0],
		dirExit: arg[1],
		doorExit: arg[2],
		roomExit: arg[3]
	}
})


