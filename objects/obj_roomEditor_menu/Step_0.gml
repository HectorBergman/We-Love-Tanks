if !global.editorPause{
	visible = false;
	exit;
}

visible = true;
switch (state){
	case editorMenuStates.notActive:{
		if place_meeting(x,y,obj_roomEditor_dragger){
			if mouse_check_button_pressed(mb_left){
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
			if  mouse_check_button_pressed(mb_left){
				tween = TweenFire(id,EaseOutQuad,0,false,0,30,"x",activeX,notActiveX);
				activating = false;
				state = editorMenuStates.transition;
				deactivateDisplayObjects();
			}
		}
		mask_index = spr_roomEditor_menu_hitbox;
		var tempList = ds_list_create()
		instance_place_list(x,y,obj_roomEditor_instanceRep,tempList,false)
		for (var i = 0; i < ds_list_size(tempList); i++){
			var instance = ds_list_find_value(tempList,i);
			if instance != noone && !instance.held && instance.justDropped > 0 {
				instance_destroy(instance)
			}
		}
		mask_index = regularMask
		ds_list_destroy(tempList);
	}break;
		
}
