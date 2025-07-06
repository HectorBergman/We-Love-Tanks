//This will run every time game is booted, if some other object is needed on bootup,
//please summon using this object.
timer = 0;
global.editorPause = false;

//print(randomize());
//223416234
random_set_seed(3403208798);
global.dungeonSeed = random_get_seed();
global.currentSeed = global.dungeonSeed;
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


global.itemRoomPool = ["cactus","spinnyBullet", "backJack","caseOfAces", "fanfare", "fullMetalJacket"];


//in the future, create seperate lists or w/e for items that
//perform different things at different points
//like create a onHit list, and add all items that activate
//on hit there. So when player gets hit, go through the list
//and use all of their onHit effects
global.items = {
	spinnyBullet: {
		name:"Spinny Bullet",
		pickupText: "It spins :)",
		infoText: "Your bullets spin and leave behind a protective barrier.",
		sprite: spr_itemTemp,
		onBulletTravel: spinnyBullet_onBulletTravel,
		
	},
	cactus: {
		name:"The Cactus",
		pickupText: "Prickly!",
		infoText: "On hit: Shoot out 8 bullets from your body.",
		sprite: spr_item_cactus,
		onHit: cactus_onHit,
	},
	backJack: {
		name:"Go-Back Jack",
		pickupText: "Do it again!",
		infoText: "After firing, fire again 1 second later",
		sprite: spr_item_backJack,
		onFire: backJack_onFire,
		onTick: backJack_onTick,
	},
	caseOfAces: {
		name:"A Case of Aces",
		pickupText: "Done up loose for dealing.",
		infoText: "+4 Luck",
		sprite: spr_item_caseOfAces,
		onPickup: caseOfAces_onPickup
	},
	fanfare: {
		name:"Fanfare!",
		pickupText: "Ta taaaah!!",
		infoText: "Enemies explode in + upon kill",
		sprite: spr_item_fanfare,
		onKill: fanfare_onKill
	},
	fullMetalJacket: {
		name:"Full Metal Jacket",
		pickupText: "I AM. IN A WORLD. OF $#!@.",
		infoText: "+1 durability",
		sprite: spr_item_FMJ,
		onPickup: fullMetalJacket_onPickup
	}
}

window_set_size(display_get_width(),display_get_height());


gpu_set_texfilter(false);

window_set_cursor(cr_none); //hide pc cursor todo: replace cursor with something fun :))
scribble_font_bake_outline_and_shadow("fnt_coolFont", "fnt_coolFont_outline",0,0, SCRIBBLE_OUTLINE.EIGHT_DIR_THICK ,0,false);

scribble_font_set_default("fnt_coolFont_outline");

window_set_size(1920,1080); //window_get_width