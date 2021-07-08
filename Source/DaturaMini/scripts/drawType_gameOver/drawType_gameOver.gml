function drawType_gameOver(_fade, _stripe, _fadeTxt){
    
    if(is_undefined(_fade)){ _fade = fade[0]; }
    if(is_undefined(_stripe)){ _stripe = fade_stripe[0]; }
    if(is_undefined(_fadeTxt)){ _fadeTxt = fade_txt[1]; } //using index 1 to skip tweening
    
    var
    _x = x + (camW / 2),
    _y = y + (camH / 2),
    _offY = _stripe * camH * 0.5,
    _offX = 10;
    
    draw_set_alpha(_fade);
    draw_set_color(CC_UI_ACCENT);
    
    draw_rectangle(x, y, x + camW, y + camH, false);
    
    draw_set_alpha(1);
    draw_set_color(c_black);
    
    draw_rectangle(x, _y + -_offY, x + camW, _y + _offY, false);
    
    if(clamp(_fadeTxt, 0, 9) == _fadeTxt){
    
        draw_set_font(ft_small);
        draw_set_halign(fa_right);
        draw_set_valign(fa_center);
        draw_set_color(c_white);
        
        draw_text(_x, _y + 1, "CONTINUE?");
        
        draw_set_font(ft_titleX);
        draw_set_halign(fa_left);
        draw_set_alpha((sin(current_time / 10) * 0.5) + 0.5);
        
        styleTxt(string(_fadeTxt), _x + _offX, _y + 2, c_white, CC_UI_ACCENT);
        
        if(io_check(en_ioType.PRESS, [en_input.MENU_START])){
            
            fc_next = noone;
            
            fade = [0, 0];
            fade_stripe = [0, 0];
            fade_txt = [0, 0];
            
            drawType = drawType_slant;
            
            endNim();
            
            with obj_player{
                
                iFrames = 2;
                iState = false;
                visible = true;
                
                switchPly();
                
                loseHp(-99, plyTeam[0]);
                loseHp(-99, plyTeam[1]);
                
                hyperStart();
                
                global.hyperTime = HYPER_DURATION / 2;
                
            }
            
        }else if(io_check(en_ioType.PRESS, [en_input.MENU_ACCEPT, en_input.MENU_CANCEL])){
            fc_next();
        }
    
    }
    
    _offX = 30;
    
    draw_set_font(ft_titleX);
    draw_set_color(c_black);
    draw_set_alpha(1);
    
    if(_fade > 1){
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        
        _x = lerp(x + camW, x + _offX, clamp(_fade + -1, 0, 1));
        
        draw_text(_x, y + _offX, "GAME");
        
    }
    
    if(_fade > 2){
        
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        
        _x = lerp(x, x + camW + -_offX, clamp(_fade + -2, 0, 1));
        
        draw_text(_x, y + camH + -_offX, "OVER");
        
    }
    
}