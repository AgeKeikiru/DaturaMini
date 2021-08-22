#macro TESTING_MODE false

function scr_init(){
	
	randomize();
	
	surface_resize( application_surface, camera_get_view_width( view_camera[0] ), camera_get_view_height( view_camera[0] ) );
	
	scr_place(obj_ui);
	
	global.gpDevice = 0;
    
    var _pads = gamepad_get_device_count();
    
    for(var _i = _pads + -1; _i >= 0; _i--){
        
        if(gamepad_is_connected(_i)){
            global.gpDevice = _i;
        }
        
    }
	
	loadData();
	
}

#region //score data

    enum en_hiScore{
        
        POINTS,
        TEAM,
        NAME,
        
        LENGTH
        
    }
    
    function new_hiScore(_p, _team, _name){
        
        var _arr = [];
        array_copy(_arr, 0, _team, 0, array_length(_team));
        
        return [
            _p,
            _arr,
            _name
        ];
        
    }
    
    global.points = TESTING_MODE ? 999999 : 0;
    global.pointName = "";
    global.pointRank = 0;

#endregion

#region //manual sound mixing

    global.map_soundMix = ds_map_create();
    
    global.map_soundMix[? sfx_cut1] = 0.4;
    global.map_soundMix[? sfx_cut2] = 0.4;
    global.map_soundMix[? sfx_shot3] = 0.3;
    global.map_soundMix[? sfx_shot4] = 0.3;
    global.map_soundMix[? sfx_explode] = 0.5;
    global.map_soundMix[? sfx_whoosh1] = 0.6;
    /**/

#endregion

global.txt_stageNum = "1";
global.txt_stageName = "test";

global.txt_bossClass = "";
global.txt_bossName = "";

global.arr_team = [1, 0];

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

global.bonus_time = [0, 6000];
global.bonus_kill = [28, 0];
global.bonus_token = [16, 0];
global.bonus_hyper = [0, 3];

#macro HYPER_DURATION 8
#macro CC_HYPINK $feaeff