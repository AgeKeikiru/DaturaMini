function fc_gameOver_1(){
    
    with obj_ui{
    
        fc_next = fc_gameOver_2;
        fc_delay = 0.8;
        
        global.noMiss = false;
        
        with obj_player{
            
            visible = false;
            iState = true;
            
        }
        
        instance_deactivate_object(obj_player);
        
        startNim();
    
    }
    
}

function fc_gameOver_2(){
    
    with obj_ui{
    
        fc_next = fc_gameOver_3;
        fc_delay = 0.4;
        
        drawType = drawType_gameOver;
        
        fade = [0, 0.5];
        fade_stripe = [0, 0.07];
        fade_txt[1] = 10;
    
    }
    
}

function fc_gameOver_3(){
    
    with obj_ui{
    
        fc_delay = 1;
        
        fade_txt[1] += -1;
        
        if(fade_txt[1] < 0){
            
            fc_next = fc_gameOver_4;
            fc_delay = 0.4;
            
            fade[1] = 1;
            
        }
        
        audf_playSfx(sfx_tick2);
    
    }
    
}

function fc_gameOver_4(){
    
    with obj_ui{
    
        fc_delay = 0.6;
        
        fade[1] += 1;
        
        if(fade[1] == 3){
            fc_delay = 1.2;
        }
        
        audio_stop_sound(bgmCurr);
        
        if(bgmCurr != noone){
            
            audf_playSfx(sfx_gameOver);
            bgmCurr = noone;
            
        }
        
        if(fade[1] > 3){
            
            fade_stripe[1] = 1;
            
            fc_next = fc_gameOver_5;
            
        }
    
    }
    
}

function fc_gameOver_5(){
    
    with obj_ui{
    
        if(global.points > global.map_save[? en_save.SCORES][9][en_hiScore.POINTS]){
            fc_next = fc_nameEntry_1;
        }else{
            fc_next = fc_scoreTable_1;
        }
        
        fc_delay = 0.5;
        
        room_goto(rm_title);
    
    }
    
}