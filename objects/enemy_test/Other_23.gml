/// @description Attack Data

enum e_attack_data_punk
{
	punch,
	
	last
}

// Attacks
attack_data = array_create(e_attack_data_punk.last);
attack_data[e_attack_data_punk.punch] = new character_action_state_attack(create_attack_params(2), spr_enemy_test_punch);