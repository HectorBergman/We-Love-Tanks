//This will run every time game is booted, if some other object is needed on bootup,
//please summon using this object.
timer = 0;

window_set_cursor(cr_none); //hide pc cursorr
room_goto(rm_startingRoom);

window_set_size(display_get_width(),display_get_height());
show_debug_message(string(display_get_width()) + string(display_get_height()))
summonObject(obj_cam, [["swag", true], ["x", 100]])
