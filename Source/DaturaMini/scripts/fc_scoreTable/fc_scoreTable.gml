function fc_scoreTable_1(){
    
    with obj_ui{
    
        drawType = drawType_scoreTable;
        
        fade = [1, 0];
        fade_stripe = [0, 0];
        clearPhase = [0, 0];
        
        menuControl = false;
        arr_menus = [];
    
    }
    
}

function fc_scoreTable_2(){
    
    with obj_ui{
    
        fc_next = fc_scoreTable_3;
        fc_delay = 1;
        
        fade[1] = 1;
        
        audio_sound_gain(bgmCurr, 0, 1000);
    
    }
    
}

function fc_scoreTable_3(){
    
    with obj_ui{
    
        drawType = drawType_title;
        
        room_goto(rm_title);
    
    }
    
}