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

hitSound = sfx_hit;

hitSpark = noone;
hitSparkX = 0;
hitSparkY = 0;

altBlend = false;

glow = noone;

//character specific effects
sp_freeze = 0; //for breia, 0:none, 1:add freeze, 2:break freeze

fn_addSpark = function(_x, _y){
    
    if(hitSpark != noone){
        
        var
        //_spark = scr_place(obj_spark, _x + (hitSparkX * sign(image_xscale)), _y + hitSparkY);
        _spark;
        
        repeat(2){
        
            _spark = scr_place(obj_spark, _x + (hitSparkX * sign(image_xscale)), _y + hitSparkY);
            
            _spark.sprite_index = hitSpark;
            //_spark.image_blend = obj_player.currPly.uiCol;
            _spark.duration = sprite_get_number(hitSpark);
            _spark.image_xscale = sign(image_xscale);
            _spark.depth = depth + -999;
        
        }
        
        _spark.image_blend = obj_player.currPly.uiCol;
        _spark.x += 1;
        
    }
    
}

fn_collCheck = function(_other){
    
    return (!hazard && object_is_ancestor(_other.object_index, obj_enemy) && !_other.checkState(_other.fn_state_dead) && !_other.player && ds_list_find_index(lst_hits, _other.id) == -1 && _other.iFrames <= 0 && !_other.iState);
    
}