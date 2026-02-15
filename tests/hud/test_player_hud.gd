extends GdUnitTestSuite

var _hud: PlayerHUD


func before_test() -> void:
	_hud = auto_free(PlayerHUD.new())


# --- _format_hp ---

func test_format_hp_with_full_health() -> void:
	var result = _hud._format_hp(3)
	assert_str(result).is_equal("HP: o o o ")


func test_format_hp_with_zero_health() -> void:
	var result = _hud._format_hp(0)
	assert_str(result).is_equal("HP: ")


func test_format_hp_with_negative_health() -> void:
	var result = _hud._format_hp(-1)
	assert_str(result).is_equal("HP: ")


func test_format_hp_with_one_health() -> void:
	var result = _hud._format_hp(1)
	assert_str(result).is_equal("HP: o ")


func test_format_hp_with_large_health() -> void:
	var result = _hud._format_hp(5)
	assert_str(result).is_equal("HP: o o o o o ")
