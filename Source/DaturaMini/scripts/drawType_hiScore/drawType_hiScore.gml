function drawType_hiScore(_score, _y, _scoreRank, _preLetter){
    
    if(is_undefined(_preLetter)){ _preLetter = ""; }
    
    var
    _x = x + 22,
    _offX = 15,
    _offY = HEADER_SIZE / 2,
    _gap = 15,
    _rank = string(_scoreRank + 1),
    _chars = [
        global.arr_chars[_score[en_hiScore.TEAM][0]].s_icon[0],
        global.arr_chars[_score[en_hiScore.TEAM][1]].s_icon[0]
    ];
    
    switch _rank{
        
        case "1":
            _rank += "st";
            break;
        case "2":
            _rank += "nd";
            break;
        case "3":
            _rank += "rd";
            break;
        default:
            _rank += "th";
            break;
        
    }
    
    draw_set_font(ft_small);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    
    styleTxt(string(_score[en_hiScore.POINTS]), x + camW + -_offX, _y, c_white, c_black, true);
    
    draw_set_halign(fa_left);
    
    if(_preLetter != ">" && _preLetter != ""){
        
        if(sin(current_time / 10) > 0){
            draw_set_alpha(0);
        }
        
        styleTxt(_score[en_hiScore.NAME] + _preLetter, x + _offX + 55, _y, c_white, c_black, true);
        
    }
    
    draw_set_alpha(1);
    
    styleTxt(_score[en_hiScore.NAME], x + _offX + 55, _y, c_white, c_black, true);
    
    draw_set_font(ft_title);
    
    styleTxt(_rank, x + _offX, _y, c_white, c_black, true);
    
    draw_set_color(c_white);
    
    for(var _i = 0; _i < 2; _i++){
        
        draw_sprite(_chars[_i], 0, x + _offX + 90 + (16 * _i), _y);
        
    }
    
}