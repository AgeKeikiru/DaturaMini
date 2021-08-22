event_inherited();

if(forcePod.vis){
    draw_sprite_ext(spr_tear_force, (current_time / 200), forcePod.xx, forcePod.yy, 1, 1, forcePod.angle, c_white, 1);
}

if(mergeGlow > 0){
    
    draw_set_alpha(0.5);
    draw_set_color(CC_HP_GREEN);
    
    draw_rectangle(obj_ui.x, y + -mergeGlow + -15, obj_ui.x + obj_ui.camW, y + mergeGlow + -14, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    mergeGlow = lerp(mergeGlow, 0, 0.3);
    
}