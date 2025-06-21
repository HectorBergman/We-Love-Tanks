//This will run every time game is booted, if some other object is needed on bootup,
//please summon using this object.
timer = 0;
global.editorPause = false;
print(randomize());
//random_set_seed(1391546381);
window_set_cursor(cr_none); //hide pc cursorr
room_goto(rm_menuBum);

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


window_set_size(display_get_width(),display_get_height());


gpu_set_texfilter(false);

window_set_cursor(cr_none); //hide pc cursor todo: replace cursor with something fun :))
scribble_font_bake_outline_and_shadow("fnt_coolFont", "fnt_coolFont_outline",0,0, SCRIBBLE_OUTLINE.EIGHT_DIR_THICK ,0,false);

scribble_font_set_default("fnt_coolFont_outline");

window_set_size(1920,1080); //window_get_width