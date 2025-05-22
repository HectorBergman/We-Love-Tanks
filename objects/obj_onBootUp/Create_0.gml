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
show_debug_message(string(display_get_width()) + string(display_get_height()))
summonObject(obj_cam, [["swag", true], ["x", 100]])
