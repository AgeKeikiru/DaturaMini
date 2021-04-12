#region //vars

	#macro GRAVITY 0.23
	#macro MAX_JUMP 0.15
	
	depth = 0;
	
	s_idle = noone;
	s_move = noone;
	
	player = false;
	hazard = false;
	
	hp = 1;
	
	deadspin = 0;
	
	input_x = 0;
	input_y = 0;
	input_lock = false;
	
	force_x = 0;
	force_y = 0;

    fixed = false; //fixed position
	weight = 1;
	moveSpd = 1.3;
	jumpSpd = 2.5;
	jumpTime = -1;
	maxFall = 5; //terminal velocity

	state_current = noone; //state system
	state_is_new = true;
	state_timer = 0;
	
	cstate_curr = noone; //custom states, adding additional states to the platforming state system is not behaving as planned
	cstate_new = true;
	cstate_time = 0;
	
	stun = 0;
	iFrames = 0;
	iState = false;
	blocking = false;
	
	arr_timers = [0];
	
	//aggro bounds for letting enemies detect the player
	aggro_ahead = 0;
	aggro_above = 0;
	aggro_w = -1;
	aggro_h = -1;
	
	intf_platforming_implement();

#endregion


#region //functions
	
	function fn_getAggroRect(){
	
		if(aggro_w < 1 || aggro_h < 1){ return noone; }
		
		var
		_x = x + (aggro_ahead * image_xscale),
		_y = y + -aggro_above;
		
		return new lwo_rectangle(_x + -aggro_w, _y + -aggro_h, _x + aggro_w, _y + aggro_h);
	
	}
	
	function scr_inputCheck(_key, _type, _ignoreLock){
		
		if(is_undefined(_type)){ _type = ev_keyboard; }
		if(is_undefined(_ignoreLock)){ _ignoreLock = false; }
		
		var _check = false;
		
		switch(_type){
			
			case ev_keyboard:
				_check = keyboard_check(_key);
				break;
				
			case ev_keypress:
				_check = keyboard_check_pressed(_key);
				break;
				
			case ev_keyrelease:
				_check = keyboard_check_released(_key);
				break;
				
		}
		
		return (!input_lock || _ignoreLock) && stun <= 0 && _check;

	}
	
	function facePlayer(){
	
		if(instance_exists(obj_player)){
			image_xscale = (x > obj_player.x) ? -1 : 1;
		}
	
	}
	
	#region //states
	
		function switchState(_state){
		
			cstate_time = 0;
			cstate_new = true;
			cstate_curr = _state;
			
			hazard = false;
		
		}
		
		function checkState(_state){
			return _state == cstate_curr;
		}
		
		function pstate_ground(){
			
			//on-enter actions
			if(state_is_new){
				
				input_x = 0; //stop movement upon landing if moving in midair from an attack
				
				spd_y = 0;
				spdFrac_y = 0;
				
				state_is_new = false;
				
			}

			if(!on_ground()){
				state_current = method(undefined, pstate_air);
			}else{

				jumpTime = -1;
				
				if(player && scr_inputCheck(vk_space, ev_keypress)){
					
					if(keyboard_check(ord("S")) && on_passThru() && !on_wall() && !on_slope()){
						
						y++;
						spd_y = 2;
						
					}else{
						
						spd_y = -jumpSpd;
						jumpTime = 0;
						
					}
					
					state_current = method(undefined, pstate_air);
					exit;
					
				}
			
			}
			
		}
		
		function pstate_air(){
		
			//on-enter actions
			if(state_is_new){
				
				state_is_new = false;
				
			}

			//change state when hitting the ground and not going up
			if(on_ground() && spd_y >= 0){
				state_current = method(undefined, pstate_ground);
			}else{

				//gravity
				if(scr_inputCheck(vk_space, ev_keyrelease)){
					jumpTime = -1;
				}else if(clamp(jumpTime, 0, MAX_JUMP) == jumpTime){
				
					spd_y = -jumpSpd;
					jumpTime += global.timeFlow / room_speed;
					
					if(player && global.hyperActive){
					    
					    spd_y *= 1.4;
					    
					}
				
				}else{
					spd_y += GRAVITY * weight * global.timeFlow;
				}

				if(spd_y > maxFall){
					spd_y = maxFall;
				}
				
			}
		
		}
	
	#endregion

#endregion

state_current = method(undefined, pstate_ground);