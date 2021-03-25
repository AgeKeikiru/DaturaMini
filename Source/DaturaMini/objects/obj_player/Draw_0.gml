
event_inherited();

if(global.hyperActive){
    
    var _r = 15;
    
    var fn_drawArc = function(__r){
        
        var
        _factor = global.hyperTime / HYPER_DURATION,
        _cx = x,
        _cy = y + -10;
        
        draw_primitive_begin(pr_linestrip);
    
        for(var _angle = 0; _angle < (360 * _factor); _angle += 10){
            
            draw_vertex(_cx + lengthdir_x(__r, _angle + 90), _cy + lengthdir_y(__r, _angle + 90));
            
        }
        
        draw_primitive_end();
        
    }
    
    draw_set_color(CC_HYPINK);
    
    fn_drawArc(_r);
    _r += -0.5;
    
    fn_drawArc(_r);
    _r += -0.5;
    
    draw_set_color(c_white);
    
    fn_drawArc(_r);
    _r += -0.5;
    
    fn_drawArc(_r);
    _r += -0.5;
    
    fn_drawArc(_r);
    _r += -0.5;
    
    draw_set_color(CC_HYPINK);
    
    fn_drawArc(_r);
    
    draw_set_font(ft_small);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    if(sin(current_time / 15) > 0){
        
        draw_set_color(c_yellow);
        
    }
    
    draw_text_transformed(x + 10, y + -22, "x" + string(global.hyperChain), 1, 1, 0);
    
}

draw_set_color(c_white);