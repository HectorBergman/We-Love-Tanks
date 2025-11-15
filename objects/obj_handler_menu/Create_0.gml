menuInstances = {}
activeInstance = noone;

var mainMenu_clickables = [clickable_create(
	obj_button, 
	[["x", 64],["y",160],["image_xscale", 10],["image_yscale",2],["action",1],["text","Play!"]],
	popup_createInfo(true)
)]

menuInstance_add("mainMenu",mainMenu_clickables)


/// @function activateMenuInstance
/// @desc
/// @param {string} name
/// @returns {void}
function activateMenuInstance(name) {
    SignalSend("activateMenuInstance", name);
	print(variable_struct_get(menuInstances, name))
    activeInstance = summonObject(
        obj_menuInstance,
        [
            ["name", name],
            ["clickables", variable_struct_get(menuInstances, name).clickables]
        ]
    );
}

activateMenuInstance("mainMenu");