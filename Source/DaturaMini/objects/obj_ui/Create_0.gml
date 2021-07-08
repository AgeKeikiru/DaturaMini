
intf_flowchart_implement();

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

bgmCurr = noone;

lst_sfx = ds_list_create();

arr_menus = [];

drawType = drawType_slant;

#region //functions

    //leave as a method variable so "obj_ui.menuBack" can be called
    menuBack = function(){
        
        array_pop(arr_menus);
        
    }
    
    function drawClearStat(_y, _s1, _s2, _bonus){
        
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
    
    function approachStat(_val1, _val2){
        
        var _skip = io_check(en_ioType.PRESS, [en_input.MENU_ACCEPT, en_input.MENU_START]);
        
        if(_val1 < _val2[0] || (_val2[0] == 0 && _val1 != _val2[0])){
                    
            audf_playSfx(sfx_tick2);
            
            _val1 += max(ceil(_val2[0] / room_speed), 1);
            
            if(_val1 >= _val2[0] || _skip || _val2[0] == 0){
                
                _val1 = _val2[0];
                
                if(_val2[0] >= _val2[1] xor _val2 == global.bonus_time){
                    
                    global.points += 5000;
                    audf_playSfx(sfx_cut2);
                    
                }
                
                fc_next = fc_clear_3b;
                fc_delay = _skip ? 0.01 : 0.4;
                
            }
            
        }
        
        return _val1;
        
    }
    
    function wrapStripe(_y, _w, _h, _gap, _spd, _col, _a){
        
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
    
    function pointNameAppend(){
        
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

#endregion