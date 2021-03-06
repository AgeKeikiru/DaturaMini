event_inherited();

hp = 5;

value = 150;

moveSpd = 0.6;

moveWait = 2;

aggro_w = 30;
aggro_h = 12;
aggro_ahead = aggro_w * 0.4;
aggro_above = aggro_h;

s_idle = spr_slime_idle;
s_move = spr_slime_move;
mask_index = s_idle;

fn_state_move = function(){

	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		input_x = choose(1, -1);
		animate = true;
		
		if(random(1) > 0.5){ input_x = -image_xscale; }
				
	}
	
	if(cstate_time > 0.8){
	
		input_x = 0;
		animate = false;
	
		switchState(noone);
		
	}

}

fn_state_atk_a1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		input_x = 0;
		
		sprite_index = spr_slime_attack1;
		image_xscale = (x > obj_player.x) ? -1 : 1;
				
	}
	
	//TODO EXH reduce windup
	
	if(cstate_time > 0.5){
	
		switchState(fn_state_atk_a2);
	
	}
	
}

fn_state_atk_a2 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		force_x = image_xscale * 5.5;
		hazard = true;
		
		spd_y = -3;
		state_current = method(undefined, pstate_air);
		
		sprite_index = spr_slime_attack2;
				
	}
	
	if(on_ground() && abs(force_x) < 1){
		
		sprite_index = spr_slime_idle;
		
		arr_timers[0] = 1;
		
		switchState(noone);
		
	}
	
}