function character_add_movement_path(_path)
{		
	if (path_get_number(_path) == 0)
		return;
	
	var _px = path_get_point_x(_path, 0),
		_py = path_get_point_y(_path, 0),
		_vx = _px - x,
		_vy = _py - y;
	
	if (_vx != 0 || _vy != 0)
	{
		var _dist = sqrt(_vx * _vx + _vy * _vy),
			_speed = move_speed_max * max(0, move_speed_mod);
			
		// Check if reached current path point
		if (_dist < _speed)
		{
			// Set x/y to current point and remove distance from speed
			x = _px;
			y = _py;
			_speed -= _dist;
			
			// Delete point and finish if none left
			path_delete_point(_path, 0);
			if (path_get_number(_path) == 0)
				return;
				
			// Get next path point
			var _px = path_get_point_x(_path, 0),
				_py = path_get_point_y(_path, 0),
				_vx = _px - x,
				_vy = _py - y;
			
			// Ensure next point is not the same
			if (_vx == 0 && _vy == 0)
				return;
			
			_dist = sqrt(_vx * _vx + _vy * _vy);

		}
		
		// Normalize
		_vx /= _dist; // cosine
		_vy /= _dist; // sine
		
		// Add acceleration to current movement
		var _move_accel = (move_accel + move_decel) * move_friction;
		move_x += _vx * _move_accel;
		move_y += _vy * _move_accel;
		
		// Limit max movement speed
		_dist = sqrt(move_x * move_x + move_y * move_y);
		move_speed = min(_speed, _dist);
		if (_dist != 0)
		{
			// Set new normal vector
			move_norm_x = move_x / _dist; // cosine
			move_norm_y = move_y / _dist; // sine
		}
		
		// Set the movement direction
		move_dir = darctan2(move_norm_y, move_norm_x);
	}
	
}

function character_add_movement_input(_input_x, _input_y)
{	
	// Apply acceleration
	if (_input_x != 0 || _input_y != 0)
	{		
		// Normalize input
		var _dist = sqrt(_input_x * _input_x + _input_y * _input_y);
		_input_x /= _dist; // cosine
		_input_y /= _dist; // sine
	
		// Add acceleration to current movement
		var _move_accel = (move_accel + move_decel) * move_friction;
		move_x += _input_x * _move_accel;
		move_y += _input_y * _move_accel;
	
		// Limit max movement speed
		_dist = sqrt(move_x * move_x + move_y * move_y);
		move_speed = min(move_speed_max * max(0, move_speed_mod), _dist);
		if (_dist != 0)
		{
			// Set new normal vector
			move_norm_x = move_x / _dist; // cosine
			move_norm_y = move_y / _dist; // sine
		}
	
		// Set the movement direction
		move_dir = darctan2(move_norm_y, move_norm_x);
	}
}

function character_add_movement_direction(_direction)
{
	_direction = (_direction + 360) mod 360;
	
	var _cos = dcos(_direction),
		_sin = -dsin(_direction),
		_move_accel = (move_accel + move_decel) * move_friction;
	
	// Add acceleration to current movement
	move_x += _cos * _move_accel;
	move_y += _sin * _move_accel;
	move_norm_x = _cos;
	move_norm_y = _sin;
	move_dir = _direction;
	move_speed = min(move_speed_max * max(0, move_speed_mod), move_speed + _move_accel);
}

function character_add_impulse_direction(_dir, _power)
{
	_power *= impulse_mod;
	
	var _vx   = impulse_force_x + dcos(_dir) * _power,
		_vy   = impulse_force_y - dsin(_dir) * _power,
		_dist = sqrt(_vx * _vx + _vy * _vy);
		
	// Limit to maximum impulse force
	if (_dist > C_MOVE_MAX_IMPULSE)
	{
		// Normalize and apply magnitude
		impulse_force_x = _vx / _dist * C_MOVE_MAX_IMPULSE; // cosine * magnitude
		impulse_force_y = _vy / _dist * C_MOVE_MAX_IMPULSE; // sine   * magnitude
	}
	else
	{
		impulse_force_x = _vx;
		impulse_force_y = _vy;
	}
}

