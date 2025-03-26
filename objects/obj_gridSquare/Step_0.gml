
if (breadCrumbTimer == 5){
	distance = point_distance(x,y,playerTank.x,playerTank.y)
}
breadCrumbTimer--


if (breadCrumbTimer == 1){
	if (distance < 32*5 ){
	}
}else if (breadCrumbTimer == 0){
	if (distance < 32*5){
		if (!collision_line(x+16, y+16, playerTank.x, playerTank.y, obj_wall, false, true) && !instance_exists(activeBreadcrumb)){
			if squareNo == 295{
				print("YUP!");
			}
			activeBreadcrumb = summonObject(obj_breadCrumbs, [["x" , x], ["y", y]]);
		}else if (instance_exists(activeBreadcrumb) && collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true) && activeBreadcrumb.lifeTime < 0){
			instance_destroy(activeBreadcrumb);
		}
	}else if distance >= 32*5 && instance_exists(activeBreadcrumb) && activeBreadcrumb.lifeTime < 0{
		instance_destroy(activeBreadcrumb);
	}
	wallSeen = 0;
	breadCrumbTimer = 5;
}