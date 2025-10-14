// DRAW EVENT
// 1. Draw the bullet itself first



// DRAW EVENT
// 1. Ensure surface exists
/*if (!surface_exists(pathSurface)) {
	pathSurface = surface_create(room_width, room_height);
}

// 2. Draw to surface
surface_set_target(pathSurface);
	// Clear with transparent
	draw_clear_alpha(c_black, 0);
    
	// Draw thick path (if we have points)
	if (ds_list_size(pathPoints) >= 2) {
	    // MAIN LINE (smooth and thick)
	    draw_set_color($23B9E8);
	    gpu_set_blendmode(bm_add);
		
	    for (var i = 0; i < ds_list_size(pathPoints)-1; i++) {
			draw_set_alpha(i*5 / ds_list_size(pathPoints));
	        var _p1 = ds_list_find_value(pathPoints, i);
	        var _p2 = ds_list_find_value(pathPoints, i+1);
	        // Draw circles at each point for thickness
	        draw_circle(_p1[0], _p1[1], 3, false);
	        // Connect them with rectangles
	        draw_line_width(_p1[0], _p1[1], _p2[0], _p2[1], 3);
	    }
	    gpu_set_blendmode(bm_normal);
	}
surface_reset_target();

// 3. Draw the surface with outline effect
draw_surface_ext(pathSurface, 0, 0, 1, 1, 0, c_white, 0.7);*/


draw_self();

var top_offsetX = -sprite_get_xoffset(sprite_index)*scale;
var top_offsetY = -sprite_get_yoffset(sprite_index)*scale;
var bot_offsetX = sprite_height - sprite_get_xoffset(sprite_index)*scale;
var bot_offsetY = sprite_height - sprite_get_yoffset(sprite_index)*scale;
print(top_offsetX)
var cosA = dcos(image_angle);
var sinA = dsin(image_angle);

var topX = floor(x + top_offsetY * sinA );  // Round to nearest pixel
var topY = floor(y + top_offsetY * cosA);
var botX = floor(x + bot_offsetY * sinA );
var botY = floor(y + bot_offsetY * cosA );


draw_set_color(c_red);
var endX1 = topX + movementVector[0] * 4000;
var endY1 = topY + movementVector[1] * 4000;
var endX2 = botX + movementVector[0] * 4000;
var endY2 = botY + movementVector[1] * 4000;

draw_line(topX, topY, endX1, endY1);
draw_set_color(c_blue);
draw_line(botX, botY, endX2, endY2);