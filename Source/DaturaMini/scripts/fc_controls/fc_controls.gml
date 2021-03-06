function fc_controls_1(){
    
    with obj_ui{
    
        var _menu = new lwo_menuBody();
        
        _menu.onBack = function(){
            
            saveData();
            
            obj_ui.menuBack();
            
        };
        
        _menu.arr_items = [[]];
        
        for(var _i = 0; _i < 2; _i++){
            
            _menu.arr_items[_i] = [
            
                new lwo_menuItem_ioBind(en_input.UNI_UP, _i),
                new lwo_menuItem_ioBind(en_input.UNI_DOWN, _i),
                new lwo_menuItem_ioBind(en_input.UNI_LEFT, _i),
                new lwo_menuItem_ioBind(en_input.UNI_RIGHT, _i),
                
                new lwo_menuSpacer(),
                
                new lwo_menuItem_ioBind(en_input.MENU_ACCEPT, _i),
                new lwo_menuItem_ioBind(en_input.MENU_CANCEL, _i),
                new lwo_menuItem_ioBind(en_input.MENU_START, _i),
                
                new lwo_menuSpacer(),
                
                new lwo_menuItem_ioBind(en_input.GAME_JUMP, _i),
                new lwo_menuItem_ioBind(en_input.GAME_ATK1, _i),
                new lwo_menuItem_ioBind(en_input.GAME_ATK2, _i),
                new lwo_menuItem_ioBind(en_input.GAME_DEF1, _i),
                new lwo_menuItem_ioBind(en_input.GAME_DEF2, _i),
                new lwo_menuItem_ioBind(en_input.GAME_HYPER, _i),
                new lwo_menuItem_ioBind(en_input.GAME_ATK_CURRENT, _i),
                new lwo_menuItem_ioBind(en_input.GAME_DEF_CURRENT, _i),
                new lwo_menuItem_ioBind(en_input.GAME_SWITCH, _i)
                
            ];
            
        }
        
        _menu.disp_y = -50;
        _menu.pageH = 7;
        
        array_push(arr_menus, _menu);
    
    }
    
}