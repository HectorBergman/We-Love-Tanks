var text = "[$eee7e7][scale," + string(bounceSizeBase + sqrt(bounceSize)) +"]$ " + string(money);
var toDraw = scribble(text)
toDraw.draw(20, 70);

toDraw.flush();