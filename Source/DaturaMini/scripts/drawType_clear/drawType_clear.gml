function drawType_clear(_fade, _stripe, _fadeTxt){
    
    if(is_undefined(_fade)){ _fade = fade[0]; }
    if(is_undefined(_stripe)){ _stripe = fade_stripe[0]; }
    if(is_undefined(_fadeTxt)){ _fadeTxt = fade_txt[0]; }
    
    if(clearPhase[1]){
        _fade = 1;
    }
    
    var
    _clear_topY = y + 20,
    _x = x + (camW / 2),
    _y = y + (camH / 2),
    _y2 = lerp(_y + 2, _clear_topY, _fade),
    _offX = lerp(100, 2, _fadeTxt),
    _offY = _stripe * camH * 0.5;
    
    draw_set_color(c_white);
    draw_set_alpha(0.9);
    
    draw_rectangle(x, _y + -_offY, x + camW, _y + _offY, false);
    
    draw_set_color(c_dkgray);
    draw_set_alpha(_fadeTxt);
    draw_set_font(ft_title);
    draw_set_halign(fa_right);
    draw_set_valign(fa_center);
    
    draw_text(_x + -_offX, _y2, "STAGE");
    
    draw_set_halign(fa_left);
    
    draw_text(_x + _offX, _y2, "CLEAR");
    
    _y = _clear_topY + 30;
    _offY = 15;
    
    if(clearPhase[1] >= 1){
        
        var
        _str = "",
        _time = clearDisp_time;
        
        _str += string(floor(_time / (room_speed * 60))) + ":";
        
        _time = _time mod (room_speed * 60);
        
        _str += string(floor(_time / room_speed)) + ".";
        
        _time = _time mod room_speed;
        
        _str += string(floor(_time / 0.6));
        
        drawClearStat(_y, "TIME", _str, (clearDisp_time == global.bonus_time[0]) && (global.bonus_time[0] < global.bonus_time[1]));
        
        clearDisp_time = approachStat(clearDisp_time, global.bonus_time);
        
    }
    
    _y += _offY;
    
    if(clearPhase[1] >= 2){
        
        drawClearStat(_y, "KILLS", string(clearDisp_kill), (clearDisp_kill == global.bonus_kill[0]) && (global.bonus_kill[0] >= global.bonus_kill[1]));
        
        clearDisp_kill = approachStat(clearDisp_kill, global.bonus_kill);
        
    }
    
    _y += _offY;
    
    if(clearPhase[1] >= 3){
        
        drawClearStat(_y, "TOKENS", string(clearDisp_token), (clearDisp_token == global.bonus_token[0]) && (global.bonus_token[0] >= global.bonus_token[1]));
        
        clearDisp_token = approachStat(clearDisp_token, global.bonus_token);
        
    }
    
    _y += _offY;
    
    if(clearPhase[1] >= 4){
        
        drawClearStat(_y, "MAX HYPER", string(clearDisp_hyper), (clearDisp_hyper == global.bonus_hyper[0]) && (global.bonus_hyper[0] >= global.bonus_hyper[1]));
        
        clearDisp_hyper = approachStat(clearDisp_hyper, global.bonus_hyper);
        
    }
    
    if(clearPhase[1] == 5 && io_check(en_ioType.PRESS, [en_input.MENU_ACCEPT, en_input.MENU_START])){
        
        fc_next = (global.rmNext == room) ? fc_allClear_1 : fc_segment_fadeOut_2;
        fc_delay = 1.5;
        
        fade = [2, 1];
        
        clearPhase[1] = 6;
        
        audio_sound_gain(bgmCurr, 0, 500);
        
    }
    
    _y = y + camH + -10;
    
    if(clearPhase[1]){
        
        draw_set_font(ft_small);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        
        styleTxt("TOTAL SCORE", _x, _y + -15, c_gray, c_ltgray);
        
        draw_set_font(ft_title);
        
        styleTxt(string_replace_all(string_format(clearDisp_score, SCORE_DIGITS, 0), " ", "0"), _x, _y, CC_UI_ACCENT, c_black);
        
        if(clearDisp_score < global.points){
            
            clearDisp_score += ceil(global.points / room_speed);
            
            if(clearDisp_score >= global.points){
                clearDisp_score = global.points;
            }
            
        }
        
    }
    
    if(clearPhase[1] == 6){
        
        drawType_slant(fade[0], 0, 0);
        
    }
    
}