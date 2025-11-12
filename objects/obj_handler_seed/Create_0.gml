/// @function string_to_uint32(_str)
/// @param {string} _str
/// @returns {real} 32-bit unsigned integer
print("swag");
function string_to_uint32(_str) {
    var hash = 2166136261; // FNV offset basis
    var prime = 16777619;  // FNV prime
    var len = string_length(_str);

    for (var i = 1; i <= len; i++) {
        var c = ord(string_char_at(_str, i)); // Get ASCII code of character
        hash = hash ^ c;                      // XOR with hash
        hash = (hash * prime) & $FFFFFFFF;    // Multiply and keep it 32-bit
    }

    // Return as unsigned 32-bit (GML uses signed reals, so handle negatives)
    if (hash < 0) {
        hash += 4294967296; // add 2^32 to wrap around
    }

    return hash;
}

function initMenuArgs(objectArgs, _menuOffset){
	objectArguments = objectArgs
	menu = noone
	menuOffset = _menuOffset
	instanceArgumentsChoices = [];
	setInstanceArgumentsChoices()
	print("iac: ", instanceArgumentsChoices);
	instanceArgumentsChoices[0] = string(global.dungeonSeed)
	toggleMenu();
}

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateSeed(arg)});

function updateSeed(arg){ //this code stinks
	updateInstanceArgumentChoices(arg[0],arg[1], arg[2])
	global.dungeonSeed = string_to_uint32(instanceArgumentsChoices[0])
}
initMenuArgs([createArgument("seed", argumentTypes.freetext)], [0,0]);