function character_add_impulse_position(_x, _y, _power)
{
	_power *= impulse_mod;
	
	var _vx = x - _x,
		_vy = y - _y,
		_dist = _vx * _vx + _vy * _vy;
	
	if (_dist != 0)
	{
		// Normalize, apply magnitude, and add to current impulse vector
		_dist = sqrt(_dist);
		_vx = impulse_force_x + _vx / _dist * _power; // cosine * magnitude
		_vy = impulse_force_y + _vy / _dist * _power; // sine   * magnitude
		
		// Limit to maximum impulse force
		_dist = sqrt(_vx * _vx + _vy * _vy);
		if (_dist > C_MOVE_MAX_IMPULSE)
		{
			// Normalize and apply magnitude
			impulse_force_x = _vx / _dist * C_MOVE_MAX_IMPULSE; // cosine * magnitude
			impulse_force_y = _vy / _dist * C_MOVE_MAX_IMPULSE; // sine   * magnitude
		}
		else
		{
			impulse_force_x = _vx;
			impulse_force_y = _vy;
		}
	}
}

function character_add_impulse_x(_power)
{	
	impulse_force_x = clamp(impulse_force_x + _power, -C_MOVE_MAX_IMPULSE, C_MOVE_MAX_IMPULSE);	
}

function character_add_impulse_y(_power)
{	
	impulse_force_y = clamp(impulse_force_y + _power, -C_MOVE_MAX_IMPULSE, C_MOVE_MAX_IMPULSE);	
}

function character_add_impulse_z(_power)
{
	impulse_force_z = clamp(_power, -C_MOVE_MAX_IMPULSE_Z, C_MOVE_MAX_IMPULSE_Z);	
}

function character_add_constant_force(_direction, _power)
{
	constant_force_x += dcos(_direction) * _power;
	constant_force_y -= dsin(_direction) * _power;
}

function character_movement_state()
{
	var _dist   = 0,
		_move_x = 0,
		_move_y = 0,
		_speed  = move_speed * (on_ground ? 1 : C_MOVE_AIR_CONTROL);
	
	// Update movement vector
	if (can_move && _speed > 0)
	{	
		move_x = move_norm_x * _speed;
		move_y = move_norm_y * _speed;
		
		// Apply local avoidance
		if (has_local_avoidance && on_ground)
		{				
			_move_x = move_x + avoid_x;
			_move_y = move_y + avoid_y;
			_dist = sqrt(_move_x * _move_x + _move_y * _move_y);
			if (_dist != 0)
			{
				_move_x = _move_x / _dist * _speed;
				_move_y = _move_y / _dist * _speed;
			}
		}
		else
		{
			_move_x = move_x;
			_move_y = move_y;
		}
	}
	else
	{
		move_x  = 0;
		move_y  = 0;
		avoid_x = 0;
		avoid_y = 0;
	}
	
	if (!can_impulse)
	{
		impulse_force_x = 0;
		impulse_force_y = 0;
		impulse_force_z = 0;
	}

	// Add up total movement velocity
	var _vx = _move_x + impulse_force_x + constant_force_x,
		_vy = _move_y + impulse_force_y + constant_force_y;

	// Normalize and set magnitude
	_dist = sqrt(_vx * _vx + _vy * _vy);
	velocity = min(C_MOVE_TERM_VELOCITY, _dist);
	if (_dist != 0)
	{
		_vx = _vx / _dist * velocity;
		_vy = _vy / _dist * velocity;
	}

	velocity_x = _vx;
	velocity_y = _vy;

	// **** Movement and collisions ****
	if (place_meeting(x + _vx, y + _vy, collided_object))
	{
		collided_with = move_and_collide(_vx, _vy, collided_object, C_COLLISION_STEPS, 0, 0, -1, -1);
		collided_count = array_length(collided_with);
	}
	else
	{
		x += _vx;
		y += _vy;
		collided_count = 0;
	}

	// **** Post-movement friction, resets, etc. ****
	// Decel and reset modifier
	move_speed = max(move_speed - move_decel * move_friction, 0); 
	move_speed_mod = 1;

	// Apply friction to impulse vector
	impulse_mod = 1;
	if (abs(impulse_force_x) + abs(impulse_force_y) > 1)
	{
		impulse_force_x *= impulse_friction;
		impulse_force_y *= impulse_friction;
	}
	else
	{
		impulse_force_x = 0;
		impulse_force_y = 0;		
	}
	
	// Z height
	z_height = max(z_height + impulse_force_z, 0);
	impulse_force_z = max(impulse_force_z - C_MOVE_GRAVITY_POWER, -C_MOVE_TERM_VELOCITY);
	on_ground = (z_height == 0);
	y_draw = y - z_height;

	// Always goes back to zero
	constant_force_x = 0;
	constant_force_y = 0;	
	
	// Reduce local avoidance
	avoid_x *= C_CHARACTER_AVOID_POWER;
	avoid_y *= C_CHARACTER_AVOID_POWER;
}