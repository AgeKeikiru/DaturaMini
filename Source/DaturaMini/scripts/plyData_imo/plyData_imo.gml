function plyData_imo(_src) : plyData(_src, 4) constructor{

	uiCol = CC_IMO_RED;
	
	s_idle = spr_imo_idle;
	s_move = spr_imo_move;
	
	#region //atk

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
	
	#endregion
	
	#region //atkUp
	
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
    	
    #endregion
    
    #region //atkDn
    
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
    	
    #endregion
    
    #region //def
	
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
    	
    #endregion
	
}