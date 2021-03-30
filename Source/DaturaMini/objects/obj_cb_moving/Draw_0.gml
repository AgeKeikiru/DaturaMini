
var
_spr = spr_9s_vr;

for(var _x = 0; _x < bbox_right + -x; _x += 8){
    
    for(var _y = 0; _y < bbox_bottom + -y; _y += 8){
    
        var
        _dx = (_x mod (sprite_get_width(_spr) + -16)) + 8,
        _dy = (_y mod (sprite_get_height(_spr) + -16)) + 8;
        
        if(_x == 0){ _dx = 0; }
        if(_x >= bbox_right + -x + -8){ _dx = sprite_get_width(_spr) + -8; }
        
        if(_y == 0){ _dy = 0; }
        if(_y >= bbox_bottom + -y + -8){ _dy = sprite_get_height(_spr) + -8; }
        
        draw_sprite_part(_spr, 0, _dx, _dy, 8, 8, x + _x, y + _y);
        
    }
    
}

/*
draw_sprite_part(_spr, 0, 0, 0, 8, 8, _x, _y);

_x += 8;

while(_x < bbox_right + -8){
    
    draw_sprite_part(_spr, 0, ((_iMid mod _midCount) + 1) * 8, 0, 8, 8, _x, _y);
    
    _x += 8;
    _iMid++;
    
}

draw_sprite_part(_spr, 0, sprite_get_width(_spr) + -8, 0, 8, 8, _x, _y);