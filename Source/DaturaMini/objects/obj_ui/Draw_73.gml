
#macro CC_HP_GREEN $75e397
#macro CC_EN_BLUE $c6ac4f
#macro CC_EN_RECHARGE $929292

fade[0] = lerp(fade[0], fade[1], 0.18);
uiOffset[0] = lerp(uiOffset[0], uiOffset[1], 0.2);

var
_camW = camera_get_view_width(view_camera[0]),
_camH = camera_get_view_height(view_camera[0]);

#region //gameplay

    if(instance_number(obj_player)){
    
        var
        _uiX = x + 20,
        _uiY = y + 20 + -(40 * uiOffset[0]),
        _uiW = 6,
        _c_uiFrame = $202020,
        _colCurr = c_white,
        _ply = obj_player.currPly == obj_player.plyTeam[1],
        _team = obj_player.plyTeam,
        _len = max(_team[_ply].hpMax, _team[!_ply].hpMax, obj_player.enMax);
        
        function drawUI(_spr, _col, _x, _y, _strokeCol){
        	
        	if(!is_undefined(_strokeCol)){
        	
        		draw_sprite_ext(_spr, 0, _x + 1, _y, 1, 1, 0, _strokeCol, draw_get_alpha());
        		draw_sprite_ext(_spr, 0, _x + -1, _y, 1, 1, 0, _strokeCol, draw_get_alpha());
        		draw_sprite_ext(_spr, 0, _x, _y + 1, 1, 1, 0, _strokeCol, draw_get_alpha());
        		draw_sprite_ext(_spr, 0, _x, _y + -1, 1, 1, 0, _strokeCol, draw_get_alpha());
        		
        		draw_sprite_ext(_spr, 0, _x + -1, _y + -1, 1, 1, 0, _strokeCol, draw_get_alpha());
        		draw_sprite_ext(_spr, 0, _x + -2, _y + -1, 1, 1, 0, _strokeCol, draw_get_alpha());
        	
        	}
        	
        	draw_sprite_ext(_spr, 0, _x, _y, 1, 1, 0, _col, draw_get_alpha());
        	
        }
        
        #region //ui stroke
        
            drawUI(spr_ui_labelFrame, c_black, _uiX, _uiY, _team[_ply].uiCol);
            
            for(var _i = 0; _i < _len; _i++){
            	
            	drawUI(spr_ui_hpFrame, c_black, _uiX + (_uiW * _i), _uiY, _team[_ply].uiCol);
            	
            	drawUI(spr_ui_hpSubFrame, c_black, _uiX + (_uiW * _i), _uiY, _team[_ply].uiCol);
            	
            	if(_i < obj_player.enMax){
            		drawUI(spr_ui_enFrame, c_black, _uiX + (_uiW * _i), _uiY, _team[_ply].uiCol);
            	}
            	
            }
        
        #endregion
        
        #region //ui fill
        
            drawUI(spr_ui_labelFrame, _c_uiFrame, _uiX, _uiY);
            drawUI(spr_ui_labelTxt, c_white, _uiX, _uiY);
            
            for(var _i = 0; _i < _len; _i++){
            	
            	//hp
            	drawUI(spr_ui_hpFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            	drawUI(spr_ui_hpFill, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            	
            	if(_i < _team[_ply].hpMax){
            	
            		_colCurr = c_dkgray;
            		if(_i < _team[_ply].hpRegen){ _colCurr = c_red; }
            		if(_i < _team[_ply].hp){ _colCurr = CC_HP_GREEN; }
            	
            		drawUI(spr_ui_hpFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            		drawUI(spr_ui_hpFill, _colCurr, _uiX + (_uiW * _i), _uiY);
            		drawUI(spr_ui_hpOver, c_white, _uiX + (_uiW * _i), _uiY);
            	
            	}
            	
            	//partner hp
            	drawUI(spr_ui_hpSubFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            	drawUI(spr_ui_hpSubFill, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            	
            	if(_i < _team[!_ply].hpMax){
            	
            		_colCurr = c_dkgray;
            		if(_i < _team[!_ply].hpRegen){ _colCurr = c_red; }
            		if(_i < _team[!_ply].hp){ _colCurr = CC_HP_GREEN; }
            	
            		drawUI(spr_ui_hpSubFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            		
            		drawUI(spr_ui_hpSubFill, (_i < _team[!_ply].hpRegen) ? c_red : c_dkgray, _uiX + (_uiW * _i), _uiY);
            		
            		draw_sprite_part_ext(spr_ui_hpSubFill, 0, 0, 0, floor(sprite_get_width(spr_ui_hpSubFill) * clamp(_team[!_ply].hp + -_i, 0, 1)), sprite_get_height(spr_ui_hpSubFill), _uiX + (_uiW * _i) + 5, _uiY + -11, 1, 1, (_team[!_ply].hp + -_i < 1) ? CC_EN_RECHARGE : CC_HP_GREEN, 1);
            	
            	}
            	
            	//en
            	if(_i < obj_player.enMax){
            	
            		drawUI(spr_ui_enFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
            		
            		drawUI(spr_ui_enFill, c_dkgray, _uiX + (_uiW * _i), _uiY);
            		
            		draw_sprite_part_ext(spr_ui_enFill, 0, 0, 0, floor(sprite_get_width(spr_ui_enFill) * clamp(obj_player.en + -_i, 0, 1)), sprite_get_height(spr_ui_enFill), _uiX + (_uiW * _i) + 1, _uiY, 1, 1, (obj_player.en + -_i < 1) ? CC_EN_RECHARGE : CC_EN_BLUE, 1);
            		
            		drawUI(spr_ui_enOver, c_white, _uiX + (_uiW * _i), _uiY);
            	
            	}
            	
            }
        
        #endregion
        
        #region //mini ui
    
            if(uiMini > 0){
            
                var
                _mW = 3,
                _mH = 2,
                _mH2 = 3,
                _mX = obj_player.x + -(_mW * _len * 0.5),
                _mY = obj_player.y + 2;
                
                for(var _i = 0; _i < _len; _i++){
                    
                    var _coord = [_mX + (_mW * _i), _mY];
                    
                    draw_set_color(c_black);
                    
                    draw_rectangle(_coord[0], _coord[1], _coord[0] + _mW, _coord[1] + _mH, false);
                    
                    if(_i < floor(_team[!_ply].hp)){
                        draw_set_color(CC_HP_GREEN);
                    }else if(_i < _team[!_ply].hpRegen){
                        draw_set_color(c_red);
                    }
                    
                    draw_rectangle(_coord[0] + 1, _coord[1] + 1, _coord[0] + _mW, _coord[1] + _mH + -1, false);
                    
                    _coord[1] += _mH;
                    draw_set_color(c_black);
                    
                    draw_rectangle(_coord[0], _coord[1], _coord[0] + _mW, _coord[1] + _mH2, false);
                    
                    if(_i < _team[_ply].hp){
                        draw_set_color(CC_HP_GREEN);
                    }else if(_i < _team[_ply].hpRegen){
                        draw_set_color(c_red);
                    }
                    
                    draw_rectangle(_coord[0] + 1, _coord[1] + 1, _coord[0] + _mW, _coord[1] + _mH2 + -1, false);
                    
                    _coord[1] += _mH2;
                    draw_set_color(c_black);
                    
                    draw_rectangle(_coord[0], _coord[1], _coord[0] + _mW, _coord[1] + _mH, false);
                    
                    if(_i < obj_player.en){
                        draw_set_color(CC_EN_BLUE);
                    }
                    
                    draw_rectangle(_coord[0] + 1, _coord[1] + 1, _coord[0] + _mW, _coord[1] + _mH + -1, false);
                    
                }
                
                draw_set_color(c_black);
                
                _mX += (_mW * _len);
                
                draw_rectangle(_mX, _mY, _mX, _mY + (_mH * 2) + _mH2, false);
                
            }
        
        #endregion
        
        #region //score
        
            draw_set_font(ft_small);
            draw_set_halign(fa_right);
            
            styleTxt("SCORE \n" + string_replace_all(string_format(global.points, 10, 0), " ", "0"), x + _camW + -8, y + 6 + -(40 * uiOffset[0]));
            
            draw_set_halign(fa_left);
        
        #endregion
        
        if(checkDebugView()){
        
        	//player = true; //idk why this is here
        
        	draw_set_font(ft_small);
        	draw_set_color(c_black);
        
        	draw_text(x + 2, y + 2,
        		"onGround: " + string(on_ground()) +
        		"\nspd_x: " + string(obj_player.spd_x) +
        		"\nx: " + string(x) +
        		"\ncam_x: " + string(obj_player.cam_x)
        	);
        
        }
        
        draw_set_color(c_white);
    
    }

#endregion

#region //transitions

    if(clamp(fade[0], 0.1, 1.9) == fade[0]){
        
        var
        _x = x + ((_camW + _camH) * (1 + -fade[0])),
        _y = y;
        
        draw_set_color(c_black);
        draw_primitive_begin(pr_trianglefan);
        
        draw_vertex(_x, _y);
        draw_vertex(_x + _camW + _camH, _y);
        draw_vertex(_x + _camW, _y + _camH);
        draw_vertex(_x + -_camH, _y + _camH);
        draw_vertex(_x, _y);
        
        draw_primitive_end();
        
    }

#endregion