draw_self();
/*var interval = 1;
var distanceToCrumb = 0;
var breadCrumb = 0;
var vector = [0,0]
var reachable = false;
for (var i = 0; i < instance_number(obj_breadCrumbs); ++i;){
		breadCrumb = instance_find(obj_breadCrumbs,i);
		distanceToCrumb = point_distance(x,y,breadCrumb.x,breadCrumb.y);
		reachable = true;
		vector = normalizedVector(id, breadCrumb);
		for (var j = 16; j < distanceToCrumb; j = j+interval){
			if collision_rectangle(x+vector[0]*j-16, y+vector[1]*j-16, x+vector[0]*(j+interval)+16, y+vector[1]*(j+interval)+16, obj_wall, 0, 1){
				reachable = false;
				break;
			}
		}
		if reachable{
			var crumbDistance = point_distance(playerTank.x, playerTank.y, breadCrumb.x, breadCrumb.y);
			if (crumbDistance) < nearestCrumbDistance{
				nearestCrumb = breadCrumb
				nearestCrumbDistance = crumbDistance
			}
		}
	}
	for (var j = 16; j < distanceToCrumb; j = j+interval){
		draw_rectangle_color(x+vector[0]*j-16, y+vector[1]*j-16, x+vector[0]*(j+interval)+16, y+vector[1]*(j+interval)+16, c_orange,c_orange,c_orange,c_orange,0)
	}
