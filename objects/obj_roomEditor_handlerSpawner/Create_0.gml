if instance_number(obj_roomEditor_dragger) == 0{summonObject(obj_roomEditor_dragger);}
if instance_number(obj_roomEditor_menu) == 0{summonObject(obj_roomEditor_menu, [["x", 816], ["y", 0]]);}
if instance_number(obj_player) == 0{summonObject(obj_player, [["x", 960/2], ["y", 540/2]]);}
if instance_number(obj_pathFinderHandler) == 0{summonObject(obj_pathFinderHandler);}
if instance_number(obj_itemHandler) == 0{summonObject(obj_itemHandler);}
if instance_number(obj_button) == 0{summonObject(obj_button, [["x", 0], ["y", 0],["action", 3]]);}
if instance_number(obj_crosshair) == 0{summonObject(obj_crosshair, [["x", 960/2], ["y", 540/2]]);}
if instance_number(obj_cam) == 0{summonObject(obj_cam);}
instance_destroy();
