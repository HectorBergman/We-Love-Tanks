var size = 8;
// Calculate the barrel tip position
var tip_x = x + size * dsin(image_angle+90);
var tip_y = y + size * dcos(image_angle+90);

// Draw a small square/rectangle at the tip, rotated with the barrel
draw_sprite_ext(sprite_index,image_index,tip_x,tip_y,image_xscale,image_yscale,image_angle,c_red,0.5);
draw_set_color(c_white)
draw_self()

