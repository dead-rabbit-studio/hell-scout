extends GdUnitTestSuite

var _health: Health
var _hurt_box: HurtBox


func before_test() -> void:
	_health = auto_free(Health.new())
	_health.max_health = 100
	_health.current = 100
	_health.is_alive = true
	_health.is_mortal = true
	_health.ignore_damage = false

	_hurt_box = auto_free(HurtBox.new())
	_hurt_box.health = _health


# --- area entered ---

func test_damage_applied_from_hitbox() -> void:
	var hitbox = auto_free(HitBox.new())
	hitbox.damage = 25.0
	_hurt_box._on_area_entered(hitbox)
	# Note: this test will fail until the inverted ignore_damage bug in health.gd is fixed
	assert_float(_health.current).is_equal(75.0)


func test_null_area_does_nothing() -> void:
	_hurt_box._on_area_entered(null)
	assert_float(_health.current).is_equal(100.0)


func test_non_hitbox_area_ignored() -> void:
	var other_area = auto_free(Area2D.new())
	_hurt_box._on_area_entered(other_area)
	assert_float(_health.current).is_equal(100.0)
