function drawType_boss(_fade, _stripe, _txtMain){

    if(is_undefined(_fade)){ _fade = fade[0]; }
    if(is_undefined(_stripe)){ _stripe = fade_stripe[0]; }
    if(is_undefined(_txtMain)){ _txtMain = txtMain[0]; }
    
    if(clamp(_fade, 0, 0.99) == _fade){
        
        var
        _off = 200 * _fade,
        _x = x + 160,
        _y = y;
        
        draw_set_color(c_black);
        
        draw_rectangle(x, y, _x + -_off, y + camH, false);
        draw_rectangle(x + camW, y, _x + _off, y + camH, false);
        
        draw_set_color(c_white);
        draw_set_font(ft_small);
        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        
        draw_text(x + 90, y + 50, _txtMain);
        
        
        if(clamp(_stripe, 0.01, 1) == _stripe){
            
            var
            _w = 15 * _stripe,
            _s1 = "/ WARNING /",
            _s2 = "/ NO X-ING /",
            _rate = 2000;
            
            draw_set_color(CC_UI_ACCENT);
            draw_rectangle(_x + -_off + 1, y, _x + -_off + -_w, y + camH, false);
            draw_rectangle(_x + _off, y, _x + _off + _w, y + camH, false);
            
            draw_set_color(c_black);
            draw_set_font(ft_title);
            draw_set_halign(fa_center);
            draw_set_valign(fa_center);
            
            draw_text_transformed(
                _x + -_off + -7 + 1,
                y + (((current_time mod _rate) / _rate) * string_width(_s1)),
                string_repeat(_s1, 3), 1, 1, 90
            );
            
            draw_text_transformed(
                _x + _off + 7 + 2,
                y + camH + -(((current_time mod _rate) / _rate) * string_width(_s2)),
                string_repeat(_s2, 3), 1, 1, -90
            );
            
        }
        
    }
    
}