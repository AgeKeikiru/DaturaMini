
x += xspd * (global.timeFlow);
y += yspd * (global.timeFlow);

yspd += 0.2 * (global.timeFlow);

image_angle += 60 * (global.timeFlow);

duration += -TICK * global.timeFlow;

if(duration < 0){
    instance_destroy();
}

image_alpha = (sin(current_time / 10) / 2) + 0.5;