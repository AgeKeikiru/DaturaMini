scr_init();

if(TESTING_MODE){

    global.map_save[? en_save.SET_BGM] = 0.0;
    global.map_save[? en_save.SET_SFX] = 0.5;

}

room_goto(TESTING_MODE ? rm_lv3_1 : rm_title);