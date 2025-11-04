playerInput()
if control && cKey && !hasCopied{
	copy = true;
	hasCopied = true;
}

if !(control && cKey){
	hasCopied = false;
}