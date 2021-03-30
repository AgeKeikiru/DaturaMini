
var _p = collision_rectangle(bbox_left, bbox_top + -1, bbox_right, bbox_bottom, obj_player, false, true);

globalvar G_ground;
G_ground = false;

with _p{
    
    G_ground = on_ground();
    
}

if(instance_exists(_p) && G_ground && _p.spd_y == 0 && crumbleTime == 0 && !crumbled){
    
    crumbleTime = 1;
    
}

if(crumbleTime > 0){
    
    crumbleTime += -TICK * global.timeFlow;
    
    if(crumbleTime <= 0){
        
        crumbled = !crumbled;
        
        if(crumbled){
            
            crumbleTime = 0.5;
            
        }
        
    }
    
}