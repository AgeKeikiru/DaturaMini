event_inherited();

if(checkState(noone) && cstate_time > 1.5){

	facePlayer();
	
	if(x > room_width * 0.8){
	    image_xscale = -1;
	}
	
	if(x < room_width * 0.2){
	    image_xscale = 1;
	}
	
	switchState(choose(fn_state_atk_a1, fn_state_atk_b1));

}