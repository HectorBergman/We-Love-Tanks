playerInput()
if control && cKey && !hasCopied{
	copy = true;
	hasCopied = true;
	print("yeaaah");
}

if !(control && cKey){
	hasCopied = false;
}