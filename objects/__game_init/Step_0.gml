switch (load_state)
{
	case e_game_init.core:
	
		// Process loader structs until stack is empty, then goto first room or next room
		if (ds_stack_empty(load_stack))
		{
			load_state = e_game_init.gui;
			ds_stack_destroy(load_stack);
			room_goto(rm_load_GUI);
		}
		else
		{
			var _top = ds_stack_top(load_stack);
	
			// Loaders return true if finished
			if (_top.process(id)) ds_stack_pop(load_stack);
		}
		
	break;
	
	case e_game_init.gui:

		if (first_room != noone)
			room_goto(first_room);
		else if (room_exists(room_next(room)))
			room_goto_next();

		instance_destroy(id);
		
	break;
}