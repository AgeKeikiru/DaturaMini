event_inherited();

visible = true;

roundSpd();

if(!platMove_x(spdInt_x)){
	
    spd_x *= -1;    // Reverse the speed in case of collision
    spdFrac_x = 0;
	
}

if(!platMove_y(spdInt_y)){
	
    spd_y *= -1;    // Reverse the speed in case of collision
    spdFrac_y = 0;
	
}