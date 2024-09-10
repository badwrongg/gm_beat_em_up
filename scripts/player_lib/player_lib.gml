function player_constant_state()
{
	input_attack  = input_attack >> 1;
	input_special = input_special >> 1;
	input_jump    = input_jump   >> 1;
	
	if (keyboard_check_pressed(input_bind_attack))
		input_attack = C_INPUT_REMEMBER;
		
	if (keyboard_check_pressed(input_bind_special))
		input_special = C_INPUT_REMEMBER;
				
	if (keyboard_check_pressed(input_bind_jump))
		input_jump = C_INPUT_REMEMBER;
			
	input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));	
}

function player_primary_actions()
{
	add_movement_input(input_x, input_y);
	
	if (!can_act)
		return;
		
	if (on_ground)
	{
		if (input_jump)
		{
			input_jump = 0;
			add_impulse_z(jump_power);
			sprite_index = anim_jump;
			image_index  = 0;
			audio_play_sound(sfx_jump, 5, false);
		}
		else if (input_attack)
		{	
			input_attack = 0;
			set_action_state(attack_data[e_attack_data_proto.jab]);
		}
	}
	else
	{
		if (input_attack)
		{	
			input_attack = 0;
			set_action_state(attack_data[e_attack_data_proto.dive_kick]);
		}
	}		
}

function player_action_state_combo(_attack_params, _animation, _state = [false, true, false]) constructor
{	
	attack_params = _attack_params;
	animation	  = _animation;
	first_hit     = true;
	can_move	  = _state[0];
	can_impulse   = _state[1];
	can_act       = _state[2];
	
	enter_action	    = noone;
	attack_start_action = noone;
	attack_end_action   = noone;
	damage_done_action  = noone;
	
	next_attack   = noone;
	next_special  = noone;
		
	static enter = function(_this)
	{
		first_hit     = true;
		
		_this.set_state_logic(can_move, can_impulse, can_act);
		_this.set_action_animation(animation);
		
		if (enter_action != noone)
			enter_action(_this);
	}
	
	static update = function(_this)	{ }
	
	static finish = function(_this) 
	{
		_this.attack_active = C_CHARACTER_NO_ATTACK;
	}
	
	static animation_broadcast = function(_this, _value) 
	{  			
		if (_value == e_broadcast.attack_start)
		{
			if (attack_start_action != noone)
				attack_start_action(_this);
			
			ds_list_clear(_this.tag_list);
			_this.attack_active = attack_params;
		}
		else if (_value == e_broadcast.attack_end)
		{
			if (attack_end_action != noone)
				attack_end_action(_this)
				
			_this.attack_active = C_CHARACTER_NO_ATTACK;
		}
		else if (_value == e_broadcast.action_finish)
		{
			if (_this.input_attack && next_attack != noone)
			{
				_this.input_attack = 0;
				_this.set_action_state(next_attack);
			}
			else if (_this.input_attack && next_special != noone)
			{
				_this.input_special = 0;
				_this.set_action_state(next_special);
			}
			else
				_this.set_action_state(_this.action_state_free);	
		}
	}	
	
	static animation_end = function(_this) 
	{  
		_this.action_animation = false;
		_this.set_action_state(_this.action_state_free);	
	}
	
	static on_damage_done = function(_this, _damage_done, _x, _y)
	{
		if (damage_done_action != noone)
			damage_done_action(_this, _damage_done, first_hit);
		
		first_hit = false;
	}
}