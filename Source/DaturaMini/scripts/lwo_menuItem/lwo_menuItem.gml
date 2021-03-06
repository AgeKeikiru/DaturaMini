function lwo_menuItem(_name, _onRun) constructor{
    
    name = _name;
    onRun = _onRun;
    skip = false;
    
    //slider options
    sld_prefix = "";
    sld_names = [];
    sld_index = 0;
    sld_onScroll = function(){};
    
    fn_sld_setName = function(){
        
        name = sld_prefix + "< " + sld_names[sld_index] + " >";
        
        sld_onScroll();
        
    }
    
}

function lwo_menuSpacer() : lwo_menuItem("", noone) constructor{
    
    skip = true;
    
}

function lwo_menuItem_ioBind(_ioKey, _isJoy) : lwo_menuItem("", noone) constructor{
    
    io = global.map_save[? en_save.IO][_ioKey];
    ioName = global.arr_ioNames[_ioKey];
    isJoy = _isJoy;
    
    name = ioName;
    
    var _str = _isJoy ? joyToString(io[en_io.JOY]) : keyToString(io[en_io.KEY]);
        
    name += "  " + _str + string_repeat(" ", 7 + -string_length(_str));
    
    onRun = function(){
        /**/
    }
    
}

function lwo_menuSlider_vol(_setKey) : lwo_menuItem("", noone) constructor{
    
    setKey = _setKey; //en_save enum value, SET_BGM or SET_SFX
    
    sld_prefix = ((setKey == en_save.SET_BGM) ? "BGM" : "SFX") + " VOL: ";
    
    var _intervals = 20;
    
    for(var _i = 0; _i <= _intervals; _i++){
        
        sld_names[_i] = string_format(_i * (100 / _intervals), 3, 0) + "%";
        
    }
    
    sld_index = global.map_save[? setKey] * _intervals;
    
    sld_onScroll = function(){
        
        global.map_save[? setKey] = sld_index / (array_length(sld_names) + -1);
        
    };
    
    fn_sld_setName();
    
}