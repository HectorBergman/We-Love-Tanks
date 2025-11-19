menuInstances = {}
activeInstance = noone;

var main_clickables = clickables_main()
SignalSubscribe(id, "closeMenus", function(){
	SignalSend("closeMenuInstance")
	instance_destroy(activeInstance)
	activeInstance = noone;
})

SignalSubscribe(id, "activateMenuInstance", function(name){
	activateMenuInstance(name)
})


menuInstance_add("main", clickables_main())
menuInstance_add("pause", clickables_pause())


/// @function activateMenuInstance
/// @desc
/// @param {string} name
/// @returns {void}
function activateMenuInstance(name) {
	var menuInstance = variable_struct_get(menuInstances, name)
	if is_undefined(menuInstance){
		forceCrash("menuInstance named: " + string(name) + " does not exist!")
	}
    activeInstance = summonObject(
        obj_menuInstance,
        [
            ["name", name],
            ["clickables", menuInstance.clickables]
        ]
    );
}

SignalSend("activateMenuInstance", "main");
