if room == rm_editorMenu && reHandler == noone{
	reHandler = summonObject(obj_roomEditorHandler, [["handhand", id]]);
}
if obj_gameSettingHandler.gameState == gameStates.regular{
	if lethimcook{
		normal_summon();
		lethimcook = false;
	}
	if !normSummoned{
		prepSummon();
	}
}

