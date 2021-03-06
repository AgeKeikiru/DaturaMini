event_inherited();

dmg = 1;
push = 0;
lift = 0;

drawX = [x, x];
drawY = [y, y];
drawW = -1;

slowTo = 0.4;
slowDur = 0.3;

shakeX = [0, 0];
shakeY = [0, 0];

hitSound = noone;

function hitscan_init(_w){
    
    var _lst = ds_list_create();
    
    drawX = [x, x];
    drawY = [y, y];
    drawW = _w;
    
    while(!collision_point(drawX[1], drawY[1], objA_solid, true, true) && clamp(drawX[1], obj_ui.x, obj_ui.x + obj_ui.camW) == drawX[1] && clamp(drawY[1], obj_ui.y, obj_ui.y + obj_ui.camH) == drawY[1]){
        
        drawX[1] += pv_x;
        drawY[1] += pv_y;
        
        ds_list_clear(_lst);
        
        if(collision_circle_list(drawX[1], drawY[1], _w, objA_actor, true, true, _lst, false)){
            
            for(var _i = 0; _i < ds_list_size(_lst); _i++){
            
                var _o = _lst[|_i];
                
                if(fn_collCheck(_o)){
                    
                    ds_list_add(lst_hits, _o);
                    
                    var _atk = scr_place(obj_pAtk_breExpl, clamp(drawX[1], _o.bbox_left, _o.bbox_right), clamp(drawY[1], _o.bbox_top, _o.bbox_bottom));
                    
                    _atk.visible = false;
                    _atk.image_xscale = pv_x;
                    _atk.dmg = dmg;
                    _atk.atkStun = atkStun;
                    _atk.push = push;
                    _atk.lift = lift;
                    _atk.slowTo = slowTo;
                    _atk.slowDur = slowDur;
                    _atk.shakeX = shakeX;
                    _atk.shakeY = shakeY;
                    _atk.hitSpark = spr_spk_bash;
                    _atk.sp_freeze = sp_freeze;
                    
                }
            
            }
            
        }
        
    }
    
    ds_list_destroy(_lst);
    
    pv_x = 0;
    pv_y = 0;
    
}