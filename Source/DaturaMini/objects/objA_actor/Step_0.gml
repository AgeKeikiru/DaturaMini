var
_state = state_current;

if(stun <= 0){

	if(player && !input_lock && (cstate_curr == noone || !move_lock)){
		
		input_x = scr_playerIO([en_input.UNI_RIGHT]) + -scr_playerIO([en_input.UNI_LEFT]);
		
	}

	if(abs(input_x)){
	
		image_xscale = input_x;
		spd_x = input_x * moveSpd;
		
		if(player && global.hyperActive){
		    
		    spd_x *= 1.5;
		    
		}
		
		if(sprite_index == s_idle && s_idle != s_move){
			sprite_index = s_move;
		}
	
	}else{

		spd_x = 0;
		
		if(sprite_index == s_move && s_idle != s_move){
			sprite_index = s_idle;
		}

	}

}

if(state_current != noone){
	state_current();
}

if(cstate_curr != noone){
	cstate_curr();
}

state_is_new = _state != state_current;
state_timer = state_is_new ? 0 : (state_timer + global.timeFlow);

if(stun > 0){
	stun += -global.timeFlow / room_speed;
}else{
	cstate_time += global.timeFlow / room_speed;
}

if(iFrames > 0){
	iFrames += -global.timeFlow / room_speed;
}

for(var _i = 0; _i < array_length(arr_timers); _i++){
	
	if(arr_timers[_i] > 0){ arr_timers[_i] += -global.timeFlow / room_speed; }
	
}

force_x = scr_approach(force_x, 0, 0.15 * global.timeFlow);
force_y = scr_approach(force_y, 0, 0.15 * global.timeFlow);

#region //movement calculation

    if(!fixed){
        
    	roundSpd();
    
    	// Let the instance decide what to do when it can't move
    	if(!move_x((spdInt_x + force_x) * global.timeFlow, true)){
    	    spd_x = 0;
    	    spdFrac_x = 0;
    	}
    
    	if(!move_y((spdInt_y + force_y) * global.timeFlow)){
    	    spd_y = 0;
    	    spdFrac_y = 0;
    	}
	
    }

#endregion

#region //sudden wall-clip handling

	if(collision_rectangle(bbox_left, bbox_top, x, bbox_bottom, obj_cb_wall, false, true)){
		x++;
	}
	
	if(collision_rectangle(bbox_right, bbox_top, x, bbox_bottom, obj_cb_wall, false, true)){
		x--;
	}

#endregion

if(boss && bossStun > 0){
    
    bossStun += -(0.5 * global.timeFlow) / room_speed;
    
}

image_speed = global.timeFlow;