function fc_nameEntry_1(){
    
    with obj_ui{
    
        drawType = drawType_nameEntry;
        
        fade = [1, 0];
        clearPhase = [0, 0];
        
        hiScore_edit = new_hiScore(global.points, global.arr_team, "");
        
        for(hiScore_rank = 0; hiScore_rank < array_length(global.map_save[? en_save.SCORES]); hiScore_rank++){
            
            if(global.map_save[? en_save.SCORES][hiScore_rank][en_hiScore.POINTS] < hiScore_edit[en_hiScore.POINTS]){
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
        
        audf_playBgm(bgm_ranking);
    
    }
    
}

function fc_nameEntry_2(){
    
    with obj_ui{
    
        fc_next = fc_scoreTable_1;
        fc_delay = 1;
        
        fade[1] = 1;
    
    }
    
}