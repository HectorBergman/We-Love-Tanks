currentItems = ds_list_create();
onHitItems = ds_list_create();
onBulletTravelItems = ds_list_create();

allItems = ds_list_create();

global.itemRoomPool = ["cactus","spinnyBullet", "backJack","caseOfAces"];


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
	}
}