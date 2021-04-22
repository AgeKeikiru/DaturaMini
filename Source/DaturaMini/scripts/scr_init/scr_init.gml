function scr_init(){
	
	randomize();
	
	surface_resize( application_surface, camera_get_view_width( view_camera[0] ), camera_get_view_height( view_camera[0] ) );
	
	scr_place(obj_ui);
	
}

#region //character data

    enum en_charID{
        
        IMO,
        ARI,
        BREIA,
        TEAR,
        WITCHY,
        ALTAI,
        
        LENGTH
        
    }
    
    enum en_exCharID{
        
        VELD,
        
        LENGTH
        
    }
    
    function lwo_charData() constructor{
        
        name = "";
        unlockDesc = "???";
        
        hintDesc = [
            
            "ATK\n\n",
            "UP-ATK\n\n",
            "DOWN-ATK\n\n",
            "DEFEND\n\n"
            
        ];
        
        introTxt = array_create(en_charID.LENGTH, "...");
        
        s_icon = [spr_ari_idle, spr_ari_move];
        s_port = spr_ari_port;
        
    }
    
    function lwo_imoData() : lwo_charData() constructor{
        
        name = "Imo'lei";
        
        hintDesc[0] += "Basic slash,\nclose range";
        hintDesc[1] += "Rising slash,\ncreates wave\non the ground";
        hintDesc[2] += "Down-slash,\npulls enemies\nin";
        hintDesc[3] += "Block,\nmove to dodge";
        
        introTxt[en_charID.IMO] = "\"Try not to get in the way too\nmuch.\"";
        introTxt[en_charID.ARI] = "\"Ugh, how did I get stuck with\nyou?\"";
        
        s_icon = [spr_imo_idle, spr_imo_move];
        s_port = spr_imo_port;
        
    }
    
    function lwo_ariData() : lwo_charData() constructor{
        
        name = "Ari";
        
        hintDesc[0] += "Rapid shot,\nsafe,\ndoesn't stun";
        hintDesc[1] += "Missile volley,\nlimited homing";
        hintDesc[2] += "Down-crash,\nmore height\nimproves AoE";
        hintDesc[3] += "Sliding dodge,\nstuns enemies";
        
        introTxt[en_charID.IMO] = "\"Ha! Just try to keep up then!\"";
        introTxt[en_charID.ARI] = "\"Alright, we got this in the\nbag!\"";
        
        s_icon = [spr_ari_idle, spr_ari_move];
        s_port = spr_ari_port;
        
    }
    
    function lwo_breiaData() : lwo_charData() constructor{
        
        name = "Breia";
        unlockDesc = "Clear Stage 1";
        //s_icon = [spr_imo_idle, spr_imo_move];
        //s_port = spr_imo_port;
        
    }
    
    function lwo_tearData() : lwo_charData() constructor{
        
        name = "Tear";
        unlockDesc = "Clear Stage 2\nwith no\ncontinues";
        //s_icon = [spr_imo_idle, spr_imo_move];
        //s_port = spr_imo_port;
        
    }
    
    function lwo_witchyData() : lwo_charData() constructor{
        
        name = "Witchy";
        unlockDesc = "Clear the game";
        //s_icon = [spr_imo_idle, spr_imo_move];
        //s_port = spr_imo_port;
        
    }
    
    function lwo_altaiData() : lwo_charData() constructor{
        
        name = "Altai";
        unlockDesc = "Clear any stage\non EXH with no\ncontinues";
        //s_icon = [spr_imo_idle, spr_imo_move];
        //s_port = spr_imo_port;
        
    }
    
    function lwo_veldData() : lwo_charData() constructor{
        
        name = "Veld";
        //s_icon = [spr_imo_idle, spr_imo_move];
        //s_port = spr_imo_port;
        
    }
    
    global.arr_chars = [
        
        new lwo_imoData(),
        new lwo_ariData(),
        new lwo_breiaData(),
        new lwo_tearData(),
        new lwo_witchyData(),
        new lwo_altaiData()
        
    ];
    
    global.arr_exChars = [
        
        new lwo_veldData()
        
    ];

#endregion

#region //score data

    function lwo_hiScore(_p, _team, _name) constructor{
        
        points = _p;
        
        team = [];
        array_copy(team, 0, _team, 0, array_length(_team));
        
        name = _name;
        
    }
    
    global.points = 999999;
    global.pointName = "";
    global.pointRank = 0;

#endregion

