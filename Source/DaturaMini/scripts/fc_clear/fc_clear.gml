function fc_clear_1(){
    
    with obj_ui{
    
        fc_next = fc_clear_2;
        fc_delay = 0.8;
        
        drawType = drawType_clear;
        
        clearPhase = [0, 0];
        clearDisp_time = -1;
        clearDisp_kill = -1;
        clearDisp_token = -1;
        clearDisp_hyper = -1;
    
        fade_stripe = [0, 0.1];
        fade_txt = [0, 1];
        fade = [0, 0];
        
        audf_playBgm(bgm_clear);
        
        //breia unlock
        if(room == rm_lv1_boss && global.map_save[? en_save.CHAR_UNLOCK][2] == 0){
            global.map_save[? en_save.CHAR_UNLOCK][2] = 1;
        }
    
    }
    
}

function fc_clear_2(){
    
    with obj_ui{
    
        fc_next = fc_clear_3;
        fc_delay = 0.5;
        
        fade_stripe[1] = 1;
        fade[1] = 1;
    
    }
    
}

function fc_clear_3(){
    
    with obj_ui{
    
        clearDisp_score = global.points;
        clearPhase[1] = 1;
        fade = [0, 0];
    
    }
    
}

function fc_clear_3b(){

    obj_ui.clearPhase[1] += 1;
    
}