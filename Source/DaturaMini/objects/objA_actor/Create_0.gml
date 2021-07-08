#region //vars

	#macro GRAVITY 0.23
	#macro MAX_JUMP 0.2
	#macro BOSS_STUNMAX 10
	#macro SPRINT_RATE 1
	#macro SPRINT_THRESH 0.94
	
	depth = 0;
	
	s_idle = noone;
	s_move = noone;
	
	player = false;
	hazard = false;
	boss = false;
	armored = false;
	
	hp = 1;
	bossHp = 1;
	bossStun = 0;
	
	deadspin = 0;
	
	input_x = 0;
	input_y = 0;
	input_lock = false;
	move_lock = false;
	
	force_x = 0;
	force_y = 0;

    fixed = false; //fixed position
	weight = 1;
	moveSpd = 1.3;
	sprinting = 0;
	sprintAftImg = noone;
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
	
	//character specific effects
	sp_frozen = false;
	
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
	
	function scr_playerIO(_key, _type, _ignoreLock){
		
		if(is_undefined(_type)){ _type = en_ioType.DOWN; }
		if(is_undefined(_ignoreLock)){ _ignoreLock = false; }
		
		return (!input_lock || _ignoreLock) && stun <= 0 && io_check(_type, _key);

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
			iState = false;
			blocking = false;
			
			with obj_pAtk_afterimage{
			    
			    if(id != global.hyperAfterImg){
			        instance_destroy();
			    }
			    
			}
			
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
				
				if(player && scr_playerIO([en_input.GAME_JUMP], en_ioType.PRESS)){
					
					if(scr_playerIO([en_input.UNI_DOWN]) && on_passThru() && !on_wall() && !on_slope()){
						
						y++;
						spd_y = 2;
						
					}else{
						
						spd_y = -jumpSpd;
						jumpTime = 0;
						
					}
					
					move_lock = false;
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
				if(scr_playerIO([en_input.GAME_JUMP], en_ioType.RELEASE)){
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