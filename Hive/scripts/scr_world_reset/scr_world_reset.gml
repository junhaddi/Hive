/// @description 월드 무작위 초기화
/// @param roomNum

var roomNum = argument0;

if (show_question("저장 파일을 불러오시겠습니까?")) {
	if (file_exists("save.sav")) {
		var json = scr_load_file("save.sav");
	
		ds_grid_read(global.worldGrid, json[? "worldData"]);
		var infoList = json[? "infoList"];
		var memoryList = json[? "memoryList"];

		for (var i = 0; i < ds_list_size(infoList); i++) {
			var _infoMap = infoList[| i];
			var _memoryMap = memoryList[| i];
			
			global.roomList[| i] = ds_list_create();
			ds_list_mark_as_list(global.roomList, i);

			var worldIndex = global.roomList[| i];
			worldIndex[| MARK.INFO] = ds_map_create();
			worldIndex[| MARK.ENTRY] = ds_list_create();
			worldIndex[| MARK.MEMORY] = ds_list_create();
			ds_list_mark_as_map(worldIndex, MARK.INFO);
			ds_list_mark_as_list(worldIndex, MARK.ENTRY);
			ds_list_mark_as_list(worldIndex, MARK.MEMORY);

			// 룸 정보 추가
			var infoMap = worldIndex[| MARK.INFO];
			infoMap[? "index"] = _infoMap[? "index"];
			infoMap[? "shape"] = _infoMap[? "shape"];
			infoMap[? "event"] = _infoMap[? "event"];
			infoMap[? "search"] = _infoMap[? "search"];
			infoMap[? "room"] = _infoMap[? "room"];
			
			var memoryMap = worldIndex[| MARK.MEMORY];
			memoryMap[? "id"] = _memoryMap[? "id"];
			memoryMap[? "hp"] = _memoryMap[? "hp"];
		}
	}
}
else {
	var controlX = ds_grid_width(global.worldGrid) div 2;
	var controlY = ds_grid_height(global.worldGrid) div 2;
	global.currentIndex = 0;

	// 월드 초기화
	for (var _y = 0; _y < ds_grid_height(global.worldGrid); _y++) {
		for (var _x = 0; _x < ds_grid_width(global.worldGrid); _x++) {
			global.worldGrid[# _x, _y] = WALL;	
		}
	}

	// 룸 이벤트 추가|섞기
	var minibossNum = 1;
	var supplyNum = 3;
	var shopNum = 1;
	var questNum = 1;
	var eventList = ds_list_create();

	repeat (minibossNum) {
		ds_list_add(eventList, EVENT.MINIBOSS);
	}

	repeat (supplyNum) {
		ds_list_add(eventList, EVENT.SUPPLY);
	}

	repeat (shopNum) {
		ds_list_add(eventList, EVENT.SHOP);
	}

	repeat (questNum) {
		ds_list_add(eventList, EVENT.QUEST);
	}
	ds_list_shuffle(eventList);

	// 월드 생성
	global.worldGrid[# controlX, controlY] = 0;
	scr_world_room_reset(global.worldGrid[# controlX, controlY], SHAPE.SMALL, EVENT.STAGE);

	for (var i = 1; i < roomNum; i++) {
		var isCreateRoom = false;
	
		do {
			var previousX = controlX;
			var previousY = controlY;
			var controlDir = choose(DIR.EAST, DIR.WEST, DIR.SOUTH, DIR.NORTH);
			var roomShape, roomEvent;
		
			// 보스|일반 스테이지 설정
			if (i == roomNum - 1) {
				roomShape = SHAPE.SMALL;
				roomEvent = EVENT.BOSS;
			}
			else {
				roomShape = choose(SHAPE.SMALL, SHAPE.BIG, SHAPE.WLONG, SHAPE.HLONG);
				var eventCycle = floor((roomNum - 2) / ds_list_size(eventList));

				if (i mod eventCycle == 0) {
					roomEvent = eventList[| i / eventCycle - 1];
				}
				else {
					roomEvent = EVENT.STAGE;
				}
			}

			switch (roomShape) {
				#region SMALL
				case SHAPE.SMALL:
					switch (controlDir) {
						case DIR.EAST:
							controlX++;
							break;
						case DIR.WEST:
							controlX--;
							break;
						case DIR.SOUTH:
							controlY++;
							break;
						case DIR.NORTH:
							controlY--;
							break;
					}
				
					if (controlX < 0 || controlY < 0 || controlX >= ds_grid_width(global.worldGrid) || controlY >= ds_grid_height(global.worldGrid)) {
						controlX = previousX;
						controlY = previousY;
					}
					else if (global.worldGrid[# controlX, controlY] == WALL) {
						global.worldGrid[# controlX, controlY] = i;
						scr_world_room_reset(global.worldGrid[# controlX, controlY], SHAPE.SMALL, roomEvent);
						isCreateRoom = true;
					}
					break;
				#endregion
				#region BIG
				case SHAPE.BIG:	
					var controlX1, controlY1, controlX2, controlY2;
			
					switch (controlDir) {
						case DIR.EAST:
							controlX++;
							controlX1 = controlX;
							controlY1 = controlY + choose(0, -1);
							controlX2 = controlX1 + 1;
							controlY2 = controlY1 + 1;
							break;
						case DIR.WEST:
							controlX--;
							controlX1 = controlX;
							controlY1 = controlY + choose(0, -1);
							controlX2 = controlX1 - 1;
							controlY2 = controlY1 + 1;
							break;
						case DIR.SOUTH:
							controlY++;
							controlX1 = controlX + choose(0, -1);
							controlY1 = controlY;
							controlX2 = controlX1 + 1;
							controlY2 = controlY1 + 1;
							break;
						case DIR.NORTH:
							controlY--;
							controlX1 = controlX + choose(0, -1);
							controlY1 = controlY;
							controlX2 = controlX1 + 1;
							controlY2 = controlY1 - 1;
							break;
					}

					if (controlX1 < 0 || controlY1 < 0 || controlX1 >= ds_grid_width(global.worldGrid) || controlY1 >= ds_grid_height(global.worldGrid) ||
						controlX2 < 0 || controlY2 < 0 || controlX2 >= ds_grid_width(global.worldGrid) || controlY2 >= ds_grid_height(global.worldGrid)) {
						controlX = previousX;
						controlY = previousY;
					}
					else {
						var isEmpty = true;
					
						for (var j = 0; j < i; j++) {
							if (ds_grid_value_exists(global.worldGrid, controlX1, controlY1, controlX2, controlY2, j)) {
								isEmpty = false;
								break;
							}
						}
					
						if (isEmpty) {
							ds_grid_set_region(global.worldGrid, controlX1, controlY1, controlX2, controlY2, i);
							scr_world_room_reset(global.worldGrid[# controlX, controlY], SHAPE.BIG, roomEvent);
							isCreateRoom = true;
						}
						else if (global.worldGrid[# controlX, controlY] == WALL) {
							controlX = previousX;
							controlY = previousY;
						}	
					}
					break;
				#endregion
				#region WLONG
				case SHAPE.WLONG:	
					var controlX1, controlY1, controlX2, controlY2;
			
					switch (controlDir) {
						case DIR.EAST:
							controlX++;
							controlX1 = controlX;
							controlY1 = controlY;
							controlX2 = controlX1 + 1;
							controlY2 = controlY1;
							break;
						case DIR.WEST:
							controlX--;
							controlX1 = controlX;
							controlY1 = controlY;
							controlX2 = controlX1 - 1;
							controlY2 = controlY1;
							break;
						case DIR.SOUTH:
							controlY++;
							controlX1 = controlX + choose(0, -1);
							controlY1 = controlY;
							controlX2 = controlX1 + 1;
							controlY2 = controlY1;
							break;
						case DIR.NORTH:
							controlY--;
							controlX1 = controlX + choose(0, -1);
							controlY1 = controlY;
							controlX2 = controlX1 + 1;
							controlY2 = controlY1;
							break;
					}

					if (controlX1 < 0 || controlY1 < 0 || controlX1 >= ds_grid_width(global.worldGrid) || controlY1 >= ds_grid_height(global.worldGrid) ||
						controlX2 < 0 || controlY2 < 0 || controlX2 >= ds_grid_width(global.worldGrid) || controlY2 >= ds_grid_height(global.worldGrid)) {
						controlX = previousX;
						controlY = previousY;
					}
					else {
						var isEmpty = true;
					
						for (var j = 0; j < i; j++) {
							if (ds_grid_value_exists(global.worldGrid, controlX1, controlY1, controlX2, controlY2, j)) {
								isEmpty = false;
								break;
							}
						}
					
						if (isEmpty) {
							ds_grid_set_region(global.worldGrid, controlX1, controlY1, controlX2, controlY2, i);
							scr_world_room_reset(global.worldGrid[# controlX, controlY], SHAPE.WLONG, roomEvent);
							isCreateRoom = true;
						}
						else if (global.worldGrid[# controlX, controlY] == WALL) {
							controlX = previousX;
							controlY = previousY;
						}
					}
					break;
				#endregion
				#region HLONG
				case SHAPE.HLONG:	
					var controlX1, controlY1, controlX2, controlY2;
				
					switch (controlDir) {
						case DIR.EAST:
							controlX++;
							controlX1 = controlX;
							controlY1 = controlY + choose(0, -1);
							controlX2 = controlX1;
							controlY2 = controlY1 + 1;
							break;
						case DIR.WEST:
							controlX--;
							controlX1 = controlX;
							controlY1 = controlY + choose(0, -1);
							controlX2 = controlX1;
							controlY2 = controlY1 + 1;
							break;
						case DIR.SOUTH:
							controlY++;
							controlX1 = controlX;
							controlY1 = controlY;
							controlX2 = controlX1;
							controlY2 = controlY1 + 1;
							break;
						case DIR.NORTH:
							controlY--;
							controlX1 = controlX;
							controlY1 = controlY;
							controlX2 = controlX1;
							controlY2 = controlY1 - 1;
							break;
					}

					if (controlX1 < 0 || controlY1 < 0 || controlX1 >= ds_grid_width(global.worldGrid) || controlY1 >= ds_grid_height(global.worldGrid) ||
						controlX2 < 0 || controlY2 < 0 || controlX2 >= ds_grid_width(global.worldGrid) || controlY2 >= ds_grid_height(global.worldGrid)) {
						controlX = previousX;
						controlY = previousY;
					}
					else {
						var isEmpty = true;
					
						for (var j = 0; j < i; j++) {
							if (ds_grid_value_exists(global.worldGrid, controlX1, controlY1, controlX2, controlY2, j)) {
								isEmpty = false;
								break;
							}
						}
					
						if (isEmpty) {
							ds_grid_set_region(global.worldGrid, controlX1, controlY1, controlX2, controlY2, i);
							scr_world_room_reset(global.worldGrid[# controlX, controlY], SHAPE.HLONG, roomEvent);
							isCreateRoom = true;
						}
						else if (global.worldGrid[# controlX, controlY] == WALL) {
							controlX = previousX;
							controlY = previousY;
						}
					}
					break;
				#endregion
			}
		}
		until (isCreateRoom);
	}
}

// 룸 입구 생성
for (var _y = 0; _y < ds_grid_height(global.worldGrid); _y++) {
	for (var _x = 0; _x < ds_grid_width(global.worldGrid); _x++) {
		if (global.worldGrid[# _x, _y] != WALL) {
			scr_room_entry_create(global.worldGrid[# _x, _y], _x, _y);	
		}
	}
}