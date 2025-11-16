menuInstances = {}
activeInstance = noone;

var mainMenu_clickables = clickables_mainMenu()
SignalSubscribe(id, "closeMenus", function(){
	//SignalSend("closeMenuInstance")
	instance_destroy(activeInstance)
	activeInstance = noone;
})

SignalSubscribe(id, "activateMenuInstance", function(name){
	activateMenuInstance(name)
})


menuInstance_add("mainMenu",mainMenu_clickables)


/// @function activateMenuInstance
/// @desc
/// @param {string} name
/// @returns {void}
function activateMenuInstance(name) {
	print("activateMenuInstance")
    activeInstance = summonObject(
        obj_menuInstance,
        [
            ["name", name],
            ["clickables", variable_struct_get(menuInstances, name).clickables]
        ]
    );
}

SignalSend("activateMenuInstance", "mainMenu");
