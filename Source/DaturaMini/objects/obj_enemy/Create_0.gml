event_inherited();

arr_timers[0] = 1;

value = 0; //point value

lst_uniqueHits = ds_list_create(); //points multiplier

//hazard = true;

if(instance_exists(obj_player) && x > obj_player.x){
    
    image_xscale = -1;
    
}

fn_state_dead = function(){

	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		spd_y = -5;
		state_current = method(undefined, pstate_air);
		y--;
		
		weight = max(weight, 0.5);
		
		image_angle = 0;
		
	}

    fixed = false;

	spd_x = -image_xscale * 1;
	
	deadspin += (image_xscale * 3600 * global.timeFlow) / room_speed;
	
	if(cstate_time > 0.6 || on_ground() || collision_rectangle(bbox_left + -1, bbox_top + -1, bbox_right + 1, bbox_bottom + 1, objA_solid, false, true)){
		instance_destroy();
	}

}