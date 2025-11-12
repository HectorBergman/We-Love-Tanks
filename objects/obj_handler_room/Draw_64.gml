var text = "[$eee7e7][scale,1] " + string(currentRoom.coords[0]) + "," + string(currentRoom.coords[1]);
var toDraw = scribble(text)
toDraw.draw(900, 30);
toDraw.flush();