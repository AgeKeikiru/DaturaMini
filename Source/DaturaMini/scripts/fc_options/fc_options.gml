function fc_options_1(){
    
    with obj_ui{
    
        var _menu = new lwo_menuBody();
        
        _menu.onBack = function(){
            
            saveData();
            
            obj_ui.menuBack();
            
        };
        
        _menu.arr_items = [[
            
            new lwo_menuSlider_vol(en_save.SET_BGM),
            new lwo_menuSlider_vol(en_save.SET_SFX)
            
        ]];
        
        _menu.disp_y = -30;
        
        array_push(arr_menus, _menu);
    
    }
    
}