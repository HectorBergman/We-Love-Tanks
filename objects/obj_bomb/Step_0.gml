timer -= ts
if timer <= 0{
	summonObject(obj_explosion,
		[
		 ["radius", radius],
		 ["x", x],
		 ["y", y]
		]
	)
	instance_destroy()
}