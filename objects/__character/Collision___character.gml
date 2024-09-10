/// @description Local Avoidance

// Ignore dead characters
if (other.hitpoints <= 0)
	exit;

// Push away with an elliptical shape
var _ox	 = other.x,
	_oy	 = other.y,
	_dir = point_direction(_ox, _oy, x, y),
	_cos = dcos(_dir),
	_sin = dsin(_dir),
	_ax  = _cos * (avoid_radius_x + other.avoid_radius_x),
	_ay  = _sin * (avoid_radius_y + other.avoid_radius_y);

if (_ax != 0)
	avoid_x += _cos * abs((x - _ox) / _ax);
	
if (_ay != 0)
	avoid_y -= _sin * abs((y - _oy) / _ay);