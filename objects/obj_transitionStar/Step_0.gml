image_angle = image_angle + spinSpeed;
switch (phase){
	case tD_phase.start:
		TweenFire(id, EaseLinear, 0, false, delay, tweenTime*4, "x", x, x+(960+50)*4-offset[0])
		tween = TweenFire(id, EaseLinear, 0, false, delay, tweenTime*4, "y", y, y-(960+50)*4-offset[1])
		
		
		phase = tD_phase.wait;
		break;
	case tD_phase.wait:
		break;
	case tD_phase.completed:
		break;
}