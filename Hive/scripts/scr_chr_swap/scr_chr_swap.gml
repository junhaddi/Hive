/// @description 캐릭터 무기 교체

if (keyboard_check_pressed(vk_space)) {
	if (!isSwapDelay) {
		if (global.chrMap[? "swap"] == SWAP.RANGER) {
			global.chrMap[? "swap"] = SWAP.WARRIOR;
			alarm[ALARM_CHR.RELOAD] = 0;
		}
		else {
			global.chrMap[? "swap"] = SWAP.RANGER;
			global.chrMap[? "ammo"] = global.chrMap[? "ammoMax"];
		}
		isSwapDelay = true;
		alarm[ALARM_CHR.SWAP] = swapSpeed;
		
		// TODO add swap skill
	}
}