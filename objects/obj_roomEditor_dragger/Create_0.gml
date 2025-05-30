held = noone;
depth = -110;
highlighted = noone;
grabbedCorner = noone;
cornerOrigin = [0,0];
prevDepth = 0;

enum draggerState{
	enlargeningCorner,
	grabbingInstance,
	highlighting,
	none,
}

state = draggerState.none;