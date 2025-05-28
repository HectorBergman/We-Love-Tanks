currentItems = ds_list_create();
onHitItems = ds_list_create();
onBulletTravelItems = ds_list_create();

allItems = ds_list_create();

global.itemRoomPool = ["cactus","spinnyBullet", "backJack"];


//in the future, create seperate lists or w/e for items that
//perform different things at different points
//like create a onHit list, and add all items that activate
//on hit there. So when player gets hit, go through the list
//and use all of their onHit effects
global.items = {
	spinnyBullet: {
		name:"Spinny Bullet",
		pickupText: "It spins :)",
		sprite: spr_itemTemp,
		onBulletTravel: spinnyBullet_onBulletTravel,
		
	},
	cactus: {
		name:"The Cactus",
		pickupText: "Prickly!",
		sprite: spr_item_cactus,
		onHit: cactus_onHit,
	},
	backJack: {
		name:"Go-Back Jack",
		pickupText: "Do it again!",
		sprite: spr_item_backJack,
		onFire: backJack_onFire,
		onTick: backJack_onTick,
	}
}