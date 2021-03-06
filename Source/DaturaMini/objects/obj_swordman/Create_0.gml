event_inherited();

hp = 15;

value = 300;

moveSpd = 0.6;

moveWait = 1;

aggro_w = 20;
aggro_h = 8;
aggro_ahead = aggro_w * 1;
aggro_above = aggro_h;

s_idle = spr_swordman_idle;
s_move = spr_swordman_move;
mask_index = s_idle;

fn_state_move = function(){

	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		sprite_index = spr_swordman_atk1;
		
		facePlayer();
		
		force_x = 4 * choose(1, -1, image_xscale);
		force_y = -3;
				
	}
	
	if(cstate_time > 0.3){
	
		sprite_index = s_idle;
		
		switchState(noone);
		
	}

}

fn_state_atk_a1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		
		sprite_index = spr_swordman_atk1;
		facePlayer();
		
		force_x = image_xscale * -2;
				
	}
	
	//TODO EXH reduce windup
	
	if(cstate_time > 0.4){
	
		switchState(fn_state_atk_a2);
	
	}
	
}

fn_state_atk_a2 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		force_x = image_xscale * 5;
		
		//state_current = method(undefined, pstate_air);
		
		sprite_index = spr_swordman_atk2;
		
		//create slash
		var _atk = scr_place(obj_pAtkDn_imo, x + (image_xscale * 0), y + -18);
		_atk.image_xscale = image_xscale;
		_atk.hazard = true;
		
		audf_playSfx(sfx_cut1);
		audf_playSfx(sfx_cut2);
				
	}
	
	if(abs(force_x) < 1){
		
		sprite_index = s_idle;
		
		arr_timers[0] = 1;
		
		switchState(noone);
		
	}
	
}