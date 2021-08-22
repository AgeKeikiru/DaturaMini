function fc_boss_1(){
    
    with obj_ui{
    
        fc_next = fc_boss_2;
        fc_delay = 1;
        
        drawType = drawType_boss;
        
        fade_stripe = [0, 1];
        fade = [0, 0];
        
        txtMain = ["", ""];
        
        audf_playBgm(bgm_boss);
    
    }
    
}

function fc_boss_2(){
    
    with obj_ui{
    
        fc_next = fc_boss_3;
        fc_delay = 0.8;
        
        fade[1] = 0.2;
    
    }
    
}

function fc_boss_3(){
    
    with obj_ui{
        
        fc_next = fc_boss_4;
        fc_delay = 0.6;
        
        txtMain[1] = global.txt_bossClass + "\nCLASS";
    
    }
    
}

function fc_boss_4(){
    
    with obj_ui{
    
        fc_next = fc_boss_5;
        fc_delay = 0.8;
        
        txtMain[1] += "\n\n" + global.txt_bossName;
    
    }
    
}

function fc_boss_5(){
    
    with obj_ui{
    
        fc_next = fc_segment_fadeIn_2;
        fc_delay = 0.5;
        
        fade[1] = 1;
        txtMain = ["", ""];
        
        with obj_enemy{
            if(boss){
                cstate_time = 0;
            }
        }
    
    }
    
}