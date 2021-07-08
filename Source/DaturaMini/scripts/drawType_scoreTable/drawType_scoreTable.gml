function drawType_scoreTable(){
    
    var
    _y = y + fade_stripe[1],
    _offY = HEADER_SIZE / 2,
    _gap = 40;
    
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    
    draw_rectangle(x, y, x + camW, y + camH, false);
    
    draw_set_color(c_white);
    draw_set_alpha(1);
    
    for(var _i = 0; _i < array_length(global.map_save[? en_save.SCORES]); _i++){
        
        var _dy = _y + -((10 + -_i) * _gap);
        
        if(clamp(_dy, y, y + camH) == _dy){
            drawType_hiScore(global.map_save[? en_save.SCORES][_i], _dy, _i);
        }
        
    }
    
    draw_set_color(c_black);
    
    drawType_banner(fade[0], true, HEADER_SIZE, camH / 2);
    
    draw_set_color(c_white);
    draw_set_font(ft_title);
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);
    
    if(fade[0] == 0){
    
        draw_text(camMidX, y + _offY + 2, "SCORE");
        draw_text(camMidX, y + camH + -_offY + 2, "RANKING");
    
    }
    
    if(fade_stripe[1] < (_gap * 10) + HEADER_SIZE + 30){
        fade_stripe[1] += 40 / room_speed;
    }else if(clearPhase[1] == 0){
        
        fc_next = fc_scoreTable_2;
        fc_delay = 3;
        
        clearPhase[1] = 1;
        
    }
    
    if(io_check(en_ioType.PRESS) && fade[0] == 0){
        
        //io_clear();
        fc_scoreTable_2();
        
        //audf_playSfx(sfx_confirm);
        
    }
    
}