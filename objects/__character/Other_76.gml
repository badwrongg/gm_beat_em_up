enum e_broadcast
{
	attack_start,
	attack_end,
	action_finish,
	motion0,
	motion1
}

// Exit if this instance didn't create broadcast
if (layer_instance_get_instance(event_data[? "element_id"]) != id)
	exit;

// Send broadcast to the action state
if (event_data[? "event_type"] == "sprite event")
{
	switch (event_data[? "message"])
	{
		case "attack_start":
			action_state.animation_broadcast(id, e_broadcast.attack_start);
		break;
		
		case "attack_end":
			action_state.animation_broadcast(id, e_broadcast.attack_end);
		break;
		
		case "action_finish":
			action_state.animation_broadcast(id, e_broadcast.action_finish);
		break;
		
		case "motion0":
			action_state.animation_broadcast(id, e_broadcast.motion0);
		break;
		
		case "motion1":
			action_state.animation_broadcast(id, e_broadcast.motion1);
		break;
		
	}
}