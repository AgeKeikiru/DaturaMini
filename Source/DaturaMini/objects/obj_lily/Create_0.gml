event_inherited();

aOff = 8;

hp = 3;

value = 150;

fixed = true;

moveWait = 2;

aggro_w = 100;
aggro_h = aggro_w * 1.2;
aggro_ahead = aggro_w * 0.0;
aggro_above = aggro_h * 0.2;

s_idle = sprite_index;
s_move = sprite_index;
mask_index = s_idle;

fn_state_atk_a1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		input_x = 0;
		
		sprite_index = spr_lily_atk1;
				
	}
	
	if(cstate_time > 0.4){
	
		s_idle = spr_lily_atk2;
		
		sprite_index = s_idle;
		
		switchState(noone);
	
	}
	
}