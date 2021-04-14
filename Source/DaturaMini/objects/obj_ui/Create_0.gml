
enum en_fadeType{
    
    slant,
    boss
    
}

uiMini = 0;

fadeType = en_fadeType.slant;
fade = [1, 1];
fade_stripe = [0, 0];
fade_txt = [0, 0];
uiOffset = [1, 1];

txtMain = ["", ""];

#region //flowcharts

    intf_flowchart_implement();
    
    #region //segment fades
    
        fc_segment_fadeIn_1 = function(){
            
            fc_next = fc_segment_fadeIn_2;
            fc_delay = 0.5;
            
            fade[1] = 2;
            fade_stripe[1] = 2;
            
        }
        
        fc_segment_fadeIn_2 = function(){
            
            endNim();
            
            obj_player.cam_xTgt = -1;
	        obj_player.cam_yTgt = -1;
            
        }
        
        fc_segment_fadeOut_1 = function(){
            
            fc_next = fc_segment_fadeOut_2;
            fc_delay = 0.5;
            
            startNim();
            
            fade = [0, 1];
            
        }
        
        fc_segment_fadeOut_2 = function(){
            
            room_goto(global.rmNext);
            
        }
    
    #endregion
    
    #region //stage intro
    
        fc_intro_1 = function(){
            
            fc_next = fc_intro_2;
            fc_delay = 0.5;
            
            fade[1] = 0.5;
            fade_stripe[1] = 1;
            
        }
        
        fc_intro_2 = function(){
            
            fc_next = fc_intro_3;
            fc_delay = 1;
            
            fade_txt[1] = 1.03;
            
        }
        
        fc_intro_3 = function(){
            
            fc_next = fc_segment_fadeIn_2;
            fc_delay = 0.5;
            
            fade[1] = 0;
            fade_stripe[1] = 2;
            fade_txt[1] = 2;
            
        }
    
    #endregion
    
    #region //boss intro
    
        fc_boss_1 = function(){
            
            fc_next = fc_boss_2;
            fc_delay = 1;
            
            fadeType = en_fadeType.boss;
            
            fade_stripe = [0, 1];
            fade = [0, 0];
            
            txtMain = ["", ""];
            
        }
        
        fc_boss_2 = function(){
            
            fc_next = fc_boss_3;
            fc_delay = 0.8;
            
            fade[1] = 0.2;
            
        }
        
        fc_boss_3 = function(){
            
            fc_next = fc_boss_4;
            fc_delay = 0.6;
            
            txtMain[1] = "ABERRATION\nCLASS";
            
        }
        
        fc_boss_4 = function(){
            
            fc_next = fc_boss_5;
            fc_delay = 0.8;
            
            txtMain[1] += "\n\nDOMINANT\nOOZE";
            
        }
        
        fc_boss_5 = function(){
            
            fc_next = fc_segment_fadeIn_2;
            fc_delay = 0.5;
            
            fade[1] = 1;
            txtMain = ["", ""];
            
            with obj_slimeBoss{
                cstate_time = 0;
            }
            
        }
    
    #endregion

#endregion