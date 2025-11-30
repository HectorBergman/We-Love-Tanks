//This will run every time game is booted, if some other object is needed on bootup,
//please summon using this object.
timer = 0;
global.editorPause = false;
global.transitionPause = false;
global.deadPause = false;
global.pause = false;

global.disablePrints = false;

global.__signals = new SignalController();

//print(randomize());
//223416234
global.dungeonSeed = 1013759533//2911830160//1020381396//random_get_seed();
random_set_seed(global.dungeonSeed);

global.currentSeed = global.dungeonSeed;
window_set_cursor(cr_none); //hide pc cursorr
room_goto(rm_menuBum);



#macro PAUSE if pause(pauseMode){exit;}

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
global.timeSpeed = 1;


defineItems();
global.itemRoomPool = getItemPool("itemRoom");



//in the future, create seperate lists or w/e for items that
//perform different things at different points
//like create a onHit list, and add all items that activate
//on hit there. So when player gets hit, go through the list
//and use all of their onHit effects


global.enemyTypes = ["stiffNoone","stiffNormal","braveheartNormal","stiffRicochet","tinyman","stiffBuckshot"]
global.bossTypes = ["testStar"]
global.roomTypes = ["standard","item","boss","nextFloor", "debug"]; 
global.roomSubtypes_dict = {standard: ["normal"], item: ["normal"], boss: ["normal","elevator"], nextFloor: ["normal"]}
global.roomSubtypes = global.roomSubtypes_dict.standard;
global.itemPools = ["itemRoom", "bossItem"];

initiateDisplayObjInfo();

window_set_size(display_get_width(),display_get_height());


gpu_set_texfilter(false);

window_set_cursor(cr_none); //hide pc cursor todo: replace cursor with something fun :))
scribble_font_bake_outline_and_shadow("fnt_coolFont", "fnt_coolFont_outline",0,0, SCRIBBLE_OUTLINE.EIGHT_DIR_THICK ,0,false);

scribble_font_set_default("fnt_coolFont_outline");

window_set_size(1920,1080); //window_get_width

