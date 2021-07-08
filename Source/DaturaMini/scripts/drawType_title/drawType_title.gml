function drawType_title(_fade, _stripe, _fadeTxt){

    if(is_undefined(_fade)){ _fade = fade[0]; }
    if(is_undefined(_stripe)){ _stripe = fade_stripe[0]; }
    if(is_undefined(_fadeTxt)){ _fadeTxt = fade_txt[1]; } //use index 1 to skip tweening
    
    var
    _x = x + (camW / 2),
    _y = y + (camH / 2),
    _offY = camH * 0.5 * _stripe;
    
    if(array_length(arr_menus) > 1){
    
        draw_set_alpha(0.6);
        draw_set_color(c_black);
        
        draw_rectangle(x, y, x + camW, y + camH, false);
        
        draw_set_alpha(1);
    
    }else{
        draw_sprite(spr_titleName, 0, x, y);
    }
    
    draw_sprite(spr_titleBorder, 0, x, y);
    
    if(_fadeTxt == 0){
        
        draw_set_color(CC_UI_ACCENT);
        
        draw_rectangle(x, y, x + camW, y + camH, false);
        
        draw_set_color(c_white);
        
        draw_sprite(spr_devLogo, 0, _x, _y);
        
        if(io_check(en_ioType.PRESS)){
            
            fc_title_5();
            //audf_playSfx(sfx_confirm);
            
        }
        
    }
    
    draw_set_font(ft_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);
    
    if(_fadeTxt == 2){
        
        if(sin(current_time / 60) > -0.5){
            styleTxt("-PRESS START-", _x, _y + 30, c_white, c_gray);
        }
        
        if(io_check(en_ioType.PRESS, [en_input.MENU_START, en_input.MENU_ACCEPT]) && menuControl){
            
            var _menu = new lwo_menuBody();
            
            _menu.arr_items = [[
                new lwo_menuItem("GAME START", fc_charSelect_1),
                new lwo_menuItem("OPTIONS", fc_options_1),
                new lwo_menuItem("KEYBINDS", fc_controls_1)
            ]];
            
            if(TESTING_MODE /*|| [flag for exh mode unlocked] || [flag for arr mode unlocked]*/){
            
                with _menu.arr_items[0][0]{
                
                    sld_names = ["GAME START -STD-", "GAME START -EXH-", "GAME START -ARR-"];
                    
                    fn_sld_setName();
                
                }
            
            }
            
            arr_menus = [_menu];
            menuControl = true;
            
            fade_txt[1] += 1;
            
            audf_playSfx(sfx_confirm);
            
        }else{
            
            title_idle += TICK;
            
            if(title_idle > 5 && menuControl){
                
                fc_next = fc_scoreTable_1;
                fc_delay = 1.5;
                
                fade_stripe[1] = 0;
                
                menuControl = false;
                
            }
            
        }
        
    }
    
    if(_fadeTxt == 3 && array_length(arr_menus)){
        
        var _menu = array_peek(arr_menus);
        
        if(array_length(_menu.arr_items) > 1){
        
            draw_set_color(c_white);
            draw_text(_x, y + 20, "< " + (_menu.menuX ? "Gamepad" : "Keyboard") + " >");
        
        }
        
        for(var _i = 0; _i < min(array_length(_menu.arr_items[0]), _menu.pageH); _i++){
            
            var
            _i2 = _i + _menu.pageY,
            _item = _menu.arr_items[_menu.menuX, _i2],
            _y2 = _y + _menu.disp_y + 20 + (15 * _i);
            
            draw_set_color(c_white);
            
            if(_menu.menuY == _i2){
                
                draw_rectangle(x, _y2 + -7, x + camW, _y2 + 4, false);
                
                draw_set_color(c_black);
                
            }
            
            draw_text(_x, _y2, _item.name);
            
        }
        
    }
    
    if(_stripe < 1){
    
        draw_set_color(c_black);
        
        draw_rectangle(x, y, x + camW, _y + -_offY, false);
        draw_rectangle(x, y + camH, x + camW, _y + _offY, false);
    
    }

}