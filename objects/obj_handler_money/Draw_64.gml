var text = "[$eee7e7][scale," + string(bounceSizeBase + sqrt(bounceSize)) +"]$ " + string(money);
var toDraw = scribble(text)
toDraw.draw(10, 10);

toDraw.flush();