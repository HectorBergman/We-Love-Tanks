RoomLoader.data_init(rm_test);
cam = instance_find(obj_cam, 0);
loadedRooms = ds_list_create();
colliding = false;

currentRoom = [7,7]



roomHeightnOffset = 540+32;
roomWidthnOffset = 960+32;

roomJump = 64;

width = 14;  
height = 14;  


roomGrid = array_create(width);
for (var i = 0; i < width; i++) {
    roomGrid[i] = array_create(height);
    

    for (var j = 0; j < height; j++) {
        roomGrid[i][j] = noone; 
    }
}


roomGrid[7][7] = ["startRoom", true];


function roomCreate(newRoom, xChange, yChange){
	//print(currentRoom[0])
	//print(currentRoom[1])
	if (roomGrid[currentRoom[0]][currentRoom[1]][0] != "startRoom"){
		roomGrid[currentRoom[0]][currentRoom[1]][0].cleanup();
		roomGrid[currentRoom[0]][currentRoom[1]][1] = false;
	}
	currentRoom[0] += xChange;
	currentRoom[1] += yChange
	cam.x += xChange*roomWidthnOffset;
	cam.y += yChange*roomHeightnOffset
	
	if (roomGrid[currentRoom[0]][currentRoom[1]] == noone || !roomGrid[currentRoom[0]][currentRoom[1]][1]){
		roomGrid[currentRoom[0]][currentRoom[1]][0] = RoomLoader.load(newRoom, cam.x, cam.y, 0, 0)
	}else{
		//print("hi");
	}
	playerTank.x += xChange*roomJump
	playerTank.y += yChange*roomJump
	roomGrid[currentRoom[0]][currentRoom[1]][1] = true;
}
