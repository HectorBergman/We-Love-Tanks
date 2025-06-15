collideable = true;
enum crumbleWallState {
	normal,
	crumble
}
rememberBullets = ds_map_create();

crumbleTime = 120;
crumbleTimer = crumbleTime;
crumbleTimerIncoming = 0;
state = crumbleWallState.normal;

function processDsMapValues(dsMap) {
    var key = ds_map_find_first(dsMap);
    while (key != undefined) {
        var value = ds_map_find_value(dsMap, key);
        // Do something with value here
        value = processValue(value); // Your processing function
		if value < 1{
			ds_map_delete(dsMap,key)
		}else{
			ds_map_replace(dsMap, key, value);
		}
        key = ds_map_find_next(dsMap, key);
    }
}

function processValue(val) {
    // Example processing - modify as needed
    return val - 1; // Or any other operation
}