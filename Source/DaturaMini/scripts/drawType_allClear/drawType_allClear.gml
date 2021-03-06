function drawType_allClear(){
    
    var _y = y + 60;
    
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    
    draw_rectangle(x, y, x + camW, y + camH, false);
    
    draw_set_alpha(1);
    
    draw_set_font(ft_title);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    styleTxt("ALL CLEAR!!!", camMidX, _y, (sin(current_time / 10) > 0) ? CC_HYPINK : c_yellow, c_black);
    
    draw_set_font(ft_small);
    draw_set_valign(fa_top);
    
    styleTxt(txtMain[1], camMidX, _y + 10, c_white, c_black);
    
    drawType_banner(fade[0], true);
    
    draw_set_color(c_white);
    
    if(fade[0] == 0 && io_check(en_ioType.PRESS, [en_input.MENU_ACCEPT, en_input.MENU_START])){
        
        fc_next = fc_gameOver_5;
        fc_delay = 1;
        
        fade[1] = 1;
        
    }
    
}