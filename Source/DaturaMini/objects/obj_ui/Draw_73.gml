
#macro CC_HP_GREEN $75e397
#macro CC_EN_BLUE $c6ac4f
#macro CC_EN_RECHARGE $929292
#macro CC_UI_ACCENT $9c3cff
#macro CC_IMO_RED $c3c3ff
#macro CC_ARI_GREEN $c3ffd9
#macro CC_BRE_PURP $d18aa8
#macro CC_ENEMY_PINK $bb00ff

#macro SCORE_DIGITS 9
#macro SCORE_CAP 999999999
#macro HEADER_SIZE 20

camW = camera_get_view_width(view_camera[0]);
camH = camera_get_view_height(view_camera[0]);
camMidX = x + (camW / 2);
camMidY = y + (camH / 2);

var
_lerp = 0.18;

fade[0]         = lerp(fade[0],         fade[1],        _lerp);
fade_stripe[0]  = lerp(fade_stripe[0],  fade_stripe[1], _lerp);
fade_txt[0]     = lerp(fade_txt[0],     fade_txt[1],    _lerp * 1.5);
uiOffset[0]     = lerp(uiOffset[0],     uiOffset[1],    _lerp);
clearPhase[0]   = lerp(clearPhase[0],   clearPhase[1],  _lerp);

repeat(1){
    
    if(string_length(txtMain[0]) < string_length(txtMain[1])){
        txtMain[0] += string_char_at(txtMain[1], string_length(txtMain[0]) + 1);
    }
    
}

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
            
            drawUI(spr_ui_hyperFrame, c_black, _uiX, _uiY, _team[_ply].uiCol);
        
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
            	
            	//hyper
            	drawUI(spr_ui_hyperFrame, _c_uiFrame, _uiX, _uiY);
            		
        		drawUI(spr_ui_hyperFill, c_dkgray, _uiX, _uiY);
        		
        		draw_sprite_part_ext(spr_ui_hyperFill, 0, 0, 0, floor(sprite_get_width(spr_ui_hyperFill) * global.hyper), sprite_get_height(spr_ui_hyperFill), _uiX + -13, _uiY, 1, 1, (global.hyper >= 1 && sin(current_time / 15) > 0) ? c_yellow : CC_HYPINK, 1);
        		
        		drawUI(spr_ui_hyperOver, c_white, _uiX, _uiY);
            	
            }
        
        #endregion
        
        #region //mini ui
    
            //disabled, considering adding a toggle to enable
            /*if(uiMini > 0){
            
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
                    
                    if(_i < floor(obj_player.en)){
                        draw_set_color(CC_EN_BLUE);
                    }
                    
                    draw_rectangle(_coord[0] + 1, _coord[1] + 1, _coord[0] + _mW, _coord[1] + _mH + -1, false);
                    
                }
                
                draw_set_color(c_black);
                
                _mX += (_mW * _len);
                
                draw_rectangle(_mX, _mY, _mX, _mY + (_mH * 2) + _mH2, false);
                
            }/**/
        
        #endregion
        
        #region //score
        
            draw_set_font(ft_small);
            draw_set_halign(fa_right);
            draw_set_valign(fa_top);
            
            global.points = clamp(global.points, 0, SCORE_CAP);
            
            styleTxt("SCORE \n" + string_replace_all(string_format(global.points, SCORE_DIGITS, 0), " ", "0"), x + camW + -8, y + 6 + -(40 * uiOffset[0]));
            
            draw_set_halign(fa_left);
        
        #endregion
        
        #region //boss hp
        
            globalvar G_boss;
            
            G_boss = noone;
            
            with obj_enemy{
                
                if(boss){
                    G_boss = id;
                }
                
            }
            
            if(G_boss != noone){
                
                var
                _boss_xOff = 40,
                _boss_x = [x + _boss_xOff, x + camW + -_boss_xOff],
                _boss_y = y + camH + -5 + (40 * uiOffset[0]);
                
                draw_set_color(_c_uiFrame);
                
                draw_rectangle(_boss_x[0], _boss_y + -2, _boss_x[1], _boss_y + 1, false);
                
                draw_set_color(CC_HYPINK);
                
                draw_rectangle(lerp(_boss_x[1], _boss_x[0], clamp(G_boss.bossStun / BOSS_STUNMAX, 0, 1)), _boss_y + -2, _boss_x[1], _boss_y + 1, false);
                
                draw_set_color(c_dkgray);
                
                draw_rectangle(_boss_x[0] + 1, _boss_y + -1, _boss_x[1], _boss_y, false);
                
                draw_set_color(CC_HP_GREEN);
                
                draw_rectangle(lerp(_boss_x[1], _boss_x[0] + 1, clamp(G_boss.hp / G_boss.bossHp, 0, 1)), _boss_y + -1, _boss_x[1], _boss_y, false);
                
                draw_set_font(ft_small);
                draw_set_halign(fa_left);
                draw_set_valign(fa_bottom);
                
                styleTxt("BOSS", _boss_x[1], _boss_y + 4, c_white, _c_uiFrame);
                
            }
        
        #endregion
        
        if(checkDebugView()){
        
        	//player = true; //idk why this is here
        
        	draw_set_font(ft_micro);
        	draw_set_halign(fa_left);
        	draw_set_valign(fa_bottom);
        	draw_set_color(c_white);
        
        	draw_text(x + 2, y + camH + -2,
        		"dbg. K:" + string(global.bonus_kill[0]) + "/" + string(global.bonus_kill[1])
        	);
        
        }
        
        draw_set_color(c_white);
    
    }

#endregion

drawType();

draw_set_color(c_white);
draw_set_alpha(1);