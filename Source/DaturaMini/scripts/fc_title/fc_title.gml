function fc_title_1(){
    
    with obj_ui{
    
        fc_delay = 0.3;
        fc_next = fc_title_2;
        
        drawType = drawType_title;
        menuControl = true;
        
        fade = [0, 0];
        fade_stripe = [0, 0];
        fade_txt = [0, 0];
        
        title_idle = 0;
        arr_menus = [];
    
    }
    
}

function fc_title_2(){
    
    with obj_ui{
    
        fc_delay = 1.5;
        fc_next = fc_title_3;
        
        fade_stripe = [0, 0.25];
    
    }
    
}

function fc_title_3(){
    
    with obj_ui{
    
        fc_delay = 0.8;
        fc_next = fc_title_4;
        
        fade_stripe[1] = 0;
    
    }
    
}

function fc_title_4(){
    
    with obj_ui{
    
        fc_delay = 0.5;
        fc_next = fc_title_5;
        
        fade_stripe = [0, 1];
        fade_txt[1] = 1;
    
    }
    
}

function fc_title_5(){
    
    with obj_ui{
    
        //fc_delay = 0.8;
        fc_next = noone;
        
        fade_stripe = [1, 1];
        fade_txt[1] = 2;
        
        drawType = drawType_title;
        menuControl = true;
        
        title_idle = 0;
        arr_menus = [];
    
    }
    
}