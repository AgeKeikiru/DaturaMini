
uiMini = 0;

fade = [1, 1];
fade_stripe = [0, 0];
fade_txt = [0, 0];
uiOffset = [1, 1];

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
            
        }
        
        fc_segment_fadeOut_1 = function(){
            
            fc_next = fc_segment_fadeOut_2;
            fc_delay = 0.5;
            
            startNim();
            
            fade = [0, 1];
            
        }
        
        fc_segment_fadeOut_2 = function(){
            
            room_restart();
            
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
    
    #region
    
    #region //boss intro
    
        fc_boss_1 = function(){
            
            //fc_next = fc_boss_fadeIn_2;
            //fc_delay = 0.5;
            
            //vertical warning tape, 2 stripes, right offset
            //boss title, left side
            
        }
    
    #endregion

#endregion