event_inherited();

hp = 2;

value = 100;

moveSpd = 0.6;
weight = 0;

moveWait = 1.5;

aggro_w = 50;
aggro_h = aggro_w;
aggro_ahead = aggro_w * 0.1;
aggro_above = aggro_h * 0.2;

s_idle = spr_conflyer_idle;
s_move = s_idle;
mask_index = s_idle;

fn_state_move = function(){

	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		//find player and get angle to point at them
		var
		_ply = instance_find(obj_player, 0);
		
		if(_ply != noone){
			
			direction = point_direction(x, y, _ply.x, _ply.y) + (random_range(10,80) * choose(1,-1));
			
		}
		
		facePlayer();
		
	}
	
	state_current = method(undefined, pstate_air);
	spd_x = lengthdir_x(moveSpd, direction);
	spd_y = lengthdir_y(moveSpd, direction);
	
	if(cstate_time > 0.8){
	
		spd_x = 0;
		spd_y = 0;
		
		switchState(noone);
		
	}

}

fn_state_atk_a1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		spd_x = 0;
		spd_y = 0;
		
		sprite_index = spr_conflyer_atk1;
		facePlayer();
				
	}
	
	if(cstate_time > 0.5){
	
		switchState(fn_state_atk_a2);
	
	}
	
}

fn_state_atk_a2 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		var
		_force = -3,
		_ply = instance_find(obj_player, 0);
		
		if(_ply != noone){
			
			direction = point_direction(x, y, _ply.x, mean(_ply.bbox_bottom, _ply.bbox_top));
			
		}
		
		cstate_new = false;
		force_x = lengthdir_x(_force, direction);
		force_y = lengthdir_y(_force, direction);
		
		sprite_index = spr_conflyer_atk2;
		
		_force = 2;
		var _o = scr_place(obj_eAtk_fireball, x, mean(bbox_bottom,bbox_top));
		
		_o.pv_x = lengthdir_x(_force, direction);
		_o.pv_y = lengthdir_y(_force, direction);
		
	}
	
	if(cstate_time > 0.5){
		
		sprite_index = spr_conflyer_idle;
		
		arr_timers[0] = 1;
		
		switchState(noone);
		
	}
	
}