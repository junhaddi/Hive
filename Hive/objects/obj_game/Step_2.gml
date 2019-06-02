// 광원 블랜딩
if (surface_exists(lightSuf)) {
	surface_set_target(lightSuf);
	draw_set_alpha(0.6);
	draw_set_color(c_black);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_color(c_white);
	draw_set_alpha(1);

	if (!instance_exists(obj_parent_transition)) {
		gpu_set_blendmode(bm_subtract);

		with (obj_chr) {
			draw_sprite(spr_particle_light_glow, 0, x + random_range(-1, 1), y + random_range(-1, 1));
		}
	
		with (obj_bullet) {
			draw_self();
		}
		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target();
}
else {
	lightSuf = surface_create(global.gameWidth, global.gameHeight);
}

// 피격 효과 투명도 설정
damageAlpha = scr_tween_to(damageAlpha, 0, 0.06);