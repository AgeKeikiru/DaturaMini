
menuControl = false;

uiMini = 0;

fade = [1, 1];
fade_stripe = [0, 0];
fade_txt = [0, 0];
uiOffset = [1, 1];

txtMain = ["", ""];

clearPhase = [0, 0];

clearDisp_score = 0;
clearDisp_time = 0;
clearDisp_kill = 0;
clearDisp_token = 0;
clearDisp_hyper = 0;

hiScore_edit = noone;
hiScore_rank = 0;

title_idle = 0;

camW = 0;
camMidX = 0;
camH = 0;
camMidY = 0;

lwo_menuItem = function(_name, _onRun) constructor{
    
    name = _name;
    onRun = _onRun;
    skip = false;
    
}

lwo_menuBody = function() constructor{
    
    arr_items = [[]];
    
    menuX = 0;
    menuY = 0;
    
    fn_menuScroll = function(){
        
        do{
        
            if(keyboard_check_pressed(ord("W"))){
                menuY--;
            }
            
            if(keyboard_check_pressed(ord("S"))){
                menuY++;
            }
            
            if(keyboard_check_pressed(ord("A"))){
                menuX--;
            }
            
            if(keyboard_check_pressed(ord("D"))){
                menuX++;
            }
            
            menuX = (menuX + array_length(arr_items)) mod array_length(arr_items);
            
            menuY = (menuY + array_length(arr_items[0])) mod array_length(arr_items[0]);
        
        }until(!fn_getSelected().skip);
        
        if(obj_ui.drawType == obj_ui.drawType_charSelect){
            
            obj_ui.fade_txt[0] = 0;
            
        }
        
        io_clear();
        
    }
    
    fn_menuSelect = function(){
        
        var _scr = arr_items[menuX, menuY].onRun;
        
        io_clear();
        
        if(_scr != noone){
            _scr();
        }
        
    }
    
    fn_getSelected = function(){
        
        return arr_items[menuX, menuY];
        
    }
    
    fn_addPly = function(){
        
        var
        _item = fn_getSelected(),
        _i = real(_item.name);
        
        if(global.map_save[? en_save.CHAR_UNLOCK][_i]){
        
            if(global.arr_team[0] == noone){
                
                global.arr_team[0] = _i;
                _item.skip = true;
                
                menuX++;
                
                fn_menuScroll();
                
            }else{
                
                global.arr_team[1] = _i;
                
                with obj_ui{
                    fc_charSelect_2();
                }
                
            }
        
        }
        
    }
    
}

arr_menus = [];

