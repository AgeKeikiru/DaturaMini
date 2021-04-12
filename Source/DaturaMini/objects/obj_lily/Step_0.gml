event_inherited();

if(stun <= 0 && sprite_index == spr_lily_idle){

	var _box = fn_getAggroRect();

	if(collision_rectangle(_box.x1, _box.y1, _box.x2, _box.y2, obj_player, false, true) && arr_timers[0] <= 0){
		switchState(fn_state_atk_a1);
	}

}

if(fixed && sprite_index == spr_lily_atk2){
    
    if(arr_timers[0] > 0){
        arr_timers[0] += -TICK * global.timeFlow;
    }else{
        
        arr_timers[0] = 0.1;
        aOff *= -1;
        
        var
        _force = 6.5,
        _dir = image_angle + aOff + 90,
        _o = scr_place(obj_eAtk_fireball, x, mean(bbox_bottom,bbox_top));
		
		_o.pv_x = lengthdir_x(_force, _dir);
		_o.spd_y = lengthdir_y(_force, _dir) + 0;
		_o.weight = 1;
		_o.depth = depth + 99;
		
		with _o{
		    
		    state_current = method(undefined, pstate_air);
		    
		    if(spd_y > 0){
		        
		        pv_x *= 1.5;
		        spd_y *= 0.1;
		        
		    }
		    
		}
        
    }
    
}