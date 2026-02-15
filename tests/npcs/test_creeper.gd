extends GdUnitTestSuite

var _health: Health
var _creeper: Creeper


func before_test() -> void:
	_health = auto_free(Health.new())
	_health.max_health = 3
	_health.current = 3
	_health.is_alive = true
	_health.is_mortal = true
	_health.ignore_damage = false

	_creeper = auto_free(Creeper.new())
	_creeper.health = _health


# --- take_damage ---

func test_take_damage_reduces_health() -> void:
	_creeper.take_damage(1.0)
	assert_float(_health.current).is_equal(2.0)


func test_take_damage_kills_at_zero() -> void:
	_creeper.take_damage(3.0)
	assert_bool(_health.is_alive).is_false()


func test_take_damage_partial() -> void:
	_creeper.take_damage(1.0)
	_creeper.take_damage(1.0)
	assert_float(_health.current).is_equal(1.0)


# --- engage area ---

func test_body_entered_sets_player_in_sight() -> void:
	var body = auto_free(CharacterBody2D.new())
	_creeper._on_engage_area_body_entered(body)
	assert_object(_creeper._player_in_sight).is_equal(body)


func test_body_exited_clears_player_in_sight() -> void:
	var body = auto_free(CharacterBody2D.new())
	_creeper._on_engage_area_body_entered(body)
	_creeper._on_engage_area_body_exited(body)
	assert_object(_creeper._player_in_sight).is_null()
	assert_bool(_creeper._player_los).is_false()


func test_non_character_body_ignored() -> void:
	var body = auto_free(Node2D.new())
	_creeper._on_engage_area_body_entered(body)
	assert_object(_creeper._player_in_sight).is_null()
