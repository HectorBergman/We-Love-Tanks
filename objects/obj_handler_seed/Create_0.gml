
function initMenuArgs(objectArgs, _menuOffset){
	objectArguments = objectArgs
	menu = noone
	menuOffset = _menuOffset
	instanceArgumentsChoices = [];
	setInstanceArgumentsChoices()
	toggleMenu();
}
initMenuArgs([createArgument("seed", argumentTypes.freetext)], [0,0]);