
var
_x = x,
_y = y,
_spr = spr_3s_vr,
_midCount = (sprite_get_width(_spr) / 8) + -2,
_iMid = 0,
_shakeX = 0;

image_alpha = lerp(image_alpha, !crumbled, 0.2);
draw_set_alpha(image_alpha);

if(crumbleTime > 0){
    
    _shakeX = sin(current_time / 10);
    
}

draw_sprite_part(_spr, 0, 0, 0, 8, 8, _x + _shakeX, _y);

_x += 8;

while(_x < bbox_right + -8){
    
    draw_sprite_part(_spr, 0, ((_iMid mod _midCount) + 1) * 8, 0, 8, 8, _x + _shakeX, _y);
    
    _x += 8;
    _iMid++;
    
}

draw_sprite_part(_spr, 0, sprite_get_width(_spr) + -8, 0, 8, 8, _x + _shakeX, _y);

draw_set_alpha(1);