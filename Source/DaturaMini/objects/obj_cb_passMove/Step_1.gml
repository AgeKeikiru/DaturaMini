event_inherited();

visible = true;

roundSpd();

//testing movement without bounce to avoid a bug where attacking on a moving platform reverses movement

if(!platMove_x(spdInt_x)){
	
    //spd_x *= -1;    // Reverse the speed in case of collision
    //spdFrac_x = 0;
	
}

if(!platMove_y(spdInt_y)){
	
    //spd_y *= -1;    // Reverse the speed in case of collision
    //spdFrac_y = 0;
	
}