#region //input data

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
    
    global.gpDevice = 0;
    
    function lwo_io(_name, _key, _joy, _group) constructor{
    
        name = _name;
        
        key = _key;
        newKey = _key;
        
        joy = _joy;
        newJoy = _joy;
        
        group = _group; //members of the same group cannot overlap, -1 cannot overlap with anything
        
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
            
            if(_io.key != noone){
                
                if(keyboard_check(_io.key)){ _r[en_ioType.DOWN] = true; }
                if(keyboard_check_pressed(_io.key)){ _r[en_ioType.PRESS] = true; }
                if(keyboard_check_released(_io.key)){ _r[en_ioType.RELEASE] = true; }
                
            }
            
            if(_io.joy != noone){
                
                if(gamepad_button_check(global.gpDevice, _io.joy)){ _r[en_ioType.DOWN] = true; }
                if(gamepad_button_check_pressed(global.gpDevice, _io.joy)){ _r[en_ioType.PRESS] = true; }
                if(gamepad_button_check_released(global.gpDevice, _io.joy)){ _r[en_ioType.RELEASE] = true; }
                
            }
        
        }
        
        return _r[_type];
        
    }

#endregion

#region //save data

    enum en_save{
        
        CHAR_UNLOCK,
        EXCHAR_UNLOCK,
        
        SCORES,
        
        SET_BGM,
        SET_SFX,
        
        IO,
        
        LENGTH
        
    }
    
    global.map_save = ds_map_create();
    
    global.map_save[? en_save.CHAR_UNLOCK] = array_create(en_charID.LENGTH, 0);
    global.map_save[? en_save.CHAR_UNLOCK][0] = 2;
    global.map_save[? en_save.CHAR_UNLOCK][1] = 2;
    
    global.map_save[? en_save.EXCHAR_UNLOCK] = array_create(en_exCharID.LENGTH, false);
    
    global.map_save[? en_save.SCORES] = [
        
        new lwo_hiScore(10000, [0, 1], "KEI"),
        new lwo_hiScore(9000, [1, 0], "IMO"),
        new lwo_hiScore(8000, [0, 1], "ARI"),
        new lwo_hiScore(7000, [1, 0], "BLZ"),
        new lwo_hiScore(6000, [0, 1], "TEA"),
        new lwo_hiScore(5000, [1, 0], "WCH"),
        new lwo_hiScore(4000, [0, 1], "ALT"),
        new lwo_hiScore(3000, [1, 0], "VLD"),
        new lwo_hiScore(2000, [0, 1], "HRZ"),
        new lwo_hiScore(1000, [1, 0], "JCK")
        
    ];
    
    global.map_save[? en_save.IO] = [
    
        new lwo_io("ALL:Up", vk_up, gp_padu, -1),
        new lwo_io("ALL:Down", vk_down, gp_padd, -1),
        new lwo_io("ALL:Left", vk_left, gp_padl, -1),
        new lwo_io("ALL:Right", vk_right, gp_padr, -1),
    
        new lwo_io("MENU:Accept", ord("Z"), gp_face1, 0),
        new lwo_io("MENU:Cancel", ord("X"), gp_face2, 0),
        new lwo_io("MENU:Start", vk_enter, gp_start, 0),
        
        new lwo_io("GAME:Jump", vk_space, gp_face1, 1),
        new lwo_io("GAME:Atk 1", ord("Z"), gp_face3, 1),
        new lwo_io("GAME:Atk 2", ord("X"), gp_face4, 1),
        new lwo_io("GAME:Def", ord("C"), noone, 1),
        new lwo_io("GAME:Hyper", vk_shift, gp_face2, 1),
        
        new lwo_io("GAME:Atk", ord("D"), noone, 1),
        new lwo_io("GAME:Def 1", ord("A"), gp_shoulderl, 1),
        new lwo_io("GAME:Def 2", ord("S"), gp_shoulderr, 1),
        new lwo_io("GAME:Switch", ord("F"), noone, 1)
    
    ];
    
    global.map_save[? en_save.SET_BGM] = 0.35;
    global.map_save[? en_save.SET_SFX] = 0.3;
    
    //testing
    global.map_save[? en_save.SET_BGM] = 0;
    //global.map_save[? en_save.SET_SFX] = 0.2;

#endregion

#region //manual sound mixing

    global.map_soundMix = ds_map_create();
    global.map_soundMix[? sfx_pointGet] = 0.4;
    global.map_soundMix[? sfx_shot1] = 0.3;
    global.map_soundMix[? sfx_hit] = 0.5;
    global.map_soundMix[? sfx_tick2] = 0.8;

#endregion

global.arr_team = [0, 1];

global.nim = false;

global.timeFlow = 1;
global.timeSlow = 0;
global.timeDebug = false;

global.hyperActive = false;
global.hyperAfterImg = noone;
global.hyperTime = 0;
global.hyperChain = 0;
global.hyper = 0;

global.map_hyperValue = ds_map_create();

global.rmNext = rm_test;

global.bonus_time = [6052, 6000];
global.bonus_kill = [28, 0];
global.bonus_token = [16, 0];
global.bonus_hyper = [2, 3];

#macro HYPER_DURATION 8
#macro CC_HYPINK $feaeff