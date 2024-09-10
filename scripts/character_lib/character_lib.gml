function character_event_tick()
{	
	x_draw = 0;
	
	// Concurrent states, order is VERY important
	constant_state();
	action_state.update(id);
	movement_state();
	animation_state();
	attack_state();
	hurtbox.set_position(x, y_draw, image_xscale);
	
	// Store safe navgrid position
	var _sx = x div C_NAVGRID_CELL_WIDTH,
		_sy = y div C_NAVGRID_CELL_HEIGHT;
		
	if (mp_grid_get_cell(ai_navgrid, _sx, _sy) == 0)
	{
		// Snapped to cell position
		safe_nav_x = _sx * C_NAVGRID_CELL_WIDTH + C_NAVGRID_CELL_WIDTH_2;
		safe_nav_y = _sy * C_NAVGRID_CELL_HEIGHT + C_NAVGRID_CELL_HEIGHT_2;
	}
	
	x_draw = x + x_draw;
}

function character_set_action_state(_state) 
{
	action_state.finish(id);
	action_state = _state;
	_state.enter(id);
}

function character_set_state_logic(_can_move, _can_impulse, _can_act)
{
	can_move	= _can_move;
	can_impulse	= _can_impulse;
	can_act     = _can_act;
}

function character_set_action_animation(_sprite, _image_index = 0)
{
	sprite_index	 = _sprite;
	image_index		 = _image_index;
	action_animation = true;
}

function character_animation_state()
{
	// Animation state for characters
	// When "action_animation" is true then animation state is overriden
	
	// TODO add hitstun?
	
	if (on_ground)
	{		
		// If attacking or other action
		if (action_animation)
			return;
		
		// Normal locomotion
		if (move_speed == 0)
			sprite_index = anim_idle;
		else
			sprite_index = anim_walk;
			
		if (input_x != 0)
			image_xscale = sign(input_x);	
	}
	else
	{
		// Air animations should stop at the last frame
		image_index = min(image_index, image_number - 1);
	}
}

function character_on_damage_done(_damage_done)
{	
	action_state.on_damage_done(id, _damage_done);
}

function character_receive_attack(_attack, _source)
{	
	if (!vulnerable)
		return 0;
	
	var _damage_done = _attack[e_attack.damage];
	// TODO damage calculation... armor, reduction?
	hitpoints -= _damage_done;

	if (hitpoints <= 0)
	{
		set_action_state(new character_action_state_death());
		// TODO create death effect, particles, etc.
	}
	else if (has_armor)
	{
		// Armor prevents hitstun, knockback, and knockup
		// TODO flashing damage visual
	}
	else
	{
		if (_attack[e_attack.knockback])
			add_impulse_position(_source.x, _source.y, _attack[e_attack.knockback]);
	
		if (_attack[e_attack.knockup])
			add_impulse_z(_attack[e_attack.knockup]);
			
		set_action_state(action_state_hurt);
	}
	
	return _damage_done;
}

function character_attack_state()
{
	if (attack_active == C_CHARACTER_NO_ATTACK)
		return;
	
	// Find what was hit
	ds_list_clear(hit_list);
	var _count		 = instance_hitbox_list(x, y_draw, image_xscale, image_yscale, sprite_index, __hurtbox, hit_list, false),
		_damage_done = 0,
		_center		 = get_collision_hitbox_center(), // Get the center of where the hitbox currently is
		_cx		     = _center[0],
		_cy			 = _center[1],
		_effect		 = attack_active[e_attack.effect],
		_bbox_top    = 0,
		_bbox_bot    = 0;

	// Apply damage to what was hit and tag it
	for (var _i = 0, _id; _i < _count; _i++)
	{
		_id = hit_list[| _i]; 
		
		// Can't hurt same team or already hit instance
		if (_id.team == team || ds_list_find_index(tag_list, _id) != -1)
			continue;
		
		// Hit depth is between the top and bottom of the ellipse collision mask
		_bbox_top = _id.owner.bbox_top;
		_bbox_bot = _id.owner.bbox_bottom;
		
		// Compare hit depth
		if (bbox_bottom + hit_depth < _bbox_top || bbox_top - hit_depth > _bbox_bot)
			continue;

		// Store the target id and send attack
		ds_list_add(tag_list, _id);
		_damage_done += _id.receive_attack(attack_active, id);
		
		// Impact point is halfway between hitbox (_cx, _cy) and center of target
		_effect((_cx + ((_id.bbox_left + _id.bbox_right) >> 1)) >> 1, (_cy + ((_id.bbox_top + _id.bbox_bottom) >> 1)) >> 1, _bbox_bot);
	}
	
	// Callback on successful attacks
	if (_damage_done)
	{
		on_damage_done(_damage_done);
	}
}