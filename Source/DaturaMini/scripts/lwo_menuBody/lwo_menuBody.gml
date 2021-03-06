function lwo_menuBody() constructor{
    
    arr_items = [[]];
    
    menuX = 0;
    menuY = 0;
    
    pageX = 0;
    pageY = 0;
    pageW = 99;
    pageH = 99;
    
    onBack = noone;
    
    //drawing vars
    disp_x = 0;
    disp_y = 0;
    
    #region //functions
    
        fn_menuWrap = function(){
            
            menuX = (menuX + array_length(arr_items)) mod array_length(arr_items);
            menuY = (menuY + array_length(arr_items[0])) mod array_length(arr_items[0]);
            
        }
        
        fn_menuScroll = function(){
            
            fn_menuWrap();
            
            var _item = fn_getSelected();
            
            if(array_length(_item.sld_names) && io_check(en_ioType.PRESS, [en_input.UNI_LEFT, en_input.UNI_RIGHT])){
            
                var
                _sldLen = array_length(_item.sld_names),
                _sldScroll = -io_check(en_ioType.PRESS, [en_input.UNI_LEFT]) + io_check(en_ioType.PRESS, [en_input.UNI_RIGHT]);
            
                _item.sld_index = (_item.sld_index + _sldScroll + _sldLen) mod _sldLen;
                
                _item.fn_sld_setName();
            
            }else{
                
                do{
                
                    if(io_check(en_ioType.PRESS, [en_input.UNI_UP])){
                        menuY--;
                    }
                    
                    if(io_check(en_ioType.PRESS, [en_input.UNI_DOWN])){
                        menuY++;
                    }
                    
                    if(io_check(en_ioType.PRESS, [en_input.UNI_LEFT])){
                        menuX--;
                    }
                    
                    if(io_check(en_ioType.PRESS, [en_input.UNI_RIGHT])){
                        menuX++;
                    }
                    
                    fn_menuWrap();
                
                }until(!fn_getSelected().skip);
            
            }
            
            audf_playSfx(sfx_tick1);
            
            if(obj_ui.drawType == drawType_charSelect){
                
                obj_ui.fade_txt[0] = 0;
                
            }
            
            var
            _w2 = pageX + pageW,
            _h2 = pageY + pageH + -1;
            
            if(menuY < pageY){
                pageY = menuY;
            }
            
            if(menuY > _h2){
                pageY = menuY + -pageH + 1;
            }
            
        }
        
        fn_getSelected = function(){
            
            return arr_items[menuX, menuY];
            
        }
        
        fn_menuSelect = function(){
            
            var _scr = fn_getSelected().onRun;
            
            io_clear();
            
            if(_scr != noone){
                
                audf_playSfx(sfx_confirm);
                
                _scr();
                
            }
            
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
    
    #endregion
    
}