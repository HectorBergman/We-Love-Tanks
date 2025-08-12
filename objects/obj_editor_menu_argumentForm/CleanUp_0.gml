SignalUnsubscribe(id, "closeMenu: " + string(instanceId))
SignalUnsubscribe(id, "updateInstance: " + string(instanceId))
SignalUnsubscribe(id, "closeDropdown: " + string(instanceId) + string(argumentIndex));
SignalUnsubscribe(id, "textbox: selected");
SignalUnsubscribe(id,"editor_clicked")
cleanUpSearchForClick();