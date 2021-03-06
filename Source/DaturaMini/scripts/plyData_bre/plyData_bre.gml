function plyData_bre(_src) : plyData(_src, 3) constructor{

	uiCol = CC_BRE_PURP;
	
	s_idle = spr_bre_idle;
	s_move = spr_bre_move;
	
	#region //atk

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
    	
    #endregion
    
    #region //atkUp
	
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
    	
    #endregion
    
    #region //atkDn
    
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
    				    
    				    _f_atk(_atk.x, _atk.y, image_xscale + (1 * sign(image_xscale)), 1, currPly.uiCol);
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
    
    #endregion
    
    #region //def
	
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
    	
    #endregion
	
}