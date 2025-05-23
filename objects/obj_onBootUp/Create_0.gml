//This will run every time game is booted, if some other object is needed on bootup,
//please summon using this object.
timer = 0;

print(randomize());
//random_set_seed(744240049);
window_set_cursor(cr_none); //hide pc cursorr
room_goto(rm_startingRoom);

var buffer =  buffer_load("roomData.json");
var _string = buffer_read(buffer, buffer_string);
global.roomList = json_parse(_string);
print(global.roomList);


window_set_size(display_get_width(),display_get_height());


gpu_set_texfilter(false);

window_set_cursor(cr_none); //hide pc cursor todo: replace cursor with something fun :))
scribble_font_bake_outline_and_shadow("fnt_coolFont", "fnt_coolFont_outline",0,0, SCRIBBLE_OUTLINE.EIGHT_DIR_THICK ,0,false);

scribble_font_set_default("fnt_coolFont_outline");

window_set_size(1920,1080); //window_get_width