#region //flowcharts

    intf_flowchart_implement();
    
    #region //segment fades
    
        fc_segment_fadeIn_1 = function(){
            
            fc_next = fc_segment_fadeIn_2;
            fc_delay = 0.5;
            
            drawType = drawType_slant;
            
            fade[1] = 2;
            fade_stripe[1] = 2;
            
        }
        
        fc_segment_fadeIn_2 = function(){
            
            endNim();
            
            obj_player.cam_xTgt = -1;
	        obj_player.cam_yTgt = -1;
            
        }
        
        fc_segment_fadeOut_1 = function(){
            
            fc_next = fc_segment_fadeOut_2;
            fc_delay = 0.5;
            
            drawType = drawType_slant;
            
            startNim();
            
            fade = [0, 1];
            
        }
        
        fc_segment_fadeOut_2 = function(){
            
            room_goto(global.rmNext);
            
        }
    
    #endregion
    
    #region //stage intro
    
        fc_intro_1 = function(){
            
            fc_next = fc_intro_2;
            fc_delay = 0.5;
            
            drawType = drawType_slant;
            
            fade = [1, 0.5];
            fade_stripe = [0, 1];
            
        }
        
        fc_intro_2 = function(){
            
            fc_next = fc_intro_3;
            fc_delay = 1;
            
            fade_txt[1] = 1.03;
            
        }
        
        fc_intro_3 = function(){
            
            fc_next = fc_segment_fadeIn_2;
            fc_delay = 0.5;
            
            fade[1] = 0;
            fade_stripe[1] = 2;
            fade_txt[1] = 2;
            
        }
    
    #endregion
    
    #region //boss intro
    
        fc_boss_1 = function(){
            
            fc_next = fc_boss_2;
            fc_delay = 1;
            
            drawType = drawType_boss;
            
            fade_stripe = [0, 1];
            fade = [0, 0];
            
            txtMain = ["", ""];
            
        }
        
        fc_boss_2 = function(){
            
            fc_next = fc_boss_3;
            fc_delay = 0.8;
            
            fade[1] = 0.2;
            
        }
        
        fc_boss_3 = function(){
            
            fc_next = fc_boss_4;
            fc_delay = 0.6;
            
            txtMain[1] = "ABERRATION\nCLASS";
            
        }
        
        fc_boss_4 = function(){
            
            fc_next = fc_boss_5;
            fc_delay = 0.8;
            
            txtMain[1] += "\n\nDOMINANT\nOOZE";
            
        }
        
        fc_boss_5 = function(){
            
            fc_next = fc_segment_fadeIn_2;
            fc_delay = 0.5;
            
            fade[1] = 1;
            txtMain = ["", ""];
            
            with obj_slimeBoss{
                cstate_time = 0;
            }
            
        }
    
    #endregion
    
    #region //stage clear
    
        fc_clear_1 = function(){
            
            fc_next = fc_clear_2;
            fc_delay = 0.8;
            
            drawType = drawType_clear;
            
            clearPhase = [0, 0];
            clearDisp_time = 0;
            clearDisp_kill = 0;
            clearDisp_token = 0;
            clearDisp_hyper = 0;

            fade_stripe = [0, 0.1];
            fade_txt = [0, 1];
            fade = [0, 0];
            
        }
        
        fc_clear_2 = function(){
            
            fc_next = fc_clear_3;
            fc_delay = 0.5;
            
            fade_stripe[1] = 1;
            fade[1] = 1;
            
        }
        
        fc_clear_3 = function(){
            
            clearDisp_score = global.points;
            clearPhase[1] = 1;
            fade = [0, 0];
            
        }
        
        fc_clear_3b = function(){
        
            clearPhase[1] += 1;
            
        }
    
    #endregion
    
    #region //all clear
    
        fc_allClear_1 = function(){
            
            drawType = drawType_allClear;
            
            fade = [1, 0];
            
            arr_menus = [];
            menuControl = false;
            
            room_goto(rm_title);
            
        }
    
    #endregion
    
    #region //gameOver
    
        fc_gameOver_1 = function(){
            
            fc_next = fc_gameOver_2;
            fc_delay = 0.8;
            
            with obj_player{
                
                visible = false;
                iState = true;
                
            }
            
            startNim();
            
        }
        
        fc_gameOver_2 = function(){
            
            fc_next = fc_gameOver_3;
            fc_delay = 0.4;
            
            drawType = drawType_gameOver;
            
            fade = [0, 0.5];
            fade_stripe = [0, 0.07];
            fade_txt[1] = 10;
            
        }
        
        fc_gameOver_3 = function(){
            
            fc_delay = 1;
            
            fade_txt[1] += -1;
            
            if(fade_txt[1] < 0){
                
                fc_next = fc_gameOver_4;
                fc_delay = 0.4;
                
                fade[1] = 1;
                
            }
            
        }
        
        fc_gameOver_4 = function(){
            
            fc_delay = 0.6;
            
            fade[1] += 1;
            
            if(fade[1] == 3){
                fc_delay = 0.8;
            }
            
            if(fade[1] > 3){
                
                fade_stripe[1] = 1;
                
                fc_next = fc_gameOver_5;
                
            }
            
        }
        
        fc_gameOver_5 = function(){
            
            if(global.points > global.map_save[? en_save.SCORES][9].points){
                fc_next = fc_nameEntry_1;
            }else{
                fc_next = fc_scoreTable_1;
            }
            
            fc_delay = 0.5;
            
            room_goto(rm_title);
            
        }
    
    #endregion
    
    #region //title
    
        fc_title_1 = function(){
            
            fc_delay = 0.3;
            fc_next = fc_title_2;
            
            drawType = drawType_title;
            menuControl = true;
            
            fade = [0, 0];
            fade_stripe = [0, 0];
            fade_txt = [0, 0];
            
            title_idle = 0;
            arr_menus = [];
            
        }
        
        fc_title_2 = function(){
            
            fc_delay = 1.5;
            fc_next = fc_title_3;
            
            fade_stripe = [0, 0.25];
            
        }
        
        fc_title_3 = function(){
            
            fc_delay = 0.8;
            fc_next = fc_title_4;
            
            fade_stripe[1] = 0;
            
        }
        
        fc_title_4 = function(){
            
            fc_delay = 0.5;
            fc_next = fc_title_5;
            
            fade_stripe = [0, 1];
            fade_txt[1] = 1;
            
        }
        
        fc_title_5 = function(){
            
            //fc_delay = 0.8;
            fc_next = noone;
            
            fade_stripe = [1, 1];
            fade_txt[1] = 2;
            
            drawType = drawType_title;
            menuControl = true;
            
            title_idle = 0;
            arr_menus = [];
            
        }
    
    #endregion
    
    #region //character select
    
        fc_charSelect_1 = function(){
            
            //fc_delay = 0.3;
            //fc_next = fc_title_2;
            
            drawType = drawType_charSelect;
            menuControl = true;
            
            fade = [0, 0];
            fade_stripe = [0, 0];
            fade_txt = [0, 1];
            clearPhase = [0, 0];
            txtMain = ["", ""];
            
            global.points = 0;
            
            var _menu = new lwo_menuBody();
            
            _menu.arr_items = [[], []];
            
            for(var _i = 0; _i < en_charID.LENGTH; _i++){
                
                var
                _x = _i mod 2,
                _y = floor(_i / 2);
                
                _menu.arr_items[_x, _y] = new lwo_menuItem(string(_i), _menu.fn_addPly);
                
                arr_menus = [_menu];
                
            }
            
            global.arr_team = [noone, noone];
            
        }
        
        fc_charSelect_2 = function(){
            
            fc_delay = 0.2;
            fc_next = fc_charSelect_3;
            
            menuControl = false;
            
            clearPhase[1] = 1;
            fade[1] = 0.2;
            
            txtMain = ["", ""];
            
        }
        
        fc_charSelect_3 = function(){
            
            fc_delay = 2;
            fc_next = fc_charSelect_4;
            
            var _i = global.arr_team[0];
            
            txtMain = ["", global.arr_chars[global.arr_team[0]].introTxt[_i]];
            
        }
        
        fc_charSelect_4 = function(){
            
            fc_delay = 2;
            fc_next = fc_charSelect_5;
            
            clearPhase[1] = 2;
            
            var _i = global.arr_team[0];
            
            txtMain = ["", global.arr_chars[global.arr_team[1]].introTxt[_i]];
            
        }
        
        fc_charSelect_5 = function(){
            
            fc_delay = 0.5;
            fc_next = fc_charSelect_6;
            
            fade[1] = 1;
            
            txtMain = ["", ""];
            
        }
        
        fc_charSelect_6 = function(){
            
            room_goto(rm_lv1_1);
            
        }
    
    #endregion
    
    #region //name entry
    
        fc_nameEntry_1 = function(){
            
            drawType = drawType_nameEntry;
            
            fade = [1, 0];
            clearPhase = [0, 0];
            
            hiScore_edit = new lwo_hiScore(global.points, global.arr_team, "");
            
            for(hiScore_rank = 0; hiScore_rank < array_length(global.map_save[? en_save.SCORES]); hiScore_rank++){
                
                if(global.map_save[? en_save.SCORES][hiScore_rank].points < hiScore_edit.points){
                    break;
                }
                
            }
            
            menuControl = true;
                
            array_insert(global.map_save[? en_save.SCORES], hiScore_rank, hiScore_edit);
            
            array_resize(global.map_save[? en_save.SCORES], 10);
            
            var
            _menu = new lwo_menuBody(),
            _letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.";
            
            for(var _i = 0; _i < string_length(_letters) + 1; _i++){
                
                var
                _item = new lwo_menuItem(">", pointNameAppend),
                _w = 14;
                
                if(_i < string_length(_letters)){
                    
                    _item.name = string_char_at(_letters, _i + 1);
                    
                }
                
                _menu.arr_items[_i mod _w, floor(_i / _w)] = _item;
                
            }
            
            arr_menus = [_menu];
            
        }
        
        fc_nameEntry_2 = function(){
            
            fc_next = fc_scoreTable_1;
            fc_delay = 1;
            
            fade[1] = 1;
            
        }
    
    #endregion
    
    #region //score table
    
        fc_scoreTable_1 = function(){
            
            drawType = drawType_scoreTable;
            
            fade = [1, 0];
            fade_stripe = [0, 0];
            clearPhase = [0, 0];
            
            menuControl = false;
            arr_menus = [];
            
        }
        
        fc_scoreTable_2 = function(){
            
            fc_next = fc_scoreTable_3;
            fc_delay = 1;
            
            fade[1] = 1;
            
        }
        
        fc_scoreTable_3 = function(){
            
            drawType = drawType_title;
            
            room_goto(rm_title);
            
        }
    
    #endregion

#endregion

#region //drawTypes

    drawType_scrollBG = function(){
        
        draw_set_color(CC_HYPINK);
        
        draw_rectangle(x, y, x + camW, y + camH, false);
        
        wrapStripe(50, 100, 10, 85, 1000, CC_UI_ACCENT, 0.2);
        wrapStripe(80, 100, 2, 110, 720, CC_UI_ACCENT, 0.2);
        wrapStripe(120, 100, 4, 170, 1200, CC_UI_ACCENT, 0.3);
        wrapStripe(42, 190, 5, 76, 1020, CC_UI_ACCENT, 0.2);
        wrapStripe(100, 150, 5, 100, 900, CC_UI_ACCENT, 0.2);
        wrapStripe(25, 130, 5, 72, 800, CC_UI_ACCENT, 0.2);
        wrapStripe(93, 60, 3, 100, 2900, c_white, 0.3);
        wrapStripe(33, 40, 3, 203, 2100, c_white, 0.2);
        wrapStripe(60, 200, 3, 188, 708, c_white, 0.3);
        wrapStripe(128, 110, 3, 100, 3100, c_white, 0.3);
        wrapStripe(71, 38, 3, 203, 2100, c_white, 0.2);
        wrapStripe(133, 220, 3, 188, 1822, c_white, 0.2);
        
        draw_set_color(c_white);
        
    }
    
    drawType_banner = function(_lerp, _invert, _min, _max){
        
        if(is_undefined(_invert)){ _invert = false; }
        if(is_undefined(_min)){ _min = 0; }
        if(is_undefined(_max)){ _max = camH / 2; }
        
        var
        _top = _invert ? y : camMidY,
        _bot = _invert ? (y + camH) : camMidY;
        
        if(_invert){
            
            _top += -1;
            _max += 1;
            
        }
        
        draw_rectangle(x, _top, x + camW, _top + (lerp(_min, _max, _lerp) * (_invert ? 1 : -1)), false);
        draw_rectangle(x, _bot, x + camW, _bot + (lerp(_min, _max, _lerp) * (_invert ? -1 : 1)), false);
        
    }
    
    drawType_title = function(_fade, _stripe, _fadeTxt){
        
        if(is_undefined(_fade)){ _fade = fade[0]; }
        if(is_undefined(_stripe)){ _stripe = fade_stripe[0]; }
        if(is_undefined(_fadeTxt)){ _fadeTxt = fade_txt[1]; } //use index 1 to skip tweening
        
        var
        _x = x + (camW / 2),
        _y = y + (camH / 2),
        _offY = camH * 0.5 * _stripe;
        
        draw_sprite(spr_titleName, 0, x, y);
        draw_sprite(spr_titleBorder, 0, x, y);
        
        if(_fadeTxt == 0){
            
            draw_set_color(CC_UI_ACCENT);
            
            draw_rectangle(x, y, x + camW, y + camH, false);
            
            draw_set_color(c_white);
            
            draw_sprite(spr_devLogo, 0, _x, _y);
            
            if(keyboard_check_pressed(vk_enter)){
                
                fc_title_5();
                
            }
            
        }
        
        draw_set_font(ft_small);
        draw_set_halign(fa_center);
        draw_set_valign(fa_center);
        
        if(_fadeTxt == 2){
            
            if(sin(current_time / 60) > -0.5){
                styleTxt("-PRESS START-", _x, _y + 30, c_white, c_gray);
            }
            
            if(keyboard_check_pressed(vk_enter) && menuControl){
                
                var _menu = new lwo_menuBody();
                
                _menu.arr_items = [[
                    new lwo_menuItem("GAME START", fc_charSelect_1),
                    new lwo_menuItem("OPTIONS", noone),
                    new lwo_menuItem("KEYBINDS", noone)
                ]];
                
                arr_menus = [_menu];
                menuControl = true;
                
                fade_txt[1] += 1;
                
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
            
            var _menu = arr_menus[0];
            
            for(var _i = 0; _i < array_length(_menu.arr_items[0]); _i++){
                
                var
                _item = _menu.arr_items[0, _i],
                _y2 = _y + 20 + (15 * _i);
                
                draw_set_color(c_white);
                
                if(_menu.menuY == _i){
                    
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
    
    drawType_charSelect = function(){
        
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
    
    drawType_hiScore = function(_score, _y, _scoreRank, _preLetter){
        
        if(is_undefined(_preLetter)){ _preLetter = ""; }
        
        var
        _x = x + 22,
        _offX = 15,
        _offY = HEADER_SIZE / 2,
        _gap = 15,
        _rank = string(_scoreRank + 1),
        _chars = [
            global.arr_chars[_score.team[0]].s_icon[0],
            global.arr_chars[_score.team[1]].s_icon[0]
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
        
        draw_set_font(ft_small);
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        
        styleTxt(string(_score.points), x + camW + -_offX, _y, c_white, c_black, true);
        
        draw_set_halign(fa_left);
        
        if(_preLetter != ">" && _preLetter != ""){
            
            if(sin(current_time / 10) > 0){
                draw_set_alpha(0);
            }
            
            styleTxt(_score.name + _preLetter, x + _offX + 55, _y, c_white, c_black, true);
            
        }
        
        draw_set_alpha(1);
        
        styleTxt(_score.name, x + _offX + 55, _y, c_white, c_black, true);
        
        draw_set_font(ft_title);
        
        styleTxt(_rank, x + _offX, _y, c_white, c_black, true);
        
        draw_set_color(c_white);
        
        for(var _i = 0; _i < 2; _i++){
            
            draw_sprite(_chars[_i], -1, x + _offX + 90 + (16 * _i), _y);
            
        }
        
    }
    
    drawType_nameEntry = function(){
        
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
    
    drawType_scoreTable = function(){
        
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
        
        if(keyboard_check_pressed(vk_enter)){
            
            io_clear();
            fc_title_5();
            
        }
        
    }
    
    drawType_slant = function(_fade, _stripe, _fadeTxt){
        
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
        
    drawType_boss = function(_fade, _stripe, _txtMain){
    
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
        
    drawType_clear = function(_fade, _stripe, _fadeTxt){
        
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
        
        if(clearPhase[1] == 5 && keyboard_check_pressed(vk_enter)){
            
            fc_next = fc_allClear_1;
            fc_delay = 1.5;
            
            fade = [2, 1];
            
            clearPhase[1] = 6;
            
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
    
    drawType_allClear = function(){
        
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
        
        styleTxt("Thanks for playing!\nSee you next update!", camMidX, _y + 10, c_white, c_black);
        
        drawType_banner(fade[0], true);
        
        draw_set_color(c_white);
        
        if(fade[0] == 0 && keyboard_check_pressed(vk_enter)){
            
            fc_next = fc_gameOver_5;
            fc_delay = 1;
            
            fade[1] = 1;
            
        }
        
    }
    
    drawType_gameOver = function(_fade, _stripe, _fadeTxt){
        
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
            
            if(keyboard_check_pressed(vk_enter)){
                
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
                
            }else if(keyboard_check_pressed(ord("I"))){
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

#endregion

drawClearStat = function(_y, _s1, _s2, _bonus){
    
    var _off = 20;
    
    draw_set_font(ft_small);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    styleTxt(_s1, x + _off, _y, c_gray, c_ltgray);
    
    draw_set_color(c_dkgray);
    draw_set_halign(fa_right);
    
    if(_bonus && sin(current_time / 10) > 0){
        draw_set_color(CC_UI_ACCENT);
    }
    
    draw_text(x + camW + -_off, _y, _s2);
    
}

approachStat = function(_val1, _val2){
    
    var _skip = keyboard_check_pressed(vk_enter);
    
    if(_val1 < _val2[0] || _val2[0] == 0){
                
        _val1 += ceil(_val2[0] / room_speed);
        
        if(_val1 >= _val2[0] || _skip){
            
            _val1 = _val2[0];
            
            if(_val2[0] >= _val2[1] xor _val2 == global.bonus_time){
                global.points += 5000;
            }
            
            fc_next = fc_clear_3b;
            fc_delay = _skip ? 0.01 : 0.4;
            
        }
        
    }
    
    return _val1;
    
}

wrapStripe = function(_y, _w, _h, _gap, _spd, _col, _a){
    
    _spd /= 2;
    
    var
    _x = x + -((_w + _gap) * ((current_time mod _spd) / _spd)),
    _colSave = draw_get_color(),
    _aSave = draw_get_alpha();
    
    draw_set_color(_col);
    draw_set_alpha(_a);
    
    do{
    
        draw_rectangle(_x, _y, _x + _w, _y + _h, false);
        
        _x += _w + _gap;
        
    }until(_x > x + camW);
    
    draw_set_color(_colSave);
    draw_set_alpha(_aSave);
    
}

pointNameAppend = function(){
    
    var
    _menu = arr_menus[0],
    _str = _menu.fn_getSelected().name;
    
    if(_str != ">"){
        
        hiScore_edit.name += _str;
        
        if(string_length(hiScore_edit.name) >= 3){
            
            for(var _ix = 0; _ix < array_length(_menu.arr_items); _ix++){
                
                for(var _iy = 0; _iy < array_length(_menu.arr_items[0]); _iy++){
                
                    if(_menu.arr_items[_ix, _iy].name != ">"){
                        _menu.arr_items[_ix, _iy].skip = true;
                    }else{
                        _menu.menuX = _ix;
                        _menu.menuY = _iy;
                    }
                    
                }
                
            }
            
        }
        
    }else if(hiScore_edit.name != ""){
        
        menuControl = false;
        
        fc_next = fc_nameEntry_2;
        fc_delay = 1.5;
        
    }
    
}

drawType = drawType_slant;