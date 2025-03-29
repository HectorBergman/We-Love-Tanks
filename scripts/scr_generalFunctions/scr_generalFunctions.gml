
/// @function summonObject(obj, arguments, _x, _y, _depth)
/// @description Creates an instance of `obj` at (_x, _y) with a depth of `_depth`, and assigns arguments from the `arguments` array
/// @param {object} obj The object to create
/// @param {array} arguments An array of sub-arrays, where each sub-array contains [argument_name, argument_value]
/// @param {number} _x The x-coordinate (default: x)
/// @param {number} _y The y-coordinate (default: y)
/// @param {number} _depth The depth (default: depth)

function summonObject(obj, arguments = noone, _x = x, _y = y, _depth = depth){
	var struct = 1;
	if (arguments != noone){
	    // Create a ds_map to hold the arguments
	    var argumentMap = ds_map_create();

	    // Loop through the arguments array
	    for (var i = 0; i < array_length(arguments); i++) {
	        // Get the current sub-array (which contains [argument_name, argument_value])
	        var arg = arguments[i];

	        // Ensure the sub-array has exactly 2 elements (name and value)
	        if (array_length(arg) == 2) {
	            var argName = arg[0]; // Name of the argument (can be a string)
	            var argValue = arg[1]; // Value of the argument

	            // Add the argument to the ds_map
	            argumentMap[? argName] = argValue;
	        } else {
	            show_debug_message("Invalid argument at index " + string(i) + ": Expected [name, value].");
	        }
	    }
		//convert to struct
		struct = ds_map_to_struct(argumentMap)
		ds_map_destroy(argumentMap);
	    // Create the instance with the argument map
	}else{
		struct = {}
	}
    return instance_create_depth(_x, _y, _depth, obj, struct);
    
}


/// @function ds_map_to_struct(dsMap)
/// @description Converts a ds_map to a struct.
/// @param {ds_map} dsMap The ds_map to convert.
/// @return {struct} The resulting struct.
function ds_map_to_struct(dsMap) {
    // Create an empty struct
    var resultStruct = {};

    // Get the list of keys from the ds_map
    var keys = ds_map_keys_to_array(dsMap);

    // Loop through the keys and copy them to the struct
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var value = dsMap[? key];

        // Add the key-value pair to the struct
        resultStruct[$ key] = value;
    }

    return resultStruct;
}

//this is way better
function print(text){
	show_debug_message(text);
}

function stepCollisionWhileWithFailCon(object, step, horizontal){
	global.preWhileCoord = [x,y];
	while(!place_meeting(x+step*horizontal,y+step*!horizontal,object)){
		x += step*horizontal;
		y += step*!horizontal
		global.whileFail++
		if (global.whileFail == global.whileFailLimit){
			x = global.preWhileCoord[0]
			y = global.preWhileCoord[1]
			global.whileFail = 0
			break;
		}
	}
}


function is_in_range(value, minimum, maximum) {
    return value > minimum && value < maximum;
}

function normalizedVector(objectA, objectB){
	// Get direction vector
	var dir_x = objectB.x - objectA.x;
	var dir_y = objectB.y - objectA.y;

	// Normalize using point_distance (more efficient than manual calculation)
	var dist = point_distance(0, 0, dir_x, dir_y);
	if (dist > 0) {
	    dir_x /= dist;
	    dir_y /= dist;
	}
	return [dir_x, dir_y];
}

/// @function getWallCoords(wall, quadrant)
/// @description Returns the coordinate of a corner of a wall instance
/// @param {instance} wall The wall instance to check (obj_wall or compatible)
/// @param {int} quadrant Which corner to get (0-3, counter-clockwise from top-right)
/// @returns {array<int>} [x,y] coordinates of the requested corner
/// @example
/// var corner = getWallCoords(wall_instance, 2); // Gets bottom-left corner

function getWallCoords(wall, quadrant){
	var xScale = wall.image_xscale;
	var yScale = wall.image_yscale;
	var _x = wall.x;
	var _y = wall.y;
	if quadrant == 0{
		return [_x + 32*xScale,_y]
	}
	if quadrant == 1{
		return [_x,_y]
	}
	if quadrant == 2{
		return [_x, _y + 32*yScale];
	}
	if quadrant == 3{
		return [_x + 32*xScale, _y + 32*yScale];
	}
}