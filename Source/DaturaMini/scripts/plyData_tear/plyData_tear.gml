function plyData_tear(_src) : plyData(_src, 3) constructor{

	uiCol = CC_BRE_PURP;
	
	podActive = true;
	
	s_idle = spr_tear_idle;
	s_move = spr_tear_idle;
	
	atk_loop = 0;
	
	fn_bullet = function(_obj, _x, _y, _spd, _dir){

        var _r = scr_place(_obj, _x, _y);
        
        _r.pv_d = _spd;
        _r.direction = _dir;
        _r.image_angle = _dir;
        
        _r.glow = scr_place(obj_glow, _x, _y);
        //_r.glow.size = 2;
        _r.glow.image_blend = _r.image_blend;
        _r.glow.depth = _r.depth + 10;
        
        return _r;
        
    }
    
    fn_forceMerge = function(){
        
        if(!podMerged){
            
            podMerged = true;
            
            state_atk = s_atkForce;
            state_atkUp = s_atkUpForce;
            state_atkDn = s_atkDnForce;
            
            src.s_idle = spr_tear_idle_FV;
            src.s_move = src.s_idle;
            
            src.sprite_index = src.s_idle;
            
            podActive = false;
            
            shakeCam(random_range(1, 2), random_range(1, 2));
    				
			audf_playSfx(sfx_buff);
			audf_playSfx(sfx_whoosh2);
            
        }
        
    }
    
    fn_forceSplit = function(){
        
        if(podMerged){
            
            podMerged = false;
            
            state_atk = s_atkBasic;
            state_atkUp = s_atkUpBasic;
            state_atkDn = s_atkDnBasic;
            
            src.s_idle = spr_tear_idle;
            src.s_move = src.s_idle;
            
            src.sprite_index = src.s_idle;
            
            podActive = true;
            
            with src{
            
                forcePod.xx = x;
                forcePod.yy = y + -10;
            
            }
            
            audf_playSfx(sfx_whoosh1);
            
        }
        
    }
    
    #region //atk basic

        s_atkBasic = addAct(_src);
        
        s_atkBasic.endLag = 0.07;
    	s_atkBasic.run = function(){
    		
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new){
    	
    				cstate_new = false;
    	
    				sprite_index = spr_tear_atk;
    				
    				if(global.hyperActive){
    				    
    				    if(global.hyperTime <= 0){
    				        endHyper(); //manual check to avoid infinite hyper glitch
    				    }
    				    
    				}
    				
    			}
    			
    			if(cstate_time == 0){
    			    
    			    force_x = spd_x;
    				force_y = spd_y;
    				
    				direction = 90 + -(90 * image_xscale);
    			    
    			}
    			
    			if(cstate_time < 0.03 && cstate_time != 0){
    			    
    			    //create shot
    				var
    				_atk;
    				
    				if((currPly.atk_loop mod 2) == 0){
    				    _atk = currPly.fn_bullet(obj_pAtk_ari, x + (image_xscale * 12), y + -10 + ((currPly.atk_loop == 0) ? -5 : 5), 5, -90 + (image_xscale * 90));
    				}else{
    				    
    				    _atk = currPly.fn_bullet(obj_pAtk_ari, forcePod.xx, forcePod.yy, 5, forcePod.angle);
    				    
    				    if(global.hyperActive){
    				        currPly.s_atkForce.run();
    				    }
    				    
    				}
    				
    				_atk.image_blend = CC_EN_BLUE;
    				instance_destroy(_atk.glow);
    				
    				currPly.atk_loop = (currPly.atk_loop + 1) mod 4;
    				
    				audf_playSfx(sfx_shot1);
    			    
    			}
    			
    			var
    			_vec = [0, 0],
    			_dist = 12;
    			
    			if(scr_playerIO([en_input.UNI_LEFT])){
    			    _vec[0] = -1;
    			}else if(scr_playerIO([en_input.UNI_RIGHT])){
    			    _vec[0] = 1;
    			}
    			
    			if(scr_playerIO([en_input.UNI_UP])){
    			    _vec[1] = -1;
    			}else if(scr_playerIO([en_input.UNI_DOWN])){
    			    _vec[1] = 1;
    			}
    			
    			var
    			_lst_col = ds_list_create();
    			
    			collision_rectangle_list(x + -forcePod.scanDist, y + -10 + -forcePod.scanDist, x + forcePod.scanDist, y + -10 + forcePod.scanDist, obj_enemy, true, true, _lst_col, true);
    			
    			for(var _i = ds_list_size(_lst_col) + -1; _i >= 0; _i--){
    			    
    			    var
    			    _e = _lst_col[| _i],
    			    _eAngle = (point_direction(x, y + -10, mean(_e.bbox_left, _e.bbox_right), mean(_e.bbox_top, _e.bbox_bottom)) + 360) mod 360,
    			    _angles = [(direction + -45 + 360) mod 360, (direction + 45 + 360) mod 360];
    			    
    			    show_debug_message("\n" + string(_angles[0]) + " | " + string(_eAngle) + " | " + string(_angles[1]));
    			    
    			    if(_angles[0] < _angles[1]){
    			    
    				    if(_angles[0] > _eAngle || _eAngle > _angles[1]){
    				        ds_list_delete(_lst_col, _i);
    				        show_debug_message("OUT");
    				    }
    			    
    			    }else{
    			        
    			        if(_angles[0] > _eAngle && _eAngle > _angles[1]){
    				        ds_list_delete(_lst_col, _i);
    				        show_debug_message("OUT");
    				    }
    			        
    			    }
    			    
    			    show_debug_message("\n");
    			    
    			}
    			
    			if(!array_equals(_vec, [0, 0])){
    			    
    			    direction = point_direction(0, 0, _vec[0], _vec[1]);
    			    forcePod.angle = direction;
    			    
    			}
    			
    			if(!instance_exists(forcePod.lockon) || ds_list_find_index(_lst_col, forcePod.lockon) == -1){
    			
    				forcePod.lockon = noone;
    				
    				if(ds_list_size(_lst_col)){
    				    forcePod.lockon = _lst_col[| 0];
    				}else{
    				    forcePod.angle = direction;
    				}
    			
    			}
    			
    			if(instance_exists(forcePod.lockon)){
    			    forcePod.angle = point_direction(x, y + -10, mean(forcePod.lockon.bbox_left, forcePod.lockon.bbox_right), mean(forcePod.lockon.bbox_top, forcePod.lockon.bbox_bottom));
    			}
    			
    			ds_list_destroy(_lst_col);
    			
    			forcePod.tgtX = x + lengthdir_x(_dist, forcePod.angle);
    			forcePod.tgtY = y + -10 + lengthdir_y(_dist, forcePod.angle);
    			
    			spd_x = 0;
    			spd_y = 0;
    			
    			if(cstate_time > lastAct.endLag){
    				
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
    
    #region //atk force

        s_atkForce = addAct(_src);
        
        s_atkForce.endLag = 0.2;
    	s_atkForce.run = function(){
    
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new || global.hyperActive){
    	
    				if(!global.hyperActive){
    				
        				cstate_new = false;
        				move_lock = false;
        	
        				sprite_index = spr_tear_atk_FV;
    				
    				}
    				
    				//create shot
    				for(var _i = 0; _i < 2; _i++){
    				
        				var
        				_dir = 90 + -(image_xscale * 90),
        				_atk = currPly.fn_bullet(obj_pAtk_ari, x + (image_xscale * 10), y + (_i ? -5 : -15), 6, _dir);
        				
        				if(global.hyperActive){
        				    
        				    _atk.x = forcePod.xx + lengthdir_x(8, forcePod.angle + (_i ? 45 : -45));
        				    _atk.y = forcePod.yy + lengthdir_y(8, forcePod.angle + (_i ? 45 : -45));
        				    
        				    _atk.direction = forcePod.angle;
        				    _atk.image_angle = _atk.direction;
        				    
        				}
        				
        				with _atk{
        				
            				sprite_index = spr_tracerAtk;
            				image_blend = c_red;
            				passWall = true;
            				passEnemy = true;
            				dmg = 2;
            				atkStun = 0.05;
            				glow.image_blend = image_blend;
        				
        				}
    				
    				}
    				
    				audf_playSfx(sfx_shot1);
    				audf_playSfx(sfx_shot2);
    			
    			}
    			
    			if(cstate_time > lastAct.endLag && !global.hyperActive){
    				
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
    
    #region //atkUp basic
	
    	s_atkUpBasic = addAct(_src);
    	s_atkUpBasic.airLimit = true;
    	s_atkUpBasic.enCost = 1;
    	
    	s_atkUpBasic.endLag = 0.3;
    	s_atkUpBasic.run = function(){
    
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new){
    	
    				cstate_new = false;	
    	
    				force_x = spd_x;
    				force_y = spd_y;
    				
    				input_x = 0;
    	
    				input_lock = true;
    				
    				sprite_index = spr_tear_atkUp;
    			
    			}
    			
    			spd_y = 0;
    
    			if(cstate_time > 0.1){
    
    				switchState(currPly.state_atkUp.run2);
    
    			}
    		
    		}
    
    	}
    
    	s_atkUpBasic.run2 = function(){
    
            with(src){
            
                //on-enter actions
                if(cstate_new){
                
                    cstate_new = false;
                    
                    direction = 0;
                    
                    if(global.hyperActive){
                        
                        repeat(4){
                            
                            currPly.s_atkUpForce.run();
                            
                            direction += 90;
                            
                        }
                        
                        direction = 0;
                        
                    }
                
                }
    			
                if(direction < 180 && cstate_time > 0.03){
                    
                    repeat(2){
                    
                        for(var _i = 0; _i < 2; _i++){
                        
                            var _atk = currPly.fn_bullet(obj_pAtk_ari, x, y + -10, 5, direction + (180 * _i));
                            
                            _atk.image_blend = CC_EN_BLUE;
                            _atk.duration = room_speed * 0.3;
                            instance_destroy(_atk.glow);
                        
                        }
                        
                        direction += 15;
                    
                    }
                    
                    cstate_time = 0;
                    
                    audf_playSfx(sfx_shot1);
                    
                }
    			
                spd_y = 0;
                
                if(cstate_time > lastAct.endLag * lastAct.lagCancel){
                    input_lock = false;
                }
                
                if(cstate_time > lastAct.endLag){
                
                    input_lock = false;
                    sprite_index = s_idle;
                    
                    switchState(noone);
                
                }
    		
    		}
    
    	}
    	
    #endregion
    
    #region //atkUp force

        s_atkUpForce = addAct(_src);
        
        s_atkUpForce.endLag = 0.4;
    	s_atkUpForce.run = function(){
    
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new || global.hyperActive){
    	
    				if(!global.hyperActive){
    				
        				cstate_new = false;
        				move_lock = false;
        	
        				sprite_index = spr_tear_atk_FV;
    				
    				}
    				
    				//create shot
    				for(var _i = 0; _i < 2; _i++){
    				
        				var
        				_atk = currPly.fn_bullet(obj_pAtk_ari, x + (image_xscale * 10), y + -15, 4, direction + 90 + -(image_xscale * 45) + (_i ? 10 : -10));
        				
        				with _atk{
        				
            				sprite_index = spr_tracerAtk;
            				image_blend = c_blue;
            				glow.image_blend = image_blend;
            				dmg = 4;
            				atkStun = 0.3;
        				
        				}
    				
    				}
    				
    				audf_playSfx(sfx_shot1);
    				audf_playSfx(sfx_shot2);
    			
    			}
    			
    			if(cstate_time > lastAct.endLag && !global.hyperActive){
    				
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
    
    #region //atkDn basic
    
        s_atkDnBasic = addAct(_src);
        s_atkDnBasic.airLimit = true;
    	s_atkDnBasic.enCost = 1;
        
        s_atkDnBasic.endLag = 0.4;
    	s_atkDnBasic.run = function(){
    
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new){
    	
    				cstate_new = false;	
    	
    				input_x = 0;
    	
    				input_lock = true;
    				
    				sprite_index = spr_tear_atk;
    				
    				atk_loop = 0;
    				
    				forcePod.tgtX = x + -(5 * image_xscale);
    				forcePod.tgtY = y + -10;
    				forcePod.angle = 90 + (90 * image_xscale);
    			
    			}
    			
    			spd_y = 0;
    
    			if(cstate_time > 0.2){
    
    				switchState(currPly.state_atkDn.run2);
    
    			}
    		
    		}
    
    	}
    
    	s_atkDnBasic.run2 = function(){
    		
    		with(src){
    		
    			//on-enter actions
    			if(cstate_new){
    	
    				cstate_new = false;
    				
    			}
    			
    			spd_y = 0;
    			
    			if(cstate_time > 0.1 && atk_loop < 4){
    			    
    			    cstate_time = 0;
    			    
    			    var _f_atk = function(__x, __y, __h){
    				
    					var _atk2 = scr_place(obj_pAtk_hitscan, __x, __y);
    					
    					_atk2.drawW = 4;
    					_atk2.pv_x = __h;
    					_atk2.image_blend = CC_EN_BLUE;
    					_atk2.push = __h * 2;
    			        _atk2.lift = 0;
    			        _atk2.atkStun = 0.5;
    			        
    			        audf_playSfx(sfx_shot1);
        				audf_playSfx(sfx_shot2);
        				shakeCam(random_range(1, 2), random_range(1, 2));
        				
        				return _atk2;
    				
    				}
    				
    				var _atk = _f_atk(x + (10 * image_xscale), y + -10, image_xscale);
    				
    				if(global.hyperActive){
    				    
    				    currPly.s_atkDnForce.run();
    				    
    				    direction += 180;
    				    
    				    currPly.s_atkDnForce.run();
    				    
    				    direction = 0;
    				    
    				}
    				
    				if(atk_loop mod 2){
    				    
    				    _atk.pv_x *= -1;
    				    _atk.x = forcePod.xx + -(image_xscale * 10);
    				    
    				}
    				
    				_atk.y += (clamp(atk_loop, 1, 2) == atk_loop) ? 4 : -4;
    				
    				var _flash = scr_place(obj_pAtk_bre, _atk.x, _atk.y + 1);
    				_flash.image_xscale = _atk.pv_x;
    				_flash.x += _atk.pv_x * -2;
    				
    				with _atk{
    				    hitscan_init(4);
    				}
    				
    				atk_loop++;
    			    
    			}
    			
    			if(cstate_time > lastAct.endLag * lastAct.lagCancel){
    			    input_lock = false;
    			}
    
    			if(cstate_time > lastAct.endLag){
    
    				input_lock = false;
    				sprite_index = s_idle;
    	
    				switchState(noone);
    
    			}
    		
    		}
    
    	}
    	
    #endregion
    
    #region //atkDn force

        s_atkDnForce = addAct(_src);
        
        s_atkDnForce.endLag = 0.4;
    	s_atkDnForce.run = function(){
    
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new || global.hyperActive){
    	
    				if(!global.hyperActive){
    				
        				cstate_new = false;
        				move_lock = false;
        	
        				sprite_index = spr_tear_atk_FV;
    				
    				}
    				
    				//create shot
    				var
    				_atk = currPly.fn_bullet(obj_pAtk_tearDn_force, x + (image_xscale * 12), y + -6, 3, direction + 90 + -(image_xscale * 90));
    				
    				if(direction > 90){
    				    _atk.x += image_xscale * -20;
    				}
    				
    				audf_playSfx(sfx_shot1);
    				audf_playSfx(sfx_shot2);
    			
    			}
    			
    			if(cstate_time > lastAct.endLag && !global.hyperActive){
    				
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
    
    #region //def
	
    	state_def.endLag = 0.1;
    	state_def.lagCancel = 0;
    	state_def.enCost = 0;
    	state_def.run = function(){
    
    		with(src){
    			
    			//on-enter actions
    			if(cstate_new){
    	
    				cstate_new = false;
    				input_x = 0;
    				input_lock = true;
    				
    				sprite_index = spr_tear_def;
    				
    				forcePod.tgtX = x;
    				forcePod.tgtY = y + -10;
    			
    			}
    			
    			spd_x = 0;
    			spd_y = 0;
    			
    			if(currPly.podMerged || global.hyperActive){
    			    
    			    input_lock = false;
    			    
    			    with currPly{
    			        fn_forceSplit();
    			    }
    			    
    			    switchState(noone);
    			    
    			}
    			
    			if(cstate_time > 0.3){
    			    
    			    switchState(currPly.state_def.run2);
    			    
    			}
    		
    		}
    
    	}
    	
    	state_def.run2 = function(){
    	    
    	    with src{
    	    
        	    //on-enter actions
    			if(cstate_new){
    	
    				cstate_new = false;
    				
    				with currPly{
    				    fn_forceMerge();
    				}
    			
    			}
    			
    			spd_x = 0;
    			spd_y = 0;
        	    
        	    if(cstate_time > lastAct.endLag){
    
    				input_lock = false;
    				sprite_index = s_idle;
    	
    				switchState(noone);
    
    			}
			
    	    }
    	    
    	}
    	
    #endregion
    
    state_atk = s_atkBasic;
    state_atkUp = s_atkUpBasic;
    state_atkDn = s_atkDnBasic;
	
}