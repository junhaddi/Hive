textPos = 0;
textSpeedMax = 6;
textSpeed = textSpeedMax;
alpha = 0;
alarm[0] = textSpeed;

switch (global.currentWorld) {
	case "city":
		title = "도시입성!";
		text = "시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히#아름답고 경치가 좋은 칭구들 히히히 나는 빡빡이다를 외치면 특별히 살려주도록 하지#시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히";
		break;
	case "swamp":
		title = "정글입성!";
		text = "시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히#아름답고 경치가 좋은 칭구들 히히히 나는 빡빡이다를 외치면 특별히 살려주도록 하지#시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히";
		break;
	case "underground":
		title = "지하입성!";
		text = "시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히#아름답고 경치가 좋은 칭구들 히히히 나는 빡빡이다를 외치면 특별히 살려주도록 하지#시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히";
		break;
	case "jungle":
		title = "정글입성!"
		text = "시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히#아름답고 경치가 좋은 칭구들 히히히 나는 빡빡이다를 외치면 특별히 살려주도록 하지#시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히";
		break;
	case "desert":
		title = "사막입성!"
		text = "시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히#아름답고 경치가 좋은 칭구들 히히히 나는 빡빡이다를 외치면 특별히 살려주도록 하지#시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히";
		break;
	case "school":
		title = "학교입성!"
		text = "시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히#아름답고 경치가 좋은 칭구들 히히히 나는 빡빡이다를 외치면 특별히 살려주도록 하지#시공의 폭풍은 정말로 아름답고 경치가 좋은 개망겜이라구 칭구들 히히히";
		break;	
}