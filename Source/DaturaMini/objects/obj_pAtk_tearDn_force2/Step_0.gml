timer += -TICK * global.timeFlow;

if(timer < 0){
    
    var
    _gap = 4,
    _x = _gap * (loop + 0.5),
    _o,
    _f_bullet = function(__x, __y, __dir){
        
        var _o = scr_place(obj_pAtk_ari, __x, __y);
        _o.direction = __dir;
        _o.image_angle = __dir;
        _o.pv_d = 3;
        _o.hazard = hazard;
        _o.image_blend = image_blend;
        _o.push = 0;
        _o.atkStun = 0.4;
        
    };
    
    timer = 0.01;
    
    _f_bullet(x + _x, y, 90);
    _f_bullet(x + -_x, y, 90);
    _f_bullet(x + _x, y, -90);
    _f_bullet(x + -_x, y, -90);
    
    loop++;
    
    if(loop > 3){
        instance_destroy();
    }
    
}