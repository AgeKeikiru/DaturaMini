#macro SAVE_VERSION 0

enum en_save{
    
    VERSION,
    
    CHAR_UNLOCK,
    EXCHAR_UNLOCK,
    
    FG_EXH,
    
    SCORES,
    
    SET_BGM,
    SET_SFX,
    
    IO,
    
    LENGTH
    
}

global.map_save = ds_map_create();

global.map_save[? en_save.VERSION] = SAVE_VERSION;

global.map_save[? en_save.CHAR_UNLOCK] = array_create(en_charID.LENGTH, 0);
global.map_save[? en_save.CHAR_UNLOCK][0] = 2;
global.map_save[? en_save.CHAR_UNLOCK][1] = 2;

global.map_save[? en_save.EXCHAR_UNLOCK] = array_create(en_exCharID.LENGTH, 0);

//flags
global.map_save[? en_save.FG_EXH] = 0; //exhaust difficulty mode

global.map_save[? en_save.SCORES] = [
    
    new_hiScore(10000, [0, 1], "KEI"),
    new_hiScore(9000, [1, 0], "IMO"),
    new_hiScore(8000, [0, 1], "ARI"),
    new_hiScore(7000, [1, 0], "BLZ"),
    new_hiScore(6000, [0, 1], "TEA"),
    new_hiScore(5000, [1, 0], "WCH"),
    new_hiScore(4000, [0, 1], "ALT"),
    new_hiScore(3000, [1, 0], "VLD"),
    new_hiScore(2000, [0, 1], "HRZ"),
    new_hiScore(1000, [1, 0], "JCK")
    
];

global.map_save[? en_save.IO] = [

    new_io(vk_up, gp_padu, -1),
    new_io(vk_down, gp_padd, -1),
    new_io(vk_left, gp_padl, -1),
    new_io(vk_right, gp_padr, -1),
    
    new_io(ord("Z"), gp_face1, 0),
    new_io(ord("X"), gp_face2, 0),
    new_io(vk_enter, gp_start, 0),
    
    new_io(vk_space, gp_face1, 1),
    new_io(ord("Z"), gp_face3, 1),
    new_io(ord("X"), gp_face4, 1),
    new_io(ord("C"), noone, 1),
    new_io(vk_shift, gp_face2, 1),
    
    new_io(ord("D"), noone, 1),
    new_io(ord("A"), gp_shoulderl, 1),
    new_io(ord("S"), gp_shoulderr, 1),
    new_io(ord("F"), noone, 1)

];

global.map_save[? en_save.SET_BGM] = 0.35;
global.map_save[? en_save.SET_SFX] = 0.3;