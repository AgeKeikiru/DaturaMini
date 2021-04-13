event_inherited();

cstate_time = -99999;

hp = 100;

s_idle = sprite_index;
s_move = sprite_index;
mask_index = s_idle;

wallSlam = false;

fn_state_atk_a1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		
		sprite_index = spr_slimeBoss_atk_a1;
				
	}
	
	if(cstate_time > 0.5){
	
		switchState(fn_state_atk_a2);
	
	}
	
}

fn_state_atk_a2 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		hazard = true;
		
		y--;
		
		state_current = method(undefined, pstate_air);
		
		sprite_index = spr_slimeBoss_atk_a2;
		
		shakeCam(1, 1);
				
	}
	
	if(cstate_time < 0.5){
	    
	    spd_y = -3;
	    
	}
	
	force_x = image_xscale * 1.5;
	
	if(on_ground() && spd_y == 0){
		
		sprite_index = s_idle;
		
		shakeCam(2, 2);
		
		if(instance_number(obj_enemy) < 6){
		
    		var _add;
    	    
    	    for(var _i = 0; _i < 2; _i++){
    	        
    	        _add = scr_place(obj_slime, x + (image_xscale * -10), y + -10);
    	        _add.depth = depth + 99;
    	        _add.image_xscale = (_i mod 2) ? 1 : -1;
    	        
    	        with _add{
    	            
    	            switchState(fn_state_atk_a2);
    	            value = 0;
    	            
    	        }
    	        
    	        _add.x += _add.image_xscale * 40;
    	        
    	    }
	    
		}
		
		switchState(noone);
		
	}
	
}

fn_state_atk_b1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		wallSlam = false;
		
		sprite_index = spr_slimeBoss_atk_b1;
				
	}
	
	if(cstate_time > 0.5){
	
		switchState(fn_state_atk_b2);
	
	}
	
}

fn_state_atk_b2 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		hazard = true;
		
		sprite_index = spr_slimeBoss_atk_b2;
		
		shakeCam(1, 1);
				
	}
	
	force_x = image_xscale * 5;
	
	if(collCheck(image_xscale, 0, objA_solid) && !wallSlam){
	    
	    wallSlam = true;
	    
	    shakeCam(2, 2);
	    
	    if(instance_number(obj_enemy) < 6){
	    
    	    var _add;
    	    
    	    for(var _i = 0; _i < 2; _i++){
    	        
    	        _add = scr_place(obj_slime, x + (image_xscale * -10), y + -10);
    	        _add.depth = depth + 99;
    	        _add.image_xscale = -image_xscale;
    	        
    	        with _add{
    	            
    	            switchState(fn_state_atk_a2);
    	            value = 0;
    	            
    	        }
    	        
    	        _add.force_y += (1 + -_i) * -5;
    	        
    	        _add.x += -image_xscale * _i * 40;
    	        
    	    }
	    
	    }
	    
	}
	
	if(cstate_time > 0.5){
		
		sprite_index = s_idle;
		
		switchState(noone);
		
	}
	
}