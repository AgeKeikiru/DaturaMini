function fc_charSelect_1(){
    
    with obj_ui{
    
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
            
        }
        
        arr_menus = [_menu];
        
        global.arr_team = [noone, noone];
        
        audf_playBgm(bgm_select);
    
    }
    
}

function fc_charSelect_2(){
    
    with obj_ui{
    
        fc_delay = 0.2;
        fc_next = fc_charSelect_3;
        
        menuControl = false;
        
        clearPhase[1] = 1;
        fade[1] = 0.2;
        
        txtMain = ["", ""];
    
    }
    
}

function fc_charSelect_3(){
    
    with obj_ui{
    
        fc_delay = 2;
        fc_next = fc_charSelect_4;
        
        var _i = global.arr_team[0];
        
        txtMain = ["", global.arr_chars[global.arr_team[0]].introTxt[_i]];
    
    }
    
}

function fc_charSelect_4(){
    
    with obj_ui{
    
        fc_delay = 2;
        fc_next = fc_charSelect_5;
        
        clearPhase[1] = 2;
        
        var _i = global.arr_team[0];
        
        txtMain = ["", global.arr_chars[global.arr_team[1]].introTxt[_i]];
    
    }
    
}

function fc_charSelect_5(){
    
    with obj_ui{
    
        fc_delay = 0.5;
        fc_next = fc_charSelect_6;
        
        fade[1] = 1;
        
        txtMain = ["", ""];
        
        audio_sound_gain(bgmCurr, 0, 500);
    
    }
    
}

function fc_charSelect_6(){
    
    room_goto(rm_lv1_1);
    
}