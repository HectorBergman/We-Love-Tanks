function clickables_main(){
	return [
		clickable_create(
			obj_button, 
			[
				["x", 224],["y", 160],
				["image_xscale", 10],
				["image_yscale", 2],
				["action",1],
				["text","Play!"]
			],
			popup_createInfo(true)
		),
		clickable_create(
			obj_button, 
			[
				["x", 224],["y", 288],
				["image_xscale", 10],
				["image_yscale", 2],
				["action",99],
				["text","Settings"]
			],
			popup_createInfo(true)
		),
		clickable_create(
			obj_button, 
			[
				["x", 704],["y", 96],
				["image_xscale", 3],
				["image_yscale", 1],
				["action",4],
				["text","Dungeon Gen Debug"]],
			popup_createInfo(true)
		),
		clickable_create(
			obj_button, 
			[
				["x", 896],["y", 96],
				["image_xscale", 3],
				["image_yscale", 1],
				["action",5],
				["text","Room Editor"]],
			popup_createInfo(true)
		),
	]
}

function clickables_pause(){
	return [
		clickable_create(
				obj_button, 
				[
					["x", display_get_width()/4],
					["y", display_get_height()/4],
					["image_xscale", 3],
					["image_yscale", 1],
					["action",6],
					["depth", -9000],
					["text","Continue"]
				],
				popup_createInfo(true)
		)
	]
}