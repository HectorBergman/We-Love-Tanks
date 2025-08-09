SignalUnsubscribe(id, "editor_pointer: clicked itemMenu");
cleanUpSearchForClick();
ds_queue_destroy(actionsOrder);
instance_destroy(obj_editor_displayObjects);