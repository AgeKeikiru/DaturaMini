function plyData_ari(_src) : plyData(_src, 5) constructor{

	uiCol = CC_ARI_GREEN;
	
	s_idle = spr_ari_idle;
	s_move = spr_ari_move;
	
	#region //atk
	
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
    				    
    				    _atk.y = y + -2;
    				    _atk.image_xscale *= 2;
    				    _atk.image_yscale = abs(_atk.image_xscale);
    				    _atk.pv_x *= 2;
    				    
    				    var _atk2 = scr_place(obj_pAtk_ari, _atk.x, _atk.y + -6);
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
    	
    #endregion
    
    #region //atkUp
    	
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
    	
    #endregion
    
    #region //atkDn
	
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
    	
    #endregion
    
    #region //def
	
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
    	
    #endregion
	
}