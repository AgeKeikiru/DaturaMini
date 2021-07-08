function drawType_charSelect(){
    
    var
    _x = x + 100,
    _y = y + 54,
    _offX = clamp(clearPhase[0], 0, 1) * 100,
    _offY = 40,
    _menu = arr_menus[0],
    _char_i = real(_menu.fn_getSelected().name),
    _char_i2 = global.arr_team[0],
    _char_data = global.arr_chars[_char_i],
    _char_locked = !global.map_save[? en_save.CHAR_UNLOCK][_char_i],
    _char_name = _char_locked ? "???" : _char_data.name,
    _char_desc = _char_locked ? _char_data.unlockDesc : _char_data.hintDesc[(current_time / 3000) mod 4],
    _char_greyout = clearPhase[1] mod 2;
    
    drawType_scrollBG();
    
    if(_char_i2 != noone){
            
        var _data2 = global.arr_chars[_char_i2];
        
        draw_sprite_ext(_data2.s_port, 0, x + -25 + (_offX * 0.5), y + camH, 1, 1, 0, _char_greyout ? c_white : c_gray, 1);
        
        _char_name = _data2.name + "\n+\n" + _char_name;
        
    }
    
    draw_sprite_ext(_char_data.s_port, 0, x + _offX + lerp(20, 0, fade_txt[0]), y + camH, 1, 1, 0, _char_locked ? c_black : (_char_greyout ? c_gray : c_white), fade_txt[0]);
    
    if(clearPhase[1] == 0){
    
        draw_set_color(c_black);
        draw_set_alpha(0.5);
    
        draw_rectangle(camMidX + -_offY, y, camMidX + _offY, y + camH, false);
    
        draw_set_color(c_white);
        draw_set_alpha(1);
        
        draw_set_font(ft_small);
        draw_set_halign(fa_center);
        draw_set_valign(fa_center);
        
        styleTxt(string_upper(_char_name), x + 40 + 1, y + 100 + -1, c_black, c_black);
        styleTxt(string_upper(_char_name), x + 40, y + 100, c_white, c_black);
        
        draw_set_font(ft_micro);
        
        styleTxt(_char_desc, x + 200 + 1, camMidY + -1, c_black, c_black);
        styleTxt(_char_desc, x + 200, camMidY, c_white, c_black);
        
        for(var _ix = 0; _ix < array_length(_menu.arr_items); _ix++){
            
            for(var _iy = 0; _iy < array_length(_menu.arr_items[0]); _iy++){
            
                var
                _i = real(_menu.arr_items[_ix, _iy].name),
                _char = global.arr_chars[_i],
                _dx = _x + (_offY * _ix),
                _dy = _y + (_offY * _iy);
                
                if(!global.map_save[? en_save.CHAR_UNLOCK][_i]){
                    image_blend = c_black;
                }else if(_menu.arr_items[_ix, _iy].skip){
                    image_blend = c_gray;
                }
                
                draw_sprite_ext(_char.s_icon[_menu.menuX == _ix && _menu.menuY == _iy], -1, _dx, _dy, 1, 1, 0, image_blend, 1);
                
                image_blend = c_white;
                
                if(_char == _char_data){
                    
                    draw_sprite(spr_charSel_cursor, -1, _dx, _dy);
                    
                }
            
            }
            
        }
    
    }
    
    _offY = HEADER_SIZE / 2;
    
    draw_set_color(c_black);
    
    draw_rectangle(x, y, x + camW, y + HEADER_SIZE, false);
    draw_rectangle(x, y + camH, x + camW, y + camH + -lerp(HEADER_SIZE, camH, fade[0]), false);
    
    draw_set_color(c_white);
    draw_set_font(ft_title);
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);
    
    if(clearPhase[1] == 0){
    
        draw_text(camMidX, y + _offY + 2, "CHARACTER");
        draw_text(camMidX, y + camH + -_offY + 2, "SELECT");
    
    }else{
        
        draw_set_font(ft_small);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        
        styleTxt(txtMain[0], 10, camMidY + 45, c_white, c_gray);
        
    }
    
}