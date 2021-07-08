function fc_intro_1(){
    
    with obj_ui{
    
        fc_next = fc_intro_2;
        fc_delay = 0.5;
        
        drawType = drawType_slant;
        
        fade = [1, 0.5];
        fade_stripe = [0, 1];
        fade_txt = [0, 0];
    
    }
    
}

function fc_intro_2(){
    
    with obj_ui{
    
        fc_next = fc_intro_3;
        fc_delay = 1;
        
        fade_txt[1] = 1.03;
    
    }
    
}

function fc_intro_3(){
    
    with obj_ui{
    
        fc_next = fc_segment_fadeIn_2;
        fc_delay = 0.5;
        
        fade[1] = 0;
        fade_stripe[1] = 2;
        fade_txt[1] = 2;
    
    }
    
}