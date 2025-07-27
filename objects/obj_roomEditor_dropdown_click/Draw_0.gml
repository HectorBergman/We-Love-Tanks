draw_self();
var val = 0
print("penus");
if specil{
	print("specil");
	//instancerep
	val = parent.ownEditable[index][1];
}else{
	print(parent);
	val = parent.parent.instanceInfo[index][1];
}
var text = "[$eee7e7][scale,1][fnt_coolFont]" + val; 
var toDraw = scribble(text)

toDraw.draw(x+2, y);