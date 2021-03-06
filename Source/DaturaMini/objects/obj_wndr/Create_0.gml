event_inherited();

hp = 4;

value = 200;

moveSpd = random_range(100, 150);
weight = 0;

moveWait = 1;

moveAngle = random_range(0, 360);
moveDist = 0;
moveLoop = 0;
atkLoop = 0;
atkLoopMax = 10;

s_idle = sprite_index;
s_move = sprite_index;
mask_index = s_idle;

fn_state_move = function(){

	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		if(moveLoop < 4 || collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, objA_solid, false, true)){
		
		    moveDist = random_range(15, 40);
		    
		    moveLoop++;
		
		}else{
		    
		    moveLoop = 0;
		    
		    switchState(fn_state_atk_a1);
		    
		}
				
	}
	
	moveAngle += TICK * moveSpd;
	
	if(instance_exists(obj_player)){
	
    	var
    	_x = obj_player.x + lengthdir_x(moveDist * 2, moveAngle),
    	_y = obj_player.y + lengthdir_y(moveDist, moveAngle);
    	
    	x = lerp(x, _x, 0.1);
    	y = lerp(y, _y, 0.1);
    	
    	x = clamp(x, obj_ui.x, obj_ui.x + obj_ui.camW);
    	y = clamp(y, obj_ui.y, obj_ui.y + obj_ui.camH);
	
	}
	
	if(cstate_time > moveWait){
	
		switchState(fn_state_move);
		
	}

}

fn_state_atk_a1 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		moveAngle = point_direction(x, y, obj_player.x, obj_player.y + -8);
		
		s_shake = 3;
		
		arr_warns[0] = new lwo_warningBeam(x, y, moveAngle);
		
		moveAngle += 180;
				
	}
	
	if(cstate_time > 0.8){
	
	    switchState(fn_state_atk_a2);
	
	}
	
}

fn_state_atk_a2 = function(){
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		
		atkLoop = 0;
		
	}
	
	if(cstate_time > 0.05 && atkLoop < atkLoopMax){
		
		cstate_time = 0;
		atkLoop++;
		
		var
		_force = -4,
		_o = scr_place(obj_eAtk_fireball, x, y),
		_dir = moveAngle + ((atkLoop + -(atkLoopMax / 2)) * 5);
		
		_o.pv_x = lengthdir_x(_force, _dir);
		_o.pv_y = lengthdir_y(_force, _dir);
		
	}
	
	if(cstate_time > 1){
	    switchState(fn_state_move);
	}
	
}

switchState(fn_state_move);