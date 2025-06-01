PAUSE
switch (state){
	case itemState.idle:{
		floatingValue += floatingAdd;
		y = baseY + sin(floatingValue)*5;
		if place_meeting(x,y,obj_player){
			state = itemState.collected;
			ds_list_add(obj_itemHandler.currentItems, itemId);
			var _id = itemId
			with obj_player{
				find_onPickup(_id);
			}
		}
	}break;
	case itemState.collected:{
		switch (tweenStage){
			case 0:{
				tweenStage++
				tween = TweenFire(id,EaseOutBounce,0,false,0,90,"textY",textY,200);
				TweenFire(id,EaseOutQuad,0,false,0,120,"y",y,y-50);
				TweenFire(id,EaseOutQuad,0,false,0,120,"image_alpha",image_alpha,0);
				
			}
			case 1:{
				fadeWait--
				if !TweenIsActive(tween) && fadeWait < 1{
					tweenStage++
					tween = TweenFire(id,EaseInOutQuint,0,false,0,60,"textAlpha",textAlpha,0);
				}
			}
			case 2:{
				if !TweenIsActive(tween){
					instance_destroy();
				}
			}
		}
	}
}

