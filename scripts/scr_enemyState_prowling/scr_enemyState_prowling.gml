function enemyState_prowling(){
	for (var i = 0; i < instance_number(obj_breadCrumbs); ++i;){
		breadCrumbs[i][0] = instance_find(obj_breadCrumbs,i);
		if !collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true){
			var crumbDistance = point_distance(x, y, breadCrumbs[i][0].x, breadCrumbs[i][0].y);
			if (crumbDistance) < nearestCrumbDistance{
				nearestCrumb = breadCrumbs[i][0]
				nearestCrumbDistance = crumbDistance
			}
		}
	}
}
