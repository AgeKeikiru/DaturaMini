function intf_warnBeam_implement(){
    
    arr_warns = [];
    
}

function warnBeam_draw(){
    
    for(var _i = 0; _i < array_length(arr_warns); _i++){
    
        var
        _w = arr_warns[_i],
        _dist = 400,
        _col = c_red;
        
        if((current_time mod room_speed) > (room_speed / 2)){
            _col = c_orange;
        }
        
        draw_set_color(_col);
        
        switch(_w.type){
            
            case 0:
                draw_line(_w.ox, _w.oy, _w.ox + lengthdir_x(_dist, _w.dir), _w.oy + lengthdir_y(_dist, _w.dir));
                
                break;
                
            case 1:
                draw_circle(_w.ox, _w.oy, _w.dir, true);
                
                break;
        
        }
        
    }
    
    draw_set_color(c_white);
    
}