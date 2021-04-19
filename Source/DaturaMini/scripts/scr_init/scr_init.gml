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
    
    global.points = 0;
    global.pointName = "";
    global.pointRank = 0;

#endregion

#region //save data

    enum en_save{
        
        CHAR_UNLOCK,
        EXCHAR_UNLOCK,
        
        SCORES,
        
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