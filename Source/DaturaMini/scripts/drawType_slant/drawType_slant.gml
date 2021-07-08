function drawType_slant(_fade, _stripe, _fadeTxt){
    
    if(is_undefined(_fade)){ _fade = fade[0]; }
    if(is_undefined(_stripe)){ _stripe = fade_stripe[0]; }
    if(is_undefined(_fadeTxt)){ _fadeTxt = fade_txt[0]; }
    
    if(clamp(_stripe, 0.01, 1.99) == _stripe){
        
        var
        _x = x + 38 + (50 * (1 + -_stripe)),
        _y = y + 50,
        _h = 10 * (1 + -abs(1 + -_stripe));
        
        draw_set_color(CC_UI_ACCENT);
        draw_rectangle(x, _y + -_h, x + camW, _y + _h, false);
        
        draw_set_color(c_black);
        draw_set_alpha(1 + -abs(1 + -_stripe));
        draw_set_font(ft_title);
        draw_set_halign(fa_left);
        draw_set_valign(fa_center);
        
        draw_text(_x + 1, _y + 1, "CONTRACT");
        
        draw_set_color(c_white);
        
        draw_text(_x, _y, "CONTRACT");
        
        draw_set_alpha(1);
        
    }
    
    if(clamp(_fade, 0.1, 1.9) == _fade){
        
        var
        _off = camH * 1.5,
        _x = x + ((camW + _off) * (1 + -_fade)),
        _y = y;
        
        draw_set_color(c_black);
        draw_primitive_begin(pr_trianglefan);
        
        draw_vertex(_x, _y);
        draw_vertex(_x + camW + _off, _y);
        draw_vertex(_x + camW, _y + camH);
        draw_vertex(_x + -_off, _y + camH);
        draw_vertex(_x, _y);
        
        draw_primitive_end();
        
    }
    
    if(clamp(_fadeTxt, 0.01, 1.99) == _fadeTxt){
        
        var
        _x = x + 186,
        _y = y + 58,
        _off = 200 * (1 + -_fadeTxt);
        
        draw_set_color(c_white);
        draw_set_font(ft_titleX);
        draw_set_valign(fa_center);
        
        draw_set_halign(fa_right);
        draw_text(_x + 1, _y + -_off, "0");
        
        draw_set_halign(fa_left);
        draw_text(_x + -1, _y + _off, "1");
        
        draw_set_alpha(1 + -abs(1 + -_fadeTxt));
        draw_set_font(ft_title);
        draw_set_halign(fa_center);
        
        draw_text(x + 180, y + 120, "VR\nZONE I");
        
        draw_set_alpha(1);
        
    }
    
}