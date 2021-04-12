event_inherited();

if(checkState(noone) && cstate_time > 4){

	facePlayer();
	
	switchState(choose(fn_state_atk_a1, fn_state_atk_b1));

}