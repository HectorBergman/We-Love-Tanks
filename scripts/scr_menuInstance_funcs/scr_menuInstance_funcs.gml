function menuInstance_activate(name){
	SignalSend("activateMenuInstance", name);
}

//TBA: backgrounds and non-clickable elements
/// @function menuInstance_add
/// @param {string} name the name of the menu instance
/// @param {array<struct>} clickables an array of clickables
/// @returns {real}
function menuInstance_add(name, clickables){
	if (variable_struct_exists(menuInstances, name)) {
		forceCrash("menuInstance of name " + name + " already exists!")
	}
	variable_struct_set(menuInstances, name, {clickables: clickables})
}

/// @function clickable_create
/// @param {asset} obj_index
/// @param {struct} variables
/// @param {struct} [popup_info]
/// @returns {struct}
function clickable_create(obj_index, variables, popup_info = popup_createInfo(false)) {
    return {
        obj_index:   obj_index,
        variables:   variables,
        doesPopup:  popup_info.doesPopup,
		popup_info : {popupTime : popup_info.popupTime, easingFunc : popup_info.easingFunc}
    };
}

/// @function popup_createInfo
/// @param {bool} doesPopUp
/// @param {real} [popupTime=10]
/// @param {method} [easingFunc=EaseOutBounce]
/// @returns {struct}
function popup_createInfo(doesPopup, popupTime = 120, easingFunc = EaseOutElastic) {
    return {
        doesPopup: doesPopup,
        popupTime: popupTime,
        easingFunc: easingFunc
    };
}

function menuInstance_deactivate(name){
	SignalSend("closeMenuInstance", name);
}