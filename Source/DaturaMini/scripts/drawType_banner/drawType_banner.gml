function drawType_banner(_lerp, _invert, _min, _max){
    
    if(is_undefined(_invert)){ _invert = false; }
    if(is_undefined(_min)){ _min = 0; }
    if(is_undefined(_max)){ _max = camH / 2; }
    
    var
    _top = _invert ? y : camMidY,
    _bot = _invert ? (y + camH) : camMidY;
    
    if(_invert){
        
        _top += -1;
        _max += 1;
        
    }
    
    draw_rectangle(x, _top, x + camW, _top + (lerp(_min, _max, _lerp) * (_invert ? 1 : -1)), false);
    draw_rectangle(x, _bot, x + camW, _bot + (lerp(_min, _max, _lerp) * (_invert ? -1 : 1)), false);
    
}