enum en_input {
        
    UNI_UP,
    UNI_DOWN,
    UNI_LEFT,
    UNI_RIGHT,
    
    MENU_ACCEPT,
    MENU_CANCEL,
    MENU_START,
    
    GAME_JUMP,
    GAME_ATK1,
    GAME_ATK2,
    GAME_DEF_CURRENT,
    GAME_HYPER,
    GAME_ATK_CURRENT,
    GAME_DEF1,
    GAME_DEF2,
    GAME_SWITCH,
    
    LENGTH
    
}

enum en_ioType {
    
    DOWN,
    PRESS,
    RELEASE
    
}

enum en_io {
    
    KEY,
    NEWKEY,
    JOY,
    NEWJOY,
    GROUP,
    
    LENGTH
    
}

global.arr_ioNames = [
    
    " ALL:UP    ",
    " ALL:DOWN  ",
    " ALL:LEFT  ",
    " ALL:RIGHT ",
    "MENU:ACCEPT",
    "MENU:CANCEL",
    "MENU:START ",
    "GAME:JUMP  ",
    "GAME:ATK 1 ",
    "GAME:ATK 2 ",
    "GAME:DEF   ",
    "GAME:HYPER ",
    "GAME:ATK   ",
    "GAME:DEF 1 ",
    "GAME:DEF 2 ",
    "GAME:SWITCH"
    
];

function new_io(_key, _joy, _group){

    return [
        
        _key,
        _key,
        _joy,
        _joy,
        _group //members of the same group cannot overlap, -1 cannot overlap with anything
        
    ];
    
}

function io_check(_type, _arr_key){
    
    var _r = [false, false, false];
    
    if(is_undefined(_arr_key)){
        
        _arr_key = array_create(en_input.LENGTH);
        
        for(var _i = 0; _i < en_input.LENGTH; _i++){
            _arr_key[_i] = _i;
        }
        
    }
    
    for(var _i = 0; _i < array_length(_arr_key); _i++){
    
        var _io = global.map_save[? en_save.IO][_arr_key[_i]];
        
        if(_io[en_io.KEY] != noone){
            
            if(keyboard_check(_io[en_io.KEY])){ _r[en_ioType.DOWN] = true; }
            if(keyboard_check_pressed(_io[en_io.KEY])){ _r[en_ioType.PRESS] = true; }
            if(keyboard_check_released(_io[en_io.KEY])){ _r[en_ioType.RELEASE] = true; }
            
        }
        
        if(_io[en_io.JOY] != noone){
            
            if(gamepad_button_check(global.gpDevice, _io[en_io.JOY])){ _r[en_ioType.DOWN] = true; }
            if(gamepad_button_check_pressed(global.gpDevice, _io[en_io.JOY])){ _r[en_ioType.PRESS] = true; }
            if(gamepad_button_check_released(global.gpDevice, _io[en_io.JOY])){ _r[en_ioType.RELEASE] = true; }
            
        }
    
    }
    
    return _r[_type];
    
}