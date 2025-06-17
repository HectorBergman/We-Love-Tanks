//This will run every time game is booted, if some other object is needed on bootup,
//please summon using this object.
timer = 0;
global.editorPause = false;
//print(randomize());
random_set_seed(1391546381);
window_set_cursor(cr_none); //hide pc cursorr
room_goto(rm_menuBum);
//room_goto(rm_startingRoom);

/*var buffer =  buffer_load("roomData.json");
var _string = buffer_read(buffer, buffer_string);
global.roomList = json_parse(_string);
print(global.roomList);*/
#macro PAUSE if global.editorPause{exit;}

global.roomShapes = [ //this information is purely for knowing which room pool to generate from
					  //me from the future: actually its used for other things too lol
	"normal",
	"long",
	"tall",
	"topLeftAbsent",
	"topRightAbsent",
	"bottomLeftAbsent",
	"bottomRightAbsent",
	"giant",
]

global.roomList =  [/*
 {
   "roomName": "rm_room_test",
   "type": "standard",
   "difficulty": "1"
 },
 {
   "roomName": "rm_room_test_2",
   "type": "standard",
   "difficulty": "1"
 },
 {
   "roomName": "rm_room_test_3",
   "type": "standard",
   "difficulty": "1"
 },
 {
	 "roomName": "rm_room_test_4",
	 "type": "standard",
	 "difficulty": "1",
 },
 {
   "roomName": "rm_room_itemRoom_1",
   "type": "item",
   "difficulty": "0"
 }*/
]
window_set_size(display_get_width(),display_get_height());


gpu_set_texfilter(false);

window_set_cursor(cr_none); //hide pc cursor todo: replace cursor with something fun :))
scribble_font_bake_outline_and_shadow("fnt_coolFont", "fnt_coolFont_outline",0,0, SCRIBBLE_OUTLINE.EIGHT_DIR_THICK ,0,false);

scribble_font_set_default("fnt_coolFont_outline");

window_set_size(1920,1080); //window_get_width