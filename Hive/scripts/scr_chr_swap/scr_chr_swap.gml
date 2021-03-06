/// @description 캐릭터 무기 교체

if (!isSwapDelay) {
	if ((os_type == os_windows && (keyboard_check_pressed(ord("Q")) || mouse_wheel_up() || mouse_wheel_down())) ||
		(os_type == os_android && global.vkey[VKEY.SWAP, VKEY_SETTING.PRESSED])) {
		if (global.chrMap[? "swap"] == "ranger") {
			global.chrMap[? "swap"] = "warrior";
			warriorDir = 1;
		}
		else if (global.chrMap[? "swap"] == "warrior") {
			global.chrMap[? "swap"] = "ranger";
			audio_play_sound(sfx_ranger_reload, 10, false);
		}
		isSwapDelay = true;
		alarm[ALARM_CHR.SWAP] = swapSpeed;
	}
}