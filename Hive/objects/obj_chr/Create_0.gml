weaponSprite = spr_ranger_weapon1;
weaponDir = 1;
weaponLength = 16;
weaponAngle = 0;

isMove = false;
isAttackDelay = false;
isSkillDelay = false;
isDamageDelay = false;
isSwapDelay = false;

skillSpeed = room_speed * 10;
swapSpeed = room_speed * 1;
reloadSpeed = room_speed * 2;

global.chrMap[? "ammo"] = global.chrMap[? "ammoMax"];
image_speed = 0.3;
