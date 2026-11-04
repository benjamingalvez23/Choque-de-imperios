if(speed!=0){
	distance -=spd;
	
	if(distance <= 0){
		speed = 0;
	}
}

if(speed == 0){
	if(keyboard_check(ord("D"))){
		hspeed = spd;
		distance = 32;
	}
	else if (keyboard_check(ord("A"))){
		hspeed = -spd;
		distance = 32;
	}
	else if(keyboard_check(ord("W"))){
		vspeed = -spd;
		distance = 32;
	}
	else if(keyboard_check(ord("S"))){
		vspeed = spd;
		distance = 32;
	}
}
