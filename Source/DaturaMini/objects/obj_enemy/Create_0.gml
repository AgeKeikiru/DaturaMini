event_inherited();

arr_timers[0] = 1;

value = 0; //point value

lst_uniqueHits = ds_list_create(); //points multiplier

//hazard = true;

fn_state_dead = function(){

	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		spd_y = -5;
		state_current = method(undefined, pstate_air);
		y--;
		
		weight = max(weight, 0.5);
		
	}

	spd_x = -image_xscale * 1;
	
	deadspin += (image_xscale * 3600 * global.timeFlow) / room_speed;
	
	if(cstate_time > 0.6 || on_ground()){
		instance_destroy();
	}

}