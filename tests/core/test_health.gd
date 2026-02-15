extends GdUnitTestSuite

var _health: Health
var _signal_tracker: Array


func before_test() -> void:
	_signal_tracker = []
	_health = auto_free(Health.new())
	_health.max_health = 100
	_health.current = 100
	_health.is_alive = true
	_health.is_mortal = true
	_health.ignore_damage = false


# --- damage ---

func test_damage_reduces_health() -> void:
	_health.damage(30)
	assert_float(_health.current).is_equal(70.0)


func test_damage_does_not_go_below_zero() -> void:
	_health.damage(150)
	assert_float(_health.current).is_equal(0.0)


func test_damage_blocked_when_ignore_damage_true() -> void:
	_health.ignore_damage = true
	_health.damage(50)
	assert_float(_health.current).is_equal(100.0)


func test_damage_applied_when_ignore_damage_false() -> void:
	_health.ignore_damage = false
	_health.damage(25)
	assert_float(_health.current).is_equal(75.0)


func test_damage_does_nothing_when_not_alive() -> void:
	_health.is_alive = false
	_health.damage(50)
	assert_float(_health.current).is_equal(100.0)


# --- heal ---

func test_heal_increases_health() -> void:
	_health.current = 50
	_health.heal(20)
	assert_float(_health.current).is_equal(70.0)


func test_heal_does_not_exceed_max() -> void:
	_health.current = 90
	_health.heal(20)
	assert_float(_health.current).is_equal(100.0)


func test_heal_at_max_stays_at_max() -> void:
	_health.heal(10)
	assert_float(_health.current).is_equal(100.0)


# --- kill ---

func test_kill_sets_alive_false() -> void:
	_health.kill()
	assert_bool(_health.is_alive).is_false()


func test_kill_emits_depleted_signal() -> void:
	_health.depleted.connect(func(): _signal_tracker.append("depleted"))
	_health.kill()
	assert_array(_signal_tracker).contains(["depleted"])


func test_kill_does_nothing_when_already_dead() -> void:
	_health.is_alive = false
	_health.kill()
	assert_bool(_health.is_alive).is_false()


# --- mortal / death on zero hp ---

func test_mortal_character_dies_at_zero_hp() -> void:
	_health.is_mortal = true
	_health.damage(_health.max_health)
	assert_bool(_health.is_alive).is_false()


func test_immortal_character_survives_at_zero_hp() -> void:
	_health.is_mortal = false
	_health.damage(_health.max_health)
	assert_bool(_health.is_alive).is_true()


# --- revive ---

func test_revive_restores_max_health() -> void:
	_health.current = 0
	_health.revive()
	assert_float(_health.current).is_equal(100.0)


# --- max_health setter ---

func test_max_health_setter_syncs_current() -> void:
	_health.max_health = 50
	assert_float(_health.current).is_equal(50.0)
