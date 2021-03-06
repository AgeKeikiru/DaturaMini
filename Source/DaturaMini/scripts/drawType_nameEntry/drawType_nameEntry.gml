function drawType_nameEntry(){
    
    var
    _x = x + 22,
    _y = y + HEADER_SIZE + 90,
    _offX = 15,
    _offY = HEADER_SIZE / 2,
    _gap = 15,
    _menu = arr_menus[0],
    _rank = string(global.pointRank + 1),
    _chars = [
        global.arr_chars[global.arr_team[0]].s_icon[0],
        global.arr_chars[global.arr_team[1]].s_icon[0]
    ];
    
    switch _rank{
        
        case "1":
            _rank += "st";
            break;
        case "2":
            _rank += "nd";
            break;
        case "3":
            _rank += "rd";
            break;
        default:
            _rank += "th";
            break;
        
    }
    
    drawType_scrollBG();
    
    draw_set_color(CC_UI_ACCENT);
    draw_set_alpha(0.5);
    
    draw_rectangle(x, y + camH, x + camW, y + HEADER_SIZE + 70, false);
    
    draw_set_alpha(1);
    draw_set_font(ft_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);
    
    for(var _ix = 0; _ix < array_length(_menu.arr_items); _ix++){
        
        for(var _iy = 0; _iy < array_length(_menu.arr_items[0]); _iy++){
            
            var
            _str = _menu.arr_items[_ix, _iy].name,
            _dx = _x + (_ix * _gap),
            _dy = _y + (_iy * _gap);
            
            styleTxt(_str, _dx, _dy + 1, (_str == ">") ? CC_UI_ACCENT : c_white, c_black);
            
            if(_str == _menu.fn_getSelected().name && menuControl){
                
                draw_set_color(c_yellow);
                
                if(sin(current_time / 15) > 0){
                    draw_set_alpha(0.5);
                }
                
                draw_rectangle(_dx + -(_gap / 2), _dy + -(_gap / 2), _dx + (_gap / 2), _dy + (_gap / 2), true);
                
                draw_set_alpha(1);
                
            }
            
        }
        
    }
    
    drawType_hiScore(hiScore_edit, camMidY + -10, hiScore_rank, _menu.fn_getSelected().name);
    
    draw_set_color(c_black);
    
    draw_rectangle(x, y, x + camW, y + lerp(HEADER_SIZE, camH / 2, fade[0]), false);
    draw_rectangle(x, y + camH, x + camW, y + camH + -lerp(HEADER_SIZE, camH / 2, fade[0]), false);
    
    draw_set_color(c_white);
    draw_set_font(ft_title);
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);
    
    if(menuControl){
    
        draw_text(camMidX, y + _offY + 2, "NAME");
        draw_text(camMidX, y + camH + -_offY + 2, "ENTRY");
    
    }
    
}