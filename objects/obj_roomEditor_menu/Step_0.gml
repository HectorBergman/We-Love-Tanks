switch (state){
	case editorMenuStates.notActive:{
		if place_meeting(x,y,obj_roomEditor_dragger){
			if mouse_check_button(mb_left){
				tween = TweenFire(id,EaseOutQuad,0,false,0,30,"x",notActiveX,activeX);
				activating = true;
				state = editorMenuStates.transition;
			}
		}
	}break;
	case editorMenuStates.transition:{
		if !TweenIsActive(tween){
			if activating{
				state = editorMenuStates.active
				activateDisplayObjects();
			}else{
				state = editorMenuStates.notActive
			}
		}
	}break;
	case editorMenuStates.active:{
		if place_meeting(x,y,obj_roomEditor_dragger){
			if mouse_check_button(mb_left){
				tween = TweenFire(id,EaseOutQuad,0,false,0,30,"x",activeX,notActiveX);
				activating = false;
				state = editorMenuStates.transition;
				deactivateDisplayObjects();
			}
		}
		mask_index = spr_roomEditor_menu_hitbox;
		var instance  = instance_place(x,y,obj_roomEditor_instanceRep)
		if instance != noone && !instance.held {
			instance_destroy(instance)
		}
		mask_index = regularMask
	}break;
		
}