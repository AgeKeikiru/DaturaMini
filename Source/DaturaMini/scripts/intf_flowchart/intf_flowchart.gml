function intf_flowchart_implement() {
    
    fc_next = noone;
    fc_delay = -1;
    
}

function flowchart_step(){
    
    if(fc_delay > 0){
        
        fc_delay += -TICK;
        
        if(fc_delay <= 0 && is_method(fc_next)){
            fc_next();
        }
        
    }
    
}