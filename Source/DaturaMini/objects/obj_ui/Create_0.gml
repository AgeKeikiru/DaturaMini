
uiMini = 0;

fade = [1, 1];
uiOffset = [1, 1];

#region //flowcharts

    intf_flowchart_implement();
    
    fc_segment_fadeIn_1 = function(){
        
        fc_next = fc_segment_fadeIn_2;
        fc_delay = 0.5;
        
        fade[1] = 2;
        
    }
    
    fc_segment_fadeIn_2 = function(){
        
        with obj_player{
            input_lock = false;
        }
        
        uiOffset[1] = 0;
        
    }
    
    fc_segment_fadeOut_1 = function(){
        
        fc_next = fc_segment_fadeOut_2;
        fc_delay = 0.5;
        
        with obj_player{
            input_lock = false;
        }
        
        fade = [0, 1];
        uiOffset[1] = 1;
        
    }
    
    fc_segment_fadeOut_2 = function(){
        
        room_restart();
        
    }

#endregion