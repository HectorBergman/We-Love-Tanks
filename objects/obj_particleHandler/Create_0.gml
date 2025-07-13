print("kek");
SignalSubscribe(id, "transportRoom", function(){
	part_particles_clear(global.ps_above);
})
global.ps_above=part_system_create();
global.pt_flare_particles = part_type_create();

part_type_shape(global.pt_flare_particles, pt_shape_sphere);

part_type_size(global.pt_flare_particles, 0.04, 0.04, -0.0002, 0.01);

part_type_scale(global.pt_flare_particles, 2, 1);

part_type_orientation(global.pt_flare_particles, 0, 0, 0, 0, 0);

part_type_color3(global.pt_flare_particles, #e8b923, #e8b923, #e8b923);

part_type_alpha3(global.pt_flare_particles, 1, 1, 0);

part_type_blend(global.pt_flare_particles, true);

part_system_depth(global.ps_above,-10);

part_type_life(global.pt_flare_particles, 240, 280);

part_type_speed(global.pt_flare_particles, 0, 0, 0, 0);

part_type_direction(global.pt_flare_particles, 0, 360, 0, 0);

part_type_gravity(global.pt_flare_particles, 0, 0);
