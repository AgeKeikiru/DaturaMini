event_inherited();

if(stun <= 0){

	if(checkState(noone) || checkState(fn_state_move)){
	
		var _box = fn_getAggroRect();
	
		if(collision_rectangle(_box.x1, _box.y1, _box.x2, _box.y2, obj_player, false, true) && arr_timers[0] <= 0){
			switchState(fn_state_atk_a1);
		}else if(checkState(noone) && cstate_time > moveWait){
			switchState(fn_state_move);
		}
	
	}

}