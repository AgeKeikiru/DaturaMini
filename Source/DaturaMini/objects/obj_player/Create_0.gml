event_inherited();

#region //player data

	function plyData(_src) constructor{
	
		src = _src;
		
		airOK = true; //used to make sure up/down attacks can only be used in air once
		
		s_idle = spr_imo_idle;
		s_move = spr_imo_move;
	
		fn_tryAtk = function(){ return true; /*abstract*/ }
		fn_state_atk1 = function(){ /*abstract*/
			with src{ switchState(noone); }
		}
		
		fn_tryAtkUp = function(){ return true; /*abstract*/ }
		fn_state_atkUp1 = function(){ /*abstract*/
			with src{ switchState(noone); }
		}
		
		fn_tryAtkDn = function(){ return true; /*abstract*/ }
		fn_state_atkDn1 = function(){ /*abstract*/
			with src{ switchState(noone); }
		}
		
		fn_tryDef = function(){ return true; /*abstract*/ }
		fn_state_def1 = function(){ /*abstract*/
			with src{ switchState(noone); }
		}
	
	}

	function plyData_imo(_src) : plyData(_src) constructor{
	
		s_idle = spr_imo_idle;
		s_move = spr_imo_move;
	
		fn_state_atk1 = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					if(on_ground()){
						input_x = 0;
					}
		
					input_lock = true;
					
					sprite_index = spr_imo_atk1;
				
				}
	
				if(cstate_time > 0.05){
	
					switchState(currPly.fn_state_atk2);
	
				}
			
			}

		}

		fn_state_atk2 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					force_x = image_xscale * 2;
		
					sprite_index = spr_imo_atk2;
		
					//create slash
					var _atk = scr_place(obj_pAtk_imo, x + (image_xscale * 12), y);
					_atk.image_xscale = image_xscale;
				
				}
	
				if(cstate_time > 0.2){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		fn_state_atkUp1 = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					input_x = 0;
					input_lock = true;
					
					if(!on_ground()){
					
						switchState(currPly.fn_state_atkUp2);
					
					}else{
					
						force_x = image_xscale * 2;
					
						sprite_index = spr_imo_atkUp1;
					
					}
				
				}
				
				spd_y = 0;
	
				if(cstate_time > 0.2){
	
					switchState(currPly.fn_state_atkUp2);
	
				}
			
			}

		}

		fn_state_atkUp2 = function(){

			static
			_s_aftImg = noone,
			_s_slash = noone;
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
		
					force_x = image_xscale * 3;
		
					sprite_index = spr_imo_atkUp2;
					
					//move_y(-12);
					state_current = method(undefined, pstate_air);
					
					//create afterimage
					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_red;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
		
					//create slash
					_s_slash = scr_place(obj_pAtkUp_imo, x, y);
					_s_slash.image_xscale = image_xscale;
					
					//ground slash
					if(on_ground()){
						
						var
						_atk = scr_place(obj_pAtkUp_imo_ground, x + (20 * image_xscale), y);
					
						_atk.image_xscale = image_xscale * 2;
						_atk.pv_x = 2 * image_xscale;
					
					}
				
				}
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
				
				if(instance_exists(_s_slash)){
					_s_slash.x = x;
					_s_slash.y = y;
				}
				
				if(cstate_time < 0.15){
					
					spd_y = 0;
					force_y = -4.5;
					
				}
	
				if((spd_y + force_y) > 0){
	
					instance_destroy(_s_aftImg);
					instance_destroy(_s_slash);
					switchState(currPly.fn_state_atkUp3);
	
				}
			
			}

		}
		
		fn_state_atkUp3 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					sprite_index = spr_imo_atkUp3;
		
					//create slash
					//var _atk = scr_place(obj_pAtk_imo, x + (image_xscale * 12), y);
					//_atk.image_xscale = image_xscale;
				
				}
				
				if(cstate_time > 0.2){
					input_lock = false;
				}
				
				if(cstate_time < 0.3){
					//spd_y = min(spd_y, 0);
				}
	
				if(on_ground()){
	
					iState = false;
					sprite_index = s_idle;
					input_lock = false;
		
					switchState(noone);
	
				}
			
			}

		}
	
		fn_state_atkDn1 = function(){

			with(src){
				
				static _s_air = false;
				
				//on-enter actions
				if(cstate_new){
		
					_s_air = !on_ground();
					
					cstate_new = false;	
					input_x = 0;
					
					state_current = method(undefined, pstate_air);
					force_x = image_xscale * -2.5;
					spd_y = -2;
		
					input_lock = true;
					
					sprite_index = spr_imo_atkDn1;
				
				}
				
				spd_y = min(spd_y, 0);
	
				if(cstate_time > 0.3){
	
					//create slash
					var _atk = scr_place(obj_pAtkDn_imo, x + (image_xscale * 0), y + -9);
					_atk.image_xscale = image_xscale;
					
					if(_s_air){
						_atk.image_angle += -10 * image_xscale;
					}
					
					switchState(currPly.fn_state_atkDn2);
	
				}
			
			}

		}

		fn_state_atkDn2 = function(){
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					force_x = 2 * image_xscale;
		
					sprite_index = spr_imo_atkDn2;
				
				}
				
				spd_x = 0;
				spd_y = 0;
	
				if(cstate_time > 0.4){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
	}

	function plyData_ari(_src) : plyData(_src) constructor{
	
		s_idle = spr_ari_idle;
		s_move = spr_ari_move;
		
		fn_state_atk1 = function(){

			with(src){
				
				var
				_key = (currPly == plyTeam[0]) ? "I" : "O";
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
		
					sprite_index = spr_ari_atk1;
					
					//create shot
					var _atk = scr_place(obj_pAtk_ari, x + (image_xscale * 12), y + random_range(-2, 2));
					_atk.image_xscale = image_xscale;
					_atk.pv_x = image_xscale * 4;
				
				}
				
				if(cstate_time > 0.07){
					
					if(scr_inputCheck(ord(_key))){
						
						cstate_time = 0;
						cstate_new = true;
						
					}else if(cstate_time > 0.3){
	
						sprite_index = s_idle;
					
						switchState(noone);
	
					}
	
				}
			
			}

		}
		
		fn_state_atkUp1 = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					input_x = 0;
					input_lock = true;
					
					sprite_index = spr_ari_atkUp1;
				
				}
				
				spd_x = 0;
				spd_y = 0;
	
				if(cstate_time > 0.3){
	
					switchState(currPly.fn_state_atkUp2);
	
				}
			
			}

		}

		fn_state_atkUp2 = function(){
			
			static _s_ariAtkUpLoop = 0;

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					sprite_index = spr_ari_atkUp2;
					
					_s_ariAtkUpLoop = 0;
				
				}
				
				spd_y = 0;
	
				if(cstate_time > 0.05){
					
					if(_s_ariAtkUpLoop == 0 || (_s_ariAtkUpLoop > 0 && cstate_time > 0.13)){
					
						if(_s_ariAtkUpLoop < 3){
						
							force_x = image_xscale * -2;
		
							//create missile
							var _atk = scr_place(obj_pAtk_ariUp, x + (image_xscale * -8), y + -15);
							_atk.direction = 90 + -((60 + -(15 * _s_ariAtkUpLoop)) * image_xscale);
						
							_s_ariAtkUpLoop++;
							cstate_time = 0;
						
						}
						
						if(_s_ariAtkUpLoop == 3 && cstate_time > 0.3){
						
							input_lock = false;
							sprite_index = s_idle;
		
							switchState(noone);
						
						}
					
					}
	
				}
			
			}

		}
		
		fn_state_atkDn1 = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					input_x = 0;
					input_lock = true;
					
					state_current = method(undefined, pstate_air);
					force_x = image_xscale * (on_ground() ? 3 : 2);
					spd_y = -2;
					
					sprite_index = spr_ari_atkDn1;
				
				}
				
				//spd_x = max(abs(spd_x), 0.1) * image_xscale;
				spd_y = min(spd_y, 0);
	
				if(cstate_time > 0.3){
	
					switchState(currPly.fn_state_atkDn2);
	
				}
			
			}

		}
		
		fn_state_atkDn2 = function(){

			static
			_s_aftImg = noone,
			_s_ariAtkDnTime = 0;
			
			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					spd_y = maxFall;
					
					sprite_index = spr_ari_atkDn2;
					
					//create afterimage
					_s_ariAtkDnTime = 0;
					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_lime;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
					_s_aftImg.dmg = 1;
					_s_aftImg.lift = 2;
				
				}
				
				_s_ariAtkDnTime += 0.2 * global.timeFlow;
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
	
				if(on_ground()){
	
					_s_ariAtkDnTime = min(_s_ariAtkDnTime, 4);
					
					//create splash
					var
					_atk = scr_place(obj_pAtk_ariDn, x, y),
					_dist = 15;
					
					_atk = scr_place(obj_pAtk_ariDn, x + -_dist, y);
					_atk.sprite_index = spr_ari_atkDnF_b;
					_atk.mask_index = _atk.sprite_index;
					_atk.image_xscale = -1;
					_atk.pv_x = -_s_ariAtkDnTime;
					
					_atk = scr_place(obj_pAtk_ariDn, x + _dist, y);
					_atk.sprite_index = spr_ari_atkDnF_b;
					_atk.mask_index = _atk.sprite_index;
					_atk.pv_x = _s_ariAtkDnTime;
					
					shakeCam(random_range(-2, 2), random_range(10, 12));
					
					instance_destroy(_s_aftImg);
					switchState(currPly.fn_state_atkDn3);
	
				}
			
			}

		}
		
		fn_state_atkDn3 = function(){
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					sprite_index = spr_ari_atkDn3;
				
				}
	
				if(cstate_time > 0.3){
					
					input_lock = false;
					iState = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		fn_state_def1 = function(){

			static _s_aftImg = noone;
			
			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					input_x = 0;
					input_lock = true;
					
					state_current = method(undefined, pstate_air);
					force_x = image_xscale * (on_ground() ? 3 : 2);
					spd_y = -jumpSpd / 2;
					
					sprite_index = spr_ari_def;
					
					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_lime;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
					_s_aftImg.atkStun = 1;
				
				}
				
				force_x = moveSpd * 2 * image_xscale;
				spd_y = 0;
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
	
				if(cstate_time > 0.4){
	
					input_lock = false;
					iState = false;
					sprite_index = s_idle;
					
					instance_destroy(_s_aftImg);
		
					switchState(noone);
	
				}
			
			}

		}
		
	}

#endregion

function switchPly(_ply){

	if(_ply != currPly){
	
		currPly = _ply;
		
		s_idle = currPly.s_idle;
		s_move = currPly.s_move;
		sprite_index = s_idle;
	
	}

}

plyTeam = [new plyData_imo(id), new plyData_ari(id)];

player = true;

currPly = noone;
switchPly(plyTeam[0]);
mask_index = spr_imo_idle;

cam_x = x;
cam_y = y;
cam_xTgt = -1;
cam_yTgt = -1;
cam_lead = 1;
cam_leadTgt = cam_lead;
cam_shakeX = 0;
cam_shakeY = 0;