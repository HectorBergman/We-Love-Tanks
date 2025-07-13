switch (phase){
	case tD_phase.start:
		TweenFire(id, ease, 0, false, delay, tweenTime, "x", x, x+960+50-offset[0])
		tween = TweenFire(id, ease, 0, false, delay, tweenTime, "y", y, y-960-50-offset[1])
		
		phase = tD_phase.wait;
		break;
	case tD_phase.wait:
		if !TweenIsActive(tween){
				if isLast && loops == 0{
					SignalSend("lastBannerFinishedStart")
					loops++
				}else if isLast && loops == 1{
					SignalSend("lastBannerFinishedEnd")
					loops++
				}
				if isBlue && !sentSignal{
					sentSignal = true;
					SignalSend("blueFinished");
				}
			}
		
		break;
	case tD_phase.completed:
		break;
}