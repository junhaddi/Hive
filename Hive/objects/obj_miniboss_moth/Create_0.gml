hpMax = 10;
hp = hpMax; 
moveSpeed = random_range(4, 6);
damage = 3;
name = "나방"

target = obj_chr;
moveDelay = room_speed * 0.5;
moveDistance = 1200;

event_inherited();