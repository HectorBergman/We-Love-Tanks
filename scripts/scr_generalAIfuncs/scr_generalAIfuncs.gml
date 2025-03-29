function coordinateFormula(x1,y1,x2,y2,t){
	return [x1+t*(x2-x1),y1+t*(y2-y1)]
}
function findNextCoordinate(stepSize, iteration, xOffset = 0, yOffset = 0){
	return coordinateFormula(x+xOffset,y+yOffset,playerTank.x,playerTank.y,stepSize*iteration)
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