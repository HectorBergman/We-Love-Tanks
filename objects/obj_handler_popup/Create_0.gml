active_popups = {}
totalPopups = 0;
SignalSubscribe(id, "popup_clickable", 
	function(info){
		totalPopups++
		variable_struct_set(active_popups, string(totalPopups), 
			{
				instance : info.instance,
				popup_info : info.popup_info,
				tween : TweenFire(
						info.instance,
						info.popup_info.easingFunc,
						0, 
						false, 
						0,
						info.popup_info.popupTime,
						"image_xscale",
						info.instance.image_xscale*0.0001,
						info.instance.image_xscale,
						"image_yscale", 
						info.instance.image_yscale*0.0001, 
						info.instance.image_yscale
				),
			}
		)
		TweenAddCallback(
			variable_struct_get(active_popups,string(totalPopups)).tween,
			"finish", 
			id, 
			SignalSend, 
			"popupFinish", 
			totalPopups
		)
	}
)
SignalSubscribe(id, "popupFinish", function(popupNo){
		variable_struct_remove(active_popups,popupNo)
	}
)