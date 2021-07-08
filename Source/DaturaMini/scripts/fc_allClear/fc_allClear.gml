function fc_allClear_1(){
    
    with obj_ui{
    
        drawType = drawType_allClear;
        
        txtMain[1] = "Thanks for playing!\nSee you next update!";
        
        var
        _newChar = false,
        _charArr = global.map_save[? en_save.CHAR_UNLOCK];
        
        for(var _i = 0; _i < array_length(_charArr); _i++){
            
            if(_charArr[_i] == 1){
                
                _charArr[@ _i] = 2;
                
                if(!_newChar){
                    
                    _newChar = true;
                    
                    txtMain[1] += "\nCheck the character select!";
                    
                }
                
            }
            
        }
        
        fade = [1, 0];
        
        arr_menus = [];
        menuControl = false;
        
        audf_playBgm(bgm_ranking);
        
        room_goto(rm_title);
    
    }
    
}