
visible = true;
switch (state){
	case editorMenuStates2.inactive:{
		transitionMenu();
	}break;
	case editorMenuStates2.active:{
		transitionMenu();
	}break;
	default:{
		waitForTransitionEnd();
	}break;
}
x = baseX + obj_cam.newX;
y = 0 + obj_cam.newY;