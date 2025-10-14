#macro enemyBarrelLength 20
function bulletInfo_create(damage,bounces,durability,_speed,extraArgs = {}){
	var bulletInfo = {
		damage : damage,
		bounces : bounces,
		durability : durability,
		speed : _speed,
	}
	var keys = variable_struct_get_names(extraArgs);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        variable_struct_set(bulletInfo, key, variable_struct_get(extraArgs, key));
    }
	return bulletInfo
}



function fireBullet_defaultSummonStruct(bulletSpeed, maxBounce, damage, barrelLength, bulletHp, extraArgs = {}) {
    var struct = {
        bulletSpeed: bulletSpeed,
        maxBounce: maxBounce,
        damage: damage,
        barrelLength: barrelLength,
        durability: bulletHp
    };
    struct_addArgs(struct,extraArgs)
    return struct;
}

function struct_addArgs(struct,argsStruct){
	var keys = variable_struct_get_names(argsStruct);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        variable_struct_set(struct, key, variable_struct_get(argsStruct, key));
    }
}