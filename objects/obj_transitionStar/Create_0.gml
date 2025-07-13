tween = noone;
phase = tD_phase.start
ease = EaseOutQuad;
spinEase = EaseOutQuint

SignalSubscribe(id,"transitionEnd", function(arg){ if arg[0] == count{instance_destroy()}})