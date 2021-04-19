
if(uiMini > 0){
    
    uiMini += -TICK;
    
}

if(menuControl && array_length(arr_menus)){
    
    var _menu = arr_menus[array_length(arr_menus) + -1];
    
    if(keyboard_check_pressed(vk_enter)){
                
        _menu.fn_menuSelect();
        
    }else if(keyboard_check_pressed(vk_anykey)){
        
        _menu.fn_menuScroll();
        
    }
    
}

flowchart_step();