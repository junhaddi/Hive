// 깊이 순서 정렬
var instCount = instance_number(obj_parent_depth);
var depthGrid = ds_grid_create(2, instCount);
var yy = 0;
	
with (obj_parent_depth) {
	depthGrid[# 0, yy] = id;
	depthGrid[# 1, yy] = y;
	yy++;
}
ds_grid_sort(depthGrid, 1, true);

for (var i = 0; i < instCount; i++) {
	var instID = depthGrid[# 0, i];

	with (instID) {
		// 그림자 그리기
		draw_sprite_ext(spr_particle_shadow, 0, x, y, sprite_width / sprite_get_width(spr_particle_shadow), 1, 0, c_white, 1);
		
		switch (object_index) {
			#region obj_chr
			case obj_chr:
				var secondWeapon;
				
				if (global.chrMap[? "swap"] == "ranger") {
					secondWeapon = warriorSprite;
				}
				else if (global.chrMap[? "swap"] == "warrior") {
					secondWeapon = rangerSprite;
				}
				draw_sprite_ext(secondWeapon, 0, x, y - 24, 1, 1, 90 + 20 * weaponDir, c_gray, 1);
				draw_sprite_ext(chrSprite, isMove * -1, x, y, image_xscale * weaponDir, image_yscale, image_angle, image_blend, image_alpha);
				
				if (global.chrMap[? "swap"] == "ranger") {
					draw_sprite_ext(rangerSprite, 0, x + lengthdir_x(weaponLength, weaponAngle), y + lengthdir_y(weaponLength, weaponAngle) - 8, 1, weaponDir, weaponAngle, c_white, 1);
				}
				else if (global.chrMap[? "swap"] == "warrior") {
					draw_sprite_ext(warriorSprite, 0, x + lengthdir_x(weaponLength, weaponAngle), y + lengthdir_y(weaponLength, weaponAngle) - 8, 1, weaponDir * warriorDir, weaponAngle + 110 * weaponDir * warriorDir, c_white, 1);
				}
				break;
			#endregion
			#region default
			default:
				draw_self();
				break;
			#endregion
		}
	}
}
ds_grid_destroy(depthGrid);