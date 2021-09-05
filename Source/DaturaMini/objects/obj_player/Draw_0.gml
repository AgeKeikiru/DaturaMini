
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

if(currPly.podActive && forcePod.vis){
    
    if(checkState(currPly.state_atk.run)){
        
        var
        _c = forceScanTri();
        
        gpu_set_blendmode(bm_add);
        draw_set_alpha((sin(current_time / 20) > 0) ? 0.1 : 0.2);
        
        draw_triangle_color(_c[0][0], _c[0][1], _c[1][0], _c[1][1], _c[2][0], _c[2][1], c_lime, c_black, c_black, false);
        
        draw_set_alpha(draw_get_alpha() + 0.5);
        
        draw_triangle_color(_c[0][0], _c[0][1], _c[1][0], _c[1][1], _c[2][0], _c[2][1], CC_HP_GREEN, c_black, c_black, true);
        
        if(instance_exists(forcePod.lockon)){
            
            draw_set_color(CC_HP_GREEN);
            
            draw_rectangle(forcePod.lockon.bbox_left, forcePod.lockon.bbox_top, forcePod.lockon.bbox_right, forcePod.lockon.bbox_bottom, true);
            
        }
        
        gpu_set_blendmode(bm_normal);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
        
    }
    
    with forcePod.glow{
        event_perform(ev_draw, 0);
    }
    
    draw_sprite_ext(spr_tear_force, (current_time / 200), forcePod.xx, forcePod.yy, 1, 1, forcePod.angle, c_white, 1);
    
}

draw_set_color(c_white);