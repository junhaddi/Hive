if (file_exists(SAVE_FILE)) {
	scr_load_file(SAVE_FILE);

	var transition = instance_create_layer(0, 0, "layer_system", obj_transition_fadeout);
	transition.targetRoom = scr_world_room_index(0);

	// 배경음악 재생
	audio_stop_sound(global.bgmPlaying);

	global.bgmPlaying = bgm_city;
	audio_play_sound(global.bgmPlaying, 0, true);
}