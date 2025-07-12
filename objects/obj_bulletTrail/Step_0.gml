if instance_exists(parent){
	image_alpha = parent.image_alpha;
	depth = parent.depth;
	xprev=x

	yprev=y
	x = parent.x;
	y = parent.y
	

	/// All your movement code goes here

	var p_dir = point_direction(x,y,xprev,yprev)

	part_type_orientation(global.pt_flare_particles, p_dir, p_dir, 0, 0, 0);

	part_particles_create(global.ps_above,x,y,global.pt_flare_particles,1)
}else{
	instance_destroy()
}