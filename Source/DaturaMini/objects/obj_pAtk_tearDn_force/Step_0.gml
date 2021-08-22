event_inherited();

if(collision_rectangle(x + -1, y + -80, x + 1, y + 80, hazard ? obj_player : obj_enemy, true, true)){
    instance_destroy();
}