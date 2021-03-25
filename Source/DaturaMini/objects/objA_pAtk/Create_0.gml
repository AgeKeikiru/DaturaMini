event_inherited();

intf_platforming_implement();

#region //hyper decay

    #macro HYPER_DECAY 0.1
    
    var
    _map = global.map_hyperValue;
    
    if(!ds_map_exists(_map, object_index)){
        
        _map[? object_index] = 1 + HYPER_DECAY;
        
    }
    
    var _key = ds_map_find_first(_map);
    
    while(ds_map_exists(_map, _key)){
        
        _map[? _key] += (_key == object_index) ? -HYPER_DECAY : HYPER_DECAY;
        
        _map[? _key] = clamp(_map[? _key], 0, 1 + HYPER_DECAY);
        
        _key = ds_map_find_next(_map, _key);
        
    }

#endregion

depth = -999;

lst_hits = ds_list_create(); //keep track of enemies hit

dmg = 0;
duration = -1;
weight = 0;
push = 3;
lift = 2;
atkStun = 0.3;

#macro SLOW_STD 0.2
slowTo = -1;
slowDur = 0.2;

passWall = true;
passEnemy = true;

//projectile velocity
pv_x = 0;
pv_y = 0;
pv_d = 0; //directional

//cam shake effects
shakeX = [-1, 1];
shakeY = [-1, 1];
shake_onDeath = false;