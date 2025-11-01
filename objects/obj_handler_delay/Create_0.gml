delayArr = [];
SignalSubscribe(id, "delay", function(args){
	setTimer(args[0],args[1],args[2],args[3]);
})




function setTimer(author, action, time, arguments){
	delayArr[array_length(delayArr)] = {
		author: author, 
		action: method(author, action), 
		time: round(time), 
		arguments: arguments
	};
}

function loopTimers(){
	var index = 0;
	for (var i = 0; i < array_length(delayArr); i++){
		if tickTimer(delayArr[index]){
			index++
		}else{
			array_delete(delayArr,index,1);
		}
	}
}
function tickTimer(timer){
	if timer.time == 0{
		if instance_exists(timer.author){
			with timer.author{
				timer.action(timer.arguments);
			}
		}
		return false;
	}else{
		timer.time--;
		return true;
	}
}