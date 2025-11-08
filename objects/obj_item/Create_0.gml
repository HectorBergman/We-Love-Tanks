
pauseMode = allPause;
floatingValue = 0;
floatingAdd = 0.03;

baseY = y;
depth = -10;

enum itemState{
	idle,
	collected,
}
try{
	if state == itemState.collected{
		instance_destroy()
		exit;
	}
}catch(e){
}
state = itemState.idle;
textY = -200;
hasTweened = false;
textTimer = 0;
textTime = 180;

tween = noone;
tweenStage = 0;
textAlpha = 1;
fadeWait = 60;

fadeTimer = 0;
fadeTime = 30;

info = global.items[itemId]
pickupText = info.pickupText;
sprite_index = info.sprite;


text = "[$eee7e7][scale,2][alpha," + string(textAlpha) + "]" + pickupText; 
toDraw = scribble(text).align(fa_center,fa_middle);