// Move the bullet
print("hej");
x += lengthdir_x(velocity, image_angle);
y += lengthdir_y(velocity, image_angle);

// Only ricochet if we haven't exceeded max bounces
if (place_meeting(x,y,obj_wall)){
	if (ricochet_count < max_ricochets) {
	    // Get normal of the wall surface (simplified - assumes axis-aligned walls)
	    var nx, ny;
	    if (place_meeting(x, y - 1, obj_wall) || place_meeting(x, y + 1, obj_wall)) {
	        // Hit a horizontal wall (top/bottom), reflect vertically
	        nx = 0;
	        ny = 1;
	    } else {
	        // Hit a vertical wall (left/right), reflect horizontally
	        nx = 1;
	        ny = 0;
	    }
    
	    // Calculate reflection vector (simplified for axis-aligned walls)
	    if (nx != 0) {
	        direction = 180 - direction;
	    } else {
	        direction = -direction;
	    }
    
	    // Ensure direction is between 0-360
	    direction = direction mod 360;
    
	    // Move bullet out of collision
	    while (place_meeting(x, y, obj_wall)) {
	        x -= lengthdir_x(1, direction);
	        y -= lengthdir_y(1, direction);
	    }
    
	    // Reduce speed after bounce (optional)
	    speed *= 0.85;
    
	    // Increment ricochet count
	    ricochet_count++;
	} else {
	    // Destroy bullet if no ricochets remain
		parent.activeBullets--
	    instance_destroy();
	}
}