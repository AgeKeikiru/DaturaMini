
if(uiMini > 0){
    
    uiMini += -TICK;
    
}

if(menuControl && array_length(arr_menus)){
    
    var _menu = arr_menus[array_length(arr_menus) + -1];
    
    if(io_check(en_ioType.PRESS, [en_input.MENU_ACCEPT, en_input.MENU_START])){
                
        _menu.fn_menuSelect();
        
    }else if(io_check(en_ioType.PRESS, [en_input.UNI_UP, en_input.UNI_DOWN, en_input.UNI_LEFT, en_input.UNI_RIGHT])){
        
        _menu.fn_menuScroll();
        
    }else if(io_check(en_ioType.PRESS, [en_input.MENU_CANCEL]) && _menu.onBack != noone){
                
        _menu.onBack();
        
    }
    
}

if(!global.nim){
    global.bonus_time[0] += 1;
}

flowchart_step();