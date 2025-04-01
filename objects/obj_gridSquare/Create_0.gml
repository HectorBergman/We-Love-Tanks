depth = 99
activeBreadcrumb = noone;

breadCrumbTimer = 1;
breadCrumbTime = 5;

breadCrumbRadius = 2;

distance = point_distance(x, y, playerTank.x, playerTank.y);
distanceX = abs(playerTank.x - x);
distanceY = abs(playerTank.y - y);
detectionSquareWidth = 6;
wallSeen = 0;
playerSeen = false;
/*for (var i = -1; i < 2; i++){
	for (var j = -1; j < 2; j++){
		if (collision_line(x, y, x+i*32, y+j*32, obj_wall, false, true)){
			instance_destroy();
		}
	}
}

