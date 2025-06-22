function dropMoney(valueRange){
	var valueDropped = random_range(valueRange[0],valueRange[1]);
	valueDropped = round(valueDropped*100)/100
	var benjaminAmt = floor(valueDropped/100);
	valueDropped = valueDropped-benjaminAmt*100
	var hamiltonAmt = floor(valueDropped/10);
	valueDropped = valueDropped-hamiltonAmt*10
	var dollarAmt = floor(valueDropped);
	valueDropped = valueDropped-dollarAmt
	var quarterAmt = floor(valueDropped/0.25)
	valueDropped = valueDropped-quarterAmt*0.25
	var dimeAmt = floor(valueDropped/0.1);
	valueDropped = valueDropped-dimeAmt*0.1;
	var nickelAmt = floor(valueDropped/0.05);
	valueDropped = valueDropped-nickelAmt*0.05;
	var pennyAmt = floor(valueDropped/0.01);
	valueDropped = valueDropped-pennyAmt*0.01;
	if valueDropped == 0{
		print("dropped money successfully");
	}else{
		print("dropped money unsuccessfully");
	}
	print(valueDropped);
	var moneyValueArr = [100,10,1,0.25,0.1,0.05,0.01];
	var amtArr = [benjaminAmt,hamiltonAmt,dollarAmt,quarterAmt,dimeAmt,nickelAmt,pennyAmt];
	print(amtArr);
	for (var i = 0; i < 5; i++){
		print("newLoop");
		print(i);
		var val = moneyValueArr[i];
		print(val)
		print(amtArr[i])
		for (var j = 0; j < (amtArr[i]); j++){
			print("are we in");
			var zSpeed = 0;
			if val >= 1{
				zSpeed = random_range(-3,-6);
			}else{
				zSpeed = random_range(-4,-8);
			}
			summonObject(obj_dollar, [["x", x], ["y", y], 
			["dir", random_range(0,360)],["value", val],
			["zSpeed", zSpeed], ["velocity", random_range(0.1,1.5)]]);
		}
	}
}