function listenForInput(name) {
    var groups = variable_struct_get_names(global.inputs);

    // Loop through top-level groups
    for (var i = 0; i < array_length(groups); i++) {
        var groupName = groups[i];
        var group = variable_struct_get(global.inputs, groupName);

        // Check if the input exists in this group
        if (variable_struct_exists(group, name)) {
            var entry = variable_struct_get(group, name);
            if (entry.func != undefined) {
                return entry.func();
            } else {
                forceCrash("Input variable '" + string(name) + "' has no func!");
            }
        }
    }

    // If not found
    forceCrash("Input variable '" + string(name) + "' does not exist!");
}
     
function input_init(){
	global.inputs = {
    
	    movement: {
	        up:        { func: function(){ return keyboard_check(ord("W")); } },
	        down:      { func: function(){ return keyboard_check(ord("S")); } },
	        left:      { func: function(){ return keyboard_check(ord("A")); } },
	        right:     { func: function(){ return keyboard_check(ord("D")); } },

	        up_press:   { func: function(){ return keyboard_check_pressed(ord("W")); } },
	        down_press: { func: function(){ return keyboard_check_pressed(ord("S")); } }
	    },

	    actions: {
	        shoot:			{ func: function(){ return mouse_check_button(mb_left); } },
	        click:			{ func: function(){ return mouse_check_button_pressed(mb_left); } },
	        click_right:	{ func: function(){ return mouse_check_button_pressed(mb_right); } },
	        click_released:	{ func: function(){ return mouse_check_button_released(mb_left); } },
	        interact:		{ func: function(){ return keyboard_check(ord("E")); } },
	        run:			{ func: function(){ return keyboard_check(vk_shift); } }
	    },

	    debug: {
	        unlock_and_kill: { func: function(){ return keyboard_check(ord("T")); } },
	        unlock:          { func: function(){ return keyboard_check(ord("G")); } }
	    },

	    keys: {
	        escape:     { func: function(){ return keyboard_check_pressed(vk_escape); } },
	        control:    { func: function(){ return keyboard_check(vk_control); } },
	        c_key:      { func: function(){ return keyboard_check(ord("C")); } },
	        copy:       { func: function(){ return keyboard_check(ord("C")) && keyboard_check(vk_control); } },
	        up_press:   { func: function(){ return keyboard_check_pressed(vk_up); } },
	        down_press: { func: function(){ return keyboard_check_pressed(vk_down); } },
	        confirm:    { func: function(){ return keyboard_check_pressed(vk_enter); } },
	        space:      { func: function(){ return keyboard_check_pressed(vk_space); } },
	        space_held: { func: function(){ return keyboard_check(vk_space); } },
	        delete:     { func: function(){ return keyboard_check_pressed(vk_delete); } }
		}
	}
	//input_reset()
	print(global.inputs);
}

