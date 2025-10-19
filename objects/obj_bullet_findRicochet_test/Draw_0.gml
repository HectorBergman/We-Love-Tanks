draw_self();
var cosA = dcos(image_angle);
var sinA = dsin(image_angle);
var cosB = dcos(image_angle + 90);
var sinB = dsin(image_angle + 90);
var peakX = (sprite_width-2-sprite_get_xoffset(sprite_index))*scale;
var peakY = (sprite_height/2-sprite_get_yoffset(sprite_index))*scale
var completePeakX = floor(x + peakX * sinB - peakY * cosB);
var completePeakY = floor(y + peakX * cosB + peakY * sinB);
draw_circle(completePeakX,completePeakY,3,false)


var top_offsetX = -sprite_get_xoffset(sprite_index)*scale;
var top_offsetY = -sprite_get_yoffset(sprite_index)*scale;
var bot_offsetX = sprite_height*scale - sprite_get_xoffset(sprite_index)*scale;
var bot_offsetY = sprite_height*scale - sprite_get_yoffset(sprite_index)*scale;


var topX = floor(x + top_offsetY * sinA);
var topY = floor(y + top_offsetY * cosA);
var botX = floor(x + bot_offsetY * sinA);
var botY = floor(y + bot_offsetY * cosA);


draw_set_color(c_red);
var endX1 = topX + movementVector[0] * 4000;
var endY1 = topY + movementVector[1] * 4000;
var endX2 = botX + movementVector[0] * 4000;
var endY2 = botY + movementVector[1] * 4000;
var endX3 = floor(x) + movementVector[0] * 4000;
var endY3 = floor(y) + movementVector[1] * 4000;

draw_line(topX, topY, endX1, endY1);
draw_set_color(c_blue);
draw_line(botX, botY, endX2, endY2);
draw_set_color(c_white);
draw_line(x,y, endX3, endY3)

if debug.isOn{
	draw_sprite_ext(sprite_index,0,x+debug.vec[0]*4,y+debug.vec[1]*4,scale,scale,debug.angle,c_red,0.6)
	draw_set_alpha(0.6)
	draw_circle(x+debug.vec[0]*4,y+debug.vec[1]*4,3,false)
	draw_set_alpha(1);
}