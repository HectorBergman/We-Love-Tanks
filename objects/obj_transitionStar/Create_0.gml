tween = noone;
phase = tD_phase.start
ease = EaseOutQuad;
spinEase = EaseOutQuint
scale = 1;
depth = -10000
image_xscale = scale;
image_yscale = scale;
SignalSubscribe(id,"transitionEnd", function(arg){ if arg[0] == transitionId{instance_destroy()}})