switch (tP){
	case transitionPhase.start:
		var startOffset = [32,-32]
		var starSpacing = 60;
		var tweenTime = 30*tMult;
		var trueBaseDelay = 15*tMult;
		var delayIncrement = 2*tMult;
		var whiteWait = 6*tMult;
		var totalDelay = trueBaseDelay+delayIncrement*13;
		var redMax = 14;
		var redIndex = 0;
		var whiteMax = 11;
		var whiteIndex = 1;
		var spr = spr_cube_blue;
		
		summonObject(obj_transitionStripe,
			[["x", -600-45+startOffset[0]], ["y", 960+startOffset[1]],
			["sprite_index", spr], ["delay", 0],
			["tweenTime", tweenTime], ["totalDelay", totalDelay],
			["isLast", false],["isBlue", true],["offset", startOffset], ["transitionId", transitionId]]);
		for (var i = 0; i < 31; i++){
			summonObject(obj_transitionStar,
				[["x", -600-180-i*starSpacing+64-48+startOffset[0]], ["y", 960+i*starSpacing+48+startOffset[1]], ["delay", 0],
				["tweenTime", tweenTime], ["totalDelay", totalDelay], ["tMult", tMult],
				["spinSpeed", 2.4],["offset", startOffset], ["transitionId", transitionId]]);
		}
		for (var i = 0; i < 29; i++){
			summonObject(obj_transitionStar,
				[["x", -600-200-i*starSpacing-32-48+startOffset[0]], ["y", 960+i*starSpacing+48+startOffset[1]], ["delay", 0],
				["tweenTime", tweenTime], ["totalDelay", totalDelay], ["tMult", tMult],
				["spinSpeed", 2.5],["offset", startOffset], ["transitionId", transitionId]]);
		}
		for (var i = 0; i < 27; i++){
			summonObject(obj_transitionStar,
				[["x", -600-220-i*starSpacing-32-96-48+startOffset[0]], ["y", 960+i*starSpacing+48+startOffset[1]], ["delay", 0],
				["tweenTime", tweenTime], ["totalDelay", totalDelay], ["tMult", tMult],
				["spinSpeed", 2.6],["offset", startOffset], ["transitionId", transitionId]]);
		}
		for (var i = 0; i < whiteWait; i++){
			spr = spr_cube_red;
			summonObject(obj_transitionStripe,
				[["x", -600+redIndex*95+startOffset[0]], ["y", 960+startOffset[1]],
				["sprite_index", spr], ["delay", trueBaseDelay+i*delayIncrement],
				["tweenTime", tweenTime], ["totalDelay", totalDelay],
				["isLast", false],["isBlue", false],["offset", startOffset], ["transitionId", transitionId]]);
			redIndex += 2;
		}
		for (var i = 0; i < 11; i++){
			var baseDelay = trueBaseDelay;
			var index = 0;
			spr = spr_cube_white;
			if i mod 2 == 0 && redIndex < redMax{
				spr = spr_cube_red
				index = redIndex;
				redIndex += 2
			}else{
				index = whiteIndex;
				whiteIndex += 2;
				baseDelay += whiteWait
			}
			var last = false;
			if i == 10{
				last = true;
			}
				
			summonObject(obj_transitionStripe,
				[["x", -600+index*95+startOffset[0]], ["y", 960+startOffset[1]],
				["sprite_index", spr], ["delay", i*delayIncrement+baseDelay],
				["tweenTime", tweenTime], ["totalDelay", totalDelay],
				["isLast", last],["isBlue", false],["offset", startOffset], ["transitionId", transitionId]]);
		}
		transitionId++
		SignalSubscribe(id,"lastBannerFinishedStart", function(){
			SignalUnsubscribe(id,"lastBannerFinishedStart");
			tP = transitionPhase.wait2; 
			ds_list_add(delayNewRoom, "general")
			transitionSignal();
			SignalSend("transport");
			SignalSubscribe(id,"lastBannerFinishedEnd", function(){
					SignalSend("transitionEnd", [transitionId-1]);
					SignalUnsubscribe(id,"lastBannerFinishedEnd");
				})
			})
		tP = transitionPhase.wait;
		break;
	case transitionPhase.wait:
		break;
	case transitionPhase.wait2:
		waitTimer--;
		if waitTimer <= 0{
			tP = transitionPhase.inactive
			global.transitionPause = false;
		}
		break;
}