function character_action_state() constructor
{
	// Abstract implementation for action states (inherit from or ensure functions are made)
	
	static enter  = function(_this)  { /* Called when entering state */ }	
	static update = function(_this) { /* Called each step */ }
	static finish = function(_this) { /* Called when exiting the state */ }
	static animation_broadcast = function(_this, _value) { /* Called on animation broadcasts */ }
	static animation_end = function(_this) { /* Called when animation ends */ }
}

function character_action_state_free() constructor
{		
	static enter = function(_this)  
	{ 
		// Can always act, but can_move and can_impulse carry over from previous action_animation
		if (_this.action_animation)
			_this.can_act = true;
		else
			_this.set_state_logic(true, true, true);
	}
	
	static update = function(_this) { _this.primary_actions(); }
	static finish = function(_this) { /* Called when exiting the state */ }
	static animation_broadcast = function(_this, _value) { /* Called on animation broadcasts */ }
	static animation_end = function(_this) 
	{ 
		// If finishing an action_animation set free state logic
		if (_this.action_animation)
		{
			_this.set_state_logic(true, true, true);
			_this.action_animation = false;
		}
	}
}

function character_action_state_hurt() constructor
{
	static enter = function(_this)
	{
		_this.set_action_animation(_this.anim_hurt);
		_this.set_state_logic(false, true, false);
	}

	static update = function(_this) 
	{  
		// TODO add knockdown, bounce off boundary sides, etc.
		_this.x_draw = sin(current_time  * 0.05) * 5;
	}
	
	static finish = function(_this) { /* Called when exiting the state */ }
	static animation_broadcast = function(_this, _value) { /* Called on animation broadcasts */ }
	static animation_end = function(_this) 
	{ 
		// TODO evaluate if hurt state should end.. still being knocked around
		// and add a "get up" animation if knocked down, etc.
		
		_this.action_animation = false;
		_this.set_action_state(_this.action_state_free);
	}
}

function character_action_state_attack(_attack_params, _animation, _state = [false, true, false]) constructor
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
		
	static enter = function(_this)
	{
		first_hit = true;
		
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
			_this.set_action_state(_this.action_state_free);
		}
	}	
	
	static animation_end = function(_this) 
	{ 
		_this.action_animation = false;
		_this.set_action_state(_this.action_state_free);
	}
	
	static on_damage_done = function(_this, _damage_done)
	{
		if (damage_done_action != noone)
			damage_done_action(_this, _damage_done, first_hit);
		
		first_hit = false;
	}
}

function character_action_state_death(_this) constructor
{
	static enter = function(_this)
	{
		with (_this)
		{
			vulnerable = false;
			set_action_animation(anim_death);
			set_state_logic(false, true, false);
		}
	}
		
	static update = function(_this) 
	{ 
		with (_this)
		{
			if (image_speed == 0)
			{
				image_alpha -= 0.05;
				if (image_alpha < 0)
					destroy_this = true;
			}
		}
	}
	
	static finish = function(_this) { /* Called when exiting the state */ }
	static animation_broadcast = function(_this, _value) { /* Called on animation broadcasts */ }
		
	static animation_end = function(_this) 
	{ 
		with (_this)
		{
			image_speed = 0;
			image_index = image_number - 1;
		}
	}	
}