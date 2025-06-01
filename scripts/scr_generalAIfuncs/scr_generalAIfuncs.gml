function coordinateFormula(x1,y1,x2,y2,t){
	return [x1+t*(x2-x1),y1+t*(y2-y1)]
}
function findNextCoordinate(stepSize, iteration, xOffset = 0, yOffset = 0){
	return coordinateFormula(x+xOffset,y+yOffset,obj_player.x,obj_player.y,stepSize*iteration)
}


/// @function collision_cone(x1, y1, x2, y2, angle, width_steps, obj, prec, notme)
/// @description Checks if ALL paths through a cone are colliding (returns true only if entire cone is blocked)
/// @param {real} x1,		   Starting x of cone
/// @param {real} y1,		   Starting y of cone
/// @param {real} x2,		   Center target x of cone
/// @param {real} y2,		   Center target y of cone
/// @param {real} angle        Total angle of cone in degrees
/// @param {int} width_steps   Number of steps to check along cone width (more = more accurate)
/// @param {object/inst} obj   Object to check collisions against
/// @param {bool} prec         Precise collision checking
/// @param {bool} notme        Check other instances (true) or all (false)
/// @returns {bool}            True if ALL paths are blocked, false if ANY path is clear

function collision_cone(_x1, _y1, _x2, _y2, _angle, _width_steps, _obj, _prec = false, _notme = true) {
    var _dir = point_direction(_x1, _y1, _x2, _y2);
    var _dist = point_distance(_x1, _y1, _x2, _y2);
    var _half_angle = _angle * 0.5;
    
    // Check center line first (optimization)
    if (!collision_line(_x1, _y1, _x2, _y2, _obj, _prec, _notme)) {
        return false;
    }
    
    // Check widening cone paths
    for (var _w = 1; _w <= _width_steps; _w++) {
        var _width_factor = _w / _width_steps;
        var _current_dist = _dist * _width_factor;
        
        // Left edge of cone
        var _left_x = _x1 + lengthdir_x(_current_dist, _dir - _half_angle);
        var _left_y = _y1 + lengthdir_y(_current_dist, _dir - _half_angle);
        if (!collision_line(_x1, _y1, _left_x, _left_y, _obj, _prec, _notme)) {
            return false;
        }
        
        // Right edge of cone
        var _right_x = _x1 + lengthdir_x(_current_dist, _dir + _half_angle);
        var _right_y = _y1 + lengthdir_y(_current_dist, _dir + _half_angle);
        if (!collision_line(_x1, _y1, _right_x, _right_y, _obj, _prec, _notme)) {
            return false;
        }
    }
    
    return true;
}


function findOptimizedPath() {
    // Get all breadcrumbs within a reasonable distance
    var nearbyCrumbs = ds_list_create();
    var crumbRadius = 300; // Pixels to search for crumbs
    var nearestCrumb = noone;
    var nearestDist = 999999;
    
    with (obj_breadCrumbs) {
        var dist = point_distance(x, y, other.x, other.y);
        if (dist < crumbRadius) {
            ds_list_add(nearbyCrumbs, id);
        }
    }
    
    // Find the crumb that gets us closest to player
    for (var i = 0; i < ds_list_size(nearbyCrumbs); i++) {
        var crumb = nearbyCrumbs[| i];
        var distToCrumb = point_distance(x, y, crumb.x, crumb.y);
        var distToPlayerFromCrumb = point_distance(crumb.x, crumb.y, obj_player.x, obj_player.y);
        
        // Prefer crumbs that are both close to us and lead toward player
        if (distToCrumb < nearestDist && distToPlayerFromCrumb < point_distance(x, y, obj_player.x, obj_player.y)) {
            // Verify path to crumb isn't blocked
            if (!collision_line(x, y, crumb.x, crumb.y, obj_solid, false, true)) {
                nearestCrumb = crumb;
                nearestDist = distToCrumb;
            }
        }
    }
    
    // Clean up
    ds_list_destroy(nearbyCrumbs);
    
    // Return array [nearestCrumb, distance]
    return [nearestCrumb, nearestDist];
}


function findAlternativePath(originalDir) {
    // Try 8 directions around original direction
    var angles = [0, 45, 90, 135, 180, 225, 270, 315];
    var bestAngle = originalDir;
    var bestScore = -1;
    
    for (var i = 0; i < array_length(angles); i++) {
        var testAngle = (originalDir + angles[i]) mod 360;
        var testX = x + lengthdir_x(64, testAngle); // Check 64 pixels ahead
        var testY = y + lengthdir_y(64, testAngle);
        
        if (!place_meeting(testX, testY, obj_solid)) {
            // Score based on how close this gets us to player
            var newDist = point_distance(testX, testY, obj_player.x, obj_player.y);
            var currentDist = point_distance(x, y, obj_player.x, obj_player.y);
            var _score = (currentDist - newDist) * 10; // Bonus for getting closer
            
            // Bonus for maintaining original direction
            if (abs(angle_difference(testAngle, originalDir)) < 45) _score += 50;
            
            if (_score > bestScore) {
                bestScore = _score;
                bestAngle = testAngle;
            }
        }
    }
    
    // Update movement vector
    movementVector[0] = lengthdir_x(movementSpeed, bestAngle);
    movementVector[1] = lengthdir_y(movementSpeed, bestAngle);
}