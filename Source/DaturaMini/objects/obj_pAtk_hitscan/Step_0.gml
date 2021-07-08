event_inherited();

if(drawW != -1){
    
    drawW = lerp(drawW, 0, 0.4);
    
    if(drawW < 0.01){
        instance_destroy();
    }
    
}