
SignalSubscribe(id, "transportRoom", function(){
	part_particles_clear(global.ps_above);
})
global.ps_above=part_system_create();
global.pt_flare_particles = part_type_create();

function flareParticles(type){
	part_type_shape(type, pt_shape_sphere);
	part_type_size(type, 0.04, 0.04, -0.0002, 0.01);
	part_type_scale(type, 2, 1);
	part_type_orientation(type, 0, 0, 0, 0, 0);
	part_type_color3(type, #e8b923, #e8b923, #e8b923);
	part_type_alpha3(type, 1, 1, 0);
	part_type_blend(type, true);

	part_system_depth(global.ps_above,-10);

	part_type_life(type, 240, 280);
	part_type_speed(type, 0, 0, 0, 0);
	part_type_direction(type, 0, 360, 0, 0);
	part_type_gravity(type, 0, 0);
}
flareParticles(global.pt_flare_particles);


SignalSubscribe(id,"flare",function(info){
	print("flare!");
	
})