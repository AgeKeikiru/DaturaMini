event_inherited();

intf_boss_implement(50);

if(TESTING_MODE){
    hp = 5;
}

cstate_time = -99999;

s_idle = sprite_index;
s_move = sprite_index;
mask_index = s_idle;

wallSlam = false;

fn_spawnAdd = function(_x, _y){
    
    var _r = scr_place(obj_slime, _x, _y);
    
    _r.depth = depth + -99;
    
    with _r{
        
        hp = 1.5;
        switchState(fn_state_atk_a2);
        value = 0;
        noCount = true;
        
    }
    
    global.bonus_kill[1] += -1;
    
    return _r;
    
}

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
    	        
    	        _add = fn_spawnAdd(x + (image_xscale * -10), y + -10);
    	        _add.image_xscale = (_i mod 2) ? 1 : -1;
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
		
		shakeCam(choose(1, -1), choose(1, -1));
				
	}
	
	force_x = image_xscale * 5;
	
	if(collCheck(image_xscale, 0, objA_solid) && !wallSlam){
	    
	    wallSlam = true;
	    
	    shakeCam(choose(2, -2), choose(2, -2));
	    
	    if(instance_number(obj_enemy) < 6){
	    
    	    var _add;
    	    
    	    for(var _i = 0; _i < 2; _i++){
    	        
    	        _add = fn_spawnAdd(x + (image_xscale * -10), y + -10);
    	        _add.image_xscale = -image_xscale;
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

fn_state_stun1 = function(){
    
    //on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		hazard = false;
		
		iFrames = 99;
		
	}
	
	if(cstate_time > 1){
	    
	    sprite_index = spr_slimeBoss_atk_a1;
	    
	    switchState(fn_state_stun2);
	    
	}
    
}

fn_state_stun2 = function(){
    
    //on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		hazard = false;
		
		iFrames = 99;
		
	}
	
	if(cstate_time > 0.2){
	    
	    if(instance_number(obj_enemy) < 10){
	    
    	    var _add = fn_spawnAdd(x + random_range(-40, 40), y + -random_range(10, 20));
	        
	        _add.image_xscale = choose(1, -1);
	        _add.force_y += -random_range(0, 5);
	        
	        cstate_time = 0;
	    
	    }else{
	        
	        iFrames = 0;
	        sprite_index = s_idle;
	        switchState(noone);
	        
	    }
	    
	}
    
}