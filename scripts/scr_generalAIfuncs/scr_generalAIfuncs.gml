function coordinateFormula(x1,y1,x2,y2,t){
	return [x1+t*(x2-x1),y1+t*(y2-y1)]
}
function findNextCoordinate(stepSize, iteration, xOffset = 0, yOffset = 0){
	return coordinateFormula(x+xOffset,y+yOffset,playerTank.x,playerTank.y,stepSize*iteration)
}
function getStepSize(){
	return detectionSquareWidth/distance
}