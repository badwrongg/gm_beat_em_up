function enemy_base_constant_state()
{
	// TODO
	// Select attack to use (range, melee, distance to target)
	// Setup aggro table since multiplayer will have multiple targets
					
	if (ai_target_update_timer > 0)
		ai_target_update_timer -= game_speeds[e_game_speed.tick];
	else
	{
		ai_target_update_timer = C_AI_TARGET_UPDATE_TIME;
		
		if (instance_exists(ai_target))
		{
			var _tx	   = ai_target.x,
				_ty	   = ai_target.y,
				_sight = collision_line(x, y, _tx, _ty, __collider, false, true) == noone &&
						 collision_line(bbox_left, y, ai_target.bbox_left, _ty, __collider, false, true) == noone &&
						 collision_line(bbox_right, y, ai_target.bbox_right, _ty, __collider, false, true) == noone;
						 
			// Store the real target x, y, and direction
			ai_target_x = _tx;
			ai_target_y = _ty;
			ai_target_dir  = point_direction(x, y, _tx, _ty);
			
			// Pick a point on the right or left of target
			_tx = x < _tx ? ai_target.bbox_left : ai_target.bbox_right;
			ai_target_dist = point_distance(x, y, _tx, _ty);
			
			if (_sight)
			{	
				// Pick a spot on the right or left of the target
				path_clear_points(ai_path);
				path_add_point(ai_path, _tx, _ty, 0);
				input_x = ai_target_x - x;
			}
			else
			{
				// Find a path around obstacles to target
				if (mp_grid_path(ai_navgrid, ai_path, safe_nav_x, safe_nav_y, ai_target.safe_nav_x, ai_target.safe_nav_y, true))
				{
					// Already at first point (or near it)
					path_delete_point(ai_path, path_get_number(ai_path) - 1);
					path_delete_point(ai_path, 0);
					
					// Last point should be actual target, not safe x/y
					path_add_point(ai_path, _tx, _ty, 0);
					input_x = path_get_point_x(ai_path, 0) - x;
				}
				else
				{
					path_clear_points(ai_path);
					// TODO Set some wander state
				}
			}
		}
		else
		{
			ai_target = instance_nearest(x, y, ai_target_object);
			ai_target_dist = infinity;
		}
	}
}

function enemy_base_primary_actions()
{
	// Temporary, each enemy would get their own primary actions
	
	if (can_act)
	{
		if (ai_target_dist < attack_range)
		{
			set_action_state(attack_data[e_attack_data_punk.punch]);
		}
		else
			add_movement_path(ai_path);
	}
			
}