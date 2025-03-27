

x = parent.x
y = parent.y
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 90;
fire = false;
state = cannonEnemyStates.scanning;

scanningArea = pi/2
scanningStep = (pi/2)/100
scanningPoint = degtorad(point_direction(x,y,playerTank.x,playerTank.y));
print(scanningPoint);
stepTilSwitchWhole = 200;
stepsTilSwitch = stepTilSwitchWhole/2;
image_angle = radtodeg(scanningPoint);
playerSeenLastStep = false;
scanningDirection = 1;