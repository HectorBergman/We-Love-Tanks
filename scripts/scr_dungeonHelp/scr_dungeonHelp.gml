/// @function findRoomsByProperty(roomArray, propertyName, targetValue)
/// @description Returns array of room names where the specified property matches targetValue
/// @param {array} roomArray     Array of room structs
/// @param {string} propertyName Property to check (e.g. "Type", "Difficulty")
/// @param {any} targetValue     Value to match (e.g. "undefined", "boss")
/// @returns {array} Matching room names

function findRoomsByProperty(roomArray, propertyName, targetValue) {
    var foundRooms = [];
    
    for (var i = 0; i < array_length(roomArray); i++) {
        var _room = roomArray[i];
        print("thisiswhereuwanttogo");
		print(targetValue);
		print(variable_struct_exists(_room, propertyName))
		print(propertyName)
        // Check if property exists AND matches targetValue
        if (variable_struct_exists(_room, propertyName) 
        && (variable_struct_get(_room, propertyName) == targetValue)) {
            array_push(foundRooms, _room); // If key is "Room_Name"
        }
    }
    
    return foundRooms;
}


/// @function pickRandomRoomByType(roomArray, roomType)
/// @description Returns a RANDOM room struct where Type matches roomType
/// @param {array} roomArray   Array of room structs
/// @param {string} roomType   Type to filter by (e.g., "fun", "boss")
/// @returns {struct|undefined} Random room struct (or undefined if no matches)

function pickRandomRoomByType(roomArray, roomType) {
    var matchingRooms = findRoomsByProperty(roomArray, "type", roomType);
    print(matchingRooms);
    if (array_length(matchingRooms) == 0) {
		print("fuckme");
        return undefined; // No matches found
    }
    
    // Pick a random index from the filtered list
    var randomIndex = irandom(array_length(matchingRooms) - 1);
    return matchingRooms[randomIndex];
}