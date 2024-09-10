/// @description Attack Data

enum e_attack_data_proto
{
	punch,
	jab,
	jump_kick,
	dive_kick,
	last
}

// Attacks
attack_data = array_create(e_attack_data_proto.last);
attack_data[e_attack_data_proto.punch]	   = new player_action_state_combo(create_attack_params(2), spr_player_punch);
attack_data[e_attack_data_proto.jab]	   = new player_action_state_combo(create_attack_params(1), spr_player_jab);
attack_data[e_attack_data_proto.jump_kick] = new character_action_state_attack(create_attack_params(3, 0, 14), spr_player_jump_kick);
attack_data[e_attack_data_proto.dive_kick] = new character_action_state_attack(create_attack_params(4, 4, 0), spr_player_dive_kick);

// Set Combos
attack_data[e_attack_data_proto.jab].next_attack   = attack_data[e_attack_data_proto.punch];
attack_data[e_attack_data_proto.punch].next_attack = attack_data[e_attack_data_proto.jump_kick];

attack_data[e_attack_data_proto.punch].enter_action = function(_this)
	{
		if (sign(_this.input_x) == sign(_this.image_xscale)) 
			_this.add_impulse_x(sign(_this.input_x) * 12);	
	}

attack_data[e_attack_data_proto.punch].damage_done_action = function(_this, _damage_done, _first_hit)
	{
		_this.impulse_force_x = 0;
	}


attack_data[e_attack_data_proto.jump_kick].enter_action = function(_this)
	{
		_this.add_impulse_z(14);	
		_this.add_impulse_x(sign(_this.input_x) * 4);	
	}
	
attack_data[e_attack_data_proto.jump_kick].damage_done_action = function(_this, _damage_done, _first_hit)
	{
		_this.impulse_force_x = 0;
	}


attack_data[e_attack_data_proto.dive_kick].enter_action = function(_this)
	{
		if (move_norm_x != 0)
			image_xscale = sign(move_norm_x);
	}

attack_data[e_attack_data_proto.dive_kick].attack_start_action = function(_this)
	{
		static _xdir = cos(-45);
		static _ydir = sin(-45);
		
		var _dist = _this.z_height * 0.5;
	
		_this.add_impulse_z(_ydir * _dist);	
		_this.add_impulse_x(_xdir * sign(image_xscale) * _dist);
		
	}
	
attack_data[e_attack_data_proto.dive_kick].damage_done_action = function(_this, _damage_done, _first_hit)
	{
		_this.impulse_force_x *= 0.2;
	}