var worldIndex = global.worldList[| global.currentIndex];
var infoMap = worldIndex[| MARK.INFO];
var entryIndex = worldIndex[| MARK.ENTRY];
var hiveIndex = worldIndex[| MARK.HIVE];
infoMap[? "search"] = SEARCH.KNOWN;

#region Create entry
with (obj_parrent_entry) {
	var isEntry = false;
	
	for (var i = 0; i < ds_list_size(entryIndex); i++) {
		var entryMap = entryIndex[| i];
		
		if (pos == entryMap[? "pos"]) {
			target_roomId = entryMap[? "target_roomId"];
			var _worldIndex = global.worldList[| target_roomId];
			var _infoMap = _worldIndex[| MARK.INFO];
			
			if (_infoMap[? "search"] == SEARCH.UNKNOWN) { 
				_infoMap[? "search"] = SEARCH.CLOSE;
			}
			isEntry = true;
			break;
		}
	}
	
	if (!isEntry) {
		var b = instance_create_depth(x, y, 0, obj_block);
		b.image_xscale = image_xscale;
		b.image_yscale = image_yscale;
		instance_destroy();
	}
}
#endregion
#region Create player
if (global.previousIndex == noone) {
	instance_create_depth(room_width / 2, room_height / 2, 0, obj_chr);
}
else {
	with (obj_parrent_entry) {
		if (target_roomId == global.previousIndex && !instance_exists(obj_chr)) {
			var entryCount = 0;
			
			for (var i = 0; i < ds_list_size(entryIndex); i++) {
				var entryMap = entryIndex[| i];
					
				if (target_roomId == entryMap[? "target_roomId"]) {
					entryCount++;
				}
			}
			
			var wcenter = (bbox_left + bbox_right) / 2;
			var hcenter = (bbox_top + bbox_bottom) / 2;
			
			if (global.previousPos == POS.TOP || global.previousPos == POS.TOP_LEFT || global.previousPos == POS.TOP_RIGHT) {
				if (entryCount == 1 ||
					(entryCount == 2 && ((global.previousPos == POS.TOP_LEFT && pos == POS.BOTTOM_LEFT) || (global.previousPos == POS.TOP_RIGHT && pos == POS.BOTTOM_RIGHT)))) {
					instance_create_depth(wcenter, hcenter - 64, 0, obj_chr);
				}
			}
				
			if (global.previousPos == POS.RIGHT || global.previousPos == POS.RIGHT_TOP || global.previousPos == POS.RIGHT_BOTTOM) {
				if (entryCount == 1 ||
					(entryCount == 2 && ((global.previousPos == POS.RIGHT_TOP && pos == POS.LEFT_TOP) || (global.previousPos == POS.RIGHT_BOTTOM && pos == POS.LEFT_BOTTOM)))) {
					instance_create_depth(wcenter + 64, hcenter, 0, obj_chr);
				}
			}
		
			if (global.previousPos == POS.BOTTOM || global.previousPos == POS.BOTTOM_RIGHT || global.previousPos == POS.BOTTOM_LEFT) {
				if (entryCount == 1 ||
					(entryCount == 2 && ((global.previousPos == POS.BOTTOM_RIGHT && pos == POS.TOP_RIGHT) || (global.previousPos == POS.BOTTOM_LEFT && pos == POS.TOP_LEFT)))) {
					instance_create_depth(wcenter, hcenter + 64, 0, obj_chr);
				}
			}
		
			if (global.previousPos == POS.LEFT ||global.previousPos == POS.LEFT_BOTTOM || global.previousPos == POS.LEFT_TOP) {
				if (entryCount == 1 ||
					(entryCount == 2 && ((global.previousPos == POS.LEFT_BOTTOM && pos == POS.RIGHT_BOTTOM) || (global.previousPos == POS.LEFT_TOP && pos == POS.RIGHT_TOP)))) {
					instance_create_depth(wcenter - 64, hcenter, 0, obj_chr);
				}
			}
		}
	}
}
#endregion
#region Create hive
for (var i = 0; i < ds_list_size(hiveIndex); i++) {
	var hiveMap = hiveIndex[| i];
	var hive = instance_create_depth(hiveMap[? "x"], hiveMap[? "y"], 0, obj_hive1);
	hive.hive_id = hiveMap[? "id"];
}
#endregion

instance_create_depth(obj_chr.x, obj_chr.y, 0, obj_camera);
instance_create_depth(0, 0, 0, obj_draw);