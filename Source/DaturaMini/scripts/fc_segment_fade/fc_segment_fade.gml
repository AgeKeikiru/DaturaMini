function fc_segment_fadeIn_1(){
    
    with obj_ui{
    
        fc_next = fc_segment_fadeIn_2;
        fc_delay = 0.5;
        
        drawType = drawType_slant;
        
        fade[1] = 2;
        fade_stripe[1] = 2;
    
    }
    
}

function fc_segment_fadeIn_2(){
    
    endNim();
    
    obj_player.cam_xTgt = -1;
    obj_player.cam_yTgt = -1;
    
}

function fc_segment_fadeOut_1(){
    
    with obj_ui{
    
        fc_next = fc_segment_fadeOut_2;
        fc_delay = 0.5;
        
        drawType = drawType_slant;
        
        startNim();
        
        fade = [0, 1];
    
    }
    
}

function fc_segment_fadeOut_2(){
    
    drawType = drawType_slant;
    fade_txt = [0, 0];
    
    room_goto(global.rmNext);
    
}