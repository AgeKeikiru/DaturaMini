event_inherited();

input_lock = true;

#region //player data

	function plyData(_src, _hp) constructor{
	
		src = _src;
		
		uiCol = $FFFFFF;
		
		hp = _hp;
		hpMax = hp;
		hpRegen = hp;
		
		airOK = true; //used to make sure up/down attacks can only be used in air once
		
		s_idle = spr_imo_idle;
		s_move = spr_imo_move;
	
		state_atk = addAct(_src);
		
		state_atkUp = addAct(_src);
		state_atkUp.airLimit = true;
		state_atkUp.enCost = 1;
		
		state_atkDn = addAct(_src);
		state_atkDn.airLimit = true;
		state_atkDn.enCost = 1;
		
		state_def = addAct(_src);
		state_def.enCost = 1;
	
	}

	function plyData_imo(_src) : plyData(_src, 4) constructor{
	
		uiCol = $c3c3ff;
		
		s_idle = spr_imo_idle;
		s_move = spr_imo_move;
	
		state_atk.run = function(){

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
	
				if(cstate_time > (global.hyperActive ? 0 : 0.05)){
	
					switchState(currPly.state_atk.run2);
	
				}
			
			}

		}

		state_atk.run2 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					force_x = image_xscale * 2;
		
					sprite_index = spr_imo_atk2;
		
					//create slash
					var _atk = scr_place(obj_pAtk_imo, x + (image_xscale * 12), y);
					_atk.image_xscale = image_xscale;
					
					if(global.hyperActive){
					    
					    _atk.image_xscale *= 2;
					    _atk.pv_x = image_xscale * 4;
					    
					}
				
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : 0.2)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_atkUp.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					input_x = 0;
					input_lock = true;
					
					if(!global.hyperActive){
					
    					if(!on_ground()){
    					
    						switchState(currPly.state_atkUp.run2);
    					
    					}else{
    					
    						force_x = image_xscale * 2;
    					
    						sprite_index = spr_imo_atkUp1;
    					
    					}
					
					}
				
				}
				
				spd_y = 0;
	
				if(cstate_time > (global.hyperActive ? 0 : 0.2)){
	
					switchState(currPly.state_atkUp.run2);
	
				}
			
			}

		}

		state_atkUp.run2 = function(){

			static _s_aftImg = noone;
			static _s_slash = noone;
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					
					state_current = method(undefined, pstate_air);
		
		            if(global.hyperActive){
		                
		                force_x = image_xscale * -3;
		                
		                spd_y = 0;
					    force_y = -4.5;
					    
					    sprite_index = spr_imo_atkDn2;
		                
		            }else{
		
    					force_x = image_xscale * 3;
    		
    					sprite_index = spr_imo_atkUp2;
    					
    					//create afterimage
    					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
    					_s_aftImg.depth = depth + -99;
    					_s_aftImg.image_xscale = image_xscale;
    					_s_aftImg.image_blend = c_red;
    					_s_aftImg.sprite_index = sprite_index;
    					_s_aftImg.mask_index = sprite_index;
    					_s_aftImg.dmg = 0;
    					_s_aftImg.atkStun = 0;
    					_s_aftImg.slowTo = 1;
    					_s_aftImg.slowDur = 0;
    		
    					//create slash
    					_s_slash = scr_place(obj_pAtkUp_imo, x, y);
    					_s_slash.image_xscale = image_xscale;
					
		            }
					
					//ground slash
					if(on_ground() || global.hyperActive){
						
						var
						_atk = scr_place(obj_pAtkUp_imo_ground, x + (20 * image_xscale), y);
					
						_atk.image_xscale = image_xscale * 2;
						_atk.pv_x = 2 * image_xscale;
						
						if(global.hyperActive){
						    
						    _atk.image_xscale *= 1.5;
						    _atk.image_yscale = 5;
						    _atk.dmg = 2;
						    
						}
					
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
				
				if(cstate_time < 0.15 && !global.hyperActive){
					
					spd_y = 0;
					force_y = -4.5;
					
				}
	
				if((spd_y + force_y) > 0){
	
					instance_destroy(_s_aftImg);
					instance_destroy(_s_slash);
					switchState(currPly.state_atkUp.run3);
	
				}
			
			}

		}
		
		state_atkUp.run3 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					sprite_index = spr_imo_atkUp3;
				
				}
				
				if(cstate_time > 0.2){
					input_lock = false;
				}
	
				if(on_ground() || global.hyperActive){
	
					iState = false;
					sprite_index = s_idle;
					input_lock = false;
		
					switchState(noone);
	
				}
			
			}

		}
	
		state_atkDn.run = function(){

			with(src){
				
				static _s_air = false;
				
				//on-enter actions
				if(cstate_new){
		
					_s_air = !on_ground();
					
					cstate_new = false;	
					input_x = 0;
					
					state_current = method(undefined, pstate_air);
					force_x = image_xscale * -2.5;
					spd_y = global.hyperActive ? -4 : -2;
		
					input_lock = true;
					
					sprite_index = spr_imo_atkDn1;
				
				}
				
				spd_y = min(spd_y, 0);
	
				if(cstate_time > (global.hyperActive ? 0.15 : 0.3)){
	
					//create slash
					var _atk = scr_place(obj_pAtkDn_imo, x + (image_xscale * 0), y + -9);
					_atk.image_xscale = image_xscale;
					
					if(_s_air || global.hyperActive){
						_atk.image_angle += -10 * image_xscale;
					}
					
					if(global.hyperActive){
					    _atk.image_xscale *= 2;
					}
					
					_atk.image_yscale = abs(_atk.image_xscale);
					
					switchState(currPly.state_atkDn.run2);
	
				}
			
			}

		}

		state_atkDn.run2 = function(){
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					force_x = 2 * image_xscale;
		
					sprite_index = spr_imo_atkDn2;
				
				}
				
				spd_x = 0;
				spd_y = 0;
	
				if(cstate_time > (global.hyperActive ? 0.1 : 0.4)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_def.enCost = 0;
		state_def.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					blocking = true;
					input_lock = true;
					
					if(on_ground()){
						input_x = 0;
						spd_x = 0;
					}
					
					sprite_index = spr_imo_def;
				
				}
				
				enDelay = 0.1;
				input_lock = true;
	
				if(!scr_inputCheck(ord("P"), ev_keyboard, true)){
	
					input_lock = false;
					blocking = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}else if(scr_inputCheck(ord("A"), ev_keypress, true) || scr_inputCheck(ord("D"), ev_keypress, true)){
					
					image_xscale = scr_inputCheck(ord("A"), ev_keypress, true) ? 1 : -1;
					
					switchState(currPly.state_def.run2);
					
				}
			
			}

		}
		
		state_def.run2 = function(){

			static _s_aftImg = noone;
			
			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					input_x = 0;
					input_lock = true;
					
					force_x = image_xscale * -4;
					
					sprite_index = spr_imo_atkDn1;
					
					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_red;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
					_s_aftImg.atkStun = 0;
					_s_aftImg.slowTo = 1;
					_s_aftImg.slowDur = 0;
				
				}
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
	
				if(abs(force_x) < 0.05){
	
					iState = false;
					
					instance_destroy(_s_aftImg);
		
					switchState(currPly.state_def.run);
	
				}
			
			}

		}
		
	}

	function plyData_ari(_src) : plyData(_src, 5) constructor{
	
		uiCol = $c3ffd9;
		
		s_idle = spr_ari_idle;
		s_move = spr_ari_move;
		
		state_atk.run = function(){

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
					
					if(global.hyperActive){
					    
					    _atk.y = y + 8;
					    _atk.image_xscale *= 2;
					    _atk.image_yscale = abs(_atk.image_xscale);
					    _atk.pv_x *= 2;
					    
					    var _atk2 = scr_place(obj_pAtk_ari, _atk.x, _atk.y + 4);
					    _atk2.image_xscale = _atk.image_xscale;
					    _atk2.image_yscale = _atk.image_yscale;
					    _atk2.pv_x = _atk.pv_x;
					    
					}
				
				}
				
				if(cstate_time > (global.hyperActive ? 0.04 : 0.07)){
					
					if(scr_inputCheck(ord(_key))){
						
						cstate_time = 0;
						cstate_new = true;
						
					}else if(cstate_time > (global.hyperActive ? 0 : 0.15)){
	
						sprite_index = s_idle;
					
						switchState(noone);
	
					}
	
				}
			
			}

		}
		
		state_atkUp.run = function(){

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
	
				if(cstate_time > (global.hyperActive ? 0 : 0.3)){
	
					switchState(currPly.state_atkUp.run2);
	
				}
			
			}

		}

		state_atkUp.run2 = function(){
			
			static _s_ariAtkUpLoop = 0;

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					sprite_index = spr_ari_atkUp2;
					
					_s_ariAtkUpLoop = 0;
				
				}
				
				spd_y = 0;
	            
				if(cstate_time > (global.hyperActive ? 0.05 : 0.05)){ //hyper 0
					
					if(_s_ariAtkUpLoop == 0 || (_s_ariAtkUpLoop > 0 && cstate_time > (global.hyperActive ? 0.13 : 0.13))){ //hyper 0.05
					
						if(_s_ariAtkUpLoop < 3){
						
							force_x = image_xscale * (global.hyperActive ? -2.5 : -2);
		
							//create missile
							repeat(global.hyperActive ? 3 : 1){
							
								var _atk = scr_place(obj_pAtk_ariUp, x + (image_xscale * -8), y + -15);
								_atk.direction = 90 + -((60 + -(15 * _s_ariAtkUpLoop)) * image_xscale); //hyper x3, random direction
								
								if(global.hyperActive){
								
									_atk.direction = 90 + -(random_range(30, 60) * image_xscale);
								
								}
							
							}
							
							_s_ariAtkUpLoop++;
							cstate_time = 0;
						
						}
						
						if(_s_ariAtkUpLoop == 3 && cstate_time > (global.hyperActive ? 0.1 : 0.3)){ //hyper 0.05
						
							input_lock = false;
							sprite_index = s_idle;
		
							switchState(noone);
						
						}
					
					}
	
				}
			
			}

		}
		
		state_atkDn.run = function(){

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
				
				spd_y = min(spd_y, 0);
	
				if(cstate_time > (global.hyperActive ? 0.1 : 0.3)){
	
					switchState(currPly.state_atkDn.run2);
	
				}
			
			}

		}
		
		state_atkDn.run2 = function(){

			static _s_aftImg = noone;
			static _s_ariAtkDnTime = 0;
			
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
				
				if(global.hyperActive){
				    spd_y = maxFall * 2;
				}
	
				if(on_ground()){
	
					_s_ariAtkDnTime = min(_s_ariAtkDnTime, 4);
					
					//create splash
					var
					_atk = scr_place(obj_pAtk_ariDn, x, y),
					_dist = 15;
					
					if(global.hyperActive){
					
						_atk.image_xscale *= 4;
						_atk.image_yscale = abs(_atk.image_xscale);
					
					}
					
					_atk = scr_place(obj_pAtk_ariDn, x + -_dist, y);
					_atk.sprite_index = spr_ari_atkDnF_b;
					_atk.mask_index = _atk.sprite_index;
					_atk.image_xscale = -1;
					_atk.pv_x = -_s_ariAtkDnTime;
					
					if(global.hyperActive){
					
						_atk.image_xscale *= 4;
						_atk.image_yscale = abs(_atk.image_xscale);
						_atk.pv_x *= _atk.image_yscale;
					
					}
					
					_atk = scr_place(obj_pAtk_ariDn, x + _dist, y);
					_atk.sprite_index = spr_ari_atkDnF_b;
					_atk.mask_index = _atk.sprite_index;
					_atk.pv_x = _s_ariAtkDnTime;
					
					if(global.hyperActive){
					
						_atk.image_xscale *= 4;
						_atk.image_yscale = abs(_atk.image_xscale);
						_atk.pv_x *= _atk.image_yscale;
					
					}
					
					shakeCam(random_range(-2, 2), random_range(10, 12));
					
					instance_destroy(_s_aftImg);
					switchState(currPly.state_atkDn.run3);
	
				}
			
			}

		}
		
		state_atkDn.run3 = function(){
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					sprite_index = spr_ari_atkDn3;
				
				}
	
				if(cstate_time > (global.hyperActive ? 0.1 : 0.3)){
					
					input_lock = false;
					iState = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_def.run = function(){

			static _s_aftImg = noone;
			
			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					input_x = 0;
					input_lock = true;
					
					//state_current = method(undefined, pstate_air);
					//force_x = image_xscale * (on_ground() ? 3 : 2);
					//spd_y = -jumpSpd / 2;
					
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
		currPly.hp  = floor(currPly.hp);
		
		s_idle = currPly.s_idle;
		s_move = currPly.s_move;
		sprite_index = s_idle;
	
	}

}

function useEn(_amt){

	en = clamp(en + -_amt, 0, enMax);
	
	if(_amt > 0){
	    
		enDelay = 1.5;
		
		with obj_ui{
		    uiMini = 1.5;
		}
		
	}

}

function loseHp(_amt, _ply){

	_amt = is_undefined(_amt) ? 1 : _amt;
	_ply = is_undefined(_ply) ? currPly : _ply;
	
	if(global.hyperActive){
	    endHyper();
	}
	
	addHyper(-0.2);
	
	_ply.hp = clamp(_ply.hp + -_amt, 0, _ply.hpMax);
	
	if(_ply.hp <= 0){
	    
		_ply.hp = -1; //set to -1 to ensure regen is set to the proper value
		
		if(_ply == plyTeam[0]){
		    switchPly(plyTeam[1]);
		}else{
		    switchPly(plyTeam[0]);
		}
		
	}
	
	_ply.hpRegen = clamp(_ply.hpRegen, _ply.hp, _ply.hp + 2);
	
	with obj_ui{
	    uiMini = 1.5;
	}

}

plyTeam = [new plyData_imo(id), new plyData_ari(id)];

player = true;

en = 4;
enMax = en;
enDelay = 0;

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