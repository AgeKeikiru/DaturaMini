event_inherited();

noCount = false; //if true, not counted towards enemy kill count
global.bonus_kill[1] += 1;

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

fn_state_bossDead = function(){

	static _s_x = 0;
	static _s_time = 0;
	
	globalvar G_id;
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		startNim();
		
		obj_player.cam_xTgt = -obj_player.x + x;
		obj_player.cam_yTgt = max(y, 1);
		
		_s_x = x;
		_s_time = 0;
		G_id = id;
		
		with obj_enemy{
		    
		    if(id != G_id){
		        instance_destroy();
		    }
		    
		}
		
		audio_sound_gain(obj_ui.bgmCurr, 0, 0);
		
	}

    x = _s_x + sin(current_time / 10);

    if(cstate_time > 1){
		
		with scr_place(obj_itemGlow_score, random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom)){
		    value = 0;
		}
		
		_s_time += TICK;
		
		if(_s_time > 0.2){
		    
		    _s_time = 0;
		    
		    audf_playSfx(sfx_explode);
		    
		}
		
	}
	
	if(cstate_time > 3){
		
		with obj_ui{
			
			fc_next = fc_clear_1;
			fc_delay = 0.5;
			
		}
		
		instance_destroy();
		
	}

}