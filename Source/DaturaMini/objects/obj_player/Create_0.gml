event_inherited();

input_lock = true;

lastAct = noone;

switching = false;

panTimer = 0;
vertPan = 0;

#region //player data

	function plyData(_src, _hp) constructor{
	
		src = _src;
		
		slot2 = false; //set true for 2nd party member to determine inputs
		
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
	
		uiCol = CC_IMO_RED;
		
		s_idle = spr_imo_idle;
		s_move = spr_imo_move;
	
	    state_atk.endLag = 0.3;
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
				
				spd_y = 0;
	
				if(cstate_time > (global.hyperActive ? 0 : 0.05)){
	
					switchState(currPly.state_atk.run2);
	
				}
			
			}

		}

		state_atk.run2 = function(){

			static _s_atk2 = false;
			
			with(src){
			
				var _f_atk = function(){
				    
				    var _r = scr_place(obj_pAtk_imo, x + (image_xscale * 12), y);
					_r.image_xscale = image_xscale;
					
					audf_playSfx(sfx_cut1);
					
					return _r;
				    
				}
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					_s_atk2 = false;
		
					force_x = image_xscale * 2;
		
					sprite_index = spr_imo_atk2;
		
					//create slash
					var _atk = _f_atk();
					
					if(global.hyperActive){
					    
					    _atk.image_xscale *= 2;
					    _atk.pv_x = image_xscale * 4;
					    
					    audf_playSfx(sfx_shot2);
					    
					}
				
				}
				
				spd_y = 0;
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel * 0.5 && !_s_atk2 && !global.hyperActive){
				        
			        _s_atk2 = true;
			        
			        var _atk = _f_atk();
			        
			        _atk.image_yscale = -1;
			        _atk.y += -14;
			        _atk.x += 2 * image_xscale;
				    
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_atkUp.endLag = 99;
		state_atkUp.lagCancel = 0;
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
			static _s_hold = true;
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					
					_s_hold = true;
					
					state_current = method(undefined, pstate_air);
		
		            if(global.hyperActive){
		                
		                force_x = image_xscale * -3;
		                
		                spd_y = 0;
					    //force_y = -4.5;
					    
					    sprite_index = spr_imo_atkDn2;
		                
		            }else{
		
    					force_x = image_xscale * 3;
    		
    					sprite_index = spr_imo_atkUp2;
    					
    					//create slash
    					_s_slash = scr_place(obj_pAtkUp_imo, x, y);
    					_s_slash.image_xscale = image_xscale;
    					
    					//create afterimage
    					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
    					_s_aftImg.src = id;
    					_s_aftImg.depth = depth + -99;
    					_s_aftImg.image_xscale = image_xscale;
    					_s_aftImg.image_blend = c_red;
    					_s_aftImg.sprite_index = sprite_index;
    					_s_aftImg.mask_index = sprite_index;
    					_s_aftImg.dmg = _s_slash.dmg;
    					_s_aftImg.atkStun = _s_slash.atkStun;
    					_s_aftImg.slowTo = _s_slash.slowTo;
    					_s_aftImg.slowDur = _s_slash.slowDur;
    					_s_aftImg.hitSound = _s_slash.hitSound;
    					
    					audf_playSfx(sfx_cut1);
    					audf_playSfx(sfx_whoosh2);
					
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
						    
						}else if(!scr_playerIO([en_input.GAME_ATK1 + currPly.slot2, en_input.GAME_ATK_CURRENT], en_ioType.DOWN, true)){
						    
						    //no jump if attack button isnt held
						    _s_hold = false;
						    
						    force_x *= 0.8;
						    
						    _atk.lift *= 1.4;
						    
						}
						
						audf_playSfx(sfx_shot2);
					
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
					force_y = -4.5 * _s_hold;
					
				}
	
				if((spd_y + force_y + -abs(force_x)) >= 0){
	
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
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
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
	    
	    state_atkDn.endLag = 0.4;
	    state_atkDn.lagCancel = 0.4;
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
					    
					    audf_playSfx(sfx_shot2);
					    
					}
					
					_atk.image_yscale = abs(_atk.image_xscale);
					
					audf_playSfx(sfx_cut1);
					audf_playSfx(sfx_cut2);
					
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
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.1 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_def.endLag = 0.01;
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
	
				if(!scr_playerIO([en_input.GAME_DEF_CURRENT, en_input.GAME_DEF1 + currPly.slot2], en_ioType.DOWN, true)){
	
					input_lock = false;
					blocking = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}else if(scr_playerIO([en_input.UNI_LEFT, en_input.UNI_RIGHT], en_ioType.PRESS, true)){
					
					image_xscale = scr_playerIO([en_input.UNI_LEFT], en_ioType.PRESS, true) ? 1 : -1;
					
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
					_s_aftImg.src = id;
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_red;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
					_s_aftImg.atkStun = 0;
					_s_aftImg.slowTo = 1;
					_s_aftImg.slowDur = 0;
					
					audf_playSfx(sfx_whoosh1);
				
				}
				
				if(cstate_time > lastAct.endLag){
				    input_lock = false;
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
	
		uiCol = CC_ARI_GREEN;
		
		s_idle = spr_ari_idle;
		s_move = spr_ari_move;
		
		state_atk.endLag = 0.07;
		state_atk.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					move_lock = false;
		
					sprite_index = spr_ari_atk1;
					
					//create shot
					var
					_atk = scr_place(obj_pAtk_ari, x + (image_xscale * 12), y + random_range(-2, 2) + -10);
					_atk.image_xscale = image_xscale;
					_atk.pv_x = image_xscale * 4;
					
					audf_playSfx(sfx_shot1);
					
					if(global.hyperActive){
					    
					    _atk.y = y + 8;
					    _atk.image_xscale *= 2;
					    _atk.image_yscale = abs(_atk.image_xscale);
					    _atk.pv_x *= 2;
					    
					    var _atk2 = scr_place(obj_pAtk_ari, _atk.x, _atk.y + 4);
					    _atk2.image_xscale = _atk.image_xscale;
					    _atk2.image_yscale = _atk.image_yscale;
					    _atk2.pv_x = _atk.pv_x;
					    
					    audf_playSfx(sfx_shot2);
					    
					    if(global.hyperTime <= 0){
					        endHyper(); //manual check to avoid infinite hyper glitch
					    }
					    
					}
				
				}
				
				if(cstate_time > (global.hyperActive ? 0.04 : lastAct.endLag)){
					
					if(scr_playerIO([en_input.GAME_ATK1 + currPly.slot2, en_input.GAME_ATK_CURRENT])){
						
						cstate_time = 0;
						cstate_new = true;
						
					}else{
	
						sprite_index = s_idle;
					
						switchState(noone);
	
					}
	
				}
			
			}

		}
		
		state_atkUp.endLag = 0.3;
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
	            
				if(cstate_time > (global.hyperActive ? 0.05 : 0.05)){
					
					if(_s_ariAtkUpLoop == 0 || (_s_ariAtkUpLoop > 0 && cstate_time > (global.hyperActive ? 0.13 : 0.13))){
					
						if(_s_ariAtkUpLoop < 3){
						
							force_x = image_xscale * (global.hyperActive ? -2.5 : -2);
		
							//create missile
							repeat(global.hyperActive ? 3 : 1){
							
								var _atk = scr_place(obj_pAtk_ariUp, x + (image_xscale * 2), y + -15);
								_atk.direction = 90 + -((60 + -(15 * _s_ariAtkUpLoop)) * image_xscale); //hyper x3, random direction
								
								if(global.hyperActive){
								
									_atk.direction = 90 + -(random_range(30, 60) * image_xscale);
								
								}
							
							}
							
							audf_playSfx(sfx_shot2);
							
							_s_ariAtkUpLoop++;
							cstate_time = 0;
						
						}
						
						if(_s_ariAtkUpLoop == 3){
						
						    if(cstate_time > lastAct.endLag * lastAct.lagCancel){
						        input_lock = false;
						    }
						
						    if(cstate_time > (global.hyperActive ? 0.1 : lastAct.endLag)){
						        
    							input_lock = false;
    							sprite_index = s_idle;
    		
    							switchState(noone);
							
						    }
						
						}
					
					}
	
				}
			
			}

		}
		
		state_atkDn.endLag = 0.3;
		state_atkDn.lagCancel = 0.01;
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
					_s_aftImg.src = id;
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_lime;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
					_s_aftImg.dmg = 1;
					_s_aftImg.lift = 2;
					
					audf_playSfx(sfx_whoosh1);
				
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
						
						audf_playSfx(sfx_shot2);
					
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
					
					audf_playSfx(sfx_explode);
					
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
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.1 : lastAct.endLag)){
					
					input_lock = false;
					iState = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_def.endLag = 0.4;
		state_def.lagCancel = 0;
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
					_s_aftImg.src = id;
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = c_lime;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = sprite_index;
					_s_aftImg.atkStun = 1;
					_s_aftImg.hitSound = sfx_whish1;
					
					audf_playSfx(sfx_whoosh1);
				
				}
				
				force_x = moveSpd * 2 * image_xscale;
				spd_y = 0;
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
    				input_lock = false;
				}
	
				if(cstate_time > lastAct.endLag){
	
					input_lock = false;
					iState = false;
					sprite_index = s_idle;
					
					instance_destroy(_s_aftImg);
		
					switchState(noone);
	
				}
			
			}

		}
		
	}
	
	function plyData_bre(_src) : plyData(_src, 3) constructor{
	
		uiCol = CC_BRE_PURP;
		
		s_idle = spr_bre_idle;
		s_move = spr_bre_move;
	
	    state_atk.endLag = 0.5;
		state_atk.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					if(on_ground()){
						input_x = 0;
					}
		
					input_lock = true;
					
					sprite_index = spr_bre_atk1;
				
				}
	
				if(cstate_time > (global.hyperActive ? 0 : 0.2)){
	
					switchState(currPly.state_atk.run2);
	
				}
			
			}

		}

		state_atk.run2 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					force_x = image_xscale * -2;
		
					//create slash
					var
					_atk = scr_place(obj_pAtk_bre, x + (image_xscale * 10), y + -9),
					_atk2 = scr_place(obj_pAtk_bre_scan, _atk.x, _atk.y);
					
					_atk.image_xscale = image_xscale;
					
					_atk2.pv_x = image_xscale;
					_atk2.drawW = 4;
					
					if(global.hyperActive){
					    
					    _atk.image_xscale *= 2;
					    _atk.image_yscale = _atk.image_xscale;
					    
					    _atk2.drawW *= 2;
					    
					}
					
					with _atk2{
					    hitscan_init(drawW);
					}
					
					audf_playSfx(sfx_shot2);
					audf_playSfx(sfx_shot3);
					shakeCam(random_range(1, 2), random_range(1, 2));
				
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_atkUp.endLag = 0.5;
		state_atkUp.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					if(on_ground()){
						input_x = 0;
					}
		
					input_lock = true;
					
					sprite_index = spr_bre_atkUp1;
				
				}
	
				if(cstate_time > (global.hyperActive ? 0 : 0.1)){
	
					switchState(currPly.state_atkUp.run2);
	
				}
			
			}

		}

		state_atkUp.run2 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					sprite_index = spr_bre_atkUp2;
		
					//create slash
					var _f_atk = function(__x, __y, __h, __v){
					    
					    var
    					_atk = scr_place(obj_pAtk_breUp, __x, __y);
    					
    					_atk.pv_x = __h;
    					_atk.pv_y = __v;
					    
					}
					
					var
					_offX = image_xscale * 5,
					_offY = -20,
					_spdX = image_xscale * 0.5,
					_spdY = -6;
					
					_f_atk(x + _offX, y + _offY, _spdX, _spdY);
					
					if(global.hyperActive){
					    
					    _f_atk(x + -_offX, y + _offY, -_spdX, _spdY);
					    
					    _spdX *= 4;
					    _spdY *= 0.7;
					    
					    _f_atk(x + _offX, y + _offY, _spdX, _spdY);
					    _f_atk(x + -_offX, y + _offY, -_spdX, _spdY);
					    
					}
					
					audf_playSfx(sfx_cut2);
				
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
	    
	    state_atkDn.endLag = 0.4;
		state_atkDn.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					input_x = 0;
		
					input_lock = true;
					
					sprite_index = spr_bre_atkDn1;
				
				}
				
				spd_y = 0;
	
				if(cstate_time > (global.hyperActive ? 0 : 0.2)){
	
					switchState(currPly.state_atkDn.run2);
	
				}
			
			}

		}

		state_atkDn.run2 = function(){
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					force_x = image_xscale * -2;
					
					sprite_index = spr_bre_atkDn2;
		
					//create slash
					var
					_atk = scr_place(obj_pAtk_bre, x + (image_xscale * 9), y + -8);
					
					_atk.sprite_index = spr_bre_atkDnF;
					_atk.image_xscale = image_xscale;
					
					var _f_atk = function(__x, __y, __h, __v, __col){
					
    					var _atk2 = scr_place(obj_pAtk_hitscan, __x, __y);
    					
    					_atk2.drawW = 4;
    					_atk2.pv_x = __h;
    					_atk2.pv_y = __v;
    					_atk2.image_blend = __col;
    					_atk2.push = 0;
    			        _atk2.lift = 0;
    			        _atk2.sp_freeze = true;
    			        _atk2.atkStun = 1.5;
    					
    					with _atk2{
    					    
    					    hitscan_init(4);
    					    
    					    with scr_place(obj_pAtk_breExpl, drawX[1], drawY[1]){
    					        
    					        image_xscale = 3;
    					        image_yscale = image_xscale;
    					        
    					        push = 0;
    					        lift = 0;
    					        sp_freeze = true;
    					        atkStun = 1.5;
    					        
    					    }
    					    
    					}
					
					}
					
					_f_atk(_atk.x, _atk.y, image_xscale, 1, currPly.uiCol);
					
					if(global.hyperActive){
					    
					    _atk.image_xscale *= 2;
					    _atk.image_yscale = _atk.image_xscale;
					    
					    _f_atk(_atk.x, _atk.y, image_xscale + 1, 1, currPly.uiCol);
					    _f_atk(_atk.x, _atk.y, image_xscale, 2, currPly.uiCol);
					    
					}
					
					audf_playSfx(sfx_shot1);
					audf_playSfx(sfx_shot4);
					shakeCam(random_range(1, 2), random_range(1, 2));
				
				}
				
				spd_y = 0;
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_def.endLag = 0.2;
		state_def.lagCancel = 0;
		state_def.enCost = 0.5;
		state_def.run = function(){

			static _s_aftImg = noone;
			
			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					input_x = 0;
					input_lock = true;
					
					sprite_index = spr_bre_def;
					
					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
					_s_aftImg.src = id;
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = currPly.uiCol;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = noone;
					_s_aftImg.atkStun = 0;
					//_s_aftImg.hitSound = sfx_whish1;
					
					//determine zip direction
					var
					_dist = 30,
					_x = (io_check(en_ioType.DOWN, [en_input.UNI_RIGHT]) + -io_check(en_ioType.DOWN, [en_input.UNI_LEFT])) * _dist,
					_y = (io_check(en_ioType.DOWN, [en_input.UNI_DOWN]) + -io_check(en_ioType.DOWN, [en_input.UNI_UP])) * _dist;
					
					show_debug_message(_x);
					
					if(_x != 0){
					    image_xscale = sign(_x);
					}
					
					if(_x == 0 && _y == 0){
					    _x = image_xscale * _dist;
					}
					
					move_x(_x, true);
					move_y(_y);
					
					force_x = _x * 0.1;
					force_y = _y * 0.1;
					
					audf_playSfx(sfx_whoosh1);
				
				}
				
				spd_x = 0;
				spd_y = 0;
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
    				input_lock = false;
				}
	
				if(cstate_time > lastAct.endLag){
	
					input_lock = false;
					iState = false;
					sprite_index = s_idle;
					
					instance_destroy(_s_aftImg);
		
					switchState(noone);
	
				}
			
			}

		}
		
	}
	
	function plyData_tear(_src) : plyData(_src, 3) constructor{
	
		uiCol = CC_BRE_PURP;
		
		s_idle = spr_tear_idle;
		s_move = spr_tear_idle;
	
	    state_atk.endLag = 0.5;
		state_atk.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					if(on_ground()){
						input_x = 0;
					}
		
					input_lock = true;
					
					sprite_index = spr_bre_atk1;
				
				}
	
				if(cstate_time > (global.hyperActive ? 0 : 0.2)){
	
					switchState(currPly.state_atk.run2);
	
				}
			
			}

		}

		state_atk.run2 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					force_x = image_xscale * -2;
		
					//create slash
					var
					_atk = scr_place(obj_pAtk_bre, x + (image_xscale * 10), y + -9),
					_atk2 = scr_place(obj_pAtk_bre_scan, _atk.x, _atk.y);
					
					_atk.image_xscale = image_xscale;
					
					_atk2.pv_x = image_xscale;
					_atk2.drawW = 4;
					
					if(global.hyperActive){
					    
					    _atk.image_xscale *= 2;
					    _atk.image_yscale = _atk.image_xscale;
					    
					    _atk2.drawW *= 2;
					    
					}
					
					with _atk2{
					    hitscan_init(drawW);
					}
					
					audf_playSfx(sfx_shot2);
					audf_playSfx(sfx_shot3);
					shakeCam(random_range(1, 2), random_range(1, 2));
				
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_atkUp.endLag = 0.5;
		state_atkUp.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					if(on_ground()){
						input_x = 0;
					}
		
					input_lock = true;
					
					sprite_index = spr_bre_atkUp1;
				
				}
	
				if(cstate_time > (global.hyperActive ? 0 : 0.1)){
	
					switchState(currPly.state_atkUp.run2);
	
				}
			
			}

		}

		state_atkUp.run2 = function(){

			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					sprite_index = spr_bre_atkUp2;
		
					//create slash
					var _f_atk = function(__x, __y, __h, __v){
					    
					    var
    					_atk = scr_place(obj_pAtk_breUp, __x, __y);
    					
    					_atk.pv_x = __h;
    					_atk.pv_y = __v;
					    
					}
					
					var
					_offX = image_xscale * 5,
					_offY = -20,
					_spdX = image_xscale * 0.5,
					_spdY = -6;
					
					_f_atk(x + _offX, y + _offY, _spdX, _spdY);
					
					if(global.hyperActive){
					    
					    _f_atk(x + -_offX, y + _offY, -_spdX, _spdY);
					    
					    _spdX *= 4;
					    _spdY *= 0.7;
					    
					    _f_atk(x + _offX, y + _offY, _spdX, _spdY);
					    _f_atk(x + -_offX, y + _offY, -_spdX, _spdY);
					    
					}
					
					audf_playSfx(sfx_cut2);
				
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
	    
	    state_atkDn.endLag = 0.4;
		state_atkDn.run = function(){

			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
		
					input_x = 0;
		
					input_lock = true;
					
					sprite_index = spr_bre_atkDn1;
				
				}
				
				spd_y = 0;
	
				if(cstate_time > (global.hyperActive ? 0 : 0.2)){
	
					switchState(currPly.state_atkDn.run2);
	
				}
			
			}

		}

		state_atkDn.run2 = function(){
			
			with(src){
			
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;	
					
					force_x = image_xscale * -2;
					
					sprite_index = spr_bre_atkDn2;
		
					//create slash
					var
					_atk = scr_place(obj_pAtk_bre, x + (image_xscale * 9), y + -8);
					
					_atk.sprite_index = spr_bre_atkDnF;
					_atk.image_xscale = image_xscale;
					
					var _f_atk = function(__x, __y, __h, __v, __col){
					
    					var _atk2 = scr_place(obj_pAtk_hitscan, __x, __y);
    					
    					_atk2.drawW = 4;
    					_atk2.pv_x = __h;
    					_atk2.pv_y = __v;
    					_atk2.image_blend = __col;
    					_atk2.push = 0;
    			        _atk2.lift = 0;
    			        _atk2.sp_freeze = true;
    			        _atk2.atkStun = 1.5;
    					
    					with _atk2{
    					    
    					    hitscan_init(4);
    					    
    					    with scr_place(obj_pAtk_breExpl, drawX[1], drawY[1]){
    					        
    					        image_xscale = 3;
    					        image_yscale = image_xscale;
    					        
    					        push = 0;
    					        lift = 0;
    					        sp_freeze = true;
    					        atkStun = 1.5;
    					        
    					    }
    					    
    					}
					
					}
					
					_f_atk(_atk.x, _atk.y, image_xscale, 1, currPly.uiCol);
					
					if(global.hyperActive){
					    
					    _atk.image_xscale *= 2;
					    _atk.image_yscale = _atk.image_xscale;
					    
					    _f_atk(_atk.x, _atk.y, image_xscale + 1, 1, currPly.uiCol);
					    _f_atk(_atk.x, _atk.y, image_xscale, 2, currPly.uiCol);
					    
					}
					
					audf_playSfx(sfx_shot1);
					audf_playSfx(sfx_shot4);
					shakeCam(random_range(1, 2), random_range(1, 2));
				
				}
				
				spd_y = 0;
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
				    input_lock = false;
				}
	
				if(cstate_time > (global.hyperActive ? 0.05 : lastAct.endLag)){
	
					input_lock = false;
					sprite_index = s_idle;
		
					switchState(noone);
	
				}
			
			}

		}
		
		state_def.endLag = 0.2;
		state_def.lagCancel = 0;
		state_def.enCost = 0.5;
		state_def.run = function(){

			static _s_aftImg = noone;
			
			with(src){
				
				//on-enter actions
				if(cstate_new){
		
					cstate_new = false;
					iState = true;
					input_x = 0;
					input_lock = true;
					
					sprite_index = spr_bre_def;
					
					_s_aftImg = scr_place(obj_pAtk_afterimage, x, y);
					_s_aftImg.src = id;
					_s_aftImg.depth = depth + -99;
					_s_aftImg.image_xscale = image_xscale;
					_s_aftImg.image_blend = currPly.uiCol;
					_s_aftImg.sprite_index = sprite_index;
					_s_aftImg.mask_index = noone;
					_s_aftImg.atkStun = 0;
					//_s_aftImg.hitSound = sfx_whish1;
					
					//determine zip direction
					var
					_dist = 30,
					_x = (io_check(en_ioType.DOWN, [en_input.UNI_RIGHT]) + -io_check(en_ioType.DOWN, [en_input.UNI_LEFT])) * _dist,
					_y = (io_check(en_ioType.DOWN, [en_input.UNI_DOWN]) + -io_check(en_ioType.DOWN, [en_input.UNI_UP])) * _dist;
					
					show_debug_message(_x);
					
					if(_x != 0){
					    image_xscale = sign(_x);
					}
					
					if(_x == 0 && _y == 0){
					    _x = image_xscale * _dist;
					}
					
					move_x(_x, true);
					move_y(_y);
					
					force_x = _x * 0.1;
					force_y = _y * 0.1;
					
					audf_playSfx(sfx_whoosh1);
				
				}
				
				spd_x = 0;
				spd_y = 0;
				
				if(instance_exists(_s_aftImg)){
					_s_aftImg.x = x;
					_s_aftImg.y = y;
				}
				
				if(cstate_time > lastAct.endLag * lastAct.lagCancel){
    				input_lock = false;
				}
	
				if(cstate_time > lastAct.endLag){
	
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

	if(is_undefined(_ply)){
	    
	    _ply = plyTeam[currPly == plyTeam[0]];
	    
	}
	
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
		
		switchPly();
		
		var _p2 = scr_place(obj_deadPlayer, x, y);
		
		_p2.sprite_index = _ply.s_idle;
		
	}
	
	_ply.hpRegen = clamp(_ply.hpRegen, _ply.hp, _ply.hp + 2);
	
	with obj_ui{
	    uiMini = 1.5;
	}
	
	if(plyTeam[0].hp <= 0 && plyTeam[1].hp <= 0){
	    
	    with obj_ui{
	        
	        uiMini = 0;
	        fc_gameOver_1();
	        
	    }
	    
	}

}

function hyperStart(){
    
    global.hyperActive = true;
    global.hyperTime = HYPER_DURATION;
    global.hyper = 0;
    global.hyperChain = 1;
    
    global.hyperAfterImg = scr_place(obj_pAtk_afterimage, x, y);
    global.hyperAfterImg.src = id;
	global.hyperAfterImg.depth = depth + 99;
	global.hyperAfterImg.image_blend = c_fuchsia;
	global.hyperAfterImg.sprite_index = sprite_index;
	global.hyperAfterImg.mask_index = spr_noMask;
	global.hyperAfterImg.dmg = 0;
	global.hyperAfterImg.atkStun = 0;
	global.hyperAfterImg.slowTo = 1;
	global.hyperAfterImg.slowDur = 0;
	
	audf_playSfx(sfx_buff);
	audf_playSfx(sfx_whish1);
    
}

var _roster = [
    
    new plyData_imo(id),
    new plyData_ari(id),
    new plyData_bre(id),
    new plyData_tear(id),
    new plyData_ari(id),
    new plyData_ari(id)
    
];

plyTeam = [_roster[global.arr_team[0]], _roster[global.arr_team[1]]];
plyTeam[0].slot2 = false;
plyTeam[1].slot2 = true;

player = true;

en = 6;
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