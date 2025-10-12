#macro enemyBarrelLength 20
function bulletInfo_create(damage,bounces,durability,speed,extraArgs = {}){
	var bulletInfo = {
		damage : 100,
		bounces : 3,
		durability : 1,
		speed : 2,
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
    print(struct)
	print(extraArgs);
    var keys = variable_struct_get_names(extraArgs);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        variable_struct_set(struct, key, variable_struct_get(extraArgs, key));
    }
	print("fireBullet")
    print(struct)
    return struct;
}