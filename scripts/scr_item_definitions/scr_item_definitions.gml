function defineItems(){
	global.triggers = ["onPickup","onTick","onFire","onBulletTravel","onHit","onKill"]
	global.items = 
	[{
		name:"Spinny Bullet",
		pickupText: "It spins :)",
		infoText: "Your bullets spin and leave behind a protective barrier.",
		sprite: spr_itemTemp,
		itemPools : ["itemRoom"],
		
		onBulletTravel: spinnyBullet_onBulletTravel,
	},
	{
		name:"The Cactus",
		pickupText: "Prickly!",
		infoText: "On hit: Shoot out 8 bullets from your body.",
		sprite: spr_item_cactus,
		itemPools : ["itemRoom"],
		
		onHit: cactus_onHit,
	},
	{
		name:"Go-Back Jack",
		pickupText: "Do it again!",
		infoText: "After firing, fire again 1 second later",
		sprite: spr_item_backJack,
		itemPools : ["itemRoom"],

		onFire: backJack_onFire,
		onTick: backJack_onTick,
	},
	{
		name:"A Case of Aces",
		pickupText: "Done up loose for dealing.",
		infoText: "+4 Luck",
		sprite: spr_item_caseOfAces,
		itemPools : ["itemRoom"],
		
		onPickup: caseOfAces_onPickup,
	},
	{
		name:"Fanfare!",
		pickupText: "Ta taaaah!!",
		infoText: "Enemies explode in + upon kill",
		sprite: spr_item_fanfare,
		itemPools : ["itemRoom"],
		
		onKill: fanfare_onKill
	},
	{//5
		name:"Full Metal Jacket",
		pickupText: "I AM. IN A WORLD. OF $#!@.",
		infoText: "+1 durability",
		sprite: spr_item_FMJ,
		itemPools : ["itemRoom"],
		
		onPickup: fullMetalJacket_onPickup,
	}]
	for (var i = 0; i < array_length(global.items); i++){
		global.items[i].itemId = i;
		global.items[i].eventTriggers = getItemEventTriggers(i)
	}
}

function hasOnPickup(itemId){
	return array_contains(global.items[itemId].eventTriggers, "onPickup")
}
function getTriggerEvent(itemId, triggerName){
	return variable_struct_get(global.items[itemId],triggerName)
}
function triggerEvent(itemId, triggerName, arguments = {}){
	getTriggerEvent(itemId, triggerName)(arguments);
}

//runnerName: object_index, trigger as all inst with that object_index
function triggerAsAll(runnerName, func){
	SignalSend(string(runnerName) + ": Trigger", func);
}

function triggerAsInstance(runnerId, func){
	SignalSend(string(runnerId) + ": Trigger", func);
}

function subToTriggers(chosenName){
	SignalSubscribe(id, string(chosenName) + ": Trigger", function(func){func()});
	SignalSubscribe(id, string(id) + ": Trigger", function(func){func()});
}
function unsubToTriggers(chosenName){
	SignalUnsubscribe(id, string(chosenName) + ": Trigger");
	SignalUnsubscribe(id, string(id) + ": Trigger");
}