if (ds_list_find_index(penetrateList, other.id) == -1) {
	var _damage = damage;
	other.hp -=  _damage;
	penetrate++;

	if (penetrate < penetrateMax) {
		ds_list_add(penetrateList, other.id);
		
		if (penetrate == 1) {
			damage = floor(damage / 2);
		}
	}
	else {
		instance_destroy();
	}
	
	if (other.hp <= 0) {
		var sfx = audio_play_sound(sfx_enemy_destroy, 10, false);
		audio_sound_pitch(sfx, random_range(0.8, 1.2));
		instance_destroy(other);
	}
	else if (!other.isHit) {
		other.isHit = true;
		other.alarm[ALARM_VFX.HIT] = room_speed * 0.1;
	}
	scr_vfx_text(random_range(other.x - 15, other.x + 15), other.y - other.sprite_height, _damage, c_white);
	scr_vfx_bullet_hit(image_angle